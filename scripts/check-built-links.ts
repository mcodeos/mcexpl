import { readFile, readdir } from 'node:fs/promises'
import { dirname, relative, resolve, sep } from 'node:path'
import { fileURLToPath } from 'node:url'
import { allExamples } from '../docs/.vitepress/catalog.ts'

const base = '/mc-examples/'
const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const outputRoot = resolve(repositoryRoot, 'docs/.vitepress/dist')

function toPosix(value: string): string {
  return value.split(sep).join('/')
}

async function collectFiles(directory: string): Promise<string[]> {
  const entries = await readdir(directory, { withFileTypes: true })
  const nested = await Promise.all(entries.map(async (entry) => {
    const path = resolve(directory, entry.name)
    return entry.isDirectory() ? collectFiles(path) : [toPosix(relative(outputRoot, path))]
  }))
  return nested.flat()
}

function outputCandidates(url: string): string[] {
  const pathname = decodeURIComponent(new URL(url, 'https://mc-examples.invalid').pathname)
  const localPath = pathname.slice(base.length).replace(/^\//, '')
  if (!localPath) return ['index.html']
  if (localPath.endsWith('/')) return [`${localPath}index.html`]
  if (/\.[a-z0-9]+$/i.test(localPath)) return [localPath]
  return [`${localPath}.html`, `${localPath}/index.html`]
}

const files = new Set(await collectFiles(outputRoot))
const htmlFiles = [...files].filter((file) => file.endsWith('.html'))
const errors: string[] = []
let checkedReferences = 0

for (const htmlFile of htmlFiles) {
  const html = await readFile(resolve(outputRoot, htmlFile), 'utf8')
  for (const match of html.matchAll(/\b(?:href|src)=["']([^"']+)["']/g)) {
    const url = match[1]
    if (url.startsWith(base)) {
      checkedReferences += 1
      const candidates = outputCandidates(url)
      if (!candidates.some((candidate) => files.has(candidate))) {
        errors.push(`${htmlFile}: missing ${url}`)
      }
    } else if (url.startsWith('/') && !url.startsWith('//')) {
      errors.push(`${htmlFile}: absolute path escapes ${base}: ${url}`)
    }
  }
}

for (const example of allExamples) {
  const page = `${example.route.replace(/^\//, '')}.html`
  if (!files.has(page)) errors.push(`Missing generated page: ${page}`)
}

if (errors.length > 0) {
  console.error(errors.join('\n'))
  process.exitCode = 1
} else {
  console.log(`Built-link validation passed: ${htmlFiles.length} HTML files and ${checkedReferences} base-path references.`)
}

import { readFile, readdir } from 'node:fs/promises'
import { dirname, relative, resolve, sep } from 'node:path'
import { fileURLToPath } from 'node:url'
import { allExamples } from '../docs/.vitepress/catalog.ts'

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')

function toPosix(value: string): string {
  return value.split(sep).join('/')
}

function headingAnchor(heading: string): string {
  const slug = heading
    .normalize('NFKD')
    .toLowerCase()
    .trim()
    .replace(/[`'’]/g, '')
    .replace(/[^\p{Letter}\p{Number}\s-]/gu, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
  return /^\d/.test(slug) ? `_${slug}` : slug
}

async function collectMCodeFiles(directory: string): Promise<string[]> {
  const entries = await readdir(directory, { withFileTypes: true })
  const nested = await Promise.all(entries.map(async (entry) => {
    const path = resolve(directory, entry.name)
    if (entry.isDirectory()) {
      if (entry.name === 'node_modules' || entry.name === 'docs' || entry.name === '.git') return []
      return collectMCodeFiles(path)
    }
    return entry.name.endsWith('.mc') ? [toPosix(relative(repositoryRoot, path))] : []
  }))
  return nested.flat()
}

const errors: string[] = []
const ids = new Set<string>()
const routes = new Set<string>()

for (const example of allExamples) {
  if (ids.has(example.id)) errors.push(`Duplicate example ID: ${example.id}`)
  if (routes.has(example.route)) errors.push(`Duplicate route: ${example.route}`)
  ids.add(example.id)
  routes.add(example.route)

  const readmePath = resolve(repositoryRoot, example.readme)
  let readme = ''
  try {
    readme = await readFile(readmePath, 'utf8')
  } catch {
    errors.push(`Missing README: ${example.readme}`)
  }

  const headings = [...readme.matchAll(/^#{2,4}\s+(.+?)(?:\s+\{#[^}]+\})?\s*$/gm)]
  const anchors = headings.map((match) => headingAnchor(match[1]))
  if (!anchors.includes(example.anchor)) {
    errors.push(`Missing README anchor ${example.anchor} in ${example.readme}`)
  }
  if (!readme.includes(`<!-- #region ${example.anchor} -->`) || !readme.includes(`<!-- #endregion ${example.anchor} -->`)) {
    errors.push(`Missing README include region ${example.anchor} in ${example.readme}`)
  }

  for (const source of example.files) {
    try {
      await readFile(resolve(repositoryRoot, source), 'utf8')
    } catch {
      errors.push(`Missing MCode source: ${source}`)
    }
  }

  const pagePath = resolve(repositoryRoot, 'docs', `${example.route.replace(/^\//, '')}.md`)
  let page = ''
  try {
    page = await readFile(pagePath, 'utf8')
  } catch {
    errors.push(`Missing documentation page: docs${example.route}.md`)
    continue
  }

  const pageDirectory = dirname(pagePath)
  const readmeImport = `${toPosix(relative(pageDirectory, readmePath))}#${example.anchor}`
  if (!page.includes(`<!--@include: ${readmeImport}-->`)) {
    errors.push(`Incorrect README include in docs${example.route}.md`)
  }

  for (const source of example.files) {
    const sourceImport = toPosix(relative(pageDirectory, resolve(repositoryRoot, source)))
    if (!page.includes(`<<< ${sourceImport}{text:line-numbers}`)) {
      errors.push(`Missing code import for ${source} in docs${example.route}.md`)
    }
  }
}

const discoveredIds = new Set(
  (await collectMCodeFiles(repositoryRoot))
    .map((file) => file.match(/(?:^|\/)(\d{3})(?:-|\/)/)?.[1])
    .filter((id): id is string => Boolean(id)),
)

for (const id of discoveredIds) {
  if (!ids.has(id)) errors.push(`Uncataloged numbered example: ${id}`)
}
for (const id of ids) {
  if (!discoveredIds.has(id)) errors.push(`Catalog ID has no numbered source: ${id}`)
}

if (errors.length > 0) {
  console.error(errors.join('\n'))
  process.exitCode = 1
} else {
  console.log(`Catalog validation passed: ${allExamples.length} examples, ${new Set(allExamples.map((example) => example.readme)).size} READMEs, ${allExamples.reduce((total, example) => total + example.files.length, 0)} source references.`)
}

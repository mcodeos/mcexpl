import { readFileSync } from 'node:fs'
import { fileURLToPath } from 'node:url'
import { defineConfig } from 'vitepress'
import { makeSidebar } from './catalog'

// The version face: one file at the root of the repository.  It holds
// the version alone -- the batch number is a coordinate of the release,
// not a part of the version.
const repoRoot = fileURLToPath(new URL('../../', import.meta.url))
const version = readFileSync(`${repoRoot}VERSION`, 'utf-8').trim()

// The build number: the version and the batch of the release this site
// was built in.  The batch arrives in the environment; a site built
// outside a release carries no batch and says so.
const batch = process.env.MCC_BUILD_NR?.replace(/^b/, '')
const build = batch ? `${version}.b${batch}` : version

export default defineConfig({
  lang: 'en-US',
  title: 'MC Examples',
  description: 'Learn MCode through practical circuits and focused language examples.',
  base: '/mcexpl/',
  cleanUrls: true,
  lastUpdated: true,
  head: [
    ['meta', { name: 'theme-color', content: '#f7f8f8' }],
    ['meta', { name: 'mcode-version', content: version }],
    ['meta', { name: 'mcode-build', content: build }],
  ],
  markdown: {
    lineNumbers: false,
    config(md) {
      md.core.ruler.after('block', 'mcode-as-text', (state) => {
        for (const token of state.tokens) {
          if (token.type === 'fence' && token.info.trim().startsWith('mc')) {
            token.info = token.info.replace(/^mc\b/, 'text')
          }
        }
      })
    },
  },
  themeConfig: {
    nav: [
      { text: 'Tutorial', link: '/tutorial/' },
      { text: 'Recipes', link: '/recipes/' },
      { text: 'Language Reference', link: '/reference/' },
      { text: 'GitHub', link: 'https://github.com/mcodeos/mcexpl' },
    ],
    sidebar: makeSidebar(),
    search: {
      provider: 'local',
      options: {
        detailedView: true,
      },
    },
    outline: {
      level: [2, 3],
      label: 'On this page',
    },
    appearance: true,
    lastUpdated: {
      text: 'Last updated',
    },
    editLink: {
      pattern: 'https://github.com/mcodeos/mcexpl/edit/main/docs/:path',
      text: 'Edit this page on GitHub',
    },
    docFooter: {
      prev: 'Previous',
      next: 'Next',
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/mcodeos/mcexpl' },
    ],
    footer: {
      message: 'MCode examples for practical circuit descriptions.',
      copyright: `MC Examples · build ${build}`,
    },
  },
})

import { defineConfig } from 'vitepress'
import { makeSidebar } from './catalog'

export default defineConfig({
  lang: 'en-US',
  title: 'MC Examples',
  description: 'Learn MCode through practical circuits and focused language examples.',
  base: '/mc-examples/',
  cleanUrls: true,
  lastUpdated: true,
  head: [
    ['meta', { name: 'theme-color', content: '#f7f8f8' }],
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
      { text: 'GitHub', link: 'https://github.com/mcodeos/mc-examples' },
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
      pattern: 'https://github.com/mcodeos/mc-examples/edit/main/docs/:path',
      text: 'Edit this page on GitHub',
    },
    docFooter: {
      prev: 'Previous',
      next: 'Next',
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/mcodeos/mc-examples' },
    ],
    footer: {
      message: 'MCode examples for practical circuit descriptions.',
      copyright: 'MC Examples',
    },
  },
})

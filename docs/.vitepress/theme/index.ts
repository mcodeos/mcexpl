import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'
import BookHome from './components/BookHome.vue'
import SectionIndex from './components/SectionIndex.vue'
import './styles.css'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('BookHome', BookHome)
    app.component('SectionIndex', SectionIndex)
  },
} satisfies Theme

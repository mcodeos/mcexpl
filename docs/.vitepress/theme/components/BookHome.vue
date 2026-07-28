<script setup lang="ts">
import { withBase } from 'vitepress'
import { catalog } from '../../catalog'
</script>

<template>
  <main class="book-home">
    <header class="book-intro">
      <p class="book-kicker">MCode learning guide</p>
      <h1>MC Examples</h1>
      <p class="book-summary">
        Learn MCode through practical circuits and focused language examples.
        Follow the tutorial in order, browse application recipes, or look up a
        language feature directly.
      </p>
      <a class="book-start" :href="withBase('/tutorial/00/001-power-net')">
        Start Tutorial
      </a>
    </header>

    <section class="book-directory" aria-labelledby="directory-title">
      <div class="directory-heading">
        <p class="book-kicker">Reading directory</p>
        <h2 id="directory-title">Browse the book</h2>
      </div>

      <div class="section-list">
        <section v-for="section in catalog" :key="section.key" class="directory-section">
          <div class="section-heading">
            <div>
              <h3><a :href="withBase(section.link)">{{ section.title }}</a></h3>
              <p>{{ section.description }}</p>
            </div>
            <span>{{ section.chapters.reduce((total, chapter) => total + chapter.examples.length, 0) }} examples</span>
          </div>

          <div class="chapter-grid">
            <article v-for="chapter in section.chapters" :key="chapter.id" class="chapter-card">
              <h4>{{ chapter.title }}</h4>
              <p>{{ chapter.description }}</p>
              <ol>
                <li v-for="example in chapter.examples" :key="example.id">
                  <a :href="withBase(example.route)">{{ example.title }}</a>
                </li>
              </ol>
            </article>
          </div>
        </section>
      </div>
    </section>
  </main>
</template>

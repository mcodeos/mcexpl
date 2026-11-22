<script setup lang="ts">
import { withBase } from 'vitepress'
import { catalog } from '../../catalog'

// The open half of the stack: the repositories a reader can read, build, and
// ship.  The closed half has no repository here -- it is reached through the
// gateway, and the gateway link below is the only route to it.
const stack = [
  {
    name: 'mcc',
    url: 'https://github.com/mcodeos/mcc',
    what: 'The MCC compiler: parsing, checks, and visualization.',
  },
  {
    name: 'mcfam',
    url: 'https://github.com/mcodeos/mcfam',
    what: 'Abstract component families.',
  },
  {
    name: 'mcparts',
    url: 'https://github.com/mcodeos/mcparts',
    what: 'Real device packs.',
  },
  {
    name: 'mcaps',
    url: 'https://github.com/mcodeos/mcaps',
    what: 'Power and interface recipes.',
  },
]
</script>

<template>
  <main class="book-home">
    <header class="book-intro">
      <p class="book-kicker">MCode Bench</p>
      <h1>MCode Bench</h1>
      <p class="book-summary">
        The public face of the MCode stack: a circuit description language, a
        compiler, an open library, and the examples that show how they fit
        together. Learn MCode through practical circuits and focused language
        examples.
      </p>
      <p class="book-actions">
        <a class="book-start" :href="withBase('/tutorial/00/001-power-net')">
          Start Tutorial
        </a>
        <a class="book-secondary" :href="withBase('/toolchain/')">
          The toolchain map
        </a>
        <a class="book-secondary" :href="withBase('/gateway/')">
          The MCode gateway
        </a>
      </p>
    </header>

    <section class="book-stack" aria-labelledby="stack-title">
      <div class="directory-heading">
        <p class="book-kicker">Open stack</p>
        <h2 id="stack-title">What is open</h2>
      </div>
      <p class="section-lead">
        The language, the compiler, the families, the device packs, and the
        recipes are open source. Closed capabilities are served through the
        MCode gateway, which is the only door to them. The
        <a :href="withBase('/toolchain/')">toolchain map</a> shows how the
        layers fit together.
      </p>
      <div class="stack-grid">
        <article v-for="repo in stack" :key="repo.name" class="stack-card">
          <h3><a :href="repo.url">{{ repo.name }}</a></h3>
          <p>{{ repo.what }}</p>
        </article>
      </div>
    </section>

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

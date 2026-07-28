<script setup lang="ts">
import { computed } from 'vue'
import { withBase } from 'vitepress'
import { catalog, type SectionKey } from '../../catalog'

const props = defineProps<{ section: SectionKey }>()
const current = computed(() => catalog.find((entry) => entry.key === props.section)!)
</script>

<template>
  <div class="section-index">
    <p class="section-lead">{{ current.description }}</p>
    <div class="chapter-grid">
      <article v-for="chapter in current.chapters" :key="chapter.id" class="chapter-card">
        <h2>{{ chapter.title }}</h2>
        <p>{{ chapter.description }}</p>
        <ol>
          <li v-for="example in chapter.examples" :key="example.id">
            <a :href="withBase(example.route)">
              <span>{{ example.title }}</span>
              <small>{{ example.summary }}</small>
            </a>
          </li>
        </ol>
      </article>
    </div>
  </div>
</template>

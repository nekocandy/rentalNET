<script setup lang="ts">
const NAVIGATION_ITEMS = [
  {
    name: 'Look for Rentals',
    path: '/rental',
  },
  {
    name: 'My Rentals',
    path: '/my-rentals',
  },
  {
    name: 'Auto Payment',
    path: '/auto-pay',
  },
]
</script>

<template>
  <div flex flex-col gap-4>
    <h1 font-bold text-2xl>
      Home
    </h1>
    <div grid grid-cols-4 gap-8>
      <NuxtLink v-for="path in NAVIGATION_ITEMS" :key="path.path" :to="path.path" border-4 px-4 py-4 flex items-center justify-center class="hover:bg-teal-800">
        {{ path.name }}
      </NuxtLink>
    </div>
  </div>
</template>

<style scoped>

</style>

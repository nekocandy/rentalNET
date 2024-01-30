<script setup lang="ts">

</script>

<template>
  <div flex flex-col gap-4 h-screen py-8 px-8 class="bg-teal-900/80" font-mono text-white>
    <main flex-1 bg-teal-900 px-4 py-4 overflow-x-auto>
      <slot />
    </main>

    <div>
      <BottomBar />
    </div>
  </div>
</template>

<style scoped>

</style>

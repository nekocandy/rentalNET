<script setup lang="ts">

</script>

<template>
  <div flex flex-col gap-8 h-screen py-8 px-12 class="bg-teal-900/80" font-mono text-white>
    <main flex-1 bg-teal-900>
      <slot />
    </main>

    <div>
      <BottomBar />
    </div>
  </div>
</template>

<style scoped>

</style>

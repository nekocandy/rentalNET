<script setup lang="ts">
import FlowImage from '~/assets/flow.svg'
</script>

<template>
  <div border-2 border-teal-900 px-8 py-4>
    <div v-if="isUserLoggedIn">
      {{ isUserLoggedIn }}
    </div>

    <div v-else flex items-center gap-4>
      <span text-white text-3xl font-bold font-mono>
        Made with
      </span>
      <img h-12 :src="FlowImage" alt="">
    </div>
  </div>
</template>

<style scoped>

</style>

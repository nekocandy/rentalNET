<script setup lang="ts">
consola.info('Hello from home page', userData.value)
</script>

<template>
  <div>
    Data: {{ JSON.stringify(userData) }}
  </div>
</template>

<style scoped>

</style>

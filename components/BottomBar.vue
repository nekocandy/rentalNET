<script setup lang="ts">
import FlowImage from '~/assets/flow.svg'

const router = useRouter()
const shouldShowLogo = computed(() => {
  return !isUserLoggedIn.value || router.currentRoute.value.path === '/'
})

watch(isUserLoggedIn, (value) => {
  if (!value && router.currentRoute.value.path !== '/')
    router.push('/')
})
</script>

<template>
  <div border-2 border-teal-900 px-8 py-4>
    <div v-if="shouldShowLogo" flex items-center gap-4>
      <span text-white text-3xl font-bold font-mono>
        Made with
      </span>
      <img h-12 :src="FlowImage" alt="">
    </div>

    <div v-else>
      {{ userData }}
    </div>
  </div>
</template>

<style scoped>

</style>

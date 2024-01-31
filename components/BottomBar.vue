<script setup lang="ts">
import FlowImage from '~/assets/flow.svg'
import { unauthenticate } from '~/utils/flow/auth'

const router = useRouter()
const shouldShowLogo = computed(() => {
  return !isUserLoggedIn.value || router.currentRoute.value.path === '/'
})

watch(isUserLoggedIn, (value) => {
  if (!value && router.currentRoute.value.path !== '/')
    router.push('/')
})

onMounted(() => {
  if (!isUserLoggedIn.value && router.currentRoute.value.path !== '/')
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

    <div v-else flex items-center justify-between gap-8>
      <NuxtLink to="/home" flex items-center gap-4>
        <div>
          <img src="" alt="">
        </div>

        <span>Kirai</span>
      </NuxtLink>

      <div flex items-center gap-4>
        <!-- navigation -->
      </div>

      <div flex items-center gap-2>
        <div h-8 w-8 rounded-full bg-blue i-material-symbols-account-circle />

        <span>{{ userData?.addr }}</span>

        <button py-2 px-4 bg-red rounded-md @click="unauthenticate">
          <div i-ic-baseline-logout />
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>

<script setup lang="ts">
import FlowImage from '~/assets/flow.svg'
import { logIn } from '~/utils/flow/auth'

async function login() {
  await logIn()
}
</script>

<template>
  <div flex flex-col h-full items-center justify-center gap-12>
    <div v-if="!isUserLoggedIn">
      <button flex items-end gap-4 px-4 bg-teal-800 px-6 py-4 border-2 @click="login">
        <div text-2xl font-bold>
          Log in with
        </div>
        <img h-8 :src="FlowImage" alt="">
      </button>
    </div>

    <div v-else flex flex-col gap-6>
      <div text-2xl font-bold>
        Welcome, {{ userData?.addr }}
      </div>

      <NuxtLink to="/home" w-full text-center px-4 bg-teal-700 px-6 py-4 border-2>
        Continue to Home
      </NuxtLink>
    </div>
  </div>
</template>

<style scoped>

</style>

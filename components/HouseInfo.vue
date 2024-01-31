<script setup lang="ts">
import { faker } from '@faker-js/faker'

defineProps<{
  image: string
}>()

const amount = faker.number.int({ min: 180, max: 2000 })
const location = faker.location.city()
</script>

<template>
  <div flex flex-col gap-4 px-4 py-4 bg-teal-700 border-4>
    <div
      h-52 w-full bg-red bg-cover bg-center bg-no-repeat :style="{
        backgroundImage: `url(${image})`,
      }"
    />

    <div>
      <div flex items-center gap-2>
        <h2 font-bold text-xl>
          Location:
        </h2>
        <h2 text-xl>
          {{ location }}
        </h2>
      </div>

      <div flex items-center gap-2>
        <h2 font-bold text-xl>
          Rent:
        </h2>
        <h2 text-xl>
          {{ amount }} $FLOW
        </h2>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>

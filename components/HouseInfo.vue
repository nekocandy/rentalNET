<script setup lang="ts">
import { faker } from '@faker-js/faker'

const props = defineProps<{
  image: string
}>()
const router = useRouter()
const amount = faker.number.int({ min: 180, max: 2000 })
const location = faker.location.city()

function onRentClick() {
  router.push({
    path: '/rent',
    query: {
      location,
      amount,
      image: props.image,
    },
  })
}
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

    <button px-8 py-2 font-bold w-full bg-teal-800 border-2 @click="onRentClick">
      Rent
    </button>
  </div>
</template>

<style scoped>

</style>

<script setup lang="ts">
const houseId = nanoid(10)

const router = useRouter()
const { query } = useRoute()
const { OWNER_ADDRESS } = useRuntimeConfig().public

const location = query.location as string
const amount = query.amount as string
const image = query.image as string

onMounted(() => {
  if (!location || !amount || !image)
    router.push('/home')
})
</script>

<template>
  <div flex flex-col gap-8>
    <h1 font-bold text-2xl>
      Rent House
    </h1>
    <div flex items-center gap-8>
      <div
        h-120 class="w-1/2" bg-red bg-cover bg-center bg-no-repeat :style="{
          backgroundImage: `url(${image})`,
        }"
      />

      <div flex flex-col gap-4>
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

        <div flex items-center gap-2>
          <h2 font-bold text-xl>
            House Owner:
          </h2>
          <h2 text-xl>
            {{ OWNER_ADDRESS }}
          </h2>
        </div>

        <div flex items-center gap-2>
          <h2 font-bold text-xl>
            ID:
          </h2>
          <h2 text-xl>
            {{ houseId }}
          </h2>
        </div>

        <button px-8 py-2 font-bold w-full bg-teal-800 border-2>
          Rent
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>

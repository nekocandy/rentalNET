<script setup lang="ts">
import { faker } from '@faker-js/faker'
import format from 'format-duration'
import { getMyRentals } from '~/utils/flow/utils'

defineProps<{
  id: string
  location: string
  amount: string
  image: string
  txnId: string
}>()
const amount = faker.number.int({ min: 180, max: 2000 })
const location = faker.location.city()

const remainingTime = ref('')

function formatTime() {
  const endDate = dayjs().add(2, 'day').endOf('month').diff()
  remainingTime.value = format(endDate)
}

onMounted(async () => {
  await getMyRentals()

  setInterval(formatTime, 1000)
})
</script>

<template>
  <div flex flex-col gap-4 px-4 py-4 bg-teal-700 border-4>
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

    <div text-center px-8 py-2 font-bold w-full bg-teal-800 border-2>
      Next Auto Payment: {{ remainingTime }}
    </div>
  </div>
</template>

<style scoped>

</style>

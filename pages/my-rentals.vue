<script setup lang="ts">
import { getMyRentals } from '~/utils/flow/utils'

const isLoading = ref(false)

async function getMyRentalsLocal() {
  isLoading.value = true
  await getMyRentals()
  isLoading.value = false
}

onMounted(async () => {
  await getMyRentalsLocal()
})
</script>

<template>
  <div flex flex-col gap-8>
    <h1 font-bold text-2xl>
      My Rentals
    </h1>
    <div v-if="!isLoading && myRentals.length" grid grid-cols-3 gap-8>
      <RentalHouseInfo
        v-for="house in myRentals"
        :id="house.house_information.id"
        :key="house.house_information.id"
        :location="house.house_information.location"
        :amount="house.rental_price"
        :txn-id="house.agreement_txn"
        :house="house"
        :image="house.house_information.image"
      />
    </div>

    <div v-else>
      You need to rent a house first!
    </div>
  </div>
</template>

<style scoped>

</style>

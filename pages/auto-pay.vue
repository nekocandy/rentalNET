<script setup lang="ts">

</script>

<template>
  <div flex flex-col gap-8>
    <h1 font-bold text-2xl>
      Auto Payment
    </h1>

    <div v-if="myRentals.length" grid grid-cols-3 gap-8>
      <RentalPayment
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

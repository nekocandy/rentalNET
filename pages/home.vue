<script setup lang="ts">
consola.info('Hello from home page', userData.value)

const houses = [
  {
    id: nanoid(),
    name: 'House 1',
    image: 'https://housing.com/news/wp-content/uploads/2022/11/shutterstock_1715891752-1200x700-compressed.jpg',
  },
]
</script>

<template>
  <div flex flex-col gap-8>
    <h1 font-bold text-2xl>
      Browse Homes
    </h1>
    <div grid grid-cols-3 gap-8>
      <HouseInfo v-for="house in houses" :key="house.id" :house="house" :image="house.image" />
    </div>
  </div>
</template>

<style scoped>

</style>

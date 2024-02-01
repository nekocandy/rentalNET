<script setup lang="ts">
import * as fcl from '@onflow/fcl'
import GET_REQUESTS from '~/cadence/scripts/getMaintenanceRequests.cdc?raw'
import ADD_REQUEST from '~/cadence/transactions/createMaintenanceRequest.cdc?raw'
import RESOLVE_REQUEST from '~/cadence/transactions/resolveMaintenanceRequest.cdc?raw'
import type { ReportData } from '~/utils/types'

const content = ref('')
const isLoading = ref(true)
const requests = ref<ReportData[]>([])

async function getRequests() {
  isLoading.value = true
  const data = await fcl.query({
    cadence: GET_REQUESTS,
  })

  requests.value = data
  consola.info('requests', requests.value)
  isLoading.value = false
}

async function submitRequest() {
  const reportId = nanoid(10)
  const requestPromise = push.promise(`Submitting Request on FLOW Blockchain | Id: ${reportId}`)
  const txn = await fcl.mutate({
    cadence: ADD_REQUEST,
    // @ts-expect-error no typings
    args: (arg, t) => [
      arg(reportId, t.String),
      arg(content.value, t.String),
      arg(userData.value?.addr, t.Address),
    ],
  })

  TransactionModals.value.push({
    title: 'Submitting Maintenance Request',
    transactionId: txn,
  })

  await fcl.tx(txn).onceSealed()
  content.value = ''
  requestPromise.resolve('Done')
  await getRequests()
}

async function resolveRequest(reportId: string) {
  const requestPromise = push.promise(`Resolving Request on FLOW Blockchain | Id: ${reportId}`)
  const txn = await fcl.mutate({
    cadence: RESOLVE_REQUEST,
    // @ts-expect-error no typings
    args: (arg, t) => [
      arg(reportId, t.String),
      arg(false, t.Bool),
    ],
  })

  TransactionModals.value.push({
    title: 'Resolving Maintenance Request',
    transactionId: txn,
  })

  await fcl.tx(txn).onceSealed()
  requestPromise.resolve('Done')
  await getRequests()
}

onMounted(async () => {
  await getRequests()
})
</script>

<template>
  <div flex flex-col gap-8>
    <h1 font-bold text-2xl>
      Transparent Maintenance Requests
    </h1>

    <div flex items-center gap-8>
      <textarea v-model="content" text-black border-4 class="focus:outline-none" px-4 py-2 border-black flex-1 placeholder="Enter your request to your landlord here" />
      <button :disabled="!content.length" border-4 px-8 py-2 h-full class="disabled:(cursor-not-allowed text-zinc-400 border-zinc-400)" @click="submitRequest">
        Submit
      </button>
    </div>

    <div v-if="requests.length" grid grid-cols-4>
      <div v-for="data in requests" :key="data.report_id" border-4 px-4 py-4 flex flex-col gap-6 w-full>
        <div flex items-center justify-between>
          Report ID: {{ data.report_id }}
          <span class="text-sm">
            {{ dayjs((Number(data.report_timestamp).toPrecision() as any as number) * 1000).format('DD/MM/YYYY HH:mm A') }}
          </span>
        </div>

        <div>
          {{ data.report_content }}
        </div>

        <div flex items-center justify-between>
          <div flex items-center gap-1>
            <span font-black text-xs>Reporter:</span>
            <span class="text-xs">
              {{ data.report_user }}
            </span>
          </div>

          <div v-if="data.report_open" flex items-center gap-1>
            <button :disabled="userData?.addr !== data.report_user" border-2 border-teal-200 px-2 py-1 h-full class="disabled:(cursor-not-allowed text-zinc-400 border-zinc-400)" @click="resolveRequest(data.report_id)">
              Resolve
            </button>
          </div>

          <div v-else>
            <span class="text-xs">
              Resolved
            </span>
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      No Maintenance Requests
    </div>
  </div>
</template>

<style scoped>

</style>

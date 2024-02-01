<script setup lang="ts">
import * as fcl from '@onflow/fcl'
import GET_REQUESTS from '~/cadence/scripts/getNotices.cdc?raw'
import ADD_REQUEST from '~/cadence/transactions/createNotice.cdc?raw'
import RESOLVE_REQUEST from '~/cadence/transactions/resolveNotice.cdc?raw'
import type { NoticeData } from '~/utils/types'

const content = ref('')
const isLoading = ref(true)
const requests = ref<NoticeData[]>([])

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
  const noticeId = nanoid(10)
  const requestPromise = push.promise(`Submitting Request on FLOW Blockchain | Id: ${noticeId}`)
  const txn = await fcl.mutate({
    cadence: ADD_REQUEST,
    // @ts-expect-error no typings
    args: (arg, t) => [
      arg(noticeId, t.String),
      arg(content.value, t.String),
      arg(userData.value?.addr, t.Address),
    ],
  })

  TransactionModals.value.push({
    title: 'Submitting Notice',
    transactionId: txn,
  })

  await fcl.tx(txn).onceSealed()
  content.value = ''
  requestPromise.resolve('Done')
  await getRequests()
}

async function resolveRequest(noticeId: string) {
  const requestPromise = push.promise(`Resolving Notice on FLOW Blockchain | Id: ${noticeId}`)
  const txn = await fcl.mutate({
    cadence: RESOLVE_REQUEST,
    // @ts-expect-error no typings
    args: (arg, t) => [
      arg(noticeId, t.String),
      arg(false, t.Bool),
    ],
  })

  TransactionModals.value.push({
    title: 'Resolving Notice',
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
      Notices
    </h1>

    <div flex items-center gap-8>
      <textarea v-model="content" text-black border-4 class="focus:outline-none" px-4 py-2 border-black flex-1 placeholder="Enter Notice for tenants here" />
      <button :disabled="!content.length" border-4 px-8 py-2 h-full class="disabled:(cursor-not-allowed text-zinc-400 border-zinc-400)" @click="submitRequest">
        Submit
      </button>
    </div>

    <div v-if="requests.length" grid grid-cols-4>
      <div v-for="data in requests" :key="data.notice_id" border-4 px-4 py-4 flex flex-col gap-6 w-full bg-lime-200 text-black>
        <div flex items-center justify-between>
          Notice ID: {{ data.notice_id }}
          <span class="text-sm">
            {{ dayjs((Number(data.notice_timestamp).toPrecision() as any as number) * 1000).format('DD/MM/YYYY HH:mm A') }}
          </span>
        </div>

        <div>
          {{ data.notice_content }}
        </div>

        <div flex items-center justify-between>
          <div flex items-center gap-1>
            <span font-black text-xs>Issued By:</span>
            <span class="text-xs">
              {{ data.notice_user }}
            </span>
          </div>

          <div v-if="data.notice_open" flex items-center gap-1>
            <button :disabled="userData?.addr !== data.notice_user" border-2 border-teal-200 px-2 py-1 h-full class="disabled:(cursor-not-allowed text-zinc-400 border-zinc-400)" @click="resolveRequest(data.notice_id)">
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
      No Notices
    </div>
  </div>
</template>

<style scoped>

</style>

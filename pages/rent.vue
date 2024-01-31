<script setup lang="ts">
import * as fcl from '@onflow/fcl'
import RENT_AGREEMENT from '~/cadence/transactions/acceptRentAgreement.cdc?raw'
import { sendFlow } from '~/utils/flow/utils'

const router = useRouter()
const { query } = useRoute()
const { OWNER_ADDRESS } = useRuntimeConfig().public

const houseId = nanoid(10)
const location = query.location as string
const amount = query.amount as string
const image = query.image as string
const termsAccepted = ref(false)
const securityDeposit = ref(2000)
const securityDepositPaid = ref(false)
const termsAcceptedTxnId = ref<string | null>(null)
const securityDepositTxnId = ref<string | null>(null)

async function acceptTerms() {
  const tosPromise = push.promise('Initiating Terms agreement transaction...')

  const tx = await fcl.mutate({
    cadence: RENT_AGREEMENT,
    // @ts-expect-error no typings available
    args: (arg, t) => [
      arg(
        { identifier: `KiraiRentAgreement_ID_${houseId}`, domain: 'storage' },
        t.Path,
      ),
    ],
  })

  TransactionModals.value.push({
    title: `Terms agreement for ${houseId}`,
    transactionId: tx,
  })

  await fcl.tx(tx).onceSealed()
  tosPromise.resolve('Terms agreement executed successfully!')
  termsAccepted.value = true
  termsAcceptedTxnId.value = tx
}

async function sendSecurityDeposit() {
  if (!termsAccepted.value)
    return

  const rentPromise = push.promise('Initiating Security Deposit transaction...')

  const tx = await sendFlow(OWNER_ADDRESS, securityDeposit.value.toString())

  TransactionModals.value.push({
    title: `Security Deposit for ${houseId}`,
    transactionId: tx,
  })

  await fcl.tx(tx).onceSealed()
  securityDepositPaid.value = true
  securityDepositTxnId.value = tx
  rentPromise.resolve('Security Deposit sent successfully!')
}

async function sendRent() {
  if (!termsAccepted.value)
    return

  const rentPromise = push.promise('Initiating Rent transaction...')

  const tx = await sendFlow(OWNER_ADDRESS, amount.toString())

  TransactionModals.value.push({
    title: `Rent for ${houseId}`,
    transactionId: tx,
  })

  await fcl.tx(tx).onceSealed()
  rentPromise.resolve('Rent sent successfully!')
}

onMounted(() => {
  if (!location || !amount || !image)
    router.push('/home')
})
</script>

<template>
  <div flex flex-col gap-8 pb-4>
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
      </div>
    </div>

    <div flex items-center gap-8>
      <div flex flex-col gap-4>
        <h1 text-3xl font-bold>
          Terms:
        </h1>

        <ul>
          <li><strong>Cleanliness:</strong> The tenant agrees to maintain the premises in a clean and sanitary condition.</li>
          <li><strong>Trash Disposal:</strong> Properly dispose of all trash in designated bins and follow local waste disposal regulations.</li>
          <li><strong>Appliance Care:</strong> Take reasonable care of all appliances provided by the landlord.</li>
          <li><strong>Reporting Damages:</strong> Promptly report any damages or maintenance issues to the landlord or property manager.</li>
          <li><strong>Yard Maintenance:</strong> If applicable, the tenant is responsible for maintaining the yard and outdoor spaces as outlined in the agreement.</li>
          <li><strong>Pest Control:</strong> Cooperate in preventing and addressing pest issues by keeping the premises clean and promptly reporting any signs of infestation.</li>
          <li><strong>Smoke Detectors:</strong> Test and maintain smoke detectors regularly; report any malfunctions for prompt repairs.</li>
          <li><strong>Inspections:</strong> Allow the landlord to conduct periodic inspections for maintenance and safety purposes, with reasonable advance notice.</li>
          <li><strong>Alterations:</strong> Obtain written permission from the landlord before making any alterations or additions to the property.</li>
        </ul>
      </div>
    </div>

    <div flex items-center gap-8>
      <div flex flex-col gap-2>
        <button :disabled="termsAccepted" px-12 py-2 bg-teal-700 border-2 class="disabled:(opacity-70 cursor-not-allowed)" @click="acceptTerms">
          Accept Terms!
        </button>
        <NuxtLink v-if="termsAcceptedTxnId" text-xs underline hover:underline-double :to="`https://testnet.flowdiver.io/tx/${termsAcceptedTxnId}`" target="_blank" text-sm>
          Txn: {{ termsAcceptedTxnId }}
        </NuxtLink>
      </div>
      <div flex flex-col gap-2>
        <button :disabled="!termsAccepted" px-12 py-2 bg-teal-700 border-2 class="disabled:(opacity-70 cursor-not-allowed)" @click="sendSecurityDeposit">
          Security Deposit ({{ securityDeposit }} $FLOW)
        </button>

        <NuxtLink v-if="securityDepositPaid" text-xs underline hover:underline-double :to="`https://testnet.flowdiver.io/tx/${securityDepositTxnId}`" target="_blank" text-sm>
          Txn: {{ securityDepositTxnId }}
        </NuxtLink>
      </div>

      <div flex flex-col gap-2>
        <button :disabled="!termsAccepted || !securityDepositPaid" px-12 py-2 bg-teal-700 border-2 class="disabled:(opacity-70 cursor-not-allowed)" @click="sendRent">
          Rent and Save Details on FLOW
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>

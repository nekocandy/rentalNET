import type { CurrentUser } from '@onflow/typedefs'
import { ref } from 'vue'
import type { RentalInformation } from './types'

export const userData = ref<CurrentUser | null>()
export const isUserLoggedIn = computed(() => !!userData.value?.addr)
export const myRentals = ref<RentalInformation[]>([])
export const TransactionModals = ref<{
  title: string
  transactionId: string
}[]>([])

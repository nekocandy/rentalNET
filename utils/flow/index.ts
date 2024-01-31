import { config } from '@onflow/fcl'
import flowJSON from '../../flow.json'

const runtimeConfig = useRuntimeConfig().public
export const network: 'mainnet' | 'testnet' | 'emulator' = (runtimeConfig.NETWORK as 'mainnet' | 'testnet' | 'emulator') || 'emulator'

const fclConfigInfo = {
  emulator: {
    accessNode: 'http://127.0.0.1:8888',
    discoveryWallet: 'http://localhost:8701/fcl/authn',
    discoveryAuthInclude: [],
  },
  testnet: {
    accessNode: 'https://rest-testnet.onflow.org',
    discoveryWallet: 'https://fcl-discovery.onflow.org/testnet/authn',
    discoveryAuthInclude: [],
  },
  mainnet: {
    accessNode: 'https://rest-mainnet.onflow.org',
    discoveryWallet: 'https://fcl-discovery.onflow.org/authn',
    discoveryAuthInclude: [],
  },
}

const { NC_ADDRESS } = runtimeConfig

const ANCRESSES: Record<string, string> = {}

Object.entries(flowJSON.contracts)
  .filter(([_, value]) => typeof value === 'object')
  .map(([key, contract]) => ANCRESSES[`0x${key}`] = `0x${(contract as any).aliases[network]}`)

config({
  'app.detail.title': 'RentalNET',
  'app.detail.icon': 'https://pycz.dev/favicon.svg',
  'flow.network': network,
  'accessNode.api': fclConfigInfo[network].accessNode,
  'discovery.wallet': fclConfigInfo[network].discoveryWallet,
  'discovery.authn.include': fclConfigInfo[network].discoveryAuthInclude,
  '0xNC': NC_ADDRESS,
  ...ANCRESSES,
}).load({ flowJSON })

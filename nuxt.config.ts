import { env } from 'std-env'
import flowConfig from './flow.json'

export default defineNuxtConfig({
  ssr: false,
  devtools: { enabled: true },
  app: {
    head: {
      title: 'opinionated nuxt',
      meta: [
        {
          name: 'description',
          content: 'an opinionated nuxt starter template',
        },
      ],
      link: [
        {
          rel: 'icon',
          href: '/oink.svg',
        },
      ],
    },
  },
  build: {
    transpile: ['trpc-nuxt'],
  },
  features: {
    inlineStyles: false,
  },
  modules: [
    '@vueuse/nuxt',
    'notivue/nuxt',
    '@unocss/nuxt',
    '@sidebase/nuxt-auth',
    '@formkit/auto-animate/nuxt',
  ],
  css: [
    '@unocss/reset/tailwind.css',
    'notivue/notifications.css',
    'notivue/animations.css',
    'md-editor-v3/lib/style.css',
  ],
  imports: {
    imports: [
      {
        name: 'nanoid',
        from: 'nanoid',
      },
      {
        name: 'consola',
        from: 'consola',
      },
    ],
  },
  auth: {
    isEnabled: false,
  },
  runtimeConfig: {
    public: {
      NETWORK: env.NETWORK,
      NC_ADDRESS: env.NC_ADDRESS || flowConfig.accounts.default.address,
      OWNER_ADDRESS: env.OWNER_ADDRESS,
    },
  },
})

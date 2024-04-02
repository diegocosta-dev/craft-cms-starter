/// <reference types="vite/client" />

declare global {
  interface Window {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    Alpine: any,
  }
}

export {}

const path = require('path')

module.exports = {
  plugins: {
    'postcss-import': {},

    'tailwindcss/nesting': {},

    tailwindcss: {},

    autoprefixer: {},

    ...(process.env.NODE_ENV === 'production'
      ? {
          cssnano: {
            preset: ['default', {discardComments: {removeAll: true}}]
          }
        }
      : {})

    // ...(process.env.NODE_ENV === "production"
    //   ? {
    //       "postcss-extract-media-query": {},
    //     }
    //   : {}),
  }
}

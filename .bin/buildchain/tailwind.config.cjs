/** @type {import('tailwindcss').Config} */
module.exports = {
  presets: [require('./tailwind.preset.cjs')],
  content: [
    './cms/templates/**/*.{twig,html}',
    './cms/config/redactor/**/*.json',
    './src/js/**/*.{js,ts}',
  ],
  safelist: [],
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms')
  ],
};

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    '../lib/**/*.{ex,leex,heex}',
    '../lib/**/*_live.ex',
    './js/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif']
      },
      colors: {
        primary: {
          50: '#f0f9ff',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          800: '#1e40af',
          900: '#1e3a8a'
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography')
  ],
}

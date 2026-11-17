// tailwind.config.js

export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],

  theme: {
    extend: {
      fontFamily: {
        gilroy: ["Gilroy", "sans-serif"],
      },
    },
  },

  plugins: [],
}
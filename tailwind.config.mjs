/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {
			colors: {
				brand: '#80ab97',
				brandLight: '#cbecdd',
				brandDark: '#386D56',
				brandDarkDark: '#1f3a2d',
				accent: '#F97316',
				bgColor: '#FFFFFF',
				textColor: '#102611'
			},
			fontFamily: {
				sans: ['Inter', 'sans-serif']
			}
		},
	},
	plugins: [],
}

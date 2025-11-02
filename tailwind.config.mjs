/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {
			fontFamily: {
				poppins: ['Poppins', 'sans-serif'],
				manrope: ['Manrope', 'sans-serif'],
			},
			colors: {
				'mdmy-dark': '#38404a',
				'mdmy-gray': '#4a5661',
			},
		},
	},
	plugins: [],
}

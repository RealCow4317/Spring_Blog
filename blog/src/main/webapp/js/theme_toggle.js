(() => {
    'use strict'

    const storedTheme = localStorage.getItem('theme')

    const getPreferredTheme = () => {
        if (storedTheme) return storedTheme
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }

    const setTheme = (theme) => {
        if (theme === 'auto') {
            document.documentElement.removeAttribute('data-bs-theme')
        } else {
            document.documentElement.setAttribute('data-bs-theme', theme)
        }
    }

    // 초기 테마 설정
    setTheme(getPreferredTheme())

    window.addEventListener('DOMContentLoaded', () => {
        const themeButtons = document.querySelectorAll('[data-theme-value]')

        themeButtons.forEach(button => {
            button.addEventListener('click', () => {
                const theme = button.getAttribute('data-theme-value')
                localStorage.setItem('theme', theme)
                setTheme(theme)

                // 버튼 활성화 표시
                themeButtons.forEach(btn => btn.classList.remove('active'))
                button.classList.add('active')
            })
        })
    })
})()

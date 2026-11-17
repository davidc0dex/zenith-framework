<template>
    <div class="flex flex-col items-end mt-[2vh]">
        <TransitionGroup name="notify">
            <div v-for="notify in notifications" 
                 :key="notify.id" 
                 class="flex flex-row-reverse items-stretch max-w-[24vh] mt-[0.75vh] overflow-hidden border-r-[0.2vh] px-[1vh] py-[0.65vh]"
                 :class="styles[notify.type].wrapper">

                <span class="font-gilroy text-white text-[1vh] text-right leading-[1.25]">
                    <span class="font-bold" :class="styles[notify.type].text">{{ styles[notify.type].label }}:</span>
                    {{ notify.message }}
                </span>
            </div>
        </TransitionGroup>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
type NotifyType = 'success' | 'error' | 'warning' | 'info'

interface Notification {
    id: number
    type: NotifyType
    message: string
    duration: number
}

const notifications = ref<Notification[]>([])

const styles = {
    success: {
        wrapper: 'bg-gradient-to-l from-green-400/30 via-green-400/10 via-55% to-transparent border-green-400',
        text: 'text-green-400',
        label: 'Success'
    },

    error: {
        wrapper: 'bg-gradient-to-l from-red-400/30 via-red-400/10 via-55% to-transparent border-red-400',
        text: 'text-red-400',
        label: 'Error'
    },

    warning: {
        wrapper: 'bg-gradient-to-l from-yellow-400/30 via-yellow-400/10 via-55% to-transparent border-yellow-400',
        text: 'text-yellow-400',
        label: 'Warning'
    },

    info: {
        wrapper: 'bg-gradient-to-l from-blue-400/30 via-blue-400/10 via-55% to-transparent border-blue-400',
        text: 'text-blue-400',
        label: 'Info'
    }
}

function createNotify(type: NotifyType, message: string, duration = 5000) {
    const id = Date.now() + Math.random()
    notifications.value.push({ id, type, message, duration })

    const audio = new Audio('sounds/notify.mp3')
    audio.volume = 0.3
    audio.play()

    setTimeout(() => {
        notifications.value = notifications.value.filter(notify => notify.id !== id)
    }, duration)
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'notify') {
        createNotify(event.data.notifyType, event.data.message, event.data.duration)
    }
})
</script>

<style scoped>
.notify-enter-active,
.notify-leave-active {
    transition: all 0.25s ease;
}

.notify-enter-from,
.notify-leave-to {
    opacity: 0;
    transform: translateX(5vh);
}
</style>
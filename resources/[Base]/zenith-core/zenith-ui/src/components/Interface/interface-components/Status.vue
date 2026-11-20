<template>
    <div class="absolute left-[2.5vh] bottom-[2.5vh] flex flex-row items-end">
        <div v-if="isMapVisible" class="MapBorder duration-500 rounded-[1.1vh] h-[17.70vh] w-[30.7vh] transition-all"></div>
        <div v-if="isMapVisible" class="MapBorder duration-500 rounded-[1.1vh] h-[17.70vh] w-[27.7vh] transition-all"></div>

        <div class="flex items-center gap-[0.75vh] pl-[0.5vh]">
            <div v-if="Status.health > 0" class="flex flex-col items-center gap-[0.5vh]">
                <div class="relative w-[3vh] h-[3vh] bg-red-400/20 rounded-[0.35vh] overflow-hidden">
                    <div class="absolute bottom-0 left-0 w-full bg-red-400 transition-all duration-200" :style="{ height: (Status.health || 0) + '%' }"></div>
                    <i class="fas fa-heart absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white text-[1.25vh]" />
                </div>
                <span class="font-gilroy text-white text-[1vh] font-bold">
                    {{ Status.health || 0 }}%
                </span>
            </div>

            <div v-if="Status.armor > 0" class="flex flex-col items-center gap-[0.5vh]">
                <div class="relative w-[3vh] h-[3vh] bg-blue-400/20 rounded-[0.35vh] overflow-hidden">
                    <div class="absolute bottom-0 left-0 w-full bg-blue-400 transition-all duration-200" :style="{ height: (Status.armor || 0) + '%' }"></div>
                    <i class="fas fa-shield-alt absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white text-[1.25vh]" />
                </div>
                <span class="font-gilroy text-white text-[1vh] font-bold">
                    {{ Status.armor || 0 }}%
                </span>
            </div>

            <div class="flex flex-col items-center gap-[0.5vh]">
                <div class="relative w-[3vh] h-[3vh] bg-yellow-400/20 rounded-[0.35vh] overflow-hidden">
                    <div class="absolute bottom-0 left-0 w-full bg-yellow-400 transition-all duration-200" :style="{ height: (Status.stamina || 0) + '%' }"></div>
                    <i class="fas fa-bolt absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white text-[1.25vh]" />
                </div>
                <span class="font-gilroy text-white text-[1vh] font-bold">
                    {{ Status.stamina || 0 }}%
                </span>
            </div>
            <div class="flex flex-col items-center gap-[0.5vh]">
                <div class="relative w-[3vh] h-[3vh] bg-orange-400/20 rounded-[0.35vh] overflow-hidden">
                    <div class="absolute bottom-0 left-0 w-full bg-orange-400 transition-all duration-200" :style="{ height: (Status.hunger || 0) + '%' }"></div>
                    <i class="fas fa-drumstick-bite absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white text-[1.25vh]" />
                </div>
                <span class="font-gilroy text-white text-[1vh] font-bold">
                    {{ Status.hunger || 0 }}%
                </span>
            </div>

            <div class="flex flex-col items-center gap-[0.5vh]">
                <div class="relative w-[3vh] h-[3vh] bg-cyan-400/20 rounded-[0.35vh] overflow-hidden">
                    <div class="absolute bottom-0 left-0 w-full bg-cyan-400 transition-all duration-200" :style="{ height: (Status.thirst || 0) + '%' }"></div>
                    <i class="fas fa-tint absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-white text-[1.25vh]" />
                </div>
                <span class="font-gilroy text-white text-[1vh] font-bold">
                    {{ Status.thirst || 0 }}%
                </span>
            </div>
        </div>

    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const Status = ref({
    health: 100,
    armor: 0,
    stamina: 100,
    hunger: 100,
    thirst: 100,
})

const isMapVisible = ref(false)

const handleMessage = (event: MessageEvent) => {
    const data = event.data

    if (data.type === 'hudStatus') {
        if (data.health !== undefined) Status.value.health = data.health
        if (data.armor !== undefined) Status.value.armor = data.armor
        if (data.hunger !== undefined) Status.value.hunger = data.hunger
        if (data.thirst !== undefined) Status.value.thirst = data.thirst
    }
    if (data.type === 'hudStamina') {
        if (data.stamina !== undefined) Status.value.stamina = data.stamina
    }

    if (data.action === "displayRadar" || data.interface === "map") {
        isMapVisible.value = data.show
    }
}

onMounted(() => {
    window.addEventListener('message', handleMessage)
})

onUnmounted(() => {
    window.removeEventListener('message', handleMessage)
})
</script>

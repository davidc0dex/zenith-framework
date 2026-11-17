<template>
    <div class="absolute right-[3vh] top-[2.5vh] flex flex-col items-end">
        <div class="flex flex-row-reverse items-center gap-[0.75vh]">
            <span class="font-gilroy text-white text-[3vh] italic font-black" style="text-shadow: 0 0 1px rgb(0, 0, 0);">zenith</span>
            <div class="flex items-center flex-row-reverse gap-[0.75vh] -mb-[0.5vh]">
                <i class="fas fa-fingerprint mr-[0.45vh] text-[1.15vh] text-white"></i>
                <span class="font-gilroy text-white/60 text-[1.15vh] font-semibold" style="text-shadow: 0 0 1px rgb(0, 0, 0);">UID: <span class="text-white">{{ HudData.uID }}</span></span>
            </div>
            <div class="flex items-center flex-row-reverse gap-[0.75vh] -mb-[0.5vh]">
                <i class="fas fa-globe mr-[0.25vh] text-[1.15vh] text-white"></i>
                <span class="font-gilroy text-white/60 text-[1.15vh] tracking-[1px] font-semibold" style="text-shadow: 0 0 1px rgb(0, 0, 0);">{{ HudData.onlinePlayers }}</span>
            </div>
        </div>
        
        <div class="flex flex-row-reverse gap-[0.5vh] items-center">
            <span class="font-gilroy font-[700] text-[1.25vh] transition-colors duration-300" 
                  :class="cashColorClass"
                  style="text-shadow: 0 0 1px rgb(0, 0, 0);">
                {{ formatMoney(Math.floor(displayCash)) }} <span class="text-green-400">$</span>
            </span>

            <Transition name="fade-money">
                <span v-if="displayMinus > 0" class="font-gilroy text-red-400 bg-red-400/20 text-[1vh] font-[700] leading-none py-[0.2vh] px-[0.8vh] mr-[0.5vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">
                    -{{ formatMoney(Math.floor(displayMinus)) }}$
                </span>
            </Transition>

            <Transition name="fade-money">
                <span v-if="displayPlus > 0" class="font-gilroy text-green-400 bg-green-400/20 text-[1vh] font-[700] leading-none py-[0.2vh] px-[0.8vh] mr-[0.5vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">
                    +{{ formatMoney(Math.floor(displayPlus)) }}$
                </span>
            </Transition>
        </div>
        
        <Notify />
    </div>
</template>

<script setup lang="ts">
import Notify from './Notify.vue';
import { ref, computed } from 'vue';
import { formatMoney } from '../../../composables/functions';

const HudData = ref({
    uID: 0,
    onlinePlayers: 0,
    cashMoney: 0,
    minusMoney: 0,
    plusMoney: 0
})

const displayCash = ref(0)
const displayPlus = ref(0)
const displayMinus = ref(0)
const cashStatus = ref<'idle' | 'up' | 'down'>('idle')

const cashColorClass = computed(() => {
    if (cashStatus.value === 'up') return 'text-green-400'
    if (cashStatus.value === 'down') return 'text-red-400'
    return 'text-white'
})

function animateValue(start: number, end: number, duration: number, onUpdate: (val: number) => void, onComplete?: () => void) {
    const startTime = performance.now()
    
    function update(now: number) {
        const elapsed = now - startTime
        const progress = Math.min(elapsed / duration, 1)
        
        const currentValue = start + (end - start) * progress
        onUpdate(currentValue)
        
        if (progress < 1) {
            requestAnimationFrame(update)
        } else if (onComplete) {
            onComplete()
        }
    }
    
    requestAnimationFrame(update)
}

let plusTimeout: ReturnType<typeof setTimeout>
let minusTimeout: ReturnType<typeof setTimeout>

window.addEventListener('message', (event) => {
    if (event.data.type === 'updateHud') {
        const newData = event.data.hudData
        
        HudData.value.uID = newData.uID
        HudData.value.onlinePlayers = newData.onlinePlayers

        if (newData.plusMoney && newData.plusMoney > 0) {
            clearTimeout(plusTimeout)
            displayPlus.value = 0
            
            cashStatus.value = 'up'
            animateValue(displayCash.value, newData.cashMoney, 800, (v) => displayCash.value = v)
            
            animateValue(0, newData.plusMoney, 1000, 
                (v) => displayPlus.value = v,
                () => {
                    plusTimeout = setTimeout(() => {
                        displayPlus.value = 0
                        cashStatus.value = 'idle'
                    }, 2000)
                }
            )
        }
        
        else if (newData.minusMoney && newData.minusMoney > 0) {
            clearTimeout(minusTimeout)
            displayMinus.value = 0
            
            cashStatus.value = 'down'
            animateValue(displayCash.value, newData.cashMoney, 800, (v) => displayCash.value = v)
            
            animateValue(0, newData.minusMoney, 1000, 
                (v) => displayMinus.value = v,
                () => {
                    minusTimeout = setTimeout(() => {
                        displayMinus.value = 0
                        cashStatus.value = 'idle'
                    }, 2000)
                }
            )
        } 
        
        else {
            displayCash.value = newData.cashMoney
            cashStatus.value = 'idle'
        }
    }
});
</script>

<style scoped>
.fade-money-enter-active,
.fade-money-leave-active {
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.fade-money-enter-from {
    opacity: 0;
    transform: translateY(-0.5vh);
}

.fade-money-leave-to {
    opacity: 0;
    transform: translateY(0.5vh);
}
</style>
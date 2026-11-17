<template>
<<<<<<< HEAD
    <div v-if="visible" class="absolute inset-0 w-full h-full overflow-hidden select-none flex flex-col justify-center pl-[10vh] py-[15vh]">
=======
    <div v-if="!visible" class="absolute inset-0 w-full h-full overflow-hidden select-none flex flex-col justify-center pl-[10vh] py-[15vh]">
>>>>>>> 918d4112a3c3d19b0b3f6825593fb349dd46996c
        <img src="/Images/auth-bg.png" alt="auth-bg" class="absolute top-0 left-0 opacity-30 w-full z-[-1] h-full object-cover pointer-events-none select-none" draggable="false"></img>
        <img src="/Images/auth-bg.png" alt="auth-bg" class="absolute top-0 left-0 w-full z-[-1] h-full object-cover pointer-events-none select-none" draggable="false"></img>
        <div class="w-[41vh] h-[6vh] flex items-center justify-between">
            <div class="flex flex-col">
                <span class="font-gilroy text-white text-[4.25vh] font-black leading-[1.1]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Zenith <span class="text-white/50">Register</span></span>
            <span class="font-gilroy text-white/60 text-[1.15vh] mt-[0.25vh] max-w-[30vh] leading-[1.2]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Enter your credentials to access the server. Start your journey into the world of zenith.</span>
            </div>
            <div class="w-[4.5vh] h-[4.5vh] flex items-center mt-[1vh] transition-all duration-300 hover:bg-red-400/75 group justify-center shrink-0 bg-red-400/20 rounded-[0.75vh]">
                <i class="fa-sharp fa-solid fa-arrow-right-from-arc rotate-180 text-red-400/60 transition-colors duration-300 group-hover:text-[#121212]"></i>
            </div>
        </div>
        <div class="flex flex-col gap-[1vh] mt-[3vh]">
            <div class="w-[41vh] flex items-center justify-center flex-col">
                <span class="self-start font-gilroy text-white/60 text-[1.15vh] mb-[0.5vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Carte de identitate</span>
                <div class="w-full flex items-center justify-center gap-[1vh]">
                    <div class="w-1/2 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-user text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="Nume" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                    <div class="w-1/2 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-user text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="Prenume" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                </div>
            </div>
            <div class="w-[41vh] flex items-center flex-col">
                <span class="self-start font-gilroy text-white/60 text-[1.15vh] mb-[0.5vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Data de nastere & Inaltimea ta</span>
                <div class="w-full flex items-center justify-center gap-[1vh]">
                    <div class="w-1/3 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-calendar text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="ZZ" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                    <div class="w-1/3 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-calendar text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="LL" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                    <div class="w-1/3 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-calendar text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="AAAA" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                    <div class="w-1/3 h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center">
                        <i class="fas fa-ruler-vertical text-white/15 text-[1.5vh]"></i>
                        <input type="text" placeholder="Height" class="bg-transparent w-full h-full text-white/80 text-[1.25vh] focus:outline-none ml-[1vh]" />
                    </div>
                </div>
            </div>
            <div class="w-[41vh] flex items-center justify-start flex-row gap-[1vh]">
                <div class="flex w-1/2 flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Par</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[1.5vh] text-[1.25vh] w-full block truncate text-center">Clariana</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <div class="flex w-1/2 flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Par Facial</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[1.5vh] text-[1.25vh] w-full block truncate text-center">Santiago</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <Slider label="Similaritate" />
            </div>
            <div class="w-[41vh] flex items-center justify-start flex-row gap-[1vh]">
                <div class="flex flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Par</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[2.5vh] text-[1.25vh] w-full block truncate text-center">1</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <div class="flex flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Par Facial</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[2.5vh] text-[1.25vh] w-full block truncate text-center">1</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <Slider />
            </div>
            <div class="w-[41vh] flex items-center justify-start flex-row gap-[1vh]">
                <div class="flex flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Par pe piept</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[2.5vh] text-[1.25vh] w-full block truncate text-center">1</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <Slider />
                <div class="flex flex-col gap-[0.5vh]">
                    <span class="font-gilroy text-white/60 text-[1.15vh]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">Sprancene</span>
                    <div class="w-full h-[6vh] bg-white/5 rounded-[0.75vh] px-[2vh] flex items-center justify-between">
                        <i class="fa-solid fa-angle-left text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                        <span class="text-white/50 px-[2.5vh] text-[1.25vh] w-full block truncate text-center">1</span>
                        <i class="fa-solid fa-angle-right text-white text-[1.25vh] leading-[1] mt-[0.25vh]"></i>
                    </div>
                </div>
                <Slider />
            </div>
            <div class="w-[41vh] h-[6vh] flex items-center">
                <div @click="toggleAgreement" :class="agreementChecked ? 'bg-green-400/10' : 'bg-red-400/5'" class="w-[2.75vh] h-[2.75vh] rounded-[0.5vh] shrink-0 flex items-center justify-center">
                    <i :class="agreementChecked ? 'text-green-400' : 'text-red-400/60'" class="fas fa-x text-[1vh]"></i>
                </div>
                <span class="font-gilroy text-white/60 text-[1.15vh] ml-[1vh] leading-[1.2]" style="text-shadow: 0 0 1px rgb(0, 0, 0);">I read the terms and conditions and I agree to them lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet</span>
            </div>
            <div class="w-[41vh] gap-[1vh] flex items-center">
                <div class="w-[6vh] h-[6vh] flex items-center transition-all duration-300 hover:bg-white/15 group justify-center shrink-0 bg-white/5 rounded-[0.75vh]">
                    <i class="fas fa-dice text-white/15 transition-colors duration-300 group-hover:text-white/60"></i>
                </div>
                <div class="hover:opacity-60 transition-opacity duration-300 w-full h-[6vh] bg-white rounded-[0.75vh] text-[#121212] font-gilroy font-black text-[1.75vh] flex items-center justify-center cursor-pointer">
                    Register Account
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import Slider from './Range.vue';

const visible = ref(false);
const agreementChecked = ref(false);

const toggleAgreement = () => { agreementChecked.value = !agreementChecked.value; };
</script>

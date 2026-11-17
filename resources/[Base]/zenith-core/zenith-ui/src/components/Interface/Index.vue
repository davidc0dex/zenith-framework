<script setup>
import RightHud from './interface-components/RightHud.vue';
import Status from './interface-components/Status.vue';
</script>

<template>
    <div class="absolute inset-0 w-full h-full overflow-hidden select-none">
        <div class="absolute right-[-30vh] top-[-23vh] w-[67vh] h-[32vh] rounded-full bg-[#000] blur-[13vh]"></div>
        <div class="absolute left-[-30vh] top-[-23vh] w-[67vh] h-[32vh] rounded-full bg-[#000] blur-[13vh]"></div>

        <RightHud />
        <Status />
    </div>
</template>
<template>
  <span>
    <svg v-if="name === 'chevron-bottom'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M4,12 15,24 26,12"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
    </svg>
    <svg v-if="name === 'chevron-left'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M18,4 6,15 18,26"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
    </svg>
    <svg v-if="name === 'chevron-right'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M12,4 24,15 12,26"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
    </svg>
    <svg v-if="name === 'chevron-top'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M4,18 15,6 26,18"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
    </svg>

    <svg v-if="name === 'chevron-bottom-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path
        d="M4,10 12,18 20,10"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
      />
    </svg>
    <svg v-if="name === 'chevron-left-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path
        d="M14,4 6,12 14,20"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
      />
    </svg>
    <svg v-if="name === 'chevron-right-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path
        d="M10,4 18,12 10,20"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
      />
    </svg>
    <svg v-if="name === 'chevron-top-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path
        d="M4,14 12,6 20,14"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
      />
    </svg>

    <svg v-if="name === 'close'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path d="M4,26 26,4" fill="none" stroke-linecap="round" stroke-width="3" />
      <path d="M4,4 26,26" fill="none" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'close-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path d="M4,20 20,4" fill="none" stroke-linecap="round" stroke-width="3" />
      <path d="M4,4 20,20" fill="none" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'delete'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M4,6 8,26 22,26 26,6"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
      <path d="M10,4 20,4" stroke-linecap="round" stroke-width="3" />
      <path d="M15,12 15,26" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'edit'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path
        d="M14,4 4,4 4,26 26,26 26,16"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="3"
      />
      <path d="M14,16 27,3" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'edit-small'" :height="size || 24" :width="size || 24" viewBox="0 0 24 24">
      <path
        d="M10,4 4,4 4,20 20,20 20,14"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
      />
      <path d="M12,12 21,3" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'menu'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path d="M4,4 26,4" fill="none" stroke-linecap="round" stroke-width="3" />
      <path d="M4,15 26,15" fill="none" stroke-linecap="round" stroke-width="3" />
      <path d="M4,26 26,26" fill="none" stroke-linecap="round" stroke-width="3" />
    </svg>

    <svg v-if="name === 'options'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <circle cx="5" cy="15" r="3" stroke-width="0" />
      <circle cx="15" cy="15" r="3" stroke-width="0" />
      <circle cx="25" cy="15" r="3" stroke-width="0" />
    </svg>

    <svg v-if="name === 'plus'" :height="size || 30" :width="size || 30" viewBox="0 0 30 30">
      <path d="M4,15 26,15" fill="none" stroke-linecap="round" stroke-width="3" />
      <path d="M15,4 15,26" fill="none" stroke-linecap="round" stroke-width="3" />
    </svg>
  </span>
</template>

<script>
export default {
  name: "IconClose",
  props: {
    name: {
      type: String,
      default: "close"
    },
    size: {
      type: String
    }
  }
};
</script>

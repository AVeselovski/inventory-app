<template>
<span>
  <svg v-if="name === 'close' && !small" height="30" width="30">
    <path d="M4,26 26,4" stroke-width="3" stroke-linecap="round" />
    <path d="M4,4 26,26" stroke-width="3" stroke-linecap="round" />
  </svg>

  <svg v-if="name === 'close' && small" height="30" width="30">
    <path d="M8,22 22,8" stroke-width="3" stroke-linecap="round" />
    <path d="M8,8 22,22" stroke-width="3" stroke-linecap="round" />
  </svg>

  <svg v-if="name === 'edit' && !small" width="30" height="30">
    <path
      d="M14,4 4,4 4,26 26,26 26,16"
      stroke-width="3"
      stroke-linecap="round"
      stroke-linejoin="round"
    />
    <path d="M14,16 27,3" stroke-width="3" stroke-linecap="round" />
  </svg>

  <svg v-if="name === 'edit' && small" width="30" height="30">
    <path
      d="M14,8 8,8 8,22 22,22 22,16"
      stroke-width="3"
      stroke-linecap="round"
      stroke-linejoin="round"
    />
    <path d="M16,14 23,7" stroke-width="3" stroke-linecap="round" />
  </svg>

  <svg v-if="name === 'menu'" height="30" width="30">
    <path d="M4,4 26,4" stroke-width="3" stroke-linecap="round" />
    <path d="M4,15 26,15" stroke-width="3" stroke-linecap="round" />
    <path d="M4,26 26,26" stroke-width="3" stroke-linecap="round" />
  </svg>

  <svg v-if="name === 'plus'" width="30" height="30">
    <path d="M4,15 26,15" stroke-width="3" stroke-linecap="round" />
    <path d="M15,4 15,26" stroke-width="3" stroke-linecap="round" />
  </svg>
</span>
</template>

<script>
export default {
  name: 'IconClose',
  props: {
    name: {
      type: String,
      default: 'close'
    },
    small: {
      type: Boolean,
      default: false
    }
  }
}
</script>

<template>
<span>
  <svg v-if="name === 'chevron-bottom' && !small" height="30" width="30">
    <path d="M4,12 15,24 26,12" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" />
  </svg>
  <svg v-if="name === 'chevron-left' && !small" height="30" width="30">
    <path d="M18,4 6,15 18,26" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" />
  </svg>
  <svg v-if="name === 'chevron-right' && !small" height="30" width="30">
    <path d="M12,4 24,15 12,26" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" />
  </svg>
  <svg v-if="name === 'chevron-top' && !small" height="30" width="30">
    <path d="M4,18 15,6 26,18" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'chevron-bottom' && small" height="24" width="24">
    <path d="M4,10 12,18 20,10" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
  </svg>
  <svg v-if="name === 'chevron-left' && small" height="24" width="24">
    <path d="M14,4 6,12 14,20" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
  </svg>
  <svg v-if="name === 'chevron-right' && small" height="24" width="24">
    <path d="M10,4 18,12 10,20" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
  </svg>
  <svg v-if="name === 'chevron-top' && small" height="24" width="24">
    <path d="M4,14 12,6 20,14" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
  </svg>

  <svg v-if="name === 'close' && !small" height="30" width="30">
    <path d="M4,26 26,4" stroke-linecap="round" stroke-width="3" />
    <path d="M4,4 26,26" stroke-linecap="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'close' && small" height="24" width="24">
    <path d="M4,20 20,4" stroke-linecap="round" stroke-width="3" />
    <path d="M4,4 20,20" stroke-linecap="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'edit' && !small" height="30" width="30">
    <path
      d="M14,4 4,4 4,26 26,26 26,16"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="3"
    />
    <path d="M14,16 27,3" stroke-linecap="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'edit' && small" height="24" width="24">
    <path
      d="M10,4 4,4 4,20 20,20 20,14"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="2"
    />
    <path d="M12,12 21,3" stroke-linecap="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'menu'" height="30" width="30">
    <path d="M4,4 26,4" stroke-linecap="round" stroke-width="3" />
    <path d="M4,15 26,15" stroke-linecap="round" stroke-width="3" />
    <path d="M4,26 26,26" stroke-linecap="round" stroke-width="3" />
  </svg>

  <svg v-if="name === 'plus'"  height="30" width="30">
    <path d="M4,15 26,15" stroke-linecap="round" stroke-width="3" />
    <path d="M15,4 15,26" stroke-linecap="round" stroke-width="3" />
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

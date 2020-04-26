<template>
  <div
    class="dropdown"
    v-on-clickaway="close"
  >
    <slot name="trigger" :toggle="toggle">
      <button></button>
    </slot>
    <div v-show="isActive" class="dropdown-menu" :class="[position, { 'active': isActive }]">
      <slot name="items"></slot>
    </div>
  </div>
</template>

<script>
import { mixin as clickaway } from 'vue-clickaway';

export default {
  props: {
    position: {
      type: String,
      default: 'bottom-left'
    } 
  },
  mixins: [ clickaway ],
  data() {
    return {
      isActive: false,
    }
  },
  methods: {
    close() {
      this.isActive = false
    },
    toggle() {
      this.isActive = !this.isActive;
    }
  }
};
</script>
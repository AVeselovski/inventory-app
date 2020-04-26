<template>
  <transition name="modal-animation" v-on:after-leave="afterLeave">
    <div
      @click="onClose"
      aria-describedby="modalDescription"
      aria-labelledby="modalTitle"
      class="modal"
      role="dialog"
      tabindex="-1"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <header class="modal-header" id="modalTitle" v-if="this.$slots.header">
            <h5 class="modal-title">
              <slot name="header"></slot>
            </h5>
            <button @click="close" aria-label="Close" class="btn-icon btn-icon-highlight" type="button" >
              <icon aria-hidden="true" name="close-small" size="18"></icon>
            </button>
          </header>

          <section class="modal-body" id="modalDescription">
            <slot name="body"></slot>
          </section>

          <footer class="modal-footer">
            <button @click="close" aria-label="Close" class="btn btn-secondary" type="button">{{ dismissMsg }}</button>
            <slot name="footer"></slot>
          </footer>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import Icon from '../components/icon.vue'

export default {
  name: 'Modal',
  components: {
    Icon
  },
  props: {
    dismissMsg: {
      type: String,
      default: 'Cancel'
    }
  },
  methods: {
    close() {
      this.$emit('close');
    },
    onClose(e) {
      if (e.target.className === 'modal') this.close()
    },
    afterLeave() {
      this.$emit('afterLeave');
    }
  }
}
</script>

<style lang="scss" scoped>
  .modal-animation-enter,
  .modal-animation-leave-active {
    opacity: 0;

    .modal-dialog {
      transform: translateY(-16px);
    }
  }
  .modal-animation-enter-active,
  .modal-animation-leave-active {
    transition: opacity 350ms cubic-bezier(0.23, 1, 0.32, 1);

    .modal-dialog {
      transition: transform 350ms cubic-bezier(0.23, 1, 0.32, 1);
    }
  }
</style>

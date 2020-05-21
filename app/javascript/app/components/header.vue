<template>
  <div class="header" id="header">
    <div class="header__left">
      <slot name="left"></slot>
    </div>
    <div class="header__center">
      <slot name="center"></slot>
    </div>
    <div class="header__right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: "Header"
};
</script>

<style lang="scss" scoped>
.header {
  align-content: center;
  display: inline-grid;
  grid-template-columns: 20% auto 20%;
  height: 80px;
  left: 0;
  pointer-events: none;
  position: fixed;
  right: 0;
  top: 0;
  width: 100%;

  &__left {
    align-self: center;
    grid-column-start: 1;
    justify-self: left;
    pointer-events: auto;
    text-align: left;
  }

  &__center {
    align-self: center;
    grid-column-start: 2;
    justify-self: center;
    pointer-events: auto;
    text-align: center;
  }

  &__right {
    align-self: center;
    grid-column-start: 3;
    justify-self: right;
    pointer-events: auto;
    text-align: right;
  }
}
</style>

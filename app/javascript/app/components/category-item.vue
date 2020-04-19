<template>
<div class="category__item">
  <div class="flex">
  <button @click="editItem" class="btn-icon btn-icon-muted"><icon name="edit" small></icon></button>
  <span>{{ item.name }}</span>
  </div>
  <div class="flex">
    <span class="text-m danger mr-2">{{ item.quantity }}</span>
    <button @click="onRemoveItem" class="btn-icon btn-icon-danger"><icon name="close" small></icon></button>
  </div>
</div>
</template>

<script>
import Icon from '../components/icon.vue'

export default {
  name: 'CategoryItem',
  props: {
    item: {
      type: Object
    }
  },
  methods: {
    editItem() {},
    onRemoveItem() {
      this.$emit('remove-item')
    },
  },
  components: { Icon }
}
</script>

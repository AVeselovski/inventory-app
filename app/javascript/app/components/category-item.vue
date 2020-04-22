<template>
<div class="category__item" :class="[isDraggable && 'is-draggable']">
  <div class="flex justify-between">
    <div v-if="!isEditing" class="flex">
      <button @click="startEditing" class="btn-icon btn-icon-muted mr-1"><icon name="edit" small></icon></button>
      <span>{{ item.name }}</span>
    </div>
    <div v-if="!isEditing" class="flex">
      <button @click="subtract" class="btn-icon btn-icon-muted"><icon name="chevron-left" small></icon></button>
      <span class="text-m" :class="[quantityClass]">x{{ item.quantity }}</span>
      <button @click="increase" class="btn-icon btn-icon-muted"><icon name="chevron-right" small></icon></button>
    </div>
  </div>

  <form v-if="isEditing" class="my-1">
    <input
      v-model="item.name"
      class="input"
      :class="[errors && errors.name && 'input-error']"
      ref="editItemNameInput"
      type="text"
    >
    <div v-if="errors && errors.name">
      <span class="text-s danger">{{ _showError(errors.name) }}</span>
    </div>
    <div class="flex align-top mt-2">
      <div class="mr-1">
        <label for="item-quantity">Quantity</label>
        <input
          v-model="item.quantity"
          class="input"
          :class="[errors && errors.quantity && 'input-error']"
          id="item-quantity"
          min="0"
          ref="editItemQuantityInput"
          type="number"
        >
      </div>
      <div class="ml-1">
        <label for="item-min-quantity">Minimum</label>
        <input
          v-model="item.minimum"
          class="input"
          :class="[errors && errors.minimum && 'input-error']"
          id="item-min-quantity"
          min="0"
          ref="editItemMinQuantityInput"
          type="number"
        >
      </div>
    </div>
    <div v-if="errors && errors.quantity">
      <span class="text-s danger">{{ _showError(errors.quantity) }}</span>
    </div>
    <div v-if="errors && errors.minimum">
      <span class="text-s danger">{{ _showError(errors.minimum) }}</span>
    </div>
    <div class="flex justify-between mt-2">
      <div class="flex">
        <button @click.prevent="updateItem" class="btn btn-success btn-m mr-2" type="submit">Edit</button>
        <button @click="stopEditing" class="btn-icon" type="button"><icon name="close" small></icon></button>
      </div>
      <a @click.prevent="onRemoveItem" class="link-danger" href="#">Remove</a>
    </div>
  </form>
</div>
</template>

<script>
import Rails from '@rails/ujs'
import { getError } from '../helpers'
import Icon from '../components/icon.vue'

export default {
  name: 'CategoryItem',
  data: function() {
    return {
      errors: null,
      isEditing: false
    }
  },
  props: {
    item: {
      type: Object
    }
  },
  computed: {
    quantityClass() {
      switch (true) {
        case (this.item.quantity < this.item.minimum):
          return 'danger'
        case (this.item.quantity > this.item.minimum):
          return 'success'
        default:
          return 'warning';
      }
    },
    isDraggable() {
      return !this.isEditing
    }
  },
  methods: {
    _showError(err) {
      return getError(err)
    },
    onRemoveItem() {
      this.$emit('remove-item')
    },
    startEditing() {
      this.isEditing = true
    },
    stopEditing() {
      this.isEditing = false
    },
    increase() {
      this.item.quantity += 1

      this.updateItemQuantity()
    },
    subtract() {
      if (this.item.quantity !== 0) this.item.quantity -= 1

      this.updateItemQuantity()
    },
    updateItemQuantity() {
      const data = new FormData
      data.append("item[quantity]", this.item.quantity)

      Rails.ajax({
        url: `/items/${this.item.id}`,
        type: "PATCH",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
        }
      })
    },
    updateItem() {
      const data = new FormData
      data.append("item[name]", this.item.name)
      data.append("item[quantity]", this.item.quantity)
      data.append("item[minimum]", this.item.minimum)

      Rails.ajax({
        url: `/items/${this.item.id}`,
        type: "PUT",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
          this.errors = error
        },
        success: data => {
          this.errors = null
          this.$nextTick(() => { this.isEditing = false })
        }
      })
    }
  },
  components: { Icon }
}
</script>

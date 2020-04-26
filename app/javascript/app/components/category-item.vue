<template>
<div class="category__item" :class="[isDraggable && 'is-draggable']">
  <div class="flex justify-between">
    <div v-if="!isEditing" class="flex">
      <button @click="startEditing" class="btn-icon btn-icon-muted mr-1"><icon name="edit-small" size="18"></icon></button>
      <span>{{ item.name }}</span>
    </div>
    <div v-if="!isEditing" class="flex">
      <button @click="subtract" class="btn-icon btn-icon-highlight"><icon name="chevron-left" size="18"></icon></button>
      <span class="text-m mono mx-1" :class="[quantityClass]">x{{ item.quantity }}</span>
      <button @click="increase" class="btn-icon btn-icon-highlight"><icon name="chevron-right" size="18"></icon></button>
    </div>
  </div>

  <form v-if="isEditing" v-on-clickaway="stopEditing" class="my-1">
    <input
      v-model="itemInEdit.name"
      class="input"
      :class="[itemErrors && itemErrors.name && 'input-error']"
      ref="editItemNameInput"
      type="text"
    >
    <div v-if="itemErrors && itemErrors.name">
      <span class="text-s danger">{{ _showError(itemErrors.name) }}</span>
    </div>
    <div class="flex align-top mt-2">
      <div class="mr-1">
        <label for="item-quantity">Quantity</label>
        <input
          v-model="itemInEdit.quantity"
          class="input"
          :class="[itemErrors && itemErrors.quantity && 'input-error']"
          id="item-quantity"
          min="0"
          ref="editItemQuantityInput"
          type="number"
        >
      </div>
      <div class="ml-1">
        <label for="item-min-quantity">Minimum</label>
        <input
          v-model="itemInEdit.minimum"
          class="input"
          :class="[itemErrors && itemErrors.minimum && 'input-error']"
          id="item-min-quantity"
          min="0"
          ref="editItemMinQuantityInput"
          type="number"
        >
      </div>
    </div>
    <div v-if="itemErrors && itemErrors.quantity">
      <span class="text-s danger">{{ _showError(itemErrors.quantity) }}</span>
    </div>
    <div v-if="itemErrors && itemErrors.minimum">
      <span class="text-s danger">{{ _showError(itemErrors.minimum) }}</span>
    </div>
    <div class="flex justify-between mt-2">
      <div class="flex">
        <button @click.prevent="updateItem" class="btn btn-inverted-success btn-m mr-2" type="submit">Edit</button>
        <button @click="stopEditing" class="btn-icon btn-icon-highlight" type="button"><icon name="close-small" size="18"></icon></button>
      </div>
      <a @click.prevent="onRemoveItem" class="link-danger" href="#">Remove</a>
    </div>
  </form>
</div>
</template>

<script>
import Rails from '@rails/ujs'
import { mixin as clickaway } from 'vue-clickaway';
import { getError } from '../helpers'
import Icon from '../components/icon.vue'

export default {
  name: 'CategoryItem',
  components: { Icon },
  data: function() {
    return {
      currentItem: null,
      itemErrors: null,
      isEditing: false
    }
  },
  props: {
    item: {
      type: Object
    }
  },
  mixins: [ clickaway ],
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
      this.itemInEdit = { ...this.item }
    },
    stopEditing() {
      this.isEditing = false

      this.itemErrors = null
      this.itemInEdit = null
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
        error: error => console.log(error)
      })
    },
    updateItem() {
      const data = new FormData
      data.append("item[name]", this.itemInEdit.name)
      data.append("item[quantity]", this.itemInEdit.quantity)
      data.append("item[minimum]", this.itemInEdit.minimum)

      Rails.ajax({
        url: `/items/${this.item.id}`,
        type: "PUT",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
          this.itemErrors = error
        },
        success: data => {
          // * temporary mutation madness!!!
          this.item = this.itemInEdit
          this.itemErrors = null
          this.$nextTick(() => { this.isEditing = false })
        }
      })
    }
  }
}
</script>

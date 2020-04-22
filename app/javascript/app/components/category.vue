<template>
<div class="category">
  <div class="category__header drag-handle">
    <h3 class="heading-3">{{ category.name }}</h3>
  </div>
  <div class="category__body">
    <draggable v-model="category.items" @change="onItemMoved" class="drag-area" draggable=".is-draggable" group="items">
      <category-item
        v-for="(item, index) in category.items"
        @remove-item="() => removeItem(item.id, index)"
        :item="item"
        :key="item.id"
      ></category-item>
    </draggable>
    
    <button v-if="!isEditing" @click="startEditing" class="btn-full-width btn-default mt-2">+ Add Item</button>
    <form v-if="isEditing" class="mt-2">
      <input v-model="newItem" class="input" :class="[errors && errors.name && 'input-error']" :placeholder="getPlaceholder()" ref="newItemInput" type="text">
      <div v-if="errors && errors.name">
        <span class="text-s danger">{{ _showError(errors.name) }}</span>
      </div>
      <div class="flex mt-2">
        <button @click.prevent="submitNewItem(category.id)" class="btn btn-success btn-m mr-2" type="submit">Add</button>
        <button @click="stopEditing" class="btn-icon" type="button"><icon name="close" small></icon></button>
      </div>
    </form>
  </div>
</div>
</template>

<script>
import Rails from '@rails/ujs'
import Draggable from 'vuedraggable'
import { getError } from '../helpers'
import CategoryItem from './category-item.vue'
import Icon from '../components/icon.vue'

const placeholders = [
  "Health Potion (vials)",
  "Mana Potion (vials)",
  "Elven Sword",
  "Steel Bikinis",
  "Elven Bow",
  "Lightning Arrows (pcs)",
  "Banana",
  "Dwarven Axe",
  "Chicken Nuggets",
  "Rusty Helmet"
]

export default {
  name: 'Category',
  data: function() {
    return {
      errors: null,
      isEditing: false,
      newItem: ''
    }
  },
  props: {
    category: {
      type: Object
    }
  },
  methods: {
    _showError(err) {
      return getError(err)
    },
    getPlaceholder() {
      return placeholders[Math.floor(Math.random() * placeholders.length) + 1]
    },
    onItemMoved(e) {
      this.$emit('item-moved', e)
    },
    removeItem(id, index) {
      Rails.ajax({
        url: `/items/${id}`,
        type: "DELETE",
        dataType: 'json',
        error: error => {
          console.log(error)
        },
        success: () => {
          this.category.items.splice(index, 1)
        }
      })
    },
    startEditing() {
      this.isEditing = true
      this.$nextTick(() => { this.$refs.newItemInput.focus() })
    },
    stopEditing() {
      this.isEditing = false
      this.errors = null
    },
    submitNewItem() {
      const data = new FormData
      data.append("item[category_id]", this.category.id)
      data.append("item[name]", this.newItem)
      data.append("item[quantity]", 1)
      data.append("item[minimum]", 1)

      Rails.ajax({
        url: "/items",
        type: "POST",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
          this.errors = error
        },
        success: data => {
          this.category.items.push(data)
          this.newItem = ''
          this.errors = null
          this.$nextTick(() => { this.$refs.newItemInput.focus() })
        }
      })
    }
  },
  components: { Draggable, CategoryItem, Icon }
}
</script>

<style lang="scss" scoped>
.drag-area {
  min-height: 16px;
}
</style>

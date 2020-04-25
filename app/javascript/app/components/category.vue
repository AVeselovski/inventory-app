<template>
<div class="category is-draggable">
  <div class="category__header drag-handle">
    <h4 v-if="!isEditingTitle" @click="startEditingTitle" class="heading-4 primary my-1 pl-2">{{ category.name }}</h4>
    <form v-if="isEditingTitle" @submit.prevent="updateCategoryTitle">
      <input v-model="category.name" v-on:blur="stopEditingTitle" class="input category__title-input" ref="editTitleInput" type="text">
    </form>
    <button @click="showOptions" class="btn-icon btn-icon-highlight" type="button"><icon name="options" size="24"></icon></button>
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
      <input v-model="newItem" class="input" :class="[itemErrors && itemErrors.name && 'input-error']" :placeholder="getPlaceholder()" ref="newItemInput" type="text">
      <div v-if="itemErrors && itemErrors.name">
        <span class="text-s danger">{{ _showError(itemErrors.name) }}</span>
      </div>
      <div class="flex mt-2">
        <button @click.prevent="submitNewItem(category.id)" class="btn btn-success btn-m mr-2" type="submit">Add</button>
        <button @click="stopEditing" class="btn-icon btn-icon-highlight" type="button"><icon name="close-small" size="18"></icon></button>
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
      itemErrors: null,
      isEditing: false,
      isEditingTitle: false,
      newItem: '',
      originalTitle: ''
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
      return placeholders[Math.floor(Math.random() * placeholders.length)]
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
    showOptions() {},
    startEditing() {
      this.isEditing = true
      this.$nextTick(() => { this.$refs.newItemInput.focus() })
    },
    startEditingTitle() {
      this.originalTitle = this.category.name
      this.isEditingTitle = true
      this.$nextTick(() => { this.$refs.editTitleInput.focus() })
    },
    stopEditing() {
      this.isEditing = false
      this.errors = null
    },
    stopEditingTitle() {
      this.isEditingTitle = false
    },
    submitNewItem() {
      const data = new FormData
      data.append("item[category_id]", this.category.id)
      data.append("item[name]", this.newItem)
      data.append("item[quantity]", 0)
      data.append("item[minimum]", 0)

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
    },
    updateCategoryTitle() {
      if (this.category.name === '') {
        this.isEditingTitle = false
        this.category.name = this.originalTitle

        return
      }

      const data = new FormData
      data.append("category[name]", this.category.name)

      Rails.ajax({
        url: `/categories/${this.category.id}`,
        type: "PATCH",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
        },
        success: data => {
          this.isEditingTitle = false
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

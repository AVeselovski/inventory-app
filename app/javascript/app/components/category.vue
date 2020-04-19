<template>
<div class="category">
  <div class="category__header">
    <h3 class="heading-3">{{ category.name }}</h3>
  </div>
  <div class="category__body">
    <draggable v-model="category.items" group="items" @change="onItemMoved" class="drag-area">
      <category-item
        v-for="(item, index) in category.items"
        :key="item.id"
        :item="item"
        @remove-item="() => removeItem(item.id, index)"
      ></category-item>
    </draggable>
    
    <button v-if="!isEditing" @click="startEditing" class="btn-full-width btn-default mt-2">+ Add Item</button>
    <form v-if="isEditing" class="mt-2">
      <input v-model="newItem" ref="newItemInput" class="input mr-1" type="text">
      <div class="flex mt-2">
        <button @click.prevent="submitNewItem(category.id)" class="btn btn-success btn-m mr-1" type="submit">Add</button>
        <button @click="isEditing = false" class="btn-icon" type="button"><icon name="close" small></icon></button>
      </div>
    </form>
  </div>
</div>
</template>

<script>
import Rails from '@rails/ujs'
import Draggable from 'vuedraggable'
import CategoryItem from './category-item.vue'
import Icon from '../components/icon.vue'

export default {
  name: 'Category',
  data: function() {
    return {
      errors: {},
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
    submitNewItem() {
      const data = new FormData
      data.append("item[category_id]", this.category.id)
      data.append("item[name]", this.newItem)
      data.append("item[quantity]", 0)

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

<template>
<draggable v-model="categories" @end="categoryMoved" class="categories-container drag-area" draggable=".is-draggable" group="categories" handle=".drag-handle" id="categories">
  <category v-for="(category, index) in categories" :category="category" @remove-category="removeCategory(category.id, index)" @item-moved="itemMoved" :key="category.id"></category>

  <div class="new-category">
    <button v-if="!isEditing" @click="startEditing" class="btn-full-width btn-default-dark">+ Add Category</button>
    <form v-if="isEditing" @submit.prevent="submitNewCategory">
      <input v-model="newCategory" v-on:blur="stopEditing" class="input" :placeholder="getPlaceholder()" ref="newCategoryInput" type="text">
    </form>
  </div>
</draggable>
</template>

<script>
import Rails from '@rails/ujs'
import Draggable from 'vuedraggable'
import { getError } from '../helpers'
import Icon from '../components/icon.vue'
import Category from './category.vue'

const placeholders = [
  "Swords",
  "Armor",
  "Potions",
  "Quest Items",
  "Junk"
]

export default {
  name: 'Categories',
  components: { Category, Draggable, Icon },
  data: function() {
    return {
      categories: JSON.parse(this.$attrs['data-categories']),
      isEditing: false,
      newCategory: ''
    }
  },
  methods: {
    _showError(err) {
      return getError(err)
    },
    getPlaceholder() {
      return placeholders[Math.floor(Math.random() * placeholders.length)]
    },
    categoryMoved(e) {
      const data = new FormData
      data.append("category[position]", e.newIndex + 1)

      Rails.ajax({
        url: `/categories/${this.categories[e.newIndex].id}/move`,
        type: "PATCH",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
        }
      })
    },
    itemMoved(e) {
      const evt = e.added || e.moved
      if (evt == undefined) return

      const el = evt.element

      const catIndex = this.categories.findIndex(cat => {
        return cat.items.find(i => {
          return i.id === el.id
        })
      })

      const data = new FormData
      data.append("item[category_id]", this.categories[catIndex].id)
      data.append("item[position]", evt.newIndex + 1)

      Rails.ajax({
        url: `/items/${el.id}/move`,
        type: "PATCH",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
        }
      })
    },
    startEditing() {
      this.isEditing = true
      this.$nextTick(() => { this.$refs.newCategoryInput.focus() })
    },
    stopEditing() {
      this.isEditing = false
    },
    submitNewCategory() {
      if (this.newCategory === '') { this.isEditing = false; return }

      const data = new FormData
      data.append("category[name]", this.newCategory)

      Rails.ajax({
        url: "/categories",
        type: "POST",
        data,
        dataType: "json",
        error: error => {
          console.log(error)
        },
        success: data => {
          this.categories.push(data)
          this.newCategory = ''
          this.isEditing = false
        }
      })
    },
    removeCategory(id, index) {
      Rails.ajax({
        url: `/categories/${id}`,
        type: "DELETE",
        dataType: 'json',
        error: error => console.log(error),
        success: () => this.categories.splice(index, 1)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.drag-area {
  min-height: 16px;
}
</style>

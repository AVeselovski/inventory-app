<template>
<div class="category is-draggable">
  <div class="category__header drag-handle">
    <h4 v-if="!isEditingTitle" @click="startEditingTitle" class="heading-4 primary my-1 pl-2">{{ category.name }}</h4>
    <form v-if="isEditingTitle" @submit.prevent="updateTitle">
      <input v-model="category.name" v-on:blur="updateTitle" class="input category__title-input" ref="editTitleInput" type="text">
    </form>
    <dropdown position="bottom">
      <template v-slot:trigger="slotProps">
        <button
          @click="slotProps.toggle"
          class="btn-icon btn-icon-highlight"
          type="button"
        >
          <icon name="options" size="24"></icon>
        </button>
      </template>
      <template v-slot:items>
        <a @click.prevent="isDeleteModalActive = true" class="link-danger link-icon flex" href="#"><icon name="delete" size="18"></icon>Delete category</a>
      </template>
    </dropdown>
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
    
    <button v-if="!isEditingNewItem" @click="startEditingNewItem" class="btn-full-width btn-default mt-2">+ Add Item</button>
    <form v-if="isEditingNewItem" v-on-clickaway="stopEditingNewItem" class="mt-2">
      <input v-model="newItem" class="input" :class="[newItemErrors && newItemErrors.name && 'input-error']" :placeholder="getPlaceholder()" ref="newItemInput" type="text">
      <div v-if="newItemErrors && newItemErrors.name">
        <span class="text-s danger">{{ _showError(newItemErrors.name) }}</span>
      </div>
      <div class="flex mt-2">
        <button @click.prevent="submitNewItem(category.id)" class="btn btn-success btn-m mr-2" type="submit">Add</button>
        <button @click="stopEditingNewItem" class="btn-icon btn-icon-highlight" type="button"><icon name="close-small" size="18"></icon></button>
      </div>
    </form>
  </div>

  <modal
    v-show="isDeleteModalActive"
    @close="isDeleteModalActive = false"
    dismissMsg="Nope..."
  >
    <template v-slot:body>Delete {{ category.name }} category?</template>
    <template v-slot:footer>
      <button @click="removeCategory" class="btn btn-danger">Yes, delete it!</button>
    </template>
  </modal>
</div>
</template>

<script>
import Rails from '@rails/ujs'
import Draggable from 'vuedraggable'
import { mixin as clickaway } from 'vue-clickaway';
import { getError } from '../helpers'
import Dropdown from './dropdown.vue'
import Modal from './modal.vue'
import Icon from './icon.vue'
import CategoryItem from './category-item.vue'

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
  components: { CategoryItem, Draggable, Dropdown, Icon, Modal },
  data: function() {
    return {
      currentTitle: '',
      isDeleteModalActive: '',
      isEditingNewItem: false,
      isEditingTitle: false,
      newItem: '',
      newItemErrors: null,
    }
  },
  props: {
    category: {
      type: Object
    }
  },
  mixins: [ clickaway ],
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
        error: error => console.log(error),
        success: () => this.category.items.splice(index, 1)
      })
    },
    startEditingNewItem() {
      this.isEditingNewItem = true
      this.$nextTick(() => { this.$refs.newItemInput.focus() })
    },
    stopEditingNewItem() {
      this.isEditingNewItem = false
      this.newItemErrors = null
      this.newItem = ''
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
          error.name
            ? console.log(`%c Form field error: ${getError(error.name)}`, 'color: red;')
            : console.log(error)
          this.newItemErrors = error
        },
        success: data => {
          this.category.items.push(data)
          this.newItemErrors = null
          this.newItem = ''
          this.$nextTick(() => { this.$refs.newItemInput.focus() })
        }
      })
    },
    startEditingTitle() {
      this.currentTitle = this.category.name
      this.isEditingTitle = true
      this.$nextTick(() => { this.$refs.editTitleInput.focus() })
    },
    stopEditingTitle() {
      this.isEditingTitle = false
    },
    updateTitle() {
      if (this.category.name === '') {
        this.isEditingTitle = false
        this.category.name = this.currentTitle

        return
      }

      const data = new FormData
      data.append("category[name]", this.category.name)

      Rails.ajax({
        url: `/categories/${this.category.id}`,
        type: "PATCH",
        data,
        dataType: "json",
        error: error => console.log(error),
        success: data => this.isEditingTitle = false
      })
    },
    removeCategory() {
      this.$emit('remove-category')
    }
  }
}
</script>

<style lang="scss" scoped>
.drag-area {
  min-height: 16px;
}
</style>

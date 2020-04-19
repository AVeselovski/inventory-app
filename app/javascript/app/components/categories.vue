<template>
<draggable v-model="categories" group="categories" @end="categoryMoved" id="categories" class="categories-container drag-area">
  <category v-for="category in categories" :key="category.id" :category="category" @item-moved="itemMoved"></category>
</draggable>
</template>

<script>
import Rails from '@rails/ujs'
import Draggable from 'vuedraggable'
import Category from './category.vue'

export default {
  name: 'Categories',
  data: function() {
    return {
      categories: JSON.parse(this.$attrs['data-categories']),
      newItems: {}
    }
  },
  methods: {
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
    }
  },
  components: {
    Draggable,
    Category
  },
}
</script>

<style lang="scss" scoped>
.drag-area {
  min-height: 16px;
}
</style>

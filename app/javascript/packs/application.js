/* eslint-disable */
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../app/app.vue'
import '../styles/application.scss'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const el = document.getElementById('app-container')

  if (el != null && el != undefined) {
    const app = new Vue({
      el,
      components: { App }
    })
  }
})

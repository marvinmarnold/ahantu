# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $("[data-behaviour~=datepicker]").datepicker(
    format: 'dd/mm/yyyy'
  )
  $('#search_keyword').autocomplete
    source: "/search_suggestions"

$(document).ready(ready)
$(document).on('page:load', ready)
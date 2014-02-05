# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.card = new Skeuocard($("#skeuocard"))
validateform = ->
  resp = card.isValid()
  if resp
    $("#credit_card_form").submit()
    return true
  false
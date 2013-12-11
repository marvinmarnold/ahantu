// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require jquery_nested_form
//= require bootstrap-datepicker
//= require bootstrap
//= require_tree .




function add_placeholder(id, placeholder) {
  var el = document.getElementById(id);
  el.placeholder = placeholder;

  el.onfocus = function () {
    if (this.value == this.placeholder) {
      this.value = '';
      el.style.cssText = '';
    }
  };

  el.onblur = function () {
    if (this.value.length == 0) {
      this.value = this.placeholder;
      el.style.cssText = 'color:#A9A9A9;';
    }
  };
  el.onblur();
}
$(document).ready(function(){


  $("#change_language").change(function(){
      var path = window.location.pathname;
      var language_id = $(this).val();
      window.location.href = "/pages/set_language?language_id=" + language_id + "&location=" + path;

  })




  add_placeholder('search_keyword', 'City, neighborhood, hotel name, etc.');
  //$(".add").tooltip();
  //$(".remove").tooltip();

  $(document.body).tooltip({selector: '[title]'})
  .on('click mouseenter mouseleave','[title]', function(ev) {
     $(this).tooltip('mouseenter' === ev.type? 'show': 'hide');
  });


var nowTemp = new Date();
var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

var checkin = $('#dp1').datepicker({
onRender: function(date) {
return date.valueOf() < now.valueOf() ? 'disabled' : '';
}
}).on('changeDate', function(ev) {
if (ev.date.valueOf() > checkout.date.valueOf()) {
var newDate = new Date(ev.date)
newDate.setDate(newDate.getDate() + 1);
checkout.setValue(newDate);

}
checkin.hide();
$('#dp2')[0].focus();
}).data('datepicker');


$("#dp2").click(function(){
  if(checkin){checkin.hide();}
})
$("#dp1").click(function(){
  if(checkout){checkout.hide();}
})
var checkout = $('#dp2').datepicker({
  onRender: function(date) {
    return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';

  }
}).on('changeDate', function(ev) {
checkout.hide();
}).data('datepicker');      

})
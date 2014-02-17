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
//= require turbolinks
//= require jquery_nested_form
//= require bootstrap
//= require bootstrap-datepicker
//= require skeuocard
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



var ready = function(){

  
	$('#myCarousel').carousel({
			interval: 4000
	});

	// handles the carousel thumbnails
	$('[id^=carousel-selector-]').click( function(){
    var size = "carousel-selector-".length;
		var id_selector = $(this).attr("id");
		var id = id_selector.substr(size);
		id = parseInt(id);
    console.log(id);
		$('#myCarousel').carousel(id);
		$('[id^=carousel-selector-]').removeClass('selected');
		$(this).addClass('selected');
	});

	// when the carousel slides, auto update
	$('#myCarousel').on('slid', function (e) {
		var id = $('.item.active').data('slide-number');
		id = parseInt(id);
		$('[id^=carousel-selector-]').removeClass('selected');
		$('[id^=carousel-selector-'+id+']').addClass('selected');
	});


  $("#change_language").change(function(){
      var path = window.location.pathname;
      var language_id = $(this).val();
      window.location.href = "/pages/set_language?language_id=" + language_id + "&location=" + path;

  })


  //add_placeholder('search_keyword', 'City, neighborhood, hotel name, etc.');
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

}

$(document).ready(ready)
$(document).on('page:load', ready)

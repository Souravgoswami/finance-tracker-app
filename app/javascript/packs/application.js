require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require('jquery')
window.$ = $

import 'bootstrap'

document.addEventListener('turbolinks:load', function() {
	$('[data-toggle="tooltip"]').tooltip({
		trigger: 'hover'
	}).click(function() { $(this).tooltip('hide') })

	$('[data-toggle="popover"]').popover()

	$('#searchTickerButton').click(function() {
		notify('Please Wait')
		$('#searchTickerButton').attr('class', 'btn btn-success')
		setTimeout(() => {
			$('#searchTickerButton').prop('disabled', true)
		}, 1000)
	})
})

import '../stylesheets/application.scss'
import '@fortawesome/fontawesome-free/js/all'

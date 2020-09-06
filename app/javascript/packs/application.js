require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import Rails from '@rails/ujs'

require('jquery')
window.$ = $

import 'bootstrap'

function ajaxCall(url, type, data) {
	Rails.ajax({
		url: url,
		type: type,
		data: data,
		dataType: 'json',
		contentType: 'json'
	})
}

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

	$('#user_email.check-duplicate').change(function() {
		ajaxCall(
			 '/check_email',
			 'get',
			 `email=${$('#user_email').val()}`,
		)
	})

	$('#user_username.check-duplicate').change(function() {
		ajaxCall(
			 '/check_username',
			 'get',
			 `username=${$('#user_username').val()}`,
		)
	})
})

import '../stylesheets/application.scss'
import '@fortawesome/fontawesome-free/js/all'

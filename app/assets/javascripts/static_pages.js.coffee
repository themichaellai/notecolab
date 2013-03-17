$(document).ready( ->
  $('#no-account').click( ->
    $('#login-home').fadeOut('fast', ->
      $('#register-home').fadeIn('fast')
    )
  )
  $('#sign-in').click( ->
    $('#register-home').fadeOut('fast', ->
      $('#login-home').fadeIn('fast')
    )
  )
)

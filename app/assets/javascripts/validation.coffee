ready = ->
  namePattern = /^([A-Z][a-zA-Z]*)\s([A-Z](-|[a-zA-Z])*)$/
  emailPattern = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
  passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/

  $('#user_name').blur ->
    if !namePattern.test(($(this).val()))
      $('#name_errors').css('visibility', 'visible')
      $(this).parent().addClass('error')
    else
      $('#name_errors').css('visibility', 'hidden')
      $(this).parent().removeClass('error')

  $('#user_email').blur ->
    if !emailPattern.test(($(this).val()))
      $('#email_errors').css('visibility', 'visible')
      $(this).parent().addClass('error')
    else
      $('#email_errors').css('visibility', 'hidden')
      $(this).parent().removeClass('error')

  $('#user_password').blur ->
    if !passwordPattern.test(($(this).val()))
      $('#password_errors').css('visibility', 'visible')
      $(this).parent().addClass('error')
    else
      $('#password_errors').css('visibility', 'hidden')
      $(this).parent().removeClass('error')

  $('#user_password_confirm').blur ->
    if ($(this).val()) != $('#user_password').val()
      $('#password_confirmation_errors').css('visibility', 'visible')
      $(this).parent().addClass('error')
    else
      $('#password_confirmation_errors').css('visibility', 'hidden')
      $(this).parent().removeClass('error')

$(document).ready(ready)
$(document).on('page:load', ready)

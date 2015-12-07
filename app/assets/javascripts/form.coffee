ready = ->
  $('form').submit ->
    values = $(this).serialize()
    $.ajax(
      type: 'POST'
      url: $(this).attr('action')
      data: values
      dataType: 'JSON'
      success: (json) ->
        console.log 'Success', json
        if json['success']
          window.location.replace json['success'][0]
        $('form').children().each( ->
          $(this).removeClass('error')
          return
        )
        if json['failed_login']
          $('p.failed-login').show()
          $('#session_email').parent().addClass('error')
          $('#session_password').parent().addClass('error')
        if json['errors']
          $('div.error-messages').show()
          $('div.error-messages ul').empty()
          messages = []
          for name, errors of json['errors']
            $('#user_' + name).parent().addClass('error')
            for error in errors
              message = name.charAt(0).toUpperCase() + name.slice(1) + ' ' + error
              if name == 'password_confirmation'
                messages.push('Passwords don\'t match')
                break
              if messages.indexOf(message) == -1
                messages.push(message)
              messageSplit = message.split(" ")
              if messageSplit[messageSplit.length - 1] == 'blank'
                break
          for message in messages
            $('div.error-messages ul').append('<li>' + message + '</li>')
        return
      error: (json) ->
        console.log 'Error', json.responseText
        return
    )
    false

  return

$(document).ready(ready)
$(document).on('page:load', ready)

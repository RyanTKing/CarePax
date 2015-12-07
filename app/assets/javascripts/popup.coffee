ready = ->
  formModal = $('.popup')
  formLogin = formModal.find('.popup-login')
  formSignup = formModal.find('.popup-register')
  formModalTab = $('.popup-switcher')
  tabLogin = formModalTab.children('li').eq(0).children('a')
  tabSignup = formModalTab.children('li').eq(1).children('a')
  page = $('#page')
  mainNav = $('#main-header')

  login_selected = ->
    formModal.addClass 'is-visible'
    formLogin.addClass 'is-selected'
    formSignup.removeClass 'is-selected'
    tabLogin.addClass 'selected'
    tabSignup.removeClass 'selected'
    page.addClass 'blurred'
    return

  signup_selected = ->
    mainNav.children('ul').removeClass 'is-visible'
    formModal.addClass 'is-visible'
    formLogin.removeClass 'is-selected'
    formSignup.addClass 'is-selected'
    tabLogin.removeClass 'selected'
    tabSignup.addClass 'selected'
    page.addClass 'blurred'
    return

  mainNav.on 'click', (event) ->
    $(event.target).is(mainNav) and mainNav.children('ul').toggleClass('is-visible')
    return

  mainNav.on 'click', '.login', login_selected

  formModal.on 'click', (event) ->
    if $(event.target).is(formModal) or $(event.target).is('.popup-close')
      formModal.removeClass 'is-visible'
      page.removeClass 'blurred'
    return

  $(document).keyup (event) ->
    if event.which == '27'
      formModal.removeClass 'is-visible'
      page.removeClass 'blurred'
    return

  formModalTab.on 'click', (event) ->
    event.preventDefault()
    if $(event.target).is(tabLogin) then login_selected() else signup_selected()
    return

  $('.password-toggle').on 'click', ->
    togglePass = $(this)
    passwordField = togglePass.prev('input')
    if 'password' == passwordField.attr('type') then passwordField.attr('type', 'text') else passwordField.attr('type', 'password')
    if 'Hide' == togglePass.text() then togglePass.text('Show') else togglePass.text('Hide')
    passwordField.putCursorAtEnd()
    return

jQuery.fn.putCursorAtEnd = ->
  @each ->
    if @setSelectionRange
      len = $(this).val().length * 2
      @focus()
      @setSelectionRange len, len
    else
      $(this).val $(this).val()
    return

$(document).ready(ready)
$(document).on('page:load', ready)

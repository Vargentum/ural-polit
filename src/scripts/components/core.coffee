$ ->

  root = $('.news-section.type-from-partner')
  title = root.find('.news-article__title')
  body = root.find('.news-article__body')

  title.succinct(
    size: 60
  )
  body.succinct(
    size: 30
  )

#responsive logic
$ ->
  media = (type, callback)->
    globalWidth = $(window).width
    if type == 'tablet'
      globalWidth >= 768 and globalWidth <= 1023
      callback()

  media('tablet', ->
    $('.project-search').click ->
      $(@).addClass('state-active')
      input = $(@).find('input')
      input.trigger('focus')
      input.blur =>
        $(@).removeClass('state-active')
  )


# encyclopedia section toggler
$ ->
  body = '.encyclopedia-section'
  toggler = '.encyclopedia-section__toggler-state'


  labelDefault = 'Развернуть'
  labelActive = 'Свернуть'

  toggleState = (el) ->
    el.toggleClass('state-active')

  $(toggler).click ->
    toggleState $(@)
    toggleState $(@).closest(body)
    if !( $(@).hasClass('state-active') )
      $(@).html(labelDefault)
    else
      $(@).html(labelActive)


###
# change header when scrolling (disabled)
$ ->
  root = $('body')
  el = $('.l-header')
  state1 = 'state-M'
  state2 = 'state-S'
  win = $(window)

  handleHeaderHeight = ->
    root.css(
      paddingTop: el.height() + 40
    )

  checkHeaderState = ->
    currentScrollPos = win.scrollTop()

    if currentScrollPos > 0 and currentScrollPos < screen.height
      el.addClass state1
      handleHeaderHeight()
      console.log 1


    else if currentScrollPos >= screen.height
      el.addClass state2
      handleHeaderHeight()
      console.log '2'

    else if currentScrollPos == 0
      el.removeClass(state1).removeClass(state2)
      handleHeaderHeight()
      console.log '3'


  win.load ->
    checkHeaderState()

  win.scroll ->
    checkHeaderState()
###

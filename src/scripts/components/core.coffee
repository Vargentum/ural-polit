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

# header navigation mobile logic
$ ->
  trigger = $('.btn-show-menu')
  elems = [$('.set-region'), $('.project-catalog')]
  win = $(window)

  checkElemsState = ->
    if win.width() <= 780
      elems.forEach (e) ->
        e.slideUp()
    else
      elems.forEach (e) ->
        e.slideDown()


  win.load ->
    checkElemsState()

  win.resize ->
    checkElemsState()

  trigger.click ->
    elems.forEach (e) ->
      e.slideToggle()

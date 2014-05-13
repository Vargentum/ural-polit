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


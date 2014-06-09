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

    else if type == 'phone'
      globalWidth < 768
      callback()

  media('tablet', ->
    $('.project-search').click ->
      $(@).addClass('state-active')
      input = $(@).find('input')
      input.trigger('focus')
      input.blur =>
        $(@).removeClass('state-active')
  )

  media('phone', ->
    el1 = $('.l-header').find('.set-region')
    el2 = $('.l-header').find('.project-catalog')
    $('.btn-show-menu').click ->
      el1.slideToggle()
      el2.slideToggle()
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


# Flexslider controller
$ ->
  $('.experts-all__carousel').flexslider(
    animation: 'slide'
    controlNav: off
    itemWidth: 150
    maxItems: 4
    move: 1
    prevText: ''
    nextText: ''
  )

  slider = $('.gallery-slider')
  sliderNav = $('.gallery-carousel')

  counterCurrent = $('.gallery-slider__counter--current')
  counterTotal = $('.gallery-slider__counter--all')
  counterCurrentInitVal = 1

  findItem = (e) ->
    e.find('.slides').find('li')

  getCurrentSliderItemIndex = ->
    for item in sliderItem
      if $(item).hasClass('flex-active-slide')
        return $(item).index()


  sliderItem = findItem slider
  sliderNavItem = findItem sliderNav

  sliderNav.flexslider(
    animation: "slide"
    controlNav: false
    animationLoop: false
    slideshow: false
    itemWidth: 160
    move: 1
    prevText: ''
    nextText: ''
    asNavFor: '.gallery-slider'
  )

  slider.flexslider(
    animation: "slide"
    controlNav: false
    animationLoop: false
    slideshow: false
    prevText: ''
    nextText: ''
    sync: ".gallery-carousel"
    init: ->
      counterTotal.html sliderItem.length
      counterCurrent.html counterCurrentInitVal

    after: ->
      i = getCurrentSliderItemIndex()
      counterCurrent.html ++i
  )

  sliderNavItem.click ->
    i = $(@).index()
    counterCurrent.html ++i




#  custom select init
$ ->
  $('select').selectpicker();

$ ->
  body = $('body')
  ie10 = window.navigator.msPointerEnabled;
  ieMobile = (!!window.ActiveXObject and +(/IEMobile\/(\d+\.?(\d+)?)/.exec(navigator.userAgent)[1])) or NaN

  if ie10
    body.addClass('ie10')

  else if ieMobile
    body.addClass('ieMobile')




###$ ->
  el = $('body')
  el.queryLoader2(
    backgroundColor: '#fff'
    barColor: '#c41b1a'
    completeAnimation: 'fade'
    percentage: on
  )###

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

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

BPMS = (60/104) * 1000
HEART_POS = 200
FUDGE = 30

class Game
  constructor: (@song, @pane) ->
    @heart = @pane.find("#heart")
    @heart.click @press
    @startTime = null
    @lastbeat = 0
    @interaction = @pane.find("#interaction")

  start: () ->
    @startTime = (new Date()).getTime()
    @song.play()
    setTimeout((=>
      @lastbeat = (new Date()).getTime()
      animateForever callback: @anim
      ), 200)
    

  press: () =>
    $current_heart = $(".heart-overlay:not(.miss, .hit)").last()
    current_top = $current_heart.addClass("hit")
    @hit()

  miss: () =>

  hit: () =>    

  addHeart: () =>
    heart = $ "<div class=\"heart-overlay\"></div>"
    @interaction.prepend heart

    heart.animate({
      opacity: 1,
      top: "+=900"
    },{
      duration: 4000,
      complete: =>
        heart.remove()
    })

  anim: () =>
    current = (new Date()).getTime()
    if (current - @lastbeat) > BPMS
      @lastbeat += BPMS
      @addHeart()
      $(".heart-overlay").each (i, el) =>
        $el = $(el)
        return if $el.hasClass("hit")
        
        if $el.position().top > (HEART_POS + FUDGE)
          $el.addClass("miss")
          @miss()
  
$play_button = null
$game_pane = null
$landing_pane = null

$ ->
  as = audiojs.createAll();
  game = new Game(as[0], $("#game_pane"))

  $play = $ "#play_button"
  $game_pane = $ "#game_pane"
  $landing_pane = $ "#landing_pane"

  $play.click ->
    $game_pane.toggleClass "onscreen"
    $landing_pane.toggleClass "onscreen"
    $landing_pane.addClass "left"

    game.start()

  
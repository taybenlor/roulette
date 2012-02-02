# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

BPMS = (60/104) * 1000

class Game
  constructor: (@song, @pane) ->
    @heart = @pane.find("#heart")
    @heart.click @press
    @startTime = null
    @lastbeat = 0

  start: () ->
    @startTime = (new Date()).getTime()
    @song.play()
    setTimeout((=>
      @lastbeat = (new Date()).getTime()
      animateForever callback: @anim
      ), 200)
    

  press: () =>


  anim: () =>
    current = (new Date()).getTime()
    if (current - @lastbeat) > BPMS
      @lastbeat += BPMS
      @heart.addClass "press"
      setTimeout((=> @heart.removeClass "press"), 20)

  
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

  
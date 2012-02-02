# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$play_button = null
$game_pane = null
$landing_pane = null

$ ->
  $play = $ "#play_button"
  $game_pane = $ "#game_pane"
  $landing_pane = $ "#landing_pane"

  $play.click ->
    $game_pane.toggleClass "onscreen"
    $landing_pane.toggleClass "onscreen"
    $landing_pane.addClass "left"
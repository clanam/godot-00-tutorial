extends "res://addons/gut/test.gd"

var Main = load('res://Main.tscn')
var _main = null


func before_each():
	_main = autoqfree(Main.instance())


func test_new_game_sets_hud_state():
	_main.new_game()

	var hud = _main.get_node("HUD")
	assert_not_null(hud, "Main should have a HUD")
	assert_eq(hud.get_node("ScoreLabel").text, "Score: 0")
	assert_eq(hud.get_node("HiScoreLabel").text, "Hi: 0")
	assert_eq(hud.get_node("Message").text, "Get Ready")

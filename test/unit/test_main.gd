extends "res://addons/gut/test.gd"

var HUD = load('res://scenes/hud/HUD.tscn')
var Main = load('res://scenes/main/Main.tscn')

var _main = null
var _hud = null


func before_each():
	_main = autoqfree(Main.instance())
	_hud = autoqfree(double(HUD).instance())
	var orig_hud = _main.get_node("HUD")
	orig_hud.replace_by(_hud, true)
	orig_hud.free()

	# Must add to the scene tree to not freak out the timers in Main.
	add_child(_main)


func after_each():
	remove_child(_main)


func test_game_over_no_high_score():
	_main.high_score = 12
	_main.score = 10

	_main.game_over()

	assert_called(_hud, "game_over")
	assert_not_called(_hud, "update_high_score")
	assert_eq(_main.high_score, 15)


func test_game_over_new_high_score():
	_main.high_score = 12
	_main.score = 15

	_main.game_over()

	assert_called(_hud, "game_over")
	assert_called(_hud, "update_high_score", [15])
	assert_eq(_main.high_score, 15)


func test_new_game_sets_hud_state():
	_main.new_game()
	assert_called(_hud, "show_message", ["Get Ready"])
	assert_called(_hud, "update_score", [0])

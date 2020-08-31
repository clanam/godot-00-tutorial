extends "res://addons/gut/test.gd"

var HUD = load('res://HUD.tscn')
var Main = load('res://Main.tscn')

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


func test_new_game_sets_hud_state():
	_main.new_game()
	assert_called(_hud, "show_message", ["Get Ready"])
	assert_called(_hud, "update_score", [0])

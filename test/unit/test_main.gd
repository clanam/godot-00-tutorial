extends "res://addons/gut/test.gd"

var HUD = load('res://scenes/hud/HUD.tscn')
var Main = load('res://scenes/main/Main.tscn')
var Persistence = load('res://scenes/main/Persistence.gd')

var _main = null
var _hud = null
var _persistence = null


func before_each():
	_main = autoqfree(Main.instance())
	_hud = autoqfree(double(HUD).instance())
	_persistence = autoqfree(double(Persistence).new())

	_main.persistence = _persistence
	stub(_persistence, "load_game").to_return(6)
	stub(_persistence, "save_game").to_do_nothing()

	# Must add to the scene tree to not freak out the timers in Main.
	add_child(_main) # calls _ready()

	# Add hud after calling _ready() so tests are clean of calls triggered in _ready()
	var orig_hud = _main.get_node("HUD")
	orig_hud.replace_by(_hud, true)
	orig_hud.free()

	stub(_hud, "show_game_over").to_do_nothing()
	stub(_hud, "update_high_score").to_do_nothing()
	stub(_hud, "update_message").to_do_nothing()
	stub(_hud, "update_score").to_do_nothing()


func after_each():
	remove_child(_main)


func test_game_over_no_high_score():
	_main.score = 4
	_main.game_over()

	assert_called(_hud, "show_game_over")
	assert_not_called(_hud, "update_high_score")
	assert_not_called(_persistence, "save_game")
	assert_eq(_main.high_score, 6)


func test_game_over_new_high_score():
	_main.score = 13
	_main.game_over()

	assert_called(_hud, "show_game_over")
	assert_called(_hud, "update_high_score", [13])
	assert_called(_persistence, "save_game", [13])
	assert_eq(_main.high_score, 13)


func test_new_game_sets_hud_state():
	_main.new_game()
	assert_called(_hud, "show_message", ["Get Ready"])
	assert_called(_hud, "update_score", [0])

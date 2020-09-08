extends "res://addons/gut/test.gd"

var HUD = load('res://scenes/hud/HUD.tscn')

var _hud = null
var _message = null
var _start_button = null
var _timer = null


func before_each():
	_hud = autoqfree(HUD.instance())
	_message = _hud.get_node("Message")
	_start_button = _hud.get_node("StartButton")
	_timer = _hud.get_node("MessageTimer")

	# Must add to the scene tree to not freak out the message timer.
	add_child(_hud)


func test_show_message():
	_hud.show_message("Yay squirrels!")
	assert_eq(_message.text, "Yay squirrels!")
	assert_true(_message.visible, "Message should be visible")

	yield(_timer, "timeout")
	assert_false(_message.visible, "Message should not longer be visible")


func test_show_game_over():
	_start_button.hide()
	_hud.show_game_over()

	assert_eq(_message.text, "Game Over")
	assert_true(_message.visible, "Message for 'game over' should be visible")
	assert_false(_start_button.visible, "Start button should not be visible")

	yield(_timer, "timeout")
	assert_eq(_message.text, "Dodge the\nCreeps!")
	assert_true(_message.visible, "Message for 'dodge creeps' should be visible")

	yield(yield_for(2), YIELD)
	assert_true(_start_button.visible, "Start button should be visible")


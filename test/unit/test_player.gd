extends "res://addons/gut/test.gd"

var Player = load('res://Player.tscn')
var _player = null

func before_each():
	_player = autoqfree(Player.instance())


func test_start_sets_player_position():
	var pos = Vector2(3, 2)
	_player.start(pos)
	assert_eq(_player.position, Vector2(3, 2), "Position should be set")


func test_start_sets_player_target():
	var pos = Vector2(41, 25)
	_player.start(pos)
	assert_eq(_player.target, Vector2(41, 25), "Target should be set")


func test_start_sets_player_animation_walk():
	var pos = Vector2(41, 25)
	_player.start(pos)
	var sprite = _player.get_node('AnimatedSprite')
	assert_eq(sprite.animation, "walk")
	assert_eq(sprite.flip_h, false, "Horizontal flip should be false")
	assert_eq(sprite.flip_v, false, "Vertical flip should be false")


func test_input_touch_event_sets_target():
	_player.start(Vector2(10, 20))
	assert_eq(_player.target, Vector2(10, 20), "Initial target should be set")

	var event = InputEventScreenTouch.new()
	event.position = Vector2(30, 25)
	event.pressed = true

	_player._input(event)
	assert_eq(_player.target, Vector2(30, 25), "Target should be updated")

extends "res://addons/gut/test.gd"

var Player = load('res://scenes/player/Player.tscn')
var _player = null


func before_each():
	_player = autoqfree(Player.instance())
	_player.init(Vector2(1000, 1000))


func test_start_sets_player_starting_state():
	var pos = Vector2(3, 2)
	_player.start(pos)
	assert_eq(_player.position, Vector2(3, 2), "Position should be set")
	assert_eq(_player.target, Vector2(3, 2), "Target should be set to position")


func test_start_sets_player_animation_walk():
	var pos = Vector2(41, 25)
	_player.start(pos)
	var sprite = _player.get_node('AnimatedSprite')
	assert_eq(sprite.animation, "walk")
	assert_eq(sprite.flip_h, false, "Horizontal flip should be false")
	assert_eq(sprite.flip_v, false, "Vertical flip should be false")


func test_input_touch_event_sets_target_anim_walk():
	_player.start(Vector2(0, 0))
	assert_eq(_player.target, Vector2(0, 0), "Initial target should be set")

	var event = InputEventScreenTouch.new()
	event.position = Vector2(500, 250)
	event.pressed = true

	_player._input(event)
	assert_eq(_player.position, Vector2(0, 0), "Position should not be updated by touch")
	assert_eq(_player.target, Vector2(500, 250), "Target should be updated by touch")

	var sprite = _player.get_node('AnimatedSprite')

	gut.simulate(_player, 1, 0.1) # calls _process() on _player 1x for delta=0.1 seconds
	assert_eq(_player.position, Vector2(35.777092, 17.888546), "Position should update on _process()")
	assert_eq(_player.target, Vector2(500, 250), "Target should not update on _process()")
	assert_eq(sprite.animation, "walk")

	gut.simulate(_player, 20, 0.1) # calls _process() on _player 20x for delta=0.1 seconds
	assert_eq(_player.position, Vector2(500.879303, 250.439651), "Position should update further")
	assert_eq(_player.target, Vector2(500, 250), "Target should still not update on _process()")
	assert_eq(sprite.animation, "walk")


func test_input_touch_event_sets_target_anim_up():
	_player.start(Vector2(0, 0))
	assert_eq(_player.target, Vector2(0, 0), "Initial target should be set")

	var event = InputEventScreenTouch.new()
	event.position = Vector2(250, 500)
	event.pressed = true

	_player._input(event)
	assert_eq(_player.position, Vector2(0, 0), "Position should not be updated by touch")
	assert_eq(_player.target, Vector2(250, 500), "Target should be updated by touch")

	var sprite = _player.get_node('AnimatedSprite')

	gut.simulate(_player, 1, 0.1) # calls _process() on _player 1x for delta=0.1 seconds
	assert_eq(_player.position, Vector2(17.888546, 35.777092), "Position should update on _process()")
	assert_eq(_player.target, Vector2(250, 500), "Target should not update on _process()")
	assert_eq(sprite.animation, "up")

	gut.simulate(_player, 20, 0.1) # calls _process() on _player 20x for delta=0.1 seconds
	assert_eq(_player.position, Vector2(250.439651, 500.879303), "Position should update further")
	assert_eq(_player.target, Vector2(250, 500), "Target should still not update on _process()")
	assert_eq(sprite.animation, "up")


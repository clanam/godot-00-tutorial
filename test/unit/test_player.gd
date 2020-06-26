extends "res://addons/gut/test.gd"

var Player = load('res://Player.tscn')
var _player = null

func before_each():
	_player = Player.instance()


func after_each():
	_player.queue_free()


func test_start_sets_player_position():
	var pos = Vector2(3, 2)
	_player.start(pos)
	assert_eq(_player.position.x, 3.0)
	assert_eq(_player.position.y, 2.0)


func test_start_sets_player_target():
	var pos = Vector2(41, 25)
	_player.start(pos)
	assert_eq(_player.target.x, 41.0)
	assert_eq(_player.target.y, 25.0)


func test_start_sets_player_animation_walk():
	var pos = Vector2(41, 25)
	_player.start(pos)
	var sprite = _player.get_node('AnimatedSprite')
	assert_eq(sprite.animation, "walk")
	assert_eq(sprite.flip_h, false)
	assert_eq(sprite.flip_v, false)

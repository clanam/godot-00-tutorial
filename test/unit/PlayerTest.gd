extends "res://addons/gut/test.gd"

var Player = load('res://Player.gd')
var _player = null

func before_each():
	_player = Player.new()
	# _player = autofree(Player.new())


func test_start_sets_player_position():
	var pos = Vector2(3, 2)
	_player.start(pos)
	assert_true(_player.position.x, 3)
	assert_true(_player.position.y, 2)


func test_start_sets_player_target():
	var pos = Vector2(41, 25)
	_player.start(pos)
	assert_true(_player.target.x, 41)
	assert_true(_player.target.y, 25)

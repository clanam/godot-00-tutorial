extends Node


export (PackedScene) var Mob
var score


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure a new random seed is used each time.
	randomize()

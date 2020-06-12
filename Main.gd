extends Node


export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure a new random seed is used each time.
	randomize()

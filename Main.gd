extends Node


export (PackedScene) var Mob

const SAVE_FILE_NAME = "user://data.save"

var score
var high_score = 0


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	
	if high_score > score:
		high_score = score
		$HUD.update_high_score(high_score)
		save_game()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()
	$Music.play()


func save_game():
	var save_game = File.new()
	save_game.open(SAVE_FILE_NAME, File.WRITE)
	save_game.store_line(to_json({"high_score": high_score}))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_FILE_NAME):
		return # Error! We don't have a save to load.

	save_game.open(SAVE_FILE_NAME, File.READ)
	
	if save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		high_score = node_data["high_score"]
		$HUD.update_high_score(high_score)

	save_game.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure a new random seed is used each time.
	randomize()
	load_game()


func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

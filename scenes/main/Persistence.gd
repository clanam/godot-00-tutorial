extends Node

const SAVE_FILE_NAME = "user://data.save"

func save_game(high_score):
	var save_game = File.new()
	save_game.open(SAVE_FILE_NAME, File.WRITE)
	save_game.store_line(to_json({"high_score": high_score}))
	save_game.close()


func load_game():
	var high_score = 0
	var save_game = File.new()
	if not save_game.file_exists(SAVE_FILE_NAME):
		return high_score # Error! We don't have a save to load.

	save_game.open(SAVE_FILE_NAME, File.READ)

	if save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		high_score = node_data["high_score"]

	save_game.close()
	return high_score

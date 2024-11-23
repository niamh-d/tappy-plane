extends Node

const SCORES_PATH = "user://high_scores.json" 

var _score: int = 0
var _high_score: int = 0
var _third_highest_score: int = 0
var high_scores_array = []
var hs_player_name: String = "ANON" if _high_score > 0 else ""

func _ready() -> void:
	load_high_score_from_file()

func get_score() -> int:
	return _score

func get_high_score() -> int:
	return _high_score

func set_hs_data() -> void:
	var data = high_scores_array[0]
	_high_score = data["highScore"]
	hs_player_name = data["playerName"]

func get_hs_player_name() -> String:
	return hs_player_name

func get_hs_data() -> Array:
	return high_scores_array

func set_score(val: int) -> void:
	_score = val
	SignalManager.on_score_updated.emit(val)

func increment_score() -> void:
	set_score(_score + 1)

func is_new_high_score() -> bool:
	return _score > _third_highest_score

func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	return a["highScore"] > b["highScore"]
	
func sort_high_scores_array() -> void:
	high_scores_array.sort_custom(sort_by_score)

func update_high_scores_array(name: String) -> void:
	var new_entry = {"playerName": name, "highScore": _score}
	sort_high_scores_array()
	high_scores_array.insert(high_scores_array.bsearch_custom(new_entry, sort_by_score), new_entry)
	set_hs_data()
	set_third_highest_score()
	SignalManager.on_leaderboard_updated.emit()

func set_third_highest_score() -> void:
		if(high_scores_array.size() >= 3):
			_third_highest_score = high_scores_array[2]["highScore"]

func set_score_data() -> void:
	sort_high_scores_array()
	var hs_data: Dictionary = high_scores_array[0]
	_high_score = hs_data["highScore"]
	hs_player_name = hs_data["playerName"]
	set_third_highest_score()

func load_high_score_from_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			var json = JSON.new()
			var data = file.get_as_text()
			high_scores_array = json.parse_string(data)
			set_score_data()
			print("Loaded HS")
		else:
			print("Nothing in file!") 
		file.close()
	else:
		print("Failed to load!")  

func save_new_high_score_to_file(name: String) -> void:
	update_high_scores_array(name)
	var json_str = JSON.stringify(high_scores_array)
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
		print("New highscore saved")
	else:
		print("Failed to load!")  

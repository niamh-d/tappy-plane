extends Node

const SCORES_PATH = "user://tappy.dat" 

var _score: int = 0
var _initial_high_score: int = 0
var _running_high_score: int = 0

func _ready() -> void:
	load_high_score_from_file()

func get_score() -> int:
	return _score
	
func get_high_score() -> int:
	return _running_high_score

func set_score(val: int) -> void:
	_score = val
	if val > _running_high_score:
		_running_high_score = val
	SignalManager.on_score_updated.emit(val)

func increment_score() -> void:
	set_score(_score + 1)

func set_running_high_score() -> void:
	_running_high_score = _initial_high_score

func load_high_score_from_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_initial_high_score = file.get_32()
			set_running_high_score()
			print("Loaded HS")
		else:
			print("Nothing in file!")
		file.close()
	else:
		print("Failed to load!")  

func save_high_score_to_file() -> void:
	if _running_high_score > _initial_high_score:
		var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
		if file:
			file.store_32(_running_high_score)
			file.close()
			print("New highscore saved")
		else:
			print("Failed to load!")  

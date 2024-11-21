extends Node

const SCORES_PATH = "user://tappy.dat" 

var _score: int = 0
var _high_score: int = 0

func _ready() -> void:
	load_high_score_from_file()

func get_score() -> int:
	return _score
	
func get_high_score() -> int:
	return _high_score

func set_score(v: int) -> void:
	_score = v
	if v > _high_score:
		_high_score = v
	SignalManager.on_score_updated.emit(v)

func increment_score() -> void:
	set_score(_score + 1)

func load_high_score_from_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_high_score = file.get_32()
			print("Loaded HS")
		else:
			print("Nothing in file!")
		file.close()
	else:
		print("Failed to load!")  

func save_high_score_to_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	if file:
		file.store_32(_high_score)
		file.close()
		print("Highscore saved")
	else:
		print("Failed to load!")  

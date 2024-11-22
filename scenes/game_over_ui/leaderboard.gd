extends GridContainer

@onready var row_1: Label = $Row1
@onready var row_2: Label = $Row2
@onready var row_3: Label = $Row3

var high_scores: Array
var children: Array
var range: int
var num_rows: int
var num_score_entries: int

func _ready() -> void:
	SignalManager.on_leaderboard_updated.connect(set_leaderboard)
	children = self.get_children()
	set_leaderboard()
	
func format_row(data: Dictionary) -> String:
	return data.playerName + ": " + str(data.highScore)

func set_leaderboard() -> void:
	high_scores = ScoreManager.get_hs_data()
	num_rows = children.size() - 1
	num_score_entries = high_scores.size()
	range = num_score_entries if num_score_entries <= num_rows else num_rows
	for i in range(range):
		children[i + 1].text = format_row(high_scores[i])

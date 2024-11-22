extends Control

@onready var high_score_num_label: Label = $MarginContainer/HighScoreNumLabel
@onready var high_score_text_label: Label = $MarginContainer/HighScoreTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score: int = ScoreManager.get_high_score()
	var hs_player_name: String = ScoreManager.get_hs_player_name()
	if high_score > 0:
		high_score_num_label.text = str(high_score) + ' (' + hs_player_name + ')'
	else:
		high_score_num_label.hide()
		high_score_text_label.hide()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()

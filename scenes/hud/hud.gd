extends Control

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	set_score_label_text(ScoreManager.get_score())
	SignalManager.on_score_updated.connect(set_score_label_text)

func set_score_label_text(score: int) -> void:
	score_label.text = str(score)

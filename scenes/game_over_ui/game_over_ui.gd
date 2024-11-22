extends Control

@onready var sound: AudioStreamPlayer2D = $Sound
@onready var timer: Timer = $Timer
@onready var new_high_score_message: Label = $NewHighScoreMessage
@onready var player_name_input: LineEdit = $PlayerNameInput
@onready var leaderboard: GridContainer = $Leaderboard
@onready var game_over_label: Label = $GameOverLabel
@onready var space_label: Label = $SpaceLabel

func _ready() -> void:
	hide()
	SignalManager.on_plane_died.connect(on_plane_died)

func _process(delta: float) -> void:
	if space_label.visible && Input.is_action_just_pressed("fly"):
		GameManager.load_main_scene()

func on_plane_died() -> void:
	show()
	sound.play()
	if ScoreManager.is_new_high_score():
		on_new_high_score()
	else:
		timer.start()

func on_new_high_score() -> void:
	new_high_score_message.show()
	player_name_input.show()
	player_name_input.grab_focus()

func _on_timer_timeout() -> void:
	game_over_label.hide()
	space_label.show()

func _on_player_name_input_text_submitted(name: String) -> void:
	ScoreManager.save_new_high_score_to_file(name)
	new_high_score_message.hide()
	player_name_input.hide()
	timer.start()

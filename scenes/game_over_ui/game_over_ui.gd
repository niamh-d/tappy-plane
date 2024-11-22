extends Control

@onready var game_over_label: Label = $GameOverLabel
@onready var space_label: Label = $SpaceLabel
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	SignalManager.on_plane_died.connect(on_plane_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if space_label.visible && Input.is_action_just_pressed("fly"):
		GameManager.load_main_scene()

func on_plane_died() -> void:
	show()
	timer.start()
	sound.play()
	ScoreManager.save_high_score_to_file()

func _on_timer_timeout() -> void:
	game_over_label.hide()
	space_label.show()

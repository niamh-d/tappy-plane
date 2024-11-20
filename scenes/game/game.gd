extends Node2D

const PIPES = preload("res://scenes/pipes/pipes.tscn")

@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_plane_died.connect(_on_plane_died)
	spawn_pipes()
	
func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var ypos: float = randf_range(spawn_u.position.y, spawn_l.position.y)
	new_pipes.position = Vector2(spawn_l.position.x, ypos)
	pipes_holder.add_child(new_pipes)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_died() -> void:
	spawn_timer.stop()

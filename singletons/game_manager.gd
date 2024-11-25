extends Node

const MAIN: PackedScene = preload("res://scenes/main/main.tscn")
const GAME: PackedScene = preload("res://scenes/game/game.tscn")
const SIMPLE_TRANSITION: PackedScene = preload("res://scenes/simple_transition/simple_transition.tscn")

const COMPLEX_TRANSITION = preload("res://scenes/complex_transition/complex_transition.tscn")

const SCROLL_SPEED: float = 120.0
const GROUP_PLANE: String = "Plane"

var next_scene: PackedScene

func load_next_scene(ns: PackedScene) -> void:
	next_scene = ns
	var cxt = COMPLEX_TRANSITION.instantiate()
	add_child(cxt)

func load_game_scene() -> void:
	load_next_scene(GAME)
	
func load_main_scene() -> void:
	load_next_scene(MAIN)

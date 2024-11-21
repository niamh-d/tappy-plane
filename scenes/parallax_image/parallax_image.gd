extends Parallax2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var texture: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_plane_died.connect(on_plane_died)
	var scale_f = get_viewport_rect().size.y / texture.get_height()
	sprite_2d.texture = texture
	repeat_size.x = texture.get_width()
	scale = Vector2(scale_f, scale_f)

func on_plane_died() -> void:
	var p = position
	autoscroll = Vector2.ZERO
	position = p

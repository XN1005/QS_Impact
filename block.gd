@tool
extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect
@onready var handle: Marker2D = $Handle

var _last_handle_pos: Vector2

func _ready():
	if Engine.is_editor_hint():
		_last_handle_pos = handle.position
		update_block_from_handle()

func _process(_delta):
	if Engine.is_editor_hint():
		if handle.position != _last_handle_pos:
			_last_handle_pos = handle.position
			update_block_from_handle()

func update_block_from_handle():
	var size = Vector2(abs(handle.position.x), abs(handle.position.y))
	size.x = max(size.x, 16)
	size.y = max(size.y, 16)

	if collision_shape.shape == null:
		collision_shape.shape = RectangleShape2D.new()

	if collision_shape.shape is RectangleShape2D:
		collision_shape.shape.size = size

	color_rect.size = size
	color_rect.position = -size / 2.0
	collision_shape.position = Vector2.ZERO
	handle.position = size / 2.0

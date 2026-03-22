extends Node2D
@export var bullet_scene: PackedScene

@onready var muzzle = $"Bullet Spawner"

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	# 1. Point the entire Weapon node directly at the mouse
	look_at(mouse_pos)
	
	# 2. Prevent the gun from looking upside down!
	if mouse_pos.x < global_position.x:
		scale.y = -1
	else:
		scale.y = 1

func shoot():
	var bullet = bullet_scene.instantiate()
		
	get_tree().current_scene.add_child(bullet) # Add bullet as a child node in main scene
		
	bullet.global_position = muzzle.global_position
	if global_scale.x < 0:
		bullet.global_rotation = PI + global_rotation
	else:
		bullet.global_rotation = global_rotation

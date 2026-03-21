extends Node2D
@export var bullet_scene: PackedScene

@onready var muzzle = $"Bullet Spawner"

func shoot():
	print('OK')
	var bullet = bullet_scene.instantiate()
		
	get_tree().current_scene.add_child(bullet) # Add bullet as a child node in main scene
		
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = global_rotation

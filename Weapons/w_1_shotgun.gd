extends Node2D

@export var bullet_scene: PackedScene

@onready var muzzle = $"Bullet Spawner"
func shoot():
	print('OK')
	
	# 5 bullets
	for i in range(5):
		var bullet = bullet_scene.instantiate()
		
		get_tree().current_scene.add_child(bullet) # Add bullet as a child node in main scene
		
		bullet.global_position = muzzle.global_position
		
		var random_spread = randf_range(-0.2, 0.2)
		bullet.global_rotation = global_rotation + random_spread

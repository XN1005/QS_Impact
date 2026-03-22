extends Node2D

@export var bullet_scene: PackedScene

@onready var muzzle = $"Bullet Spawner"
@onready var weapon_sprite = $Shotgun0

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
	
	# 5 bullets
	for i in range(5):
		var bullet = bullet_scene.instantiate()
		
		get_tree().current_scene.add_child(bullet) # Add bullet as a child node in main scene
		
		bullet.global_position = muzzle.global_position
		
		var random_spread = randf_range(-0.2, 0.2)
		if global_scale.x < 0:
			bullet.global_rotation = PI + global_rotation + random_spread
		else: 
			bullet.global_rotation = global_rotation + random_spread


	

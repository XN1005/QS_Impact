extends Node2D

@export var bullet_scene: PackedScene

@onready var muzzle = $"Bullet Spawner"
@onready var weapon_sprite = $StaffWeapon
@onready var cast_effect = $StaffCast
@onready var original_transform = cast_effect.transform
var mouse_pos

func _ready():
	cast_effect.visible = false

func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()

func cast():
	cast_effect.visible = true

	var tween = create_tween()
	
	# Set the parallel mode so both animations happen at the same time
	tween.set_parallel(true)
	
	# 1. Enlarge: Scale from current size to 3x over 1.5 seconds
	tween.tween_property(cast_effect, "scale", Vector2(0.2, 0.2), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# 2. Fade Away: Change alpha to 0 over 1.5 seconds
	tween.tween_property(cast_effect, "modulate:a", 0.0, 0.3)
	
	await tween.finished
	# Optional: Delete the object automatically when finished
	tween.chain().kill() # Stops the tween
	tween.finished.connect(queue_free)
	
	cast_effect.transform = original_transform
	cast_effect.modulate.a = 1.0
	cast_effect.visible = false
	


func shoot():
	cast()
	
	# 5 bullets
	for i in range(5):
		var bullet = bullet_scene.instantiate()
		
		get_tree().current_scene.add_child(bullet) # Add bullet as a child node in main scene
		
		bullet.global_position = muzzle.global_position
		
		
		var random_spread = randf_range(-0.35, 0.35)
		if global_scale.x < 0:
			bullet.global_rotation = global_rotation + PI + random_spread + atan((mouse_pos.y - muzzle.global_position.y) / (mouse_pos.x - muzzle.global_position.x))
		else: 
			bullet.global_rotation = global_rotation + random_spread + atan((mouse_pos.y - muzzle.global_position.y) / (mouse_pos.x - muzzle.global_position.x))
			


	

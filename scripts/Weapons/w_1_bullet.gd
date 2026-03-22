extends Area2D

@export var bullet_time = 0.5
@export var speed = 1800

func _ready():
	await get_tree().create_timer(bullet_time).timeout
	queue_free() # DELETE


func _physics_process(delta: float) -> void:
	position.x += speed * delta * cos(global_rotation)
	position.y += speed * delta * sin(global_rotation)

func _on_body_entered(body): # Collision
	queue_free()

extends Area2D
@export var bullet_time = 1
@export var speed = 2000

func _ready():
	await get_tree().create_timer(bullet_time).timeout
	queue_free() # DELETE


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta * cos(global_rotation)
	position += transform.y * speed * delta * sin(global_rotation)

func _on_body_entered(body): # Collision
	queue_free()

extends CharacterBody2D

# Base Stats
const health = 5
const shield = 3
var speed = 300.0
var dash_speed = 800.0
var jump_strength = -800.0
var wall_jump_push = 250.0

# World Stats
var double_jump = 1
const gravity = 2000.0

# Miscellaneous
var can_dash = true
var is_dashing = false
var has_control = true
var direction = 0

func dash(direction):
	can_dash = false
	is_dashing = true
	
	if direction == 0:
		direction = 1
		
	# no vertical movements while dashing
	velocity.y = 0
	velocity.x = dash_speed * direction
	
	await get_tree().create_timer(0.2).timeout # Dash for 0.2 seconds
	is_dashing = false
	
	await get_tree().create_timer(0.6).timeout # Wait 0.8 seconds to be able to dash again
	can_dash = true
	

func _physics_process(delta: float) -> void:
	if is_dashing:
		move_and_slide()
		return # END THE FUNCTION RIGHT HERE

	# 1. GRAVITY
	if not is_on_floor():
		if is_on_wall() and velocity.y > 0:
			velocity.y = 100.0
		else:
			velocity.y += gravity * delta
	
	# 2. Reset double jump count when we touch the floor
	if has_control:
		direction = Input.get_axis("ui_left", "ui_right") 
		velocity.x = direction * speed
	if is_on_floor():
		double_jump = 1
		
	# 3. Handle ALL Jumping (Ground, Air, and Wall)
	if Input.is_action_just_pressed("ui_up"):

		if is_on_wall():
			# WALL JUMP!
			# get_wall_normal().x tells us which way the wall is facing, 
			# so we multiply it by our push force to bounce away!
			has_control = false
			velocity.x = get_wall_normal().x * wall_jump_push
			velocity.y = jump_strength

			await get_tree().create_timer(0.2).timeout
			has_control = true
		elif is_on_floor():
			# Regular Ground Jump
			velocity.y = jump_strength
		elif double_jump > 0:
			# Double Jump
			velocity.y = jump_strength
			double_jump -= 1
			
			
	# 4. Handle horizontal movement

	
	if Input.is_action_just_pressed("dash") and can_dash and has_control:
		dash(direction)
	

	# 5. Execute movement
	move_and_slide()

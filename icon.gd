extends CharacterBody2D

# Base Stats
<<<<<<< HEAD
const health = 5
const shield = 3
var speed = 300.0
var dash_speed = 800.0
var jump_strength = -800.0
var wall_jump_push = 250.0
=======
@export var health = 5
@export var shield = 3
@export var speed = 300.0
@export var dash_speed = 1000.0
@export var jump_strength = -600.0
@export var wall_jump_push = 250.0
>>>>>>> c71cc0a (Player Movement + Weapon update)

# World Stats
var double_jump = 1
const gravity = 2000.0

<<<<<<< HEAD
# Miscellaneous
var can_dash = true
var is_dashing = false
var has_control = true
var direction = 0

func dash(direction):
=======
# Weapons
@onready var active_weapon = $W1_Shotgun
@onready var side_weapon = $W2_Standard
@export var shotgun_cd = 0.6
@export var rifle_cd = 0.2
@export var railgun_cd = 10.0
@export var switch_weapon_cd = 2.0

# Miscellaneous
var can_dash = true
var is_dashing = false
var direction
var can_shoot = true
var can_switch = true

func dash():
>>>>>>> c71cc0a (Player Movement + Weapon update)
	can_dash = false
	is_dashing = true
	
	if direction == 0:
		direction = 1
		
	# no vertical movements while dashing
	velocity.y = 0
	velocity.x = dash_speed * direction
<<<<<<< HEAD
	
	await get_tree().create_timer(0.2).timeout # Dash for 0.2 seconds
	is_dashing = false
	
=======
	await get_tree().create_timer(0.2).timeout
	is_dashing = false
	
	var after_dash_dir = Input.get_axis("ui_left", "ui_right")
	if after_dash_dir == direction:
		velocity.x = after_dash_dir * speed
	else:
		velocity.x = 0
	
>>>>>>> c71cc0a (Player Movement + Weapon update)
	await get_tree().create_timer(0.6).timeout # Wait 0.8 seconds to be able to dash again
	can_dash = true
	

<<<<<<< HEAD
func _physics_process(delta: float) -> void:
=======
func _physics_process(delta: float) -> void:	
	# ----------------------- MOVEMENTS -----------------------
>>>>>>> c71cc0a (Player Movement + Weapon update)
	if is_dashing:
		move_and_slide()
		return # END THE FUNCTION RIGHT HERE

	# 1. GRAVITY
	if not is_on_floor():
		if is_on_wall() and velocity.y > 0:
<<<<<<< HEAD
			velocity.y = 100.0
=======
			velocity.y = 50
>>>>>>> c71cc0a (Player Movement + Weapon update)
		else:
			velocity.y += gravity * delta
	
	# 2. Reset double jump count when we touch the floor
<<<<<<< HEAD
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
=======
	if is_on_floor():
		double_jump = 1
		
	# 3. Jumping	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_strength
		elif is_on_wall():
			# WALL JUMP
			velocity.y = jump_strength
			# Push them away from the wall
			velocity.x = get_wall_normal().x * wall_jump_push
		elif double_jump > 0:
			velocity.y = jump_strength
			double_jump -= 1

	# 4. Smooth Horizontal Movement
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, 1200 * delta)
	else:
		# If the player lets go of the keys, apply "friction" to gently slow them down
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)

	# 5. Execute movement
	move_and_slide()
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash()
	
	# 5. Execute movement
	move_and_slide()
		
	# ----------------------- COMBAT -----------------------
	side_weapon.visible = false
	active_weapon.visible = true
	
	# Switch weapon
	if can_switch and Input.is_action_just_pressed("switch_weapon"):
		can_switch = false
		if active_weapon == $W1_Shotgun:
			active_weapon = $W2_Standard
			side_weapon = $W1_Shotgun
		else:
			active_weapon = $W1_Shotgun
			side_weapon = $W2_Standard
		
		await get_tree().create_timer(switch_weapon_cd).timeout
		can_switch = true
		
		
	if can_shoot and active_weapon == $W2_Standard:
		if Input.is_action_pressed("shoot"):
			active_weapon.shoot()
			can_shoot = false
			await get_tree().create_timer(rifle_cd).timeout
			can_shoot = true
	elif can_shoot and active_weapon == $W1_Shotgun:
		if Input.is_action_just_pressed("shoot"):
			active_weapon.shoot()
			can_shoot = false
			await get_tree().create_timer(shotgun_cd).timeout
			can_shoot = true
>>>>>>> c71cc0a (Player Movement + Weapon update)

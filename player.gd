extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var SPEED = 300.0
@export var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var JUMP_VELOCITY = -400.0
@export var MAX_AIR_JUMPS = 1
var jump_count = 0
@export var short_jump_factor = 0.5
@export var coyote_time = 0.15
var coyote_timer = 0.0

func _physics_process(delta):
	handle_coyote_time(delta)
	handle_jump()
	handle_horizontal_movement()
	move_and_slide()
	pass
	
func handle_jump():
	if Input.is_action_just_pressed("ui_accept"):
		# Normal Jump (on floor or within coyote time)
		if is_on_floor() or coyote_timer > 0:
			if (!is_on_floor() and coyote_time > 0):
				jump()
				print("coyote jump")
			else: 
				jump()
		# Multi Jump (in air, but still have jumps left)
		elif jump_count < MAX_AIR_JUMPS:
			jump()
			jump_count += 1
	
	# Handle short jumps
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= short_jump_factor

func jump():
	velocity.y = JUMP_VELOCITY
	coyote_timer = 0

func handle_coyote_time(delta: float):
	if is_on_floor():
		coyote_timer = coyote_time
		jump_count = 0 # Reset jumps when touching ground
	else:
		velocity.y += gravity * delta
		coyote_timer -= delta
	
func handle_horizontal_movement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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
@export var FAST_FALL_FACTOR = 1.1
@export var MAX_FALL_SPEED = 800
@export var MAX_SLOW_FALL_SPEED = 150

func _physics_process(delta):
	handle_coyote_time(delta)
	handle_jump()
	handle_movement(delta)
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
	$AudioStreamPlayer2D.play()
	velocity.y = JUMP_VELOCITY
	coyote_timer = 0

func handle_coyote_time(delta: float):
	if is_on_floor():
		coyote_timer = coyote_time
		jump_count = 0 # Reset jumps when touching ground
	else:
		velocity.y += gravity * delta
		coyote_timer -= delta
	
func handle_movement(delta: float):
	# Horizontal
	var h_direction = Input.get_axis("ui_left", "ui_right")
	if h_direction:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Vertical
	if Input.is_action_pressed("ui_up") and Utils.is_falling(self):
		velocity.y = min(velocity.y, MAX_SLOW_FALL_SPEED)
	elif Input.is_action_pressed("ui_down") and Utils.is_falling(self):
		velocity.y *= FAST_FALL_FACTOR
	
	# X
	velocity.y = min(velocity.y, MAX_FALL_SPEED)

extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var MAX_AIR_JUMPS = 1

# Get gravity from Project Settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

var coyote_time = 0.15 
var coyote_timer = 0.0

func _physics_process(delta):
# 4. Handle Horizontal Movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# 1. Handle Coyote Timer & Gravity
	if is_on_floor():
		coyote_timer = coyote_time
		jump_count = 0 # Reset jumps when touching ground
	else:
		velocity.y += gravity * delta
		coyote_timer -= delta

	# 2. Handle Jump Input
	if Input.is_action_just_pressed("ui_accept"):
		# Option A: Normal Jump (on floor or within coyote time)
		if is_on_floor() or coyote_timer > 0:
			jump()
		# Option B: Double Jump (in air, but still have jumps left)
		elif jump_count <= MAX_AIR_JUMPS:
			jump()

	# 3. Horizontal Movement
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	


func jump():
	velocity.y = JUMP_VELOCITY
	jump_count += 1
	coyote_timer = 0
	

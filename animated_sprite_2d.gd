extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		print('right pressed')
		play("run_right")
	elif Input.is_action_pressed("ui_left"):
		play("run_left")
	elif Input.is_action_pressed("ui_up"):
		play("run_up")
	elif Input.is_action_pressed("ui_down"):
		play("run_down")
	else:
		print('idle forward')
		play("idle_forward")
	pass

extends ColorRect

var speed = 800

func _ready() -> void:
	var window_size = get_window().size
	var center = Vector2(window_size.x / 2, window_size.y / 2)
	position = center	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_W):
		direction.y = -1
	if Input.is_key_pressed(KEY_A):
		direction.x = -1
	if Input.is_key_pressed(KEY_S):
		direction.y = 1
	if Input.is_key_pressed(KEY_D):
		direction.x = 1
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		position = get_global_mouse_position()

	position += direction.normalized() * speed * delta
	#print("Position is: ", position)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("Mouse click position", event.position)
	elif event is InputEventMouseMotion:
		print("Mouse move position", event.position)
	

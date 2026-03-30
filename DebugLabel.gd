extends Label

@onready var character = $"../../CharacterBody2D"

func _process(delta: float) -> void:
	text = "Velocity: %.0f, %.0f
	Position: %.0f, %.0f
	Air Jumps left: %s" % [
		character.velocity.x, 
		character.velocity.y, 
		character.global_position.x,
		character.global_position.y,
		character.MAX_AIR_JUMPS - character.jump_count
	]
	pass

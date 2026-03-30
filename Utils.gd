extends Node

func is_falling(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and body.velocity.y > 0

@tool
extends Node

@export var target_rect: ColorRect
@export var collision_shape: CollisionShape2D

func _process(delta: float) -> void:
	if target_rect and collision_shape and collision_shape.shape is RectangleShape2D:
		collision_shape.shape.size = target_rect.size
		collision_shape.position = target_rect.position + (target_rect.size / 2)

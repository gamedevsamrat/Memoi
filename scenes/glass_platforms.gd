extends Node2D

signal safe_platform(platform_y)
signal wrong_platform

@export var is_safe: bool = false

func _ready():
	# This will be set randomly by the parent column or game manager
	pass

func _on_collision_shape_2d_body_entered(body):
	if body.has_method("fall") and not is_safe:
		body.fall()
	elif body.has_method("stand_on_platform") and is_safe:
		body.stand_on_platform(global_position.y)

func set_platform_state(safe: bool):
	is_safe = safe
	$CollisionShape2D.set_deferred("disabled", not safe)

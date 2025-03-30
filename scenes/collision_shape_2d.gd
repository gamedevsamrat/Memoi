extends Area2D

@export var next_level: String = "res://scenes/level1.tscn"

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(next_level)

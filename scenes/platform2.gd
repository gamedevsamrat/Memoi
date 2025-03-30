extends Node2D

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"): 
		get_tree().change_scene_to_file("res://scenes/level3.tscn")

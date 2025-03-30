extends Area2D

signal ball_fell

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Ball"):
		print("Game Ove")
		ball_fell.emit() 
		body.queue_free()  

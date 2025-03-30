extends Node2D

@onready var area = $Area2D 
@onready var sprite = $power
@onready var anim_player = $AnimationPlayer 

func _ready():
	area.body_entered.connect(_on_area_body_entered)
	anim_player.play("anipower")

func _on_area_body_entered(body):
	if body.is_in_group("player"):
		print("Player collected")
		body.increase_speed()  
		hide() 
		queue_free() 

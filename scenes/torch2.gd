extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	if animation_player:
		animation_player.play("torch2ani") 
		animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	animation_player.play(anim_name)  

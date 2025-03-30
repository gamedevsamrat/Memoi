extends Node2D

@onready var area = $Area2D
@onready var sprite = $power
@onready var anim_player = $AnimationPlayer

@export var arrow_scene: PackedScene 

func _ready():
	area.body_entered.connect(_on_area_body_entered)
	anim_player.play("anibulb")

func _on_area_body_entered(body):
	if body.is_in_group("player"):
		print("Player got power-up!")

		body.increase_speed()


		if arrow_scene:
			var new_arrow = arrow_scene.instantiate()
			new_arrow.global_position = body.global_position 
			get_tree().current_scene.add_child(new_arrow)

			new_arrow.activate()  
			print("New arrow at:", new_arrow.global_position)
		else:
			print("Arrow not assigned!")

		hide()
		queue_free()

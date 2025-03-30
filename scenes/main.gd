extends Node2D
@onready var p1 = $p1
@onready var p2 = $p2
@onready var platform = $Platform 


var blocks_falling = false

func _ready():
	Global.current_scene = "main"
	
	if Global:
		print("Blocks fallen count:", Global.blocks_fallen)
	else:
		print("ERROR: global singleton missing")
	
	print("Checking Global.has_correct_answered =", Global.has_correct_answered)
	

	if p1 and p2:
		p1.visible = not Global.has_correct_answered
		p2.visible = Global.has_correct_answered
		print("p1 and p2 visibility")
	else:
		print("p1 or p2 not found!")
	
	if platform:
		if not platform.five_blocks_fallen.is_connected(_on_platform_five_blocks_fallen):
			var success = platform.five_blocks_fallen.connect(_on_platform_five_blocks_fallen)
			if success == OK:
				print("Signal connected, five_blocks_fallen")
			else:
				print("Signal failed!")
		else:
			print("Signal already connected")
	else:
		print("Platform node not found")
	
	blocks_falling = false
	
	if Global.blocks_fallen == 0:
		print("block can fall")
	else:
		print("block not fall")

func _input(event):
	if Global.current_scene != "main":
		return
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		print("Spacebar")
		
		if Global.blocks_fallen == 0 and not blocks_falling:
			print("dibba girao")
			blocks_falling = true
			Global.is_dropping_blocks = true
		else:
			print("dibba gir rha h")

func _on_platform_five_blocks_fallen():
	if Global.current_scene != "main":
		return
		
	print("babba gir chukka h")
	Global.blocks_fallen = 5
	
	blocks_falling = false
	Global.is_dropping_blocks = false
	
	print("Loading l1 ")
	var new_scene = "res://scenes/level1.tscn"
	if ResourceLoader.exists(new_scene):
		print("moving to level1")
		get_tree().create_tween().kill()
		get_tree().change_scene_to_file(new_scene)
	else:
		print("Er: level1.tscn not found!")

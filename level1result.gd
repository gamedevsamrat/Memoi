extends Node2D

@onready var co_plus_button = $CO_Plus
@onready var co_minus_button = $CO_Minus
@onready var ae_plus_button = $AE_Plus
@onready var ae_minus_button = $AE_Minus
@onready var confirm_button = $Confirm

@onready var co_image_container = $COImgContainer
@onready var ae_image_container = $AEImgContainer

var co_data = 0 
var ae_data = 0  
var co_count = 0 
var ae_count = 0 

const IMAGE_SPACING = 60
const IMAGE_SCALE = Vector2(0.5, 0.5)

func _ready():
	Global.current_scene = "level1result"
	
	co_plus_button.pressed.connect(_on_co_plus_pressed)
	co_minus_button.pressed.connect(_on_co_minus_pressed)
	ae_plus_button.pressed.connect(_on_ae_plus_pressed)
	ae_minus_button.pressed.connect(_on_ae_minus_pressed)
	confirm_button.pressed.connect(_on_confirm_pressed)
	
	print_debug_info()

func print_debug_info():
	print("CO count:", co_data)
	print("AE count:", ae_data)
	print("Current blocks fallen:", Global.blocks_fallen)
	print("Current Scene:", Global.current_scene)

func _on_co_plus_pressed():
	co_count += 1
	update_co_images()
	print("CO count increased to:", co_count)

func _on_co_minus_pressed():
	if co_count > 0:
		co_count -= 1
		update_co_images()
		print("CO count decreased to:", co_count)

func _on_ae_plus_pressed():
	ae_count += 1
	update_ae_images()
	print("AE count increased", ae_count)

func _on_ae_minus_pressed():
	if ae_count > 0:
		ae_count -= 1
		update_ae_images()
		print("AE count decreased:", ae_count)

func _on_confirm_pressed():
	check_answers()

func update_co_images():
	for child in co_image_container.get_children():
		child.queue_free()
	
	for i in range(co_count):
		var new_img = Sprite2D.new()
		new_img.texture = preload("res://sources/Cookie 2.png")
		new_img.scale = IMAGE_SCALE

		var row = i / 5
		var col = i % 5
		new_img.position = Vector2(col * IMAGE_SPACING, row * IMAGE_SPACING)
		
		co_image_container.add_child(new_img)
		print("Added CO image:", new_img.position)

func update_ae_images():
	for child in ae_image_container.get_children():
		child.queue_free()
	
	for i in range(ae_count):
		var new_img = Sprite2D.new()
		new_img.texture = preload("res://sources/Applesas.png")
		new_img.scale = IMAGE_SCALE
		

		var row = i / 5
		var col = i % 5
		new_img.position = Vector2(col * IMAGE_SPACING, row * IMAGE_SPACING)
		
		ae_image_container.add_child(new_img)
		print("Added AE image at position:", new_img.position)

func check_answers():
	if Global.current_scene != "level1result":
		print("check_answers() called from wrong scene!")
		return

	var co_correct = (co_count > 0) == (co_data > 0)
	var ae_correct = (ae_count > 0) == (ae_data > 0)
	
	if co_correct and ae_correct:
		print("correct")
		
		
		Global.has_correct_answered = true  
		print("correctset")
		
		Global.blocks_fallen = 0
		print("Reset global")

		self.hide()
		print("H")

		get_tree().change_scene_to_file("res://scenes/level2.tscn")
	else:
		print("W Doublecheck")

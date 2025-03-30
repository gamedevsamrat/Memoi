extends Node2D

@onready var r1_image = $R1
@onready var r2_image = $R2
@onready var r3_image = $R3
@onready var r4_image = $R4
@onready var r5_image = $R5

var recipe_images = []

func _ready():
	recipe_images = [r1_image, r2_image, r3_image, r4_image, r5_image]
	
	update_recipe_display()

func _process(_delta):
	update_recipe_display()

func update_recipe_display():
	for image in recipe_images:
		image.visible = false
	

	if Global.current_recipe < recipe_images.size():
		recipe_images[Global.current_recipe].visible = true
		

extends Area2D

@export var fall_speed = 200 

func _ready():
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("basket") or area.name == "Basket":
		var is_needed = Global.check_fruit_collected(name)
		print(name + " collected in the basket! Needed: " + str(is_needed))
		queue_free() 

func _on_body_entered(body):
	if body.is_in_group("player") or body.name == "Player":
		var is_needed = Global.check_fruit_collected(name)
		print(name + " collected in the basket! Needed: " + str(is_needed))
		queue_free() 

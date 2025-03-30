extends Area2D

@onready var power_up_node = get_parent()  

func _ready():
	connect("area_entered", _on_area_entered)  

func _on_area_entered(area):
	if area.name == "PlayerMover":  
		print("Powerup collected")  
		power_up_node.visible = false  
		power_up_node.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED) 

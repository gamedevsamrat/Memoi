extends StaticBody2D

@export var max_hits: int = 1  
var current_hits: int = 0

func _ready():
	if scene_file_path.get_file().begins_with("Brick3") or scene_file_path.get_file().begins_with("Brick4"):
		max_hits = 2  

func hit():
	current_hits += 1
	print(name, " hit ", current_hits, "/", max_hits)  
	if current_hits >= max_hits:
		queue_free()  

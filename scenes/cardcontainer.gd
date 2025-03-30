extends Node2D  

var correct_cards_clicked = 0  
const TOTAL_CORRECT_CARDS = 4  
var game_over = false 

func _ready():
	assign_wrong_cards()

func assign_wrong_cards():
	for column in get_children():
		for card in column.get_children():
			var texture_button = card.get_node_or_null("TextureButton")
			if texture_button:
				if card.name in Global.wrong_platforms:
					texture_button.texture_focused = load("res://sources/level4/wrong.png")
					texture_button.pressed.connect(func(): on_card_clicked(false, texture_button))
				else:
					texture_button.texture_focused = load("res://sources/level4/right.png")
					texture_button.pressed.connect(func(): on_card_clicked(true, texture_button))

func on_card_clicked(is_correct, button):
	if game_over:
		return  

	if is_correct:
		print("correct")
		correct_cards_clicked += 1
	else:
		print("wrong")
		game_over = true 
		disable_all_buttons()

	if correct_cards_clicked == TOTAL_CORRECT_CARDS:
		Global.reset_wrong_platforms()
		print("lev Compl.")

func disable_all_buttons():
	for column in get_children():
		for card in column.get_children():
			var texture_button = card.get_node_or_null("TextureButton")
			if texture_button:
				texture_button.disabled = true
				texture_button.focus_mode = Control.FOCUS_NONE

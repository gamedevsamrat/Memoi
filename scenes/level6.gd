extends Node2D

@onready var question_image = $QuestionContainer/QuestionImage
@onready var answer_buttons = [
	$AnswerContainer/Answer1,
	$AnswerContainer/Answer2,
	$AnswerContainer/Answer3,
	$AnswerContainer/Answer4,
	$AnswerContainer/Answer5
]

var question_images = [
	preload("res://sources/level6/Q1.jpg"),
	preload("res://sources/level6/Q2.jpg"),
	preload("res://sources/level6/Q3.jpg"),
	preload("res://sources/level6/Q4.jpg"),
	preload("res://sources/level6/Q5.jpg")
]

var answer_images = [
	preload("res://sources/level6/1st.png"),
	preload("res://sources/level6/2nd.png"),
	preload("res://sources/level6/3rd.png"),
	preload("res://sources/level6/4th.png"),
	preload("res://sources/level6/5th.png")
]

var correct_answers = [0, 4, 3, 2, 1]  
var current_question_index = 0
var correct_count = 0

func _ready():
	assign_answer_images()
	load_question(current_question_index)

	for i in range(answer_buttons.size()):
		answer_buttons[i].pressed.connect(_on_answer_pressed.bind(i))

func assign_answer_images():
	for i in range(answer_buttons.size()):
		answer_buttons[i].texture_normal = answer_images[i]

func load_question(index):
	question_image.texture = question_images[index]
	question_image.custom_minimum_size = Vector2(800, 600)  
	question_image.scale = Vector2(0.016, 0.016) 

func _on_answer_pressed(selected_index):
	if selected_index == correct_answers[current_question_index]:  
		correct_count += 1
		if correct_count == 5:
			print("all right")
		else:
			current_question_index += 1
			load_question(current_question_index)
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")  

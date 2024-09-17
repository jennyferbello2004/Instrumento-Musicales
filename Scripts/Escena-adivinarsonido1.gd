extends Node2D

var alreadyClicked = false
var canClickAgain = false
signal node_pressed

@onready var button1 = $Button
@onready var button2 = $Button2

func _ready():
	for child in get_children():
		if child is Area2D: 
			child.connect("node_pressed", _on_node_pressed)



func _on_node_pressed():

	for child in get_children():
		if child is Area2D:
			child.input_pickable = false 

func _on_button_pressed():

	for child in get_children():
		if child is Area2D:
			child.input_pickable = true 
			button1.visible = false
			button2.visible = false

func _on_button_2_pressed():
	for child in get_children():
		if child is Area2D:
			child.input_pickable = true 
			button1.visible = false
			button2.visible = false

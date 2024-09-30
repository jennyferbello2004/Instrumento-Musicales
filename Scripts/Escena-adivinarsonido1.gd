extends Node2D

var alreadyClicked = false
var canClickAgain = false
var correctAreaPressed = false

signal node_pressed

@onready var button1 = $Button
@onready var button2 = $Button2
@onready var audioInicial = $AudioInicial
@onready var audioReady = $AudioReady 

func _ready():
	for child in get_children():
		if child is Area2D: 
			child.connect("node_pressed", _on_node_pressed)
			child.connect("correct_area_pressed", _on_correct_area_pressed)  
	_on_ready()

func _on_ready():
	for child in get_children():
		if child is Area2D:
			child.input_pickable = false
	audioInicial.play() 
	await audioInicial.finished  
	audioReady.play() 
	await audioReady.finished
	for child in get_children():
		if child is Area2D:
			child.input_pickable = true 

func _on_node_pressed():
	for child in get_children():
		if child is Area2D:
			child.input_pickable = false 
			audioReady.stop() 
	correctAreaPressed = false

func _on_button_pressed():
	if correctAreaPressed:  
		print("Changing scene...")
		$Correct.play()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Escenas/EscenaPrincipal.tscn")
	else:
		print("Incorrect Area2D pressed")
		$error2.play()
	for child in get_children():
		if child is Area2D:
			child.input_pickable = true 
			button1.visible = false
			button2.visible = false

func _on_button_2_pressed():
	$error.play()
	for child in get_children():
		if child is Area2D:
			child.input_pickable = true 
			button1.visible = false
			button2.visible = false

func _on_correct_area_pressed():
	correctAreaPressed = true 

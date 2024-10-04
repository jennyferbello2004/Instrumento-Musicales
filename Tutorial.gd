extends Control
@onready var tutorial = $Tutorialpc

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")

func _ready():
	await tutorial.finished
	$tutorial2.play()

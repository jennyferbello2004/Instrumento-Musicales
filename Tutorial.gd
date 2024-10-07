extends Control
@onready var tutorial = $Tutorialpc
var Jennyfer_lopez = preload("res://Menu.tscn")
func _on_texture_button_pressed():
	get_tree().change_scene_to_packed(Jennyfer_lopez)

func _ready():
	await tutorial.finished
	$tutorial2.play()

extends Control


func _ready():
	jennyfer_lopez()


func jennyfer_lopez():
	$audiovictoria.play()
	await $audiovictoria.finished
	$audiocontinuaruwu.play()


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")

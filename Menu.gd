extends Control

var hola = preload("res://Escenas/EscenaPrincipal.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Arpa")
	$AnimationPlayer2.play("Animation-guitarra")
	$AnimationPlayer3.play("animation-maracas")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_arpa_pressed():
	get_tree().change_scene_to_file("res://Carta.tscn")


func _on_guitarra_pressed():
	get_tree().change_scene_to_file("res://Escenas/Escena_nivel_2.tscn")


func _on_maraca_pressed():
	get_tree().change_scene_to_file("res://EscenaSonido1.tscn")


func _on_boton_volver_pressed():
	get_tree().change_scene_to_file("res://Escenas/EscenaPrincipal.tscn")

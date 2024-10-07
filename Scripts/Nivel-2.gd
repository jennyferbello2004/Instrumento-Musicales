extends Control

var score = 0
var buttons_pressed = {}

func add_point(_score):
	score += _score
	Presentation()

func Presentation():
	if score >= 8:
		$AnimationPlayer2.play("Oscuridad2")
		await get_tree().create_timer(2.5).timeout
		
		$AnimationPlayer2.play("Oscuridad")
		$AnimationPlayer.play("guitarra")
		$Guitarra.visible = true
		hide_all_buttons()  
		await get_tree().create_timer(2.5).timeout
		$Cuatro.visible = true
		$audiocuatro.play()
		await get_tree().create_timer(17).timeout
		get_tree().change_scene_to_file("res://victoria2.tscn")

func hide_all_buttons():
	var buttons = ["Button", "Button2", "Button3", "Button4", "Button5", "Button6", "Button7", "Button8"]
	for button in buttons:
		var button_node = get_node(button)
		button_node.get_node("TextureRect").visible = false
		button_node.get_node("TextureRect2").visible = false

func _on_button_pressed(button_name):
	if not buttons_pressed.has(button_name):
		print ("sumo punto")
		add_point(1)
		$AudioStreamPlayer.play()
		buttons_pressed[button_name] = true
		var button_node = get_node(button_name)
		button_node.get_node("TextureRect").visible = false
		button_node.get_node("TextureRect2").visible = true

func _ready():

	var buttons = ["Button", "Button2", "Button3", "Button4", "Button5", "Button6", "Button7", "Button8"]
	for button in buttons:
		var button_node = get_node(button)
		button_node.get_node("TextureRect").visible = true
		button_node.get_node("TextureRect2").visible = false
		var callable = Callable(self, "_on_button_pressed").bind(button)
		button_node.connect("pressed", callable)



func _on_rutaboton_3_pressed():
	get_tree().change_scene_to_file("res://Menu2.tscn")

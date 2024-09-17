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
		$AnimationPlayer.play("Words")

func hide_all_buttons():
	var buttons = ["Button", "Button2", "Button3", "Button4", "Button5", "Button6", "Button7", "Button8"]
	for button in buttons:
		get_node(button + "/TextureRect").visible = false
		get_node(button + "/TextureRect2").visible = false

func _on_button_pressed(button_name):
	if not buttons_pressed.has(button_name):
		print ("sumo punto")
		add_point(1)
		$AudioStreamPlayer.play()
		var button_node = get_node(button_name)
		var texture_rect2 = button_node.get_node("TextureRect2")
		var animation_player = texture_rect2.get_node("AnimationPlayer")
		if animation_player != null:
			animation_player.play("ButtonAnimation")  
		button_node.get_node("TextureRect").visible = false
		texture_rect2.visible = true
		buttons_pressed[button_name] = true

func _ready():
	var buttons = ["Button", "Button2", "Button3", "Button4", "Button5", "Button6", "Button7", "Button8"]
	for button in buttons:
		var callable = Callable(self, "_on_button_pressed").bind(button)
		get_node(button).connect("pressed", callable)

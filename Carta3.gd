extends TextureButton
signal card_flipped
var face_up = false
var card_value = "I"
var empty_card_texture = preload("res://Assets/Imagenes/Textura-Vacia.png")
var card_back_texture = preload("res://Assets/Imagenes/Parte trasera carta.png")
var card_front_texture = preload("res://Assets/Imagenes/Carta Maracas.png")
var can_flip = true  
var card_sound = null 
func _ready():
	self.texture_normal = card_back_texture
	self.connect("pressed", _on_Card_pressed)
	
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = card_sound

func _on_Card_pressed():
	if can_flip and not face_up: 
		flip_card()
		emit_signal("card_flipped", self)  

func flip_card():
	face_up = not face_up
	self.texture_normal = card_front_texture if face_up else card_back_texture
	self.set_process_input(not face_up) 

func play_sound():
	$AudioStreamPlayer.play()

func set_empty():
	face_up = false
	can_flip = false
	self.texture_normal = empty_card_texture 
	self.set_process_input(false)  

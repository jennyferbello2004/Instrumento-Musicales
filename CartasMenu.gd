extends Node2D

signal card_flipped
@onready var sprites = [
	$Manzana,
	$Manzana2,
	$Manzana3,
	$Manzana4,
	$Manzana5,
	$Manzana6,
]

var card_scene1 = preload("res://Carta1.tscn")
var card_scene2 = preload("res://Carta2.tscn")
var card_scene3 = preload("res://Carta3.tscn")
var card_scene4 = preload("res://Carta4.tscn")
var card_scene5 = preload("res://Carta5.tscn")
var card_scene6 = preload("res://Carta6.tscn")

var first_card = null
var second_card = null
var can_flip = true
var matched_cards = []
var score = 0  
var score_label = null  
var action_counter = 0
var action_label = null

func _ready():
	var card_grid = $GridContainer
	score_label = $Label  
	update_score_label()  
	action_label = $ClickCounter
	update_action_label()
	for sprite in sprites:
		sprite.visible = false  
	var cards = [] 

	for i in range(2):
		var card1 = card_scene1.instantiate()
		card1.card_value = "Guitar"
		card1.card_sound = preload("res://Sonidos/Instrumentos/ARpa.mp3")
		cards.append(card1)

		var card2 = card_scene2.instantiate()
		card2.card_value = "Piano"
		card2.card_sound = preload("res://Sonidos/Instrumentos/Flauta.mp3")
		cards.append(card2)

		var card3 = card_scene3.instantiate()
		card3.card_value = "Drums"
		card3.card_sound = preload("res://Sonidos/Instrumentos/Maraca.mp3")
		cards.append(card3)

		var card4 = card_scene4.instantiate()
		card4.card_value = "Violin"
		card4.card_sound = preload("res://Sonidos/Instrumentos/Sonido Guitarra.mp3")
		cards.append(card4)

		var card5 = card_scene5.instantiate()
		card5.card_value = "Flute"
		card5.card_sound = preload("res://Sonidos/Instrumentos/Tambor.mp3")
		cards.append(card5)

		var card6 = card_scene6.instantiate()
		card6.card_value = "Trumpet"
		card6.card_sound = preload("res://Sonidos/Instrumentos/Violin.mp3")
		cards.append(card6)

	cards.shuffle()

	for card in cards: 
		card_grid.add_child(card)
		card.connect("card_flipped", _on_card_flipped)

func _process(delta):
	$FPSlabel.text = "FPS: " + str(Engine.get_frames_per_second())

func _on_card_flipped(card):
	if can_flip and card not in matched_cards:
		if first_card == null:
			first_card = card
		elif second_card == null and card != first_card:
			second_card = card
			can_flip = false  
			set_cards_mouse_filter(Control.MOUSE_FILTER_IGNORE)  
			check_match()
			action_counter += 1
			update_action_label()

func check_match():
	if first_card != null and second_card != null:
		if first_card.card_value == second_card.card_value:
			match_found()
		else:
			await get_tree().create_timer(2.0).timeout
			first_card.flip_card()
			second_card.flip_card()
			reset_flip_state()

func reset_flip_state():
	first_card = null
	second_card = null
	can_flip = true 
	set_cards_mouse_filter(Control.MOUSE_FILTER_PASS) 

func set_cards_mouse_filter(filter):
	for card in $GridContainer.get_children():
		card.mouse_filter = filter

func match_found():
	matched_cards.append(first_card)
	matched_cards.append(second_card)
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player) 
	audio_player.stream = first_card.card_sound
	audio_player.play()
	await get_tree().create_timer(2.0).timeout
	audio_player.stop()
	audio_player.stream = second_card.card_sound
	audio_player.play()
	await get_tree().create_timer(2.0).timeout
	audio_player.stop()
	score += 1  
	update_score_label()  
	await get_tree().create_timer(1.0).timeout
	first_card.set_empty()  
	second_card.set_empty() 
	reset_flip_state()
	var timer = get_tree().create_timer(0.5)
	if score <= 6:  
		sprites[score - 1].visible = true
	timer.connect("timeout", _on_match_timeout)
	if score >= 6:
		get_tree().change_scene_to_file("res://EscenaSonido1.tscn")

func _on_match_timeout():
	set_cards_interactive(true) 

func set_cards_interactive(active):
	for card in $GridContainer.get_children():
		card.set_process_input(active) 
	can_flip = true
func update_action_label():
	action_label.text = "Acciones: %d" % action_counter
func update_score_label():
	score_label.text = "Puntaje: %d"

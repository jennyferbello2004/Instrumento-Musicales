extends Button

@export var instrument_image: Texture
@export var instrument_sound: AudioStream

var is_flipped = false
var is_matched = false

func _ready():
	$TextureRect.texture = null

func flip():
	if is_matched:
		return

	is_flipped = !is_flipped
	$TextureRect.texture = instrument_image if is_flipped else null

	if is_flipped:
		emit_signal("flipped", self)

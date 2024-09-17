extends Area2D
signal node_pressed





func _input_event(_viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$Sonido2.play()
		emit_signal("node_pressed")
		print ("uwu")
		await get_tree().create_timer(3.0).timeout
		$"../Button".visible = true
		$"../Button2".visible = true

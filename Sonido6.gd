extends Area2D

signal node_pressed




func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$sonido6.play()
		emit_signal("node_pressed")
		print ("uwu")
		await get_tree().create_timer(3.0).timeout
		$"../Button".visible = true
		$"../Button2".visible = true

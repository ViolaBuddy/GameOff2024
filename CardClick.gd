extends Area2D

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		Globals.clickedCard = get_parent()

func _mouse_enter() -> void:
	Globals.hoveredCard = get_parent()

func _mouse_exit() -> void:
	Globals.unhoveredCard = get_parent()

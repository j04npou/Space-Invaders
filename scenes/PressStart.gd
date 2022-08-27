extends Node2D

func _ready():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_loops()
	tween.tween_property(self, "scale", Vector2(0.7,0.7), 1)
	tween.tween_property(self, "scale", Vector2(2.7,2.7), 1)

func _unhandled_input(event):
	if Input.is_action_just_released("ui_accept"):
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)

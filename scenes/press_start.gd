extends Node2D

var tween
var firePressed = false

func _ready():
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_loops(1000)
	tween.tween_property(self, "scale", Vector2(0.7,0.7), 1)
	tween.tween_property(self, "scale", Vector2(2.7,2.7), 1)

func _unhandled_input(_event):
	if Input.is_action_just_released("ui_accept") and !firePressed:
		$AudioStreamPlayer.play()
		tween.kill()
		var tween2 = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
		tween2.tween_property(self, "modulate", Color(1,1,1,0), 0.5)
		firePressed = true


extends Node2D

var firePressed = false

func _unhandled_input(_event):
	if Input.is_action_just_released("ui_accept") and !firePressed:
		$Timer.start()
		firePressed = true

func startGame():
	var _none = get_tree().change_scene("res://scenes/decorated_game.tscn")

func _on_Timer_timeout():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1,1), 2)
	tween.tween_property(self, "position", Vector2(-76,-540), 2)
	tween.tween_property($CRTeffet, "modulate", Color(1,1,1,0), 2)
	tween.set_parallel(false)
	tween.tween_callback(self, "startGame", [])

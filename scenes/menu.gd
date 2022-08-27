extends Node2D

func _unhandled_input(event):
	if Input.is_action_just_released("ui_accept"):
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "scale", Vector2(1,1), 2)
		tween.tween_property(self, "position", Vector2(-76,-540), 2)
		tween.tween_property($CRTeffet, "modulate", Color(1,1,1,0), 2)
		tween.set_parallel(false)
		tween.tween_callback(self, "startGame", [])

func startGame():
	get_tree().change_scene("res://scenes/decorated_game.tscn")

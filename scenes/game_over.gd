extends Node2D

func _on_Timer_timeout():
#	get_tree().paused = false
	var _none = get_tree().change_scene("res://scenes/menu.tscn")

func gameOver():
#	get_tree().paused = true
	$Timer.start()
	visible = true

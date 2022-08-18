extends Node2D

func _ready():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1,1), 1)
	tween.tween_property(self, "position", Vector2(-76,-540), 1)

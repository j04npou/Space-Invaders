extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("ui_cancel"):
		$Label.visible = !get_tree().paused
		if get_tree().paused:
			$Timer.start()
		else:
			get_tree().paused = !get_tree().paused


func _on_Timer_timeout():
	get_tree().paused = false


func _on_TextureButton_pressed():
	Input.action_release("ui_cancel")

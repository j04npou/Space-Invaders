extends Node2D

onready var _default_color : Color = $Virtual_Button_fire.modulate

func _ready():
	if not OS.has_touchscreen_ui_hint():
		visible = false

func _input(event: InputEvent) -> void:
	var xmin = $Virtual_Button_fire.rect_global_position.x
	
	if event is InputEventScreenTouch:
		if event.position.x > xmin and event.position.y > 85 and !Input.is_action_pressed("ui_accept") and event.pressed:
			Input.action_press("ui_accept",1)
			$Virtual_Button_fire.modulate = Color.gray
		elif Input.is_action_pressed("ui_accept") and !event.pressed:
			Input.action_release("ui_accept")
			$Virtual_Button_fire.modulate = _default_color

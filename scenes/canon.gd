extends Node2D

var speed = 170
var isBulletReady = true
signal shot

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
		
	if Input.is_action_pressed("ui_accept") and isBulletReady:
		isBulletReady = false
		var bullet = preload("res://scenes/canon_bullet.tscn").instance()
		get_parent().add_child(bullet)
		bullet.position = position - Vector2(0,10)
		bullet.connect("bulletReady", self, "_on_bulletReady")
		emit_signal("shot")
	if position.x < 60:
		position.x = 60
	elif position.x > 540:
		position.x = 540

func _on_bulletReady():
	isBulletReady = true

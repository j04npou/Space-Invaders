extends Node2D

signal bulletReady

var speed = 400

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= speed * delta
	
	if position.y < -10:
		emit_signal("bulletReady")
		queue_free()


func _on_Area2D_body_entered(body):
#	print(body.name)
	body.get_parent().die()
	emit_signal("bulletReady")
	queue_free()

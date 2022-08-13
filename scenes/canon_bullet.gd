extends Node2D

signal bulletReady

var speed = 700

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= speed * delta
	if position.y < 120:
		speed = 0
		$AnimatedSprite.play("death")

func _on_Area2D_body_entered(body):
#	print(body.name)
	$Area2D.collision_layer = 0
	$Area2D.collision_mask = 0
	body.get_parent().die()
	$AnimatedSprite.play("death")
	speed = 0
	if "alien" in body.name:
		$AnimatedSprite.visible = false
	if position.y > 570:
		modulate = Color(0,1,0,1)

func _on_AnimatedSprite_animation_finished():
	emit_signal("bulletReady")
	queue_free()

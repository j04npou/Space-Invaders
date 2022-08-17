extends Node2D

signal bulletReady

var speed = 700

func _process(delta):
	position.y -= speed * delta
	if position.y < 120:
		speed = 0
		$AnimatedSprite.play("explosion")

func _on_Area2D_body_entered(body):
#	print(body.name)
	$Area2D.collision_layer = 0
	$Area2D.collision_mask = 0
	body.get_parent().die()
	$AnimatedSprite.play("explosion")
	speed = 0
	if "alien" in body.name:
		$AnimatedSprite.visible = false
	if position.y > 570:
		modulate = Color(0,1,0,1)

func _on_AnimatedSprite_animation_finished():
	emit_signal("bulletReady")
	queue_free()

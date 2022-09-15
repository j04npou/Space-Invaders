extends Node2D

signal points

var speed = 130
var direction = 1
var active = false
var nextDirection = -1
var points = [100,50,50,100,150,100,100,50,300,100,100,100,50,150,100]
var canon_shots = 0

func _ready():
	visible = false

func _process(delta):
	if !active:
		return
	position.x += direction * speed * delta
	if position.x < -25 or position.x > 625:
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite, "modulate", Color(1,1,1,0), 0.2)
	if position.x < -70 or position.x > 670:
		active = false
		$Timer.start()

func die():
	$AnimatedSprite.animation = "death"
	$saucer.collision_layer = 0
	$saucer.collision_mask = 0
	$AnimatedSprite.play()
	active = false
	emit_signal("points", points[canon_shots-1])

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$Timer.start()
	$points.visible = true
	$points.text = str(points[canon_shots-1])
	$points/PointsTimer.start()
	
func _on_PointsTimer_timeout():
	$points.visible = false
	visible = false

func _on_Timer_timeout():
	activate()
	
# warning-ignore:function_conflicts_variable
func activate():
	active = true
	visible = true
	$AnimatedSprite.animation = "default"
	$saucer.collision_layer = 1
	$saucer.collision_mask = 1
	direction = nextDirection
	if nextDirection > 0:
		position.x = -25
	else:
		position.x = 625
	
	$AnimatedSprite.modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite, "modulate", Color(1,1,1,1), 0.2)

func _on_grid_saucercall():
	activate()

func _on_canon_shot():
	nextDirection = -nextDirection
	canon_shots += 1
	
	if canon_shots > 15:
		canon_shots = 1

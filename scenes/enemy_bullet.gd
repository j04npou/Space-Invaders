extends Node2D

var rng = RandomNumberGenerator.new()
var speed = 200
var speed_value = 200
var impacto = false

func _process(delta):
	rng.randomize()
	position.y += speed * delta
	if position.y > 600:
		position.y = 595
		explota()
##		queue_free()
#		position.y = 50
#		position.x = rng.randi_range(280, 570)

func _on_Area2D_body_entered(body):
	rng.randomize()
#	print("body "+body.name)
	if "StaticBody2D" in body.name and !impacto:
#		impacto=true
#		position.y += 20
		#body.get_parent().rompe()
#		body.get_parent().rompe_down(4)
		rompedown(body.get_parent())
		explota()

#	elif "StaticBody2D" in body.name and impacto:
#		body.get_parent().rompe()
#		position.y = 50
##		queue_free()
#	else:
#		queue_free()

func _on_Area2D_area_entered(area):
	print("area "+area.name)
#	queue_free()

func explota():
	$Area2D.collision_layer=0
	$Area2D.collision_mask=0
	speed = 0
	position.y += 5
	$Timer.start()
	$AnimatedSprite.play("explosion")


func rompedown(bunker_pieza):
#	var bx=bunker_pieza.global_position.x
#	var by=bunker_pieza.global_position.y
	for i in get_tree().get_nodes_in_group("bunker"):
		if global_position.distance_to(i.global_position) < 30:
			i.rompe(1)
			if global_position.distance_to(i.global_position) < 20:
				i.rompe(1)
				if global_position.distance_to(i.global_position) < 10:
					i.rompe(1)

#		var x = i.global_position.x
#		var y = i.global_position.y
#		if x >= bx - 20 and x <= bx + 20 and y >= by and y <= by + 25:
#			i.rompe(1)
#			if x >= bx - 10 and x <= bx + 10 and y >= by and y <= by + 20:
#				i.rompe(1)
#			if x == bx and y >= by and y <= by + 10:
#				i.rompe(1)


func _on_Timer_timeout():
	speed = speed_value
	position.y = 350
	position.x = rng.randi_range(260, 350)
	$AnimatedSprite.play("default")
	$Area2D.collision_layer=1
	$Area2D.collision_mask=1

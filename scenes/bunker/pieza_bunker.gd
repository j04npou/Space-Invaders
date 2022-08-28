extends AnimatedSprite
var rng = RandomNumberGenerator.new()

func _ready():
	animation = "default"
	add_to_group("bunker")

func rompe(rotura):
#	rng.randomize()
#	$StaticBody2D.collision_layer = 0
#	$StaticBody2D.collision_mask = 0
#	$StaticBody2D/CollisionPolygon2D.disabled = true
#	$anim.frame = rng.randi_range(0, 9)
	
	if !("roto" in animation):
		rng.randomize()
		animation = "roto" + str(rng.randi_range(1, 3))
		frame = 0
		rotura -= 1

	if frame + rotura > 2:
		visible = false
		$Bunker.collision_layer = 0
		$Bunker.collision_mask = 0
		$Timer.start()
	else:
		frame = frame + rotura
		
func die():
	for i in get_tree().get_nodes_in_group("bunker"):
		if global_position.distance_to(i.global_position) < 20:
			i.rompe(1)
			if global_position.distance_to(i.global_position) < 15:
				i.rompe(1)
				if global_position.distance_to(i.global_position) < 8:
					i.rompe(2)

func _on_Timer_timeout():
	queue_free()

extends Sprite

# Variables


# Physics Process
func _physics_process(delta):
	
	# Rotation
	rotation = $"..".get_local_mouse_position().angle()
	
	# Bullet
	if Input.is_action_just_pressed("Shoot"):
		var bullet = load("res://Scenes/Part1/PinkbullDrop/PinkbullDrop.tscn").instance()
		get_node("/root/Node2D/Drops").add_child(bullet)
		bullet.position = $Position2D.global_position
		bullet.goDir = rotation
	

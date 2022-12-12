extends Camera2D

# No Variables Needed

# Physics Process
func _physics_process(_delta):
	position = $"%Player".position + Vector2(0, -69)

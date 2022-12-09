extends KinematicBody2D

# Variables
var vel : Vector2 # Velocity
var inputLR : float # Left/Right input, expressed from -1 to 1
var acc : float = 96 # Player Acceleration
var maxspeed : int = 96 # Maximum speed
var gravity : float = 9.8 * 16 # Gravity
var jump_strength : float = 64 # Jump Strength (How much speed you get when you jump)

# Physics Process Run
func _physics_process(delta):
	
	# Set Input
	inputLR = (Input.get_action_strength("Right") - Input.get_action_strength("Left")) * acc
	
	# Gravity
	vel.y += gravity * delta
	vel.y = 0 if is_on_floor() else vel.y
	
	# Velocity Check and etc.
	vel.x = 0 if is_on_wall() else vel.x
	
	vel.x = vel.x if vel.x < maxspeed else maxspeed
	vel.x = vel.x if vel.x > -maxspeed else -maxspeed
	
	# Left-Right Input
	vel.x += inputLR * delta
	
	# Jump
	if Input.is_action_just_pressed("Jump"):
		vel.y -= jump_strength
	
	# Move
	move_and_slide(vel, Vector2(0, -1))
	
	# Update Speed Label
	$"Camera2D/Label".text = "Vel.x = " + String(vel.x)
	

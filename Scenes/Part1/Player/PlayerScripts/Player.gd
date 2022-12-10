extends KinematicBody2D

# Variables
var vel : Vector2 # Velocity
var inputLR : float # Left/Right input, expressed from -1 to 1
var acc : float = 128 # Player Acceleration
var gravity : float = 30 * 16 # Gravity
var jump_strength : float = 256 # Jump Strength (How much speed you get when you jump)
var drag : float = 256 # Drag force, measured in pixels per second per second
var stopPower : float = 512 # Power of Stopping (When you move a different way than velocity)

# Physics Process Run
func _physics_process(delta):
	
	# Set Input
	inputLR = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	
	# Gravity
	vel.y += gravity * delta
	vel.y = 0 if is_on_floor() else vel.y
	
	# Velocity Check for Walls
	vel.x = 0 if is_on_wall() else vel.x
	
	# Drag Calculations & Opposite-Direction-Speed
	vel.x -= drag * delta if inputLR == 0 && vel.x > 0 and is_on_floor() else 0
	vel.x += drag * delta if inputLR == 0 && vel.x < 0 and is_on_floor() else 0
	vel.x = 0 if vel.x < drag * delta && vel.x > 0 && is_on_floor() && inputLR == 0 else vel.x
	vel.x = 0 if vel.x > drag * delta && vel.x < 0 && is_on_floor() && inputLR == 0 else vel.x
	
	vel.x -= abs(inputLR) * stopPower * delta if inputLR < 0 && vel.x > 0 else 0
	vel.x -= -abs(inputLR) * stopPower * delta if inputLR > 0 && vel.x < 0 else 0
	
	# Left-Right Input
	vel.x += inputLR * acc * delta
	
	# Jump
	if Input.is_action_pressed("Jump") && is_on_floor():
		vel.y -= jump_strength
	
	# Move
	move_and_slide(vel, Vector2(0, -1))
	
	# Update Speed Label
	$"Camera2D/Label".text = "Vel.x = " + String(vel.x)
	

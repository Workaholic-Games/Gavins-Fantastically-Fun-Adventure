extends CharacterBody3D


@onready var camera : Camera3D = $Camera3D
var look_dir : Vector2
var camera_sensitivity : int = 15 
var paused : bool = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _notification(what):
	match what:
		NOTIFICATION_APPLICATION_FOCUS_IN:
			paused = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		look_dir = event.relative * 0.01

func rotate_camera(delta: float, sensitivity_modifier : float = 1.0):
	if paused == false:
		rotation.y -= look_dir.x * camera_sensitivity * delta
		camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sensitivity * sensitivity_modifier * delta, -1.5, 1.5)
		look_dir = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	rotate_camera(delta)
	

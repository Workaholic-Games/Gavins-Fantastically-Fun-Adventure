extends CharacterBody3D
@onready var camera : Camera3D = $Camera3D
var look_dir : Vector2
var paused : bool = false
var interacting_with : Node3D

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
	if Input.is_action_just_pressed("interact"):
		if interacting_with != null:
			interacting_with.interact()
	
	
	if event is InputEventMouseMotion: 
		look_dir = event.relative * 0.01
	
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused == true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$Options.show()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$Options.hide()

func rotate_camera(delta: float, sensitivity_modifier : float = 1.0):
	if paused == false:
		rotation.y -= look_dir.x * Global.sensitivity * delta
		camera.rotation.x = clamp(camera.rotation.x - look_dir.y * Global.sensitivity * sensitivity_modifier * delta, -1.5, 1.5)
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
	$Camera3D.fov = Global.fov


func _on_interaction_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Interactable"):
		body.outline()
		interacting_with = body
func _on_interaction_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("Interactable"):
		body.no_outline()
		interacting_with = null

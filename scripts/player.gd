extends CharacterBody3D

signal change_pos
signal change_rotation

const SPEED = 1.0

var gravity: float = 0

func set_nick(nick: String) -> void:
	$"NickName".text = nick

func _physics_process(delta: float) -> void:
	#if !is_on_floor():
		#velocity.y -= gravity
	
	var input_rot := Input.get_axis("rot_left", "rot_right")
	if input_rot:
		rotation_degrees.y -= input_rot / 2.0
		change_rotation.emit()
	
	var input_dir := Input.get_axis("forward", "back")
	var direction := (transform.basis * Vector3(0, 0, input_dir)).normalized()
	if direction:
		velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * 10.0)
		velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * 10.0)
		change_pos.emit()
	else:
		velocity.x = lerpf(velocity.x, 0.0, delta * 10.0)
		velocity.z = lerpf(velocity.z, 0.0, delta * 10.0)
		change_pos.emit()

	move_and_slide()


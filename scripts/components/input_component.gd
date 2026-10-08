class_name InputComponent extends Node


func get_movement_vector() -> Vector3:
	var x_axis = Input.get_action_strength("right") - Input.get_action_strength("left")
	var z_axis = Input.get_action_strength("backward") - Input.get_action_strength("forward")

	return Vector3(x_axis, 0.0, z_axis)


func is_jumping() -> bool:
	return Input.is_action_just_pressed("jump")


func is_running() -> bool:
	return Input.is_action_pressed("run")


func is_using_tool() -> bool:
	return Input.is_action_pressed("tool")


func is_interacting() -> bool:
	return Input.is_action_just_pressed("interact")


func is_main_use() -> bool:
	return Input.is_action_just_pressed("main_use")


func is_alternative_use() -> bool:
	return Input.is_action_just_pressed("alternative_use")


func is_main_drink() -> bool:
	return Input.is_action_just_pressed("main_drink")


func is_secondary_drink() -> bool:
	return Input.is_action_just_pressed("secondary_drink")


func is_eat() -> bool:
	return Input.is_action_just_pressed("eat")

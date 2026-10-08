class_name Beacon extends Node3D


signal beacon_calculation_update(signals: Array[float])


@export var player: Node3D
@export var max_signal_arrow_direction: Node3D
@export var targets: Array[Target] = []
@export var max_targets: int = 1
@export_range(0.0, 0.3, 0.01) var noise_range: float = 0.03
@export_range(1.0, 10.0, 0.1) var range_at_peak: float = 10.0
@export_range(10.0, 500.0, 1.0) var max_detection_range: float = 50.0

@export_category("Magnetic field stats")
@export var permeability_freespace: float = 1.0 #4 * PI * (1.0 / 10e7)
@export_range(1, 3, 1) var antenna_count: int = 1


const FOUR_PI: float = 4 * PI


@onready var _beacon_stream_player: AudioStreamPlayer3D = $BeaconFindStreamPlayer


func _calculate_radio_amplitudes() -> void:
	self.targets.clear()
	for target in self.get_tree().get_nodes_in_group("RadioTransmitter"):
		self.targets.push_back(target as Target)

	var signal_strengths: Array[float] = []

	for target in self.targets:
		var signal_vector: Vector3 = self._compute_signal_strength2(target)
		var signal_arrow_direction = self.player.global_basis * signal_vector.normalized()
		self.max_signal_arrow_direction.look_at(self.max_signal_arrow_direction.global_position + signal_arrow_direction, Vector3.UP)

		var signal_strength: float = signal_vector.length()

		var standard_strength: float = RadioTransmitterEnums.to_float(RadioTransmitterEnums.Strength.LOW)
		var distance: float = pow(standard_strength / abs(signal_strength), 1.0 / 3.0)
		var actual_distance: float = standard_strength / target.get_signal_strength() * distance

		signal_strengths.push_back(actual_distance)

	signal_strengths.sort_custom(func(a, b): return a > b)

	self.beacon_calculation_update.emit(signal_strengths.slice(0, self.max_targets))


func _compute_signal_strength(target: Target) -> float:
	var alignment: float = (-self.player.global_basis.z).dot((target.global_position - self.player.global_position).normalized())
	var distance: float = self.player.global_position.distance_to(target.global_position)
	var strength: float = target.get_signal_strength() * alignment * (1.0 - distance / self.max_detection_range)

	return float(self._is_in_range(distance)) * strength


func _compute_signal_strength2(target: Target) -> Vector3:
	var direction_vector: Vector3 = (self.player.global_position - target.global_position).normalized()
	var distance: float = self.player.global_position.distance_to(target.global_position)
	var projection: Vector3 = (3.0 * target.get_signal_strength() * target.global_orientation.dot(direction_vector) * direction_vector)\
		- target.get_signal_strength() * target.global_orientation

	var magnetic_field: Vector3 = self.permeability_freespace / (self.FOUR_PI * pow(distance, 3)) * projection

	match self.antenna_count:
		1:
			return self._compute_one_antenna(magnetic_field)
		2:
			return self._compute_two_antenna(magnetic_field)
		3:
			return self._compute_three_antenna(magnetic_field)
		_:
			printerr("Incorrect number of antennas, cannot compute the received signal.")
			return Vector3.ZERO


func _compute_one_antenna(magnetic_field: Vector3) -> Vector3:
	var antenna_direction: Vector3 = self.player.global_basis * Vector3.FORWARD

	var detected_value: float = magnetic_field.dot(antenna_direction)

	return Vector3(detected_value, 0.0, 0.0)


func _compute_two_antenna(magnetic_field: Vector3) -> Vector3:
	var antenna_direction1: Vector3 = self.player.global_basis * Vector3(-0.707, 0.0, -0.707)
	var antenna_direction2: Vector3 = self.player.global_basis * Vector3(0.707, 0.0, -0.707)

	var detected_value1: float = magnetic_field.dot(antenna_direction1)
	var detected_value2: float = magnetic_field.dot(antenna_direction2)

	return Vector3(detected_value1, 0.0, detected_value2)


func _compute_three_antenna(magnetic_field: Vector3) -> Vector3:
	var antenna_direction1: Vector3 = self.player.global_basis * Vector3(1.0, 0.0, 0.0)
	var antenna_direction2: Vector3 = self.player.global_basis * Vector3(0.0, 1.0, 0.0)
	var antenna_direction3: Vector3 = self.player.global_basis * Vector3(0.0, 0.0, 1.0)

	var detected_value1: float = magnetic_field.dot(antenna_direction1)
	var detected_value2: float = magnetic_field.dot(antenna_direction2)
	var detected_value3: float = magnetic_field.dot(antenna_direction3)

	var dir = Vector3(detected_value1, detected_value2, detected_value3).normalized()

	print(dir)

	return Vector3(detected_value1, detected_value2, detected_value3)


func _is_in_range(distance: float) -> bool:
	return distance <= self.max_detection_range


func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
	self._calculate_radio_amplitudes()


func _on_sound_effect_timer_timeout() -> void:
	self._beacon_stream_player.play()

extends Node3D


@export var spawn_locations: Array[Node3D]
@export var spawn_number: int = 3
@export var field_resolution: float = 1.0
@export var field_area: float = 10.0


var _target_scene: PackedScene = preload("res://scenes/objects/target/target.tscn")

var _spawned_counter = 0


func _ready() -> void:
	self._spawn_targets()


func _spawn_targets() -> void:
	print("IN SPAWN")
	self.spawn_locations.shuffle()
	print(self.spawn_locations)
	for location in self.spawn_locations.slice(0, self.spawn_number):
		print(location)
		print(self._spawned_counter)
		var target: Target = self._target_scene.instantiate() as Target
		location.add_child(target)
		target.global_position = location.global_position
		target.global_orientation = Vector3(randf_range(-1.0, 1.0), 0.0, 0.0)
		target.deactivated.connect(self._on_target_deactivated)

		self._spawned_counter += 1


func _on_target_deactivated() -> void:
	self._spawned_counter -= 1
	print(self._spawned_counter)

	if self._spawned_counter == 0:
		print(self._spawned_counter, ", ", "SPAWNING")
		await self.get_tree().create_timer(4.0).timeout
		self._spawn_targets()

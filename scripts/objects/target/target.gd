class_name Target extends Node3D


signal deactivated


@export var enabled: bool = true

@export_category("Magnetic field stats")
@export var global_orientation: Vector3 = Vector3(1.0, 0.0, 0.0)
@export var peak_magnetic_moment: RadioTransmitterEnums.Strength = RadioTransmitterEnums.Strength.LOW


func deactivate() -> void:
	self.enabled = false
	self.deactivated.emit()
	self._remove()


func get_signal_strength() -> float:
	return RadioTransmitterEnums.to_float(self.peak_magnetic_moment)


func _ready() -> void:
	self.visible = false


func _process(delta: float) -> void:
	pass


func _on_player_detector_area_exited(_area: Area3D) -> void:
	self.visible = false


func _on_player_detector_area_entered(_area: Area3D) -> void:
	self.visible = true


func _remove() -> void:
	self.call_deferred("queue_free")


func _on_interactable_interacted() -> void:
	self.deactivate()

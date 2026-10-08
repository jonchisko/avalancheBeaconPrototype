class_name Interactable extends Area3D


signal interacted


@export var parent: Node3D


func interact() -> void:
	self.interacted.emit()

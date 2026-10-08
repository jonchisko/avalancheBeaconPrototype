class_name ConsumableObject extends Node3D


@onready var _mesh_instance: MeshInstance3D = $MeshInstance3D


func init(consumable: Consumable) -> void:
	self._mesh_instance.mesh = consumable.consumable_object

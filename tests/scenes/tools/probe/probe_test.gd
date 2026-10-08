extends Node3D

@export var inventory_manager: InventoryManager
@export var player: Player


func _ready() -> void:
	self.player.init(self.inventory_manager)

extends Node3D


@onready var player: Player = $Player
@onready var inventory_manager: InventoryManager = $InventoryManager

@export var consumable: Consumable


func _ready() -> void:
	self.player.init(self.inventory_manager)
	self.inventory_manager.award_consumable(self.consumable)
	self.inventory_manager.award_consumable(self.consumable)
	self.inventory_manager.award_consumable(self.consumable)

class_name InventoryManager extends Node


@export var consumables: Array[Consumable]


var _persistent_inventory_data: InventoryData


func _ready() -> void:
	var data = {}
	for consumable in self.consumables:
		data[consumable] = 0

	self._persistent_inventory_data = InventoryData.new(data)


func get_persistent_inventory_data() -> InventoryData:
	return self._persistent_inventory_data


func award_consumable(consumable: Consumable) -> void:
	self._persistent_inventory_data.add_consumable(consumable)

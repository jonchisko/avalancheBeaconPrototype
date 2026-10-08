class_name InventoryData extends RefCounted


signal consumable_changed_amount(consumable: Consumable, new_amount: int)


# Key: Consumable, Value: int
var _data: Dictionary


func _init(consumable_data: Dictionary) -> void:
	self._data = consumable_data


func add_consumable(consumable: Consumable) -> void:
	if !self._data.has(consumable):
		self._data[consumable] = 0
	self._data[consumable] += 1
	self.consumable_changed_amount.emit(consumable, self._data[consumable])


func remove_consumable(consumable: Consumable) -> bool:
	if !self._data.has(consumable) or self._data[consumable] == 0:
		return false

	self._data[consumable] -= 1
	self.consumable_changed_amount.emit(consumable, self._data[consumable])
	print("InventoryData: ", self._data)
	if self._data[consumable] == 0:
		self._data.erase(consumable)

	return true


func get_consumables() -> Array[Consumable]:
	var keys: Array[Consumable] = []
	keys.assign(self._data.keys())
	return keys


func get_amount_of_consumable(consumable: Consumable) -> int:
	return self._data.get(consumable)

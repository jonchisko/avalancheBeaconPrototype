class_name InventoryController extends Node


signal consumable_used(consumable: Consumable)


@export_category("Dependencies")
@export var inventory_ui: InventoryUi
@export var input_component: InputComponent


var _inventory_data: InventoryData
var _referenced_consumables: Array[Consumable]


func _process(_delta: float) -> void:
	if self.input_component.is_eat():
		if self._inventory_data.remove_consumable(self._referenced_consumables[0]):
			self.consumable_used.emit(self._referenced_consumables[0])
	if self.input_component.is_main_drink():
		if self._inventory_data.remove_consumable(self._referenced_consumables[1]):
			self.consumable_used.emit(self._referenced_consumables[1])
	if self.input_component.is_secondary_drink():
		if self._inventory_data.remove_consumable(self._referenced_consumables[2]):
			self.consumable_used.emit(self._referenced_consumables[2])


func init(inventory_manager: InventoryManager) -> void:
	self._inventory_data = inventory_manager.get_persistent_inventory_data()
	self._referenced_consumables = inventory_manager.consumables
	if self._referenced_consumables.size() != 3:
		push_error("Referenced consumables should be exactly 3, but is not")
	self._init_ui_controller()


func _init_ui_controller() -> void:
	self._inventory_data.consumable_changed_amount.connect(self.inventory_ui.on_set_consumable_value)

	for consumable in self._inventory_data.get_consumables():
		self.inventory_ui.on_set_consumable_value(consumable, self._inventory_data.get_amount_of_consumable(consumable))

extends Control


@export var stamina_component: StaminaComponent
@export var inventory_manager: InventoryManager
@export var player_stats: PlayerStats
@export var inventory_controller: InventoryController
@export var consumables: Array[Consumable]


@onready var awards_label: Label = %AwardsLabel
@onready var stamina_label: Label = %StaminaValue
@onready var stamina_regen: Label = %StaminaRegen


func _ready() -> void:
	self.stamina_component.init_component(self.player_stats)
	self.inventory_controller.init(self.inventory_manager)
	self.stamina_label.text = str(self.stamina_component._current_stamina)
	self.stamina_regen.text = str(self.stamina_component._stamina_regen_speed)
	self.inventory_controller.consumable_used.connect(self._on_consumable_used)


func _on_consumable_used(consumable: Consumable) -> void:
	print("consuming ", consumable.consumable_name)

	self.stamina_label.text = str(self.stamina_component._current_stamina)
	self.stamina_regen.text = str(self.stamina_component._stamina_regen_speed)

	print(self.inventory_controller._inventory_data)


# Award a random consumable
func _on_button_pressed() -> void:
	var random_consumable = self.consumables.pick_random()
	print("Picked consumable: ", random_consumable.consumable_name)
	self.inventory_manager.award_consumable(random_consumable)


func _on_add_stamina_button_pressed() -> void:
	self.stamina_component.increase_stamina(5.0)
	self.stamina_label.text = str(self.stamina_component._current_stamina)


func _on_remove_stamina_button_pressed() -> void:
	self.stamina_component.reduce_stamina(5.0, true)
	self.stamina_label.text = str(self.stamina_component._current_stamina)


# To manually update stamina regen
func _on_end_round_buton_pressed() -> void:
	self.stamina_regen.text = str(self.stamina_component._stamina_regen_speed)


func _on_start_round_button_pressed() -> void:
	self.inventory_controller.init(self.inventory_manager)

class_name Player extends CharacterBody3D


@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var look_around_component: LookAroundComponent
@export var stamina_component: StaminaComponent
@export var inventory_controler: InventoryController
@export var interactor: Interactor


@export_category("Resource")
@export var player_stats: PlayerStats


@onready var _interactor_text_ui = $CanvasLayer/InteractableTextUi


func _ready() -> void:
	pass


func init(inventory_manager: InventoryManager) -> void:
	self.player_stats.init_stats()
	self.movement_component.init_component(self.player_stats)
	self.stamina_component.init_component(self.player_stats)
	self.inventory_controler.init(inventory_manager)


func _process(delta: float) -> void:
	if self.movement_component.is_idle():
		self.stamina_component.regenerate_stamina(delta)


func _physics_process(_delta: float) -> void:
	self.movement_component.move()
	self.gravity_component.add_gravity()


func _on_interactor_interactable_gone() -> void:
	self._interactor_text_ui.visible = false


func _on_interactor_interactable_detected(_interactable: Interactable) -> void:
	self._interactor_text_ui.visible = true


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() && event.keycode == KEY_E:
			self.interactor.interact()

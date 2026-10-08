@abstract
class_name Skill extends Resource


## Necessary dependancy on the stats
@export var player_stats: PlayerStats
## How common is this skill. How often is it shown in the skill shop.
@export var rarity: GlobalEnums.SkillRarity
## Percentage of increase from the base value
@export var value: float:
	get:
		return value / 100.0


var skill_name: String:
	get:
		return self.get_script().get_global_name()


@abstract func is_maxed_out() -> bool
@abstract func upgrade() -> void

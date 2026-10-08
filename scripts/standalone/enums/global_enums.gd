class_name GlobalEnums extends RefCounted


enum ToolType {
	SHOVEL,
	PROBE,
	BEACON
}


enum SkillRarity {
	COMMON,
	RARE,
	EPIC,
}


static func rarity_to_probability(rarity: SkillRarity) -> float:
	match rarity:
		SkillRarity.COMMON:
			return 0.25
		SkillRarity.RARE:
			return 0.15
		SkillRarity.EPIC:
			return 0.05
		_:
			push_error("Unknown rarity.")
			return 0.0


enum ConsumableType {
	INSTANT,
	OVER_TIME
}

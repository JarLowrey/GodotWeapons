extends GDWeaponsLongAction
class_name GDWeaponsWeapon

const WEAPON_PATH_FROM_COMPONENT = ".."

# feel free to remove any/all below
@export var ammo: GDWeaponsAmmo
@export var auto_attack: GDWeaponsAutoAttack
@export var bool_blocker: GDWeaponsBoolBlocker
@export var bullet_spawner: GDWeaponsBulletSpawner
@export var charge: GDWeaponsCharge
@export var combo: GDWeaponsCombo
@export var magazine: GDWeaponsMagazine

#region action aliases
func start_attack():
	super.start_action()
func end_attack():
	super.end_action()
func cancel_attack():
	super.cancel_action()
#endregion

## Weapon Plugin for Godot

Weapon bootstrapping in Godot 3.1, written in GDScript.

### What is a weapon?

Essentially, I view it as a tool that can be used periodically. 
This project aims to flexibly implement tool/weapon usage and provide common components.

### How To

View the examples in `Test/` for a full introduction to the API.

#### Elevator Explanation

A weapon is an action. 
This action may end immediately, after a time period, through an animation, or however you decide (just be sure to call `end_attack` [or `end_action`/`end_reload` depending on situation]).

Components can be added as children to modify the action's ability to start or end, and can be customized in the editor.
This project aims to cover most common component needs, but you can extend them or add your own if you like.

### Base components

These components should work no matter your weapon-specific implementation

- Ammo: charge, stamina, etc
- AutoAttack: auto starts actions on successly finishing
- StartBlocker: conditions/trigger to start action
- EndBlocker: conditions/trigger to end action (useful for a charged weapon with a manual release)
- BulletSpawner: for instancing scenes on weapon state change
- Magazine (includes reload action): a magazine. Must make children editable to customize via the Capacity and LongAction children nodes.

### Common Components

These components are require further scripting to customize them to your weapon-specific implementation.

- Combo: change weapon data (animation played, cooldown delay, etc) if it is used quickly enough
- Burst: changes multiple attacks into a single atomic attack. Will stop partway through if gun cannot fire (ran out of ammo etc). Relies on developer to implement different cooldown times for burst and non-burst attacks.
- Recoil: bounce the weapon after shooting

All weapons/components currently only tested in 2D, but should work in 3D too.
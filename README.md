## Gun Plugin for Godot

These two scripts (`addons/Bullet.gd`, `addons/Gun.gd`) can be used to quickly bootstrap guns and physics simulated bullets.
Check out the examples/ directory for working scenes.

## How To

Attach the scripts to your Gun/Bullet scenes and examine the `Script Variables` that appear.

Guns can be setup to `auto fire` or can be fired manually.
They have a `clip`/magazine that must be reload()'ed when depleted.
After each shot a `Fire Delay` occurs before shooting can occur again, and when the clip is emptied the `Reload Delay` occurs.
Guns can shot 0, 1, 2 or more bullets, just enter the bullet scene's "res://" location into the Gun's `Shots` array.
Bullets are fired in the direction the gun is facing.

When bullets are fired, they are offset from the Gun's midpoint via `Fire Pos Offset`, this allows shooting multiple bullets at once (aka a volley) without them all overlapping.
When tracking a `target`, the `Tracking Angle Vel Scalar` is used to scale angular Velocity.
`Follow Gun` makes the bullets children of the Gun node instead of root, and thus will move with the Gun.
Combined with `Size Scaling Velocity` (which stretches the bullet) it can be used to create laser beams.
Scale will not grow larger than `Max Size Scale`.
When the bullet is created, you can use `Fit Collider to Sprite` to make the collider polygon perfectly over the bullet sprite.
CollisionShape2D's are recommended over complex polygons for performance reasons,

The Bullets can be killed (by calling `free()`) in a variety of ways.

- Collision: killed on first contact, requires the body to enable `Contact Monitor` and `Contacts Reported` >0
- View port Exit: killed when leaving view port, doesn't work if spawned outside of view port
- Time: killed after a set amount of time, -1 disables
- Travel Dist: killed after traveling a certain distance (may be removed as Time is similar and more performant), -1 disables

## Common Issues

Usually a gun will be placed on/inside a ship, character, etc's body.
To ensure it does not collide with its overlapping body, you must modify [Collision Layers and Collision Masks](https://godotengine.org/qa/4010/whats-difference-between-collision-layers-collision-masks).

## To Do

- Enable bullets for path follow in addition to physics
- Make applicable to 3D


## License

MIT License (MIT)

Copyright (c) 2017 James R. Lowrey.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

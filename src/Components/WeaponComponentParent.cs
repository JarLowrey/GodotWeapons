using Godot;
using System;

public class WeaponComponentParent : Node
{
    
    [Export]
    public NodePath WeaponPath = "..";
    protected Weapon weapon;

    public override void _Ready () {
        base._Ready ();

        weapon = GetNode(WeaponPath) as Weapon;
    }
}

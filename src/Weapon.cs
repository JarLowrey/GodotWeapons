using System;
using System.Collections.Generic;
using Godot;

public class Weapon : Node
{
    [Export]
    public NodePath WielderPath = "..";

    private Node Wielder;

    public override void _Ready()
    {
        base._Ready();
        Wielder = GetNode(WielderPath) as Node2D;
    }
    virtual public void WielderRevived()
    {
        SetPhysicsProcess(true);
        SetProcess(true);
    }
    virtual public void WielderKilled()
    {
        SetPhysicsProcess(false);
        SetProcess(false);

        ResetWeapon();
    }
}
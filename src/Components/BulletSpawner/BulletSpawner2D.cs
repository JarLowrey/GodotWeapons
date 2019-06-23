using Godot;
using System;

public class BulletSpawner2D : WeaponComponentParent
{
    
    [Export]
    public string BulletScenePath = "";

    private bool spawnAtStart = true;
    [Export]
    public bool SpawnAtStartOfAttack
    {
        get => spawnAtStart; set
        {
            spawnAtStart = value;
            setSpawnnerConnections();
        }
    }

    public override void _Ready()
    {
        base._Ready();
        CallDeferred(nameof(setSpawnnerConnections));
    }

    private void spawn(){
        // Node n = ((PackedScene) ResourceLoader.Load (BulletScenePath)).Instance ();
        // GetTree ().GetRoot ().AddChild (n);
        
        //initialize the bullet
        // Node2D newNode = n as Node2D;
        // Node2D weapon2D = weapon as Node2D;
        // newNode.GlobalPosition = weapon2D.GlobalPosition;
        // newNode.GlobalRotation = weapon2D.GlobalRotation;
    }

    private void setSpawnnerConnections()
    {
        string spawnFnName = nameof(spawn);
        string beginSig = nameof(Weapon.AttackBegan);
        string endSig = nameof(Weapon.AttackEnded);

        if (IsInsideTree())
        {
            if (weapon.IsConnected(endSig, this, spawnFnName))
            {
                weapon.Disconnect(endSig, this, spawnFnName);
            }
            weapon.Connect(beginSig, this, spawnFnName);
        }
        else
        {
            if (weapon.IsConnected(beginSig, this, spawnFnName))
            {
                weapon.Disconnect(beginSig, this, spawnFnName);
            }
            weapon.Connect(endSig, this, spawnFnName);
        }
    }
}

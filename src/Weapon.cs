using System;
using System.Collections.Generic;
using Godot;

public class Weapon : Node
{
    public static Random rand = new Random();

    public bool IsAttacking { get; private set; }
    public bool IsInAttackCooldown { get; private set; }
    protected Timer AttackRecoveryTimer;

    [Signal]
    public delegate void AttackEnded();
    [Signal]
    public delegate void AttackBegan();
    [Signal]
    public delegate void CanAttackAgain();

    [Export]
    public NodePath WielderPath = "..";

    private Node Wielder;


    private float recDelay = 1;
    [Export]
    public float RecoveryDelay
    {
        get => recDelay; set
        {
            recDelay = value;
            if(IsInsideTree()){
                AttackRecoveryTimer.WaitTime = recDelay;
                AttackRecoveryTimer.Start(); // restart
            }
        }
    }

    public override void _Ready()
    {
        base._Ready();

        AttackRecoveryTimer = GetNode("AttackRecoveryTimer") as Timer;
        AttackRecoveryTimer.Connect("timeout", this, nameof(ExitAttackCooldown));
        Wielder = GetNode(WielderPath) as Node2D;
    }
    virtual public void ResetWeapon()
    {
        EndAttack();

        IsAttacking = false;
        IsInAttackCooldown = false;
        AttackRecoveryTimer.Stop();
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

    virtual public void StartAttack()
    {
        if (!CanAttack())
        {
            return;
        }

        IsAttacking = true;
        EmitSignal(nameof(AttackBegan));

        EndAttack(); //TODO: Remove, this only here for testing
    }
    virtual public void EndAttack()
    {
        if (!IsAttacking) return;

        IsAttacking = false;
        IsInAttackCooldown = true;

        AttackRecoveryTimer.Start();
        EmitSignal(nameof(AttackEnded));
    }
    virtual public bool CanAttack()
    {
        return !IsAttacking && !IsInAttackCooldown;
    }
    protected void ExitAttackCooldown()
    {
        IsInAttackCooldown = false;
        AttackRecoveryTimer.Stop();
        EmitSignal(nameof(CanAttackAgain));
    }
}
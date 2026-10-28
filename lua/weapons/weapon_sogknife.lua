if SERVER then AddCSLuaFile() end
SWEP.Base = "weapon_melee"
SWEP.PrintName = "SOG SEAL 2000"
SWEP.Instructions = "A serious big knife used by seals (special forces of the US Navy). A good choice for a melee weapon.\n\nLMB to attack.\nR + LMB to change attack mode.\nRMB to block."
SWEP.Category = "Weapons - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.WorldModel = "models/weapons/combatknife/tactical_knife_iw7_wm.mdl"
SWEP.WorldModelReal = "models/weapons/combatknife/tactical_knife_iw7_vm.mdl"
SWEP.WorldModelExchange = "models/zcity/weapons/w_sog_knife.mdl"
SWEP.DontChangeDropped = true
SWEP.modelscale = 1.7
SWEP.modelscale2 = 0.95

SWEP.SuicidePos = Vector(16, -1, -3)
SWEP.SuicideAng = Angle(-40, 180, 0)
SWEP.SuicideCutVec = Vector(1, -5, 4)
SWEP.SuicideCutAng = Angle(10, 0, 0)
SWEP.SuicideTime = 0.5
SWEP.CanSuicide = true

SWEP.BleedMultiplier = 1.5
SWEP.PainMultiplier = 1.8

SWEP.DamagePrimary = 20
SWEP.DamageSecondary = 10

SWEP.setlh = false
SWEP.setrh = true
SWEP.TwoHanded = false

SWEP.basebone = 76

SWEP.HoldPos = Vector(-10,3,-2)
SWEP.HoldAng = Angle(-10,5,0)

SWEP.AttackPos = Vector(0,0,0)
SWEP.AttackingPos = Vector(0,0,0)

SWEP.weaponPos = Vector(0.5,1,-0.7)
SWEP.weaponAng = Angle(1,-120,170)

SWEP.HoldType = "knife"

--SWEP.InstantPainMul = 0.25

--models/weapons/gleb/c_knife_t.mdl
if CLIENT then
	SWEP.WepSelectIcon = Material("vgui/wep_jack_hmcd_knife")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_knife.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.BreakBoneMul = 0.5
SWEP.ImmobilizationMul = 0.45
SWEP.StaminaMul = 0.5
SWEP.HadBackBonus = true

SWEP.attack_ang = Angle(0,0,0)
function SWEP:Initialize()
    self.attackanim = 0
    self.sprintanim = 0
    self.animtime = 0
    self.animspeed = 2
    self.reverseanim = false
    self.Initialzed = true
    self:PlayAnim("idle",10,true)

    self:SetHold(self.HoldType)

    self:InitAdd()
end

SWEP.AttackTime = 0.3
SWEP.AnimTime1 = 0.8
SWEP.WaitTime1 = 0.6

SWEP.AnimTime2 = 0.5
SWEP.WaitTime2 = 0.4

SWEP.AnimList = {
    ["idle"] = "vm_knifeonly_idle",
    ["deploy"] = "vm_knifeonly_raise",
    ["attack"] = "vm_knifeonly_stab",
    ["attack2"] = "vm_knifeonly_swipe",
}

function SWEP:Reload()
    if SERVER then
        if self:GetOwner():KeyPressed(IN_ATTACK) then
            self:SetNetVar("mode", not self:GetNetVar("mode"))
            self:GetOwner():ChatPrint("Changed mode to "..(self:GetNetVar("mode") and "slash." or "stab."))
        end
    end
end

function SWEP:CanPrimaryAttack()
    if self:GetOwner():KeyDown(IN_RELOAD) then return end
    if not self:GetNetVar("mode") then
        return true
    else
        self.allowsec = true
        self:SecondaryAttack(true)
        self.allowsec = nil
        return false
    end
end

function SWEP:CustomBlockAnim(addPosLerp, addAngLerp)
    addPosLerp.z = addPosLerp.z + (self:GetBlocking() and 5 or 0)
    addPosLerp.x = addPosLerp.x + (self:GetBlocking() and 4 or 0)
    addPosLerp.y = addPosLerp.y + (self:GetBlocking() and -15 or 0)
    addAngLerp.r = addAngLerp.r + (self:GetBlocking() and 20 or 0)
    addAngLerp.y = addAngLerp.y + (self:GetBlocking() and 60 or 0)
    
    return true
end

function SWEP:CanSecondaryAttack()
    return self.allowsec and true or false
end

SWEP.AttackTimeLength = 0.01   
SWEP.Attack2TimeLength = 1

SWEP.AttackRads = 35
SWEP.AttackRads2 = 45

SWEP.SwingAng = -90
SWEP.SwingAng2 = 0

SWEP.MultiDmg1 = false
SWEP.MultiDmg2 = true
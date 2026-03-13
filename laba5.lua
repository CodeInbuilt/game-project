-- Base class (GameCharacter)
GameCharacter = {}

function GameCharacter:attack()
    print("Character attacks in a basic way")
end

-- Warrior class
Warrior = setmetatable({}, {__index = GameCharacter})

function Warrior:attack()
    print("Warrior attacks with a Sword")
end

-- Mage class
Mage = setmetatable({}, {__index = GameCharacter})

function Mage:attack()
    print("Mage attacks with Magic Spell")
end

-- Creating objects
warrior = Warrior
mage = Mage

-- Polymorphism (same method name, different behavior)
warrior:attack()
mage:attack()
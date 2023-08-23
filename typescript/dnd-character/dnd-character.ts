export class DnDCharacter {
  public strength: number = DnDCharacter.generateAbilityScore() 
  public dexterity: number = DnDCharacter.generateAbilityScore()
  public constitution: number = DnDCharacter.generateAbilityScore()
  public intelligence: number = DnDCharacter.generateAbilityScore()
  public wisdom: number = DnDCharacter.generateAbilityScore()
  public charisma: number = DnDCharacter.generateAbilityScore()
  public hitpoints: number = 10 + DnDCharacter.getModifierFor(this.constitution)

  public static generateAbilityScore(): number {
    return Math.floor(Math.random() * 15 + 3)
  }

  public static getModifierFor(abilityValue: number): number {
    return Math.floor((abilityValue - 10) / 2)
  }
}


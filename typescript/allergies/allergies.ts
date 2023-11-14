export class Allergies {
  constructor(readonly allergenIndex: number) { }

  public list(): Allergy[] {

    const listAllergies = (i: number, result: Allergy[]): Allergy[] => {
      if (i === 257) return ['eggs']
      if (i >= 128) return listAllergies(i - 128, ['cats', ...result])
      if (i >= 64) return listAllergies(i - 64, ['pollen', ...result])
      if (i >= 32) return listAllergies(i - 32, ['chocolate', ...result])
      if (i >= 16) return listAllergies(i - 16, ['tomatoes', ...result])
      if (i >= 8) return listAllergies(i - 8, ['strawberries', ...result])
      if (i >= 4) return listAllergies(i - 4, ['shellfish', ...result])
      if (i >= 2) return listAllergies(i - 2, ['peanuts', ...result])
      if (i >= 1) return listAllergies(i - 1, ['eggs', ...result])
      return result
    }

    return [...new Set(listAllergies(this.allergenIndex, []))]
  }

  public allergicTo(allergen: Allergy): boolean {
    return this.list().includes(allergen)
  }
}

type Allergy = string

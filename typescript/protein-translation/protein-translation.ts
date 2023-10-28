type Codon = string
type Protein = string

export const translate = (rna: string): string[] => {
  const transform = (codon: Codon[]): Protein[] => {
    if (codon.length === 0) return []

    const protein = asProtein(codon[0])
    if (protein === 'STOP') return []

    return [protein, ...transform(codon.slice(1))]
  }

  return transform(codons(rna))
}

const codons = (rna: string): Codon[] => {
  return rna.match(/.{1,3}/g) ?? []
}

const asProtein = (codon: Codon): Protein => {
  if (codon === 'AUG') return 'Methionine'
  if (codon === 'UUU' || codon === 'UUC') return 'Phenylalanine'
  if (codon === 'UUA' || codon === 'UUG') return 'Leucine'
  if (codon === 'UCU' || codon === 'UCC' || codon === 'UCA' || codon === 'UCG') return 'Serine'
  if (codon === 'UAU' || codon === 'UAC') return 'Tyrosine'
  if (codon === 'UGU' || codon === 'UGC') return 'Cysteine'
  if (codon === 'UGG') return 'Tryptophan'
  if (codon === 'UAA' || codon === 'UAG' || codon === 'UGA') return 'STOP'

  console.error(`Invalid codon: ${codon}`)
  throw new Error('Invalid codon')
}


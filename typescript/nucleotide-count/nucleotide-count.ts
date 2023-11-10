export const nucleotideCounts = (dna: string) => {
  return [...dna]
    .map(validNucleotide)
    .reduce((acc: { [k: string]: number }, curr: string) =>
      ({ ...acc, [curr]: acc[curr] ? acc[curr] + 1 : 1 }),
      { A: 0, C: 0, G: 0, T: 0 })
}

const validNucleotide = (x: string): string => {
  if (["A", "C", "G", "T"].includes(x)) return x

  throw new Error("Invalid nucleotide in strand")
} 

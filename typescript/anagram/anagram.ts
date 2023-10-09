export class Anagram {
  constructor(private readonly input: string) { }

  matches = (...potentials: string[]): string[] =>
    potentials.filter(potential => isAnagram(this.input, potential))
}

const isAnagram = (word: string, potential: string): boolean =>
  word.toLowerCase() !== potential.toLowerCase() &&
  sort(word.toLowerCase()) === sort(potential.toLowerCase())

const sort = (word: string): string => [...word].sort().join('')

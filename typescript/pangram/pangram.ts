export const isPangram = (sentence: string): boolean => {
  const sentenceInLowercase = sentence.toLowerCase()
  
  return [..."abcdefghijklmnopqrstuvwxyz"]
    .every((c: string) => sentenceInLowercase.includes(c))
}


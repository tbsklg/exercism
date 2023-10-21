export const parse = (phrase: string): string => {
  return (phrase.match(/[A-Z]+[a-z]*|[a-z]+/g) || [])
    .map(x => x[0].toUpperCase())
    .join('')
}

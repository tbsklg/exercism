export const encode = (plainText: string): string => {
  const text = plainText.toLowerCase().replace(/[\s|,|.]/g, '')
  const from = 'abcdefghijklmnopqrstuvwxyz'
  const to = from.split('').reverse().join('')

  const encoded = text.split('').reduce((acc, curr) => {
    if (isNumber(curr)) return acc + curr

    const index = from.indexOf(curr)
    
    if (index === -1) return acc + curr
    return acc + to[index]
  },'')

  return chunkTo5(encoded)
}

const chunkTo5 = (xs: string, ys: string[] = []): string => {
  if (xs.length === 0) return ys.join(' ')
  
  return chunkTo5(drop(5, xs), [...ys, take(5, xs)])
}

const take = (n: number, xs: string): string => xs.slice(0, n)
const drop = (n: number, xs: string): string => xs.slice(n)
const isNumber = (n: string): boolean => !isNaN(+n)

export const decode = (cipherText: string): string => {
  const text = cipherText.replace(/\s/g, '')
  const from = 'zyxwvutsrqponmlkjihgfedcba'
  const to = from.split('').reverse().join('')

  return text.split('').map((c: string) => {
    if (isNumber(c)) return c
    return to[from.indexOf(c)]
  }).join('')
}

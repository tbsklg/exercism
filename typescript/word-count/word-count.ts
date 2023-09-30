export const count = (xs: string): Map<string, number> => {
 const words = [...(xs.toLowerCase().match(/\b[\w']+\b/g) ?? [])]
 return words.reduce((acc, curr) => {
    if (!acc.has(curr)) return new Map([...acc, [curr, 1]])

    const currentValue = acc.get(curr)
    return new Map([...acc, [curr, currentValue + 1]])
 }, new Map())
}


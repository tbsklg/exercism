export const compute = (left: string, right: string): number => {
  if (left.length !== right.length) throw new Error('DNA strands must be of equal length.')

  return [...left].filter((l, i) => l !== right[i]).length
}

const zip = (x: string, y: string): [string, string][] => {
  const go = (charsX: string[], charsY: string[], result: [string, string][] = []): [string, string][] => {
    if (charsX.length === 0 || charsY.length === 0) return result

    const [headX, ...tailX] = charsX
    const [headY, ...tailY] = charsY

    return go(tailX, tailY, [...result, [headX, headY]])
  }

  return go([...x], [...y])
}

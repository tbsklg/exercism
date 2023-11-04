export const convert = (x: number): string => {
  const drops: [number, string][] = [[3, "Pling"], [5, "Plang"], [7, "Plong"]]
  return drops
    .reduce((acc: string, [n, s]) => x % n === 0 ? acc + s : acc, "")
    || x.toString()
}

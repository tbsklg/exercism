export const convert = (x: number): string => {
  const drops: [number, string][] = [[3, "Pling"], [5, "Plang"], [7, "Plong"]]
  const rain: string =
    drops.reduce((acc, [n, s]) => x % n === 0 ? acc + s : acc, "")

  return rain === "" ? x.toString() : rain
}

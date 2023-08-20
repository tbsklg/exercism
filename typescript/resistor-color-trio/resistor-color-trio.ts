export const decodedResistorValue = ([b1, b2, b3]: string[]): string => {
  const zeros = '0'.repeat(colorCode(b3))
  return  display(Number(`${colorCode(b1)}${colorCode(b2)}${zeros}`))
}

const display = (ohms: number): string => {
  if (ohms < 1000) return `${ohms} ohms`
  if (ohms < 1000000) return `${ohms / 1000} kiloohms`
  if (ohms < 10000000000) return `${ohms / 1000000} megaohms`
  return `${ohms / 1000000000} gigaohms`
}

export const colorCode = (color: Colors) => COLORS.indexOf(color);

type Colors = typeof COLORS[number];

const COLORS = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white',
]

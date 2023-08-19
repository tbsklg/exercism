export const decodedValue = ([b1, b2]: string[]): number => 
  Number(`${colorCode(b1)}${colorCode(b2)}`)

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
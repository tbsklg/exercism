export function age(planet: string, seconds: number): number {
  switch (planet) {
    case 'mercury': return toEarthYears(0.2408467, seconds)
    case 'venus': return toEarthYears(0.61519726, seconds) 
    case 'earth': return toEarthYears (1.0, seconds) 
    case 'mars': return toEarthYears (1.8808158, seconds) 
    case 'jupiter': return toEarthYears (11.862615, seconds)
    case 'saturn': return toEarthYears (29.447498, seconds)
    case 'uranus': return toEarthYears (84.016846, seconds)
    case 'neptune': return toEarthYears (164.79132, seconds)
    default: throw new Error('Invalid planet')
  }
}

const toEarthYears = (factor: number, seconds: number): number => {
  return +(seconds / 3600 / 24 / (365.25 * factor)).toFixed(2)
}
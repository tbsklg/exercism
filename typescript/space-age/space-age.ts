export function age(planet: string, seconds: number): number {
  const toEarthYearsFor = toEarthYears(seconds) 

  switch (planet) {
    case 'mercury': return toEarthYearsFor(0.2408467)
    case 'venus': return toEarthYearsFor(0.61519726)
    case 'earth': return toEarthYearsFor (1.0) 
    case 'mars': return toEarthYearsFor (1.8808158) 
    case 'jupiter': return toEarthYearsFor (11.862615)
    case 'saturn': return toEarthYearsFor (29.447498)
    case 'uranus': return toEarthYearsFor (84.016846)
    case 'neptune': return toEarthYearsFor (164.79132)
    default: throw new Error('Invalid planet')
  }
}

const toEarthYears = (seconds: number) => (factor: number) => +(seconds / 3600 / 24 / (365.25 * factor)).toFixed(2)

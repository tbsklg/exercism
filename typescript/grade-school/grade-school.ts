type Db = {
  [grade: Grade]: Name[]
}

type Name = string

type Grade = number

export class GradeSchool {
  private db: Db = {}

  roster = (): Db => structuredClone(this.db) 

  add = (name: Name, grade:number): void => {
    const withoutName = 
      Object.keys(this.db).reduce((acc, curr) => ({...acc, [curr]: this.db[curr].filter(n => n !== name)}), {})
    
    this.db = ({...withoutName, [grade]: [...withoutName[grade] || [], name].sort()})
  }

  grade = (grade: number): string[] => structuredClone((this.db[grade] || [])).sort()
}


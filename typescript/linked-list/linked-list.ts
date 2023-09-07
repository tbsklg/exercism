export class LinkedList<TElement> {
  private head: Node<TElement> | Empty = null
  private last: Node<TElement> | Empty = null
  private length: number = 0

  push = (element: TElement): void => {
    const node = {
      value: element,
      next: null,
      prev: null,
    }

    if (this.isEmpty()) {
      this.head = node
      this.last = node
      this.length += 1
      return
    }

    if (this.last) {
      const next = {
        ...node,
        prev: this.last,
      }

      this.last.next = next 
      this.last = next
      this.length += 1
    }
  }

  isEmpty = (): boolean => this.length === 0

  pop = (): (TElement | Empty) => {
    if (this.last) {
      const node = this.last
      this.last = node.prev
      this.length -= 1
      return node.value
    }

    return null
  }

  shift = (): (TElement | Empty) => {
    if (this.head) {
      const node = this.head
      this.head = node.next
      this.length -= 1
      return node.value
    }
    
    return null
  }

  public unshift(element: TElement) {
    const node = {
      value: element,
      next: null,
      prev: null,
    }

    if (this.isEmpty()) {
      this.head = node
      this.last = node

      this.length += 1
      return
    }
    
    if (this.head) {
      const prev = {
        ...node,
        next: this.head,
      }

      this.head.prev = prev
      this.head = prev
      this.length += 1
    }
  }

  delete = (element: unknown): void => {
    if (this.isEmpty()) return

    if (this.head && this.head.value === element) {
      this.head = this.head.next
      this.length -= 1
      return
    }

    let node = this.head
    while (node) {
      if (node.next && node.next.value === element) {
        node.next = node.next.next
        this.length -= 1
        return
      }

      node = node.next
    }
  }

  count = (): number => {
    return this.length
  }
}

type Empty = null

type Node<TElement> = {
  value: TElement,
  next: Node<TElement> | Empty,
  prev: Node<TElement> | Empty,
}


module LinkedList
  ( LinkedList,
    datum,
    fromList,
    isNil,
    new,
    next,
    nil,
    reverseLinkedList,
    toList,
  )
where

data LinkedList a = Node {value :: a, next :: LinkedList a} | Nil deriving (Show, Eq)

datum :: LinkedList a -> a
datum = value

fromList :: [a] -> LinkedList a
fromList [] = Nil
fromList (x : xs) = Node {value = x, next = fromList xs}

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new x ll = Node {value = x, next = ll}

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList Nil = Nil
reverseLinkedList ll = fromList . reverse . toList $ ll

toList :: LinkedList a -> [a]
toList Nil = []
toList Node {value = v, next = n} = v : toList n

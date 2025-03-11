-- Write a program printing "Hello World!" without do-notation

main :: IO ()
main = putStrLn "Hello World!"

-- Write a program using the IO monad, that prints "Hello World!", waits for the user to input a
-- string line, and then outputs that string. First, implement the program using the combinators >>
-- and >>=, then write another version using do-notation.

main2 :: IO ()
main2 = putStrLn "Hello World!" >>
       getLine >>= \input ->
       putStrLn input

-- >> is used to sequence actions where the result of the first action is not needed.
-- >>= is used to bind the result of getLine to the input variable.

main3 :: IO ()
main3 = do
      putStrLn "Hello"


-- Consider the following simple IO function:
-- ioReverse :: IO ()
-- ioReverse = do
-- putStrLn "Give me a string!"
-- str <- getLine
-- if null str then
-- do
-- putStrLn "Next time enter a non-empty string!"
-- putStrLn "Capiche?!"
-- else
-- putStrLn ("The reverse of " ++ str ++ " is " ++ (reverse str) ++ ".")
-- Transform this function to an equivalent function ioReverse' :: IO () which does the very
-- same thing, but instead of the do-notation and <- use the binder function >>= and anonymous
-- functions.

main4 :: IO ()
main4 =
  putStrLn "Give me a string!" >>
  getLine >>= \str ->
  if null str then
    putStrLn "Next time enter a non-empty string!" >>
    putStrLn "Capiche?!"
  else
    putStrLn ("The reverse of " ++ str ++ " is " ++ reverse str ++ ".")

-- Imagine you have a database with information about persons and the towns where they were born. You
-- also know for most towns, which countries they are part of. This can be represented in terms of tuples,
-- e.g.,
-- type ID = Int
-- type Name = String
-- type Country = String
-- type Town = String

-- nameTable :: [(ID, Name)]
-- nameTable = [(1, "Aybeesky"),
-- (2, "Beeseesky"),
-- (3, "Seedeesky"),
-- (4, "Ayefsky"),
-- (5, "Deebeesky")]
-- btownTable :: [(ID, Town)]
-- btownTable = [(1, "Teetown"),
-- (2, "Eston"),
-- (3, "Arby"),
-- (5, "Esfield")] -- 4th is missing
-- townCountryTable :: [(Town, Country)]
-- townCountryTable = [("Teetown", "Teeland"),
-- ("Eston", "Exland"),
-- ("Arby", "Teeland")] -- "Essfield" is missing
-- Note that some entries are missing.
-- Use Hoogle to look up a function of type Eq a => a -> [(a, b)] -> Maybe b, which you can use to
-- look up elements in such a list of tuples.
-- Now implement the following functions:
-- getID :: Name -> Maybe ID
-- -- returns the ID of a person (if available)
-- getBTown :: ID -> Maybe Town
-- -- returns the town in which a certain person was born
-- getCountry :: Town -> Maybe Country
-- -- returns the corresponding country of a town
-- Now use the monadic properties of the Maybe data type to implement the following function:
-- getBCountry :: Name -> Maybe Country
-- -- returns the country in which a certain person was born
-- Solve this once by using do-notation, and once using >>=.

-- lookup :: Eq a => a -> [(a, b)] -> Maybe b
-- >>> lookup 2 []
-- Nothing
-- >>> lookup 2 [(1, "first")]
-- Nothing
-- >>> lookup 2 [(1, "first"), (2, "second"), (3, "third")]
-- Just "second"
  
type ID = Int
type Name = String
type Country = String
type Town = String

-- Example tables
nameTable :: [(ID, Name)]
nameTable = [(1, "Aybeesky"),
             (2, "Beeseesky"),
             (3, "Seedeesky"),
             (4, "Ayefsky"),
             (5, "Deebeesky")]

btownTable :: [(ID, Town)]
btownTable = [(1, "Teetown"),
              (2, "Eston"),
              (3, "Arby"),
              (5, "Esfield")]

townCountryTable :: [(Town, Country)]
townCountryTable = [("Teetown", "Teeland"),
                    ("Eston", "Exland"),
                    ("Arby", "Teeland")]

-- Lookup functions
getID :: Name -> Maybe ID
getID name = lookup name [(n, id) | (id, n) <- nameTable]

getBTown :: ID -> Maybe Town
getBTown id = lookup id btownTable

getCountry :: Town -> Maybe Country
getCountry town = lookup town townCountryTable

-- Using do-notation
getBCountryDo :: Name -> Maybe Country
getBCountryDo name = do
  id <- getID name
  town <- getBTown id
  getCountry town

-- Using >>= notation (monadic binding)
getBCountryBind :: Name -> Maybe Country
getBCountryBind name = 
  getID name >>= \id ->
  getBTown id >>= \town ->
  getCountry town

-- Example usage
main :: IO ()
main = do
  print $ getBCountryDo "Aybeesky"    -- Should print: Just "Teeland"
  print $ getBCountryBind "Beeseesky" -- Should print: Just "Exland"
  print $ getBCountryDo "Ayefsky"     -- Should print: Nothing
  print $ getBCountryBind "Deebeesky" -- Should print: Nothing












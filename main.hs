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

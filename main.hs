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

main3 :: IO ()
main3 = do
      putStrLn "Hello"

-- >> is used to sequence actions where the result of the first action is not needed.
-- >>= is used to bind the result of getLine to the input variable.





"""
Make sure to read enable1.txt to understand the structure of the input data

First line is a number telling us the number of lines that should be checked to see
if they are a plaindrome
"""
defmodule Palindromes_232Easy do
  """
  read in challenge inputs and begin processing to check for palindromes
  """
  def readFile(challengeInputPath) do
    IO.puts("Computer begin program...")
    case File.open(Path.expand(challengeInputPath), [:read, :utf8]) do
      {:ok, file} ->
        #this will read the entire file into memory (I think) which is not ideal
        IO.stream(file, :line) |> Enum.to_list |> process_file
        File.close(file)
      {:error, reason} ->
        IO.puts("Huston we have a problem")
        IO.inspect(reason)
    end
  end

  #If collection no longer has any input to process exit
  defp process_file([]) do
    IO.puts(" ")
    IO.puts("Computer end program")
  end

  """
  @param head -- contains the number of lines long the palindrome is
  @param tail -- contains the rest of the file data
  """
  defp process_file([head | tail]) do
    IO.puts(" ")
    IO.puts("Processing Palindrome....")

    #since everything from a file is a string lets clean up it up and cast to integer
    lines_in_palindrome = head
    |> String.strip
    |> String.to_integer

    #split the collection into a collection of the current palindrome lines and the rest of the palindrome input data
    {palindrome, palindromeTail} = Enum.split(tail, lines_in_palindrome)

    #process the palindrome to see if it is actually a palindrome (maybe not the greatest name choice here)
    palindrome
    |> Enum.join
    |> String.replace(~r{\W}, "")
    |> String.downcase
    |> process_palindrome

    #continue processing the rest of the input file
    process_file(palindromeTail)
  end

  #check if a plaindrome and print out result
  defp process_palindrome(palindromeText) do
    reversedLine = String.reverse(palindromeText)

    cond do
      palindromeText == reversedLine ->
        IO.puts("Palindrome")
      palindromeText != reversedLine ->
        IO.puts("Not a palindrome")
    end
  end
end

defmodule Palindromes_232Easy do
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

  defp process_file([]) do
    IO.puts(" ")
    IO.puts("Computer end program")
  end

  defp process_file([head | tail]) do
    IO.puts(" ")
    IO.puts("Processing Palindrome....")

    lines_in_palindrome = head
    |> String.strip
    |> String.to_integer

    {palindrome, palindromeTail} = Enum.split(tail, lines_in_palindrome)

    palindrome
    |> Enum.join
    |> String.replace(~r{\W}, "")
    |> String.downcase
    |> process_palindrome

    process_file(palindromeTail)
  end

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

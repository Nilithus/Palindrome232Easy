defmodule Palindromes_232Easy do
  def readFile do
    IO.puts("Computer begin program...")
    case File.open(Path.expand("enable1.txt"), [:read, :utf8]) do
      {:ok, file} ->
        # files are not zero indexed but enumerables are...
        IO.stream(file, :line) |> process_file(1)
        File.close(file)
      {:error, reason} ->
        IO.puts("Huston we have a problem")
        IO.inspect(reason)
    end
  end

  defp process_file(fileStream, fileLineNumber) do
    IO.puts(" ")
    IO.puts("Processing Palindrome....")

    index = fileLineNumber - 1

    lines_in_palindrome = Enum.fetch!(fileStream, index)
    |> String.strip
    |> String.to_integer

    Enum.slice(fileStream, index, lines_in_palindrome)
    |> Enum.join
    |> String.replace(~r{\W}, "")
    |> String.downcase
    |> process_palindrome

    cond do
      fileLineNumber + lines_in_palindrome < Enum.count(fileStream) ->
                process_file(fileStream, fileLineNumber + lines_in_palindrome + 1)
      true ->
        IO.puts("Comupter end program...")
    end
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

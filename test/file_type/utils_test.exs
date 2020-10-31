defmodule FileType.UtilsTest do
  use ExUnit.Case
  import FileType.Utils

  doctest FileType.Utils

  describe "~m" do
    test "matches exact binary" do
      assert ~m"foo" = "foo"

      assert_raise MatchError, fn ->
        ~m"foo" = "bar"
      end
    end

    test "matches exact hex" do
      assert ~m"6869"h = "hi"
      assert ~m"0102"h = <<0x01, 0x02>>

      assert_raise MatchError, fn ->
        ~m"6869"h = "yo"
      end

      assert_raise MatchError, fn ->
        ~m"0102"h = <<0x02, 0x01>>
      end
    end

    test "matches start of binary" do
      assert ~m"foo" = "foobar"

      assert_raise MatchError, fn ->
        ~m"bar" = "foobar"
      end
    end

    test "matches start of hex" do
      assert ~m"6869"h = "hi, there!"
      assert ~m"0102"h = <<0x01, 0x02, 0x03>>

      assert_raise MatchError, fn ->
        ~m"6869"h = "oh, hi"
      end

      assert_raise MatchError, fn ->
        ~m"0102"h = <<0x03, 0x01, 0x02>>
      end
    end

    test "matches binary with offset" do
      assert ~m"3::bar"o = "foobar"

      assert_raise MatchError, fn ->
        ~m"3::bar"o = "fobar"
      end
    end

    test "matches hex with offset" do
      assert ~m"4::6869"ho = "oh, hi"

      assert_raise MatchError, fn ->
        ~m"4::6869"ho = "whatever, hi"
      end
    end
  end
end

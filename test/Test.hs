{- SPDX-FileCopyrightText: 2020 Serokell <https://serokell.io/>
 -
 - SPDX-License-Identifier: MPL-2.0
 -}

module Main
  ( main
  ) where

import GHC.IO.Encoding (mkTextEncoding, setLocaleEncoding)
import Test.Tasty (defaultMain)

import System.IO.Utf8 (withUtf8StdHandles)

import Tree (tests)

main :: IO ()
main = withUtf8StdHandles $ do
  -- The issue only shows up when current locale encoding is ASCII.
  -- Realistically, very often when running this test this will not be
  -- the case, so we unset locale encoding manually.
  mkTextEncoding "ASCII" >>= setLocaleEncoding
  tests >>= defaultMain

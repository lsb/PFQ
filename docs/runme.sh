#!/bin/bash
#
# (C) 2011-14 Nicola Bonelli <nicola@pfq.io>

set -x
set -e

echo "Creating folders..."

rm -rf api
rm -rf lang

mkdir -p api/c
mkdir -p api/cpp
mkdir -p api/haskell

mkdir -p lang/cpp
mkdir -p lang/haskell

echo "C: library docs"

cd ../user && cat ../docs/c-api.doxy | doxygen -

echo "C++: library docs"

cd ../user && cat ../docs/cpp-api.doxy | doxygen -

echo "C++: Q-Lang docs"

cd ../user && cat ../docs/cpp-lang.doxy | doxygen -

echo "Haskell: library docs" 
cd ../user/Haskell && make clean && make && haddock -h -o ../../docs/api/haskell  -t "PFQ Library v3.2" -p ../../docs/library.haddock Network/PFq.hs
cd -

echo "Haskell: Q-Lang docs" 
cd ../user/Haskell && haddock -h -o ../../docs/lang/haskell -t "PFQ-Lang v3.2" -p ../../docs/lang.haddock Network/PFq/Default.hs Network/PFq/Experimental.hs
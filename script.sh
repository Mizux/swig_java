#!/usr/bin/env bash
set -ex

rm -rf gen; mkdir -p gen
swig -DSWIGWORDSIZE64 -I. -c++ -java -o gen/foo_java_wrap.cc -package com.google.Foo -module main -outdir gen foo.i

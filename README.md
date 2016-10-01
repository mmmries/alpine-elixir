# alpine-elixir

This is a smallish docker container that contains the bare-minimum to run an elixir application.

It is based on the same ideas as bitwalker/alpine-erlang and bitwalker/alpine-elixir-phoenix.
The main difference is that I didn't want to include node.js/npm/git. 
This cuts down the image size from ~244MB to ~49MB.

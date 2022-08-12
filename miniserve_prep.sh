#!/bin/bash

## Setup for running a miniserve instance- a very and quick way of setting up an HTTP server - for home 
## or organization use in order to share files from a particular machine, server, or VMs directories.
## See more about miniserve here: https://github.com/svenstaro/miniserve

## Please run this as root!

# Here miniserve is installed via Rust, so we will automatically install rust as a required 
# dependency: https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Install dependencies for miniserve crate
dnf install make automake gcc gcc-c++ kernel-devel -y

# install miniserve crate
cargo install miniserve

# Allow default miniserve port through firewall
firewall-cmd --add-port=8080/tcp

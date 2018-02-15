export NIX_REMOTE=daemon
export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"

file="/usr/local/etc/profile.d/nix.sh"
if [ -f "$file" ]; then
  . $file
fi


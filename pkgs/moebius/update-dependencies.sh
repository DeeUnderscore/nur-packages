#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix

# note that this update script requires the package.json and package-lock.json
# files from the upstream revision corresponding to the packaged version

node2nix \
  --input package.json \
  --lock package-lock.json \
  --node-env node-env.nix \
  --output node-packages.nix \
  --composition node-composition.nix

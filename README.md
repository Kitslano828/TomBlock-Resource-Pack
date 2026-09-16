# TomBlock Resource Pack

This public repository contains only the client-side resource pack used by the
TomBlock Minecraft server. It does not contain the TomBlock plugin source, world,
or server configuration.

`pack.mcmeta` and `assets/` are the root of the downloadable Minecraft pack.

To publish an updated pack, commit the changed assets, create a new `pack-v*`
tag, and push that tag. GitHub Actions creates a versioned Release asset named
`TomBlock-Resource-Pack.zip`. The Paper server must be configured with the
download URL and SHA-1 for that exact Release asset.

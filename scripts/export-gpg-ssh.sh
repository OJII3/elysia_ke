#!/usr/bin/env bash
mkdir -p "$HOME/.ssh" && gpg --export-ssh-key F99ACACA591A7E19F2199D390F92B2F1474C0D0E > "$HOME/.ssh/id_gpg.pub"

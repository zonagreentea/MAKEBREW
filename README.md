# MAKEBREW

**One command. Software installed.**

MAKEBREW is a lightweight software installer for personal computers.

It provides a simple interface for installing applications, games,
and development tools using the host operating system's package manager.

## Quick Start

### macOS

Requirements:
- macOS
- Homebrew
- Zsh
- Git

Clone MAKEBREW:

    git clone https://github.com/zonagreentea/MAKEBREW.git
    cd MAKEBREW

Install osu!lazer:

    ./makebrew osu

Once installed, launch osu!lazer normally from Applications.

If osu!lazer already exists in Applications, Homebrew may report
an installation conflict. Do not delete an existing installation
or player data without checking it first.

## Commands

Install software:

    ./makebrew git
    ./makebrew wget
    ./makebrew osu

Manage software:

    ./makebrew search osu
    ./makebrew list
    ./makebrew update
    ./makebrew upgrade

## Windows

Experimental Windows launchers:

- makebrew.ps1
- makebrew.cmd

Windows requires WinGet.

Example:

    .\makebrew.cmd search osu

Native Windows installation has not yet been verified.

## Linux

Linux support is planned. The current published Unix installer
is intended for macOS.

## Architecture

MAKEBREW is an installer, not a process supervisor.

- No background daemon
- No process interception
- No permanent runtime overhead
- Installed applications execute natively
- Homebrew handles macOS package installation
- GNU Make is planned for source-build support

## Compatibility

| Platform | Status |
|----------|--------|
| macOS | Available for testing |
| Windows | Experimental |
| Linux | Planned |

## Project

Repository:
https://github.com/zonagreentea/MAKEBREW

## Disclaimer

MAKEBREW is an independent project.

It is not affiliated with Homebrew, Apple, Microsoft,
or the osu! development team.

osu!lazer is developed by the osu! team.

## License

No open-source license has been selected yet.

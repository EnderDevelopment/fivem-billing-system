# FiveM Billing System

A complete billing and invoicing system for FiveM ESX servers.

## Features

- Customizable UI with dark mode support
- Job-specific invoicing for Benny's, Hayes Autos, Vanilla Unicorn, and Police/Law Enforcement
- Keybind (F7) for quick access to the billing menu
- Send, view, and pay invoices directly from the in-game UI

## Requirements

- FiveM server with ESX Legacy framework
- MySQL database

## Installation

1. Download the latest release from the [releases page](https://github.com/EnderDevelopment/fivem-billing-system/releases).
2. Extract the contents into your FiveM server's `resources` directory.
3. Add `start fivem-billing-system` to your server.cfg file.
4. Run the provided SQL script to set up the database tables.

## Usage

- Press the F7 key to open the billing menu.
- Use the tabs to navigate between different invoice statuses.
- Send invoices by filling out the form in the 'Send Invoice' section.
- Pay invoices by clicking the 'Pay' button next to the invoice in the 'Open' tab.

## Configuration

The configuration file `config.lua` allows you to customize the following settings:

- Keybind for opening the billing menu
- Logo path for the billing menu
- Job-specific invoicing settings
- Dark mode settings (enabled, background color, text color, header color)

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=fivem-billing-system&utm_content=bottom) — describe it in one sentence and get the full source code.
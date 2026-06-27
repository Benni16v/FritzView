# FRITZ!View Architecture

## Overview

FRITZ!View is a modular dashboard framework for AVM FRITZ!Box devices.

LCD4Linux is used only as the rendering engine.

The FRITZ!View core is responsible for:

- collecting data
- caching data
- loading plugins
- loading themes
- generating LCD4Linux data
- reacting to events

---

## Architecture

                +----------------------+
                |    FRITZ!View Core   |
                +----------+-----------+
                           |
          +----------------+----------------+
          |                |                |
      Plugins           Themes          Scheduler
          |                |                |
          +----------------+----------------+
                           |
                      Data Cache
                           |
                    LCD4Linux Engine
                           |
                        TFT Display

---

## Core Modules

- Scheduler
- Cache Manager
- Plugin Loader
- Theme Loader
- Event Manager
- Renderer

---

## Plugins

Every plugin consists of:

- init()
- update()
- shutdown()

Examples:

- DSL
- WAN
- Phone
- Mesh
- USB
- NAS
- VPN
- SmartHome

---

## Themes

Themes contain only layout information.

No business logic.

Examples:

- AVM
- NES
- GameBoy
- PS3
- Xbox
- Matrix

---

## Events

Examples:

- Incoming Call
- Outgoing Call
- Connection Lost
- Connection Restored
- USB Inserted
- Firmware Update
- New Answering Machine Message

---

## Cache

All collected information is stored in

/var/tmp/fritzview/

The display never accesses plugins directly.

It only reads cached data.

---

## Philosophy

Plugins never know anything about the display.

Themes never know anything about the plugins.

The Core connects both worlds.

# STCP API - Elixir
⚠️ **END OF LIFE AND NOT WORKING.**

**STCP finally updated its website and now it works on mobile. During the process they removed the pages/widget this project was scraping.**

**This project is no longer needed because the new website works great on mobile.**

---

A simple Elixir API for retrieving real-time STCP (main Porto bus company) bus arrival times.

## About

This is an Elixir port of [ruitcatarino/stcp-api](https://github.com/ruitcatarino/stcp-api), converted using Claude AI with some manual intervention. 

**Note**: This is not available on Hex. The code is intentionally simple - just copy and paste it into your app instead of adding another dependency.

## Background

The original Python API by [ruitcatarino](https://github.com/ruitcatarino) included OpenAPI documentation. When converted to Elixir, I initially added OpenAPI support to test it out, but then removed it because the API is very simple and doesn't need the extra dependency. I maintained a copy of the original OpenAPI lib file and mix file, if you prefer it.

I also simplified the generated code and removed character sanitization (removal of Portuguese accents like `á` and `ã`) because I wanted proper Portuguese in my app.

This client was created for use in [mig4ng/stcp](https://github.com/mig4ng/stcp) and is published here so you don't need to spend tokens converting or creating from scratch.

## Installation

Copy and paste it into your app instead of adding another dependency.

## Run locally

Clone this repo, install dependencies with `mix deps.get`.

Run it with `mix run --no-halt`.

It should be available in `http://localhost:4000/stops/{stop}`. E.g. for `MTB1`:
```sh
> curl http://localhost:4000/stops/MTB1
[["205 ","S. ROQUE - P","a passar - "],["205 ","CAMPANHÃ - P","17:44 - 12min"],["205 ","S. ROQUE - P","18:01 - 28min"],["205 ","CAMPANHÃ - P","18:13 - 41min"]]
```

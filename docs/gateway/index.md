---
layout: page
title: The MCode gateway
description: "How closed MCode capabilities are reached, and how the public stack stays open."
sidebar: false
outline: false
editLink: false
lastUpdated: false
---

# The MCode gateway

MCode Bench is the public face of the MCode stack. The language, the compiler,
the basic library, the device packs, and the recipes you read on this site are
open: you can read them, build them, and ship them.

Some capabilities are not open. The MCode Bench product itself, the value side
of the data plane, and the authorization that decides what a given caller may
read are part of a separate implementation. That implementation is not
distributed here and is not reachable from this site by any direct route.

## One door

Closed capabilities have exactly one door: the MCode gateway. Every read of
the value plane, every authorization decision, and every quota check happens
behind it. There is no second path, and this site is not one.

Concretely, that means:

- this site never serves a closed binary and never links to one;
- this site never queries the data plane directly;
- this site never decides entitlements, prices, or quotas.

The gateway does. Point your client at it and let it answer.

## Pointing a client at the gateway

Clients reach the gateway over HTTP and carry a token with every request:

| Setting | Meaning |
|---|---|
| `MCC_MCSRV_URL` | Where the gateway runs. Defaults to `http://127.0.0.1:8430`. |
| `MCC_MCSRV_TOKEN` | The credential the gateway accepts. There is no default. |

A request without a token is refused in a structured way (`mcsrv_unconfigured`)
rather than answered with an empty or misleading result. The gateway states
its refusals plainly: a bad token is `401`, a capability that is switched off
or out of quota is `403`, and an upstream it cannot reach is `503`.

## What stays open

The rest of the stack is open source and lives in its own repositories:

| Repository | What it carries |
|---|---|
| [mcc](https://github.com/mcodeos/mcc) | The MCC compiler: parsing, checks, and visualization. |
| [mcfam](https://github.com/mcodeos/mcfam) | Abstract component families. |
| [mcparts](https://github.com/mcodeos/mcparts) | Real device packs. |
| [mcaps](https://github.com/mcodeos/mcaps) | Power and interface recipes. |

The [tutorial](/tutorial/), [recipes](/recipes/), and
[language reference](/reference/) on this site are the working guide to all of
them.

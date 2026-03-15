# Depth-First Search in LISP — IA01 Project

![LISP](https://img.shields.io/badge/Language-Common%20LISP-red)
![AI](https://img.shields.io/badge/Domain-Artificial%20Intelligence-purple)
![License](https://img.shields.io/badge/License-Academic-lightgrey)

> Implementation of a **Depth-First Search (DFS)** algorithm in Common LISP, applied to a state-space exploration problem set in the Harry Potter universe — featuring Horcrux destruction, inventory management, and a two-agent adversarial extension.

---

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Implemented Algorithms](#implemented-algorithms)
- [Constraints](#constraints)
- [Extension: Harry vs. Voldemort](#extension-harry-vs-voldemort)
- [Project Structure](#project-structure)
- [Authors](#authors)

---

## Overview

This project was developed as part of the **IA01 – Artificial Intelligence** course at the **Université de Technologie de Compiègne (UTC)**. It implements a depth-limited DFS algorithm to navigate a grid-based map, collect destruction methods, and eliminate all Horcruxes.

The agent explores the state space recursively, dynamically updating the map and its inventory at each step, while avoiding revisiting already explored cells.

---

## How It Works

At each move, the agent:

1. **Explores** a new cell on the grid
2. **Picks up** a weapon or destruction method if one is present
3. **Destroys** a Horcrux if the required method is in its inventory
4. **Continues** recursively until all Horcruxes are destroyed or the depth limit is reached

The exploration order is strictly defined as: **Up → Right → Down → Left**

---

## Implemented Algorithms

- **Depth-First Search (DFS):** Recursive state-space traversal with depth limiting
- **Successor generation:** Computes valid neighboring states based on grid boundaries and visited cells
- **Dynamic map update:** Reflects inventory and Horcrux status changes at each step
- **Inventory management:** Tracks collected weapons and enforces destruction conditions

---

## Constraints

| Parameter | Value |
|---|---|
| Maximum search depth | 7 |
| Exploration order | Up → Right → Down → Left |
| Revisit policy | No cell revisited within a path |

---

## Extension: Harry vs. Voldemort

An extended version of the program introduces a **two-agent adversarial scenario**:

- **Harry** explores the map automatically using DFS
- **Voldemort** is controlled interactively by the user
- The game ends if both agents meet under specific conditions

This extension introduces the fundamentals of multi-agent interaction and adversarial search within the same state-space framework.

---

## Project Structure
```
Lisp-DFS-Algorithm/
│
├── TP02_CAVELIUS_DERDAKI.cl    # Full LISP implementation
└── Rapport_TP02_IA01.pdf       # Design report & analysis
```

---

## Authors

| Name | Institution |
|---|---|
| Walid Cavelius | UTC — Université de Technologie de Compiègne | @walidcavelius
| Tareq Derdaki | UTC — Université de Technologie de Compiègne |

**Course:** IA01 – Artificial Intelligence  
**Institution:** [Université de Technologie de Compiègne (UTC)](https://www.utc.fr)

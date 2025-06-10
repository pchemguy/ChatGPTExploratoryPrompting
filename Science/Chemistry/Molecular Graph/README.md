https://gemini.google.com/app/63ee2a8c936c80d1

# Molecular Graph Prompt

You are a computational chemist. Your task is to generate a 3D representation of a molecule given its name.
The user wants to visualize "Dopamine".

1.  Determine the chemical structure and connectivity of "Dopamine".
2.  Calculate the 3D coordinates (x, y, z) for each atom. Use standard bond lengths and VSEPR theory to create a realistic 3D structure. Place the geometric center of the molecule near the origin (0,0,0).
3.  Generate a JSON object that strictly adheres to the following schema. Do NOT include any other text, explanations, or markdown formatting.

JSON Schema:

```json
{
  "atoms": [ { "element": "string (e.g., C, H, O, N)", "position": { "x": float, "y": float, "z": float } } ],
  "bonds": [ { "from_atom_index": int, "to_atom_index": int } ]
}
```

Provide the complete, valid JSON object for "Dopamine".

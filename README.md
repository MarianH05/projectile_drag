# Projectile Motion with Drag Simulation

This project simulates projectile motion **with and without air resistance (quadratic drag)**.
It allows you to compare how drag affects the trajectory, range, and flight time of a projectile.


## Repository Structure
```
projectile_drag/
├── src/
│ └── projectile.m # MATLAB script generating trajectory plot
├── results/
│ ├── projectile_plot.png # Trajectory plot (drag vs no drag)
│ └── projectile_animation.gif # Pre-saved animation of the projectile
├── report/
│ ├── projectile.tex # LaTeX source report
│ └── projectile.pdf # Compiled report
└── README.md # This file
```

## How to Run 

1. Open MATLAB and navigate to the `src/` folder.
2. Run `projectile.m` to generate the **trajectory plot** (`projectile_plot.png`) in `results/`. 
3. Open `results/projectile_animation.gif` to view the **pre-generated animation**. 
4. Open `report/projectile.pdf` to see the full report with theory, methodology, and plots. 

> **Note:** You can modify initial parameters (launch velocity, angle, drag coefficient, mass, etc.)
> directly in `projectile.m` if you want to regenerate the plot.


## Requirements

- MATLAB R2016a or newer (for running the script). 


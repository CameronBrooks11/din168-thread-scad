default:
    @just --list

# Check the size table against docs/references.md, render the examples and caps, check the refusals
test:
    python3 tests/test_din168.py

# Render the README picture into docs/img/
images:
    @mkdir -p docs/img
    openscad --camera=35,0,8,55,0,25,190 --imgsize=800,480 --colorscheme=Tomorrow -o docs/img/gl45-cap.png examples/gl45_cap.scad

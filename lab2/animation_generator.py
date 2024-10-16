import re
import os
from PIL import Image, ImageDraw, ImageFont
from collections import defaultdict

def parse_pddl_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    grid_size = 5  # Default size
    if 'loc-4-4' in content and 'loc-5-5' not in content:
        grid_size = 4

    drone_location = re.search(r'\(drone-location drone1 (loc-\d-\d)\)', content)
    drone_location = drone_location.group(1) if drone_location else None

    person_locations = re.findall(r'\(person-location person\d+ (loc-\d-\d)\)', content)
    
    safe_zone = re.search(r'\(safe-zone (loc-\d-\d)\)', content)
    safe_zone = safe_zone.group(1) if safe_zone else None

    obstacles = re.findall(r'\(obstacle (loc-\d-\d)\)', content)

    return grid_size, drone_location, person_locations, safe_zone, obstacles

def draw_grid(grid_size, drone_location, person_locations, safe_zone, obstacles, safe_zone_capacity):
    cell_size = 100
    img_size = cell_size * grid_size
    img = Image.new('RGB', (img_size, img_size), color='white')
    draw = ImageDraw.Draw(img)

    # Try to load a font, fall back to default if not available
    try:
        font = ImageFont.truetype("arial.ttf", 20)
    except IOError:
        font = ImageFont.load_default()

    # Draw grid lines
    for i in range(1, grid_size):
        draw.line([(0, i * cell_size), (img_size, i * cell_size)], fill='black')
        draw.line([(i * cell_size, 0), (i * cell_size, img_size)], fill='black')

    # Draw obstacles
    for obstacle in obstacles:
        x, y = map(int, obstacle[4:].split('-'))
        draw.rectangle([(x-1)*cell_size, (y-1)*cell_size, x*cell_size, y*cell_size], fill='gray')

    # Draw safe zone
    if safe_zone:
        x, y = map(int, safe_zone[4:].split('-'))
        draw.rectangle([(x-1)*cell_size, (y-1)*cell_size, x*cell_size, y*cell_size], fill='green')
        # Add capacity number
        draw.text(((x-1)*cell_size+10, (y-1)*cell_size+10), str(safe_zone_capacity), fill='black', font=font)

    # Draw drone
    if drone_location:
        x, y = map(int, drone_location[4:].split('-'))
        draw.ellipse([(x-1)*cell_size+10, (y-1)*cell_size+10, x*cell_size-10, y*cell_size-10], fill='blue')

    # Draw persons
    for person in person_locations:
        x, y = map(int, person[4:].split('-'))
        draw.rectangle([(x-1)*cell_size+30, (y-1)*cell_size+30, x*cell_size-30, y*cell_size-30], fill='red')

    return img

def parse_plan(plan_text):
    actions = []
    for line in plan_text.strip().split('\n'):
        match = re.match(r'\d+\.\d+: \((.*?)\)', line)
        if match:
            action = match.group(1).split()
            actions.append(action)
    return actions

def update_state(action, drone_location, person_locations, safe_zone_capacity):
    action_type = action[0]
    if action_type == 'move':
        drone_location = action[3]
    elif action_type == 'pick-up':
        person = action[2]
        person_locations = [loc for loc in person_locations if loc != action[3]]
    elif action_type == 'drop-off':
        person_locations.append(action[3])
        safe_zone_capacity += 1
    elif action_type == 'increase-capacity':
        safe_zone_capacity -= 1
    return drone_location, person_locations, safe_zone_capacity

def create_animation(pddl_file_path, plan_text):
    grid_size, drone_location, person_locations, safe_zone, obstacles = parse_pddl_file(pddl_file_path)
    actions = parse_plan(plan_text)
    
    safe_zone_capacity = 0
    images = []
    for action in actions:
        img = draw_grid(grid_size, drone_location, person_locations, safe_zone, obstacles, safe_zone_capacity)
        images.append(img)
        drone_location, person_locations, safe_zone_capacity = update_state(action, drone_location, person_locations, safe_zone_capacity)
    
    # Add final state
    images.append(draw_grid(grid_size, drone_location, person_locations, safe_zone, obstacles, safe_zone_capacity))
    
    # Save as GIF
    base_name = os.path.splitext(os.path.basename(pddl_file_path))[0]
    output_gif_path = f"{base_name}_animation.gif"
    images[0].save(output_gif_path, save_all=True, append_images=images[1:], duration=1000, loop=0)
    print(f"Animation saved to {output_gif_path}")

def main():
    pddl_file = "lab2/5x5_grid_solvable_problem.pddl"  # Update this to your PDDL problem file name
    plan_text = """
0.00000: (move drone1 loc-1-1 loc-1-2)
0.00100: (move drone1 loc-1-2 loc-1-3)
0.00200: (move drone1 loc-1-3 loc-2-3)
0.00300: (pick-up drone1 person1 loc-2-3)
0.00400: (move drone1 loc-2-3 loc-3-3)
0.00500: (drop-off drone1 person1 loc-3-3 capacity1)
0.00600: (move drone1 loc-3-3 loc-3-2)
0.00700: (move drone1 loc-3-2 loc-4-2)
0.00800: (pick-up drone1 person2 loc-4-2)
0.00900: (move drone1 loc-4-2 loc-3-2)
0.01000: (move drone1 loc-3-2 loc-3-3)
0.01100: (drop-off drone1 person2 loc-3-3 capacity2)
0.01200: (move drone1 loc-3-3 loc-4-3)
0.01300: (move drone1 loc-4-3 loc-4-4)
0.01400: (move drone1 loc-4-4 loc-4-5)
0.01500: (move drone1 loc-4-5 loc-5-5)
0.01600: (pick-up drone1 person3 loc-5-5)
0.01700: (move drone1 loc-5-5 loc-4-5)
0.01800: (move drone1 loc-4-5 loc-4-4)
0.01900: (move drone1 loc-4-4 loc-4-3)
0.02000: (move drone1 loc-4-3 loc-3-3)
0.02100: (drop-off drone1 person3 loc-3-3 capacity3)
    """
    
    create_animation(pddl_file, plan_text)

if __name__ == "__main__":
    main()
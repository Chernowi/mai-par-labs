import re
import os
from PIL import Image, ImageDraw

def parse_pddl_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    grid_size = 5  # Default size
    if 'loc-4-4' in content and 'loc-5-5' not in content:
        grid_size = 4

    drone_location = re.search(r'\(drone-location drone1 (loc-\d-\d)\)', content)
    drone_location = drone_location.group(1) if drone_location else None

    person_locations = re.findall(r'\(person-location person\d (loc-\d-\d)\)', content)
    
    safe_zone = re.search(r'\(safe-zone (loc-\d-\d)\)', content)
    safe_zone = safe_zone.group(1) if safe_zone else None

    obstacles = re.findall(r'\(obstacle (loc-\d-\d)\)', content)

    return grid_size, drone_location, person_locations, safe_zone, obstacles

def draw_grid(grid_size, drone_location, person_locations, safe_zone, obstacles):
    cell_size = 100
    img_size = cell_size * grid_size
    img = Image.new('RGB', (img_size, img_size), color='white')
    draw = ImageDraw.Draw(img)

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

    # Draw drone
    if drone_location:
        x, y = map(int, drone_location[4:].split('-'))
        draw.ellipse([(x-1)*cell_size+10, (y-1)*cell_size+10, x*cell_size-10, y*cell_size-10], fill='blue')

    # Draw persons
    for person in person_locations:
        x, y = map(int, person[4:].split('-'))
        draw.rectangle([(x-1)*cell_size+30, (y-1)*cell_size+30, x*cell_size-30, y*cell_size-30], fill='red')

    return img

def process_pddl_file(pddl_file_path):
    grid_size, drone_location, person_locations, safe_zone, obstacles = parse_pddl_file(pddl_file_path)
    img = draw_grid(grid_size, drone_location, person_locations, safe_zone, obstacles)
    
    # Generate output image path
    base_name = os.path.splitext(os.path.basename(pddl_file_path))[0]
    output_image_path = f"{base_name}_state.png"
    
    img.save(output_image_path)
    print(f"Image saved to {output_image_path}")

def find_pddl_problem_files(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.pddl') and 'problem' in filename.lower():
            yield os.path.join(directory, filename)

def main():
    current_directory = os.getcwd()
    for pddl_file in find_pddl_problem_files("lab2"):
        process_pddl_file(pddl_file)

if __name__ == "__main__":
    main()

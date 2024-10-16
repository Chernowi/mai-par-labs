import re
from collections import defaultdict

def parse_plan(plan_text):
    actions = []
    for line in plan_text.strip().split('\n'):
        match = re.match(r'\d+\.\d+: \((.*?)\)', line)
        if match:
            action = match.group(1).split()
            actions.append(action)
    return actions

def generate_animation_pddl(domain_file, plan_text):
    with open(domain_file, 'r') as f:
        domain_content = f.read()

    actions = parse_plan(plan_text)
    
    objects = defaultdict(set)
    init_state = set()
    
    # Extract objects and initial state from actions
    for action in actions:
        action_name = action[0]
        if action_name == 'move':
            objects['drone'].add(action[1])
            objects['location'].add(action[2])
            objects['location'].add(action[3])
            if not init_state:  # Assume first move action gives initial drone location
                init_state.add(f'(Drone-location {action[1]} {action[2]})')
        elif action_name == 'pick-up':
            objects['drone'].add(action[1])
            objects['person'].add(action[2])
            objects['location'].add(action[3])
            init_state.add(f'(Person-location {action[2]} {action[3]})')
        elif action_name == 'drop-off':
            objects['drone'].add(action[1])
            objects['person'].add(action[2])
            objects['location'].add(action[3])
            objects['capacity'].add(action[4])
            init_state.add(f'(Safe-zone {action[3]})')
            init_state.add(f'(Safe-zone-has-capacity {action[3]} {action[4]})')

    # Add Drone-free to initial state
    init_state.add('(Drone-free)')

    # Generate animation PDDL content
    animation_content = "(define (problem rescue-drone-animation)\n"
    animation_content += f"  (:domain {domain_content.split('(define (domain ')[1].split(')')[0]})\n"
    
    # Objects
    animation_content += "  (:objects\n"
    for obj_type, obj_set in objects.items():
        animation_content += f"    {' '.join(obj_set)} - {obj_type}\n"
    animation_content += "  )\n"
    
    # Initial state
    animation_content += "  (:init\n"
    for pred in init_state:
        animation_content += f"    {pred}\n"
    animation_content += "  )\n"
    
    # Goal (empty for animation)
    animation_content += "  (:goal (and))\n"
    
    # Actions (without timestamps)
    animation_content += "  (:plan\n"
    for action in actions:
        action_str = ' '.join(action)
        animation_content += f"    ({action_str})\n"
    animation_content += "  )\n"
    
    animation_content += ")"
    
    return animation_content

def main():
    domain_file = "rescue-drone-static_domain.pddl"
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
    
    animation_content = generate_animation_pddl(domain_file, plan_text)
    
    with open("animation.pddl", "w") as f:
        f.write(animation_content)
    
    print("Animation PDDL file has been generated: animation.pddl")

if __name__ == "__main__":
    main()
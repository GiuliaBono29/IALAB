import re
import matplotlib.pyplot as plt
import matplotlib.patches as patches

def parse_clips_file(filename):
    grid = {}
    row_counts = {}
    col_counts = {}

    with open(filename, 'r') as file:
        for line in file:
            match = re.match(r'\(cell \(x (\d+)\) \(y (\d+)\) \(content (\w+)\)', line)
            if match:
                x, y, content = map(str, match.groups())
                grid[(int(x), int(y))] = content

            match_row = re.match(r'\(k-per-row \(row (\d+)\) \(num (\d+)\)', line)
            if match_row:
                row, num = map(int, match_row.groups())
                row_counts[row] = num

            match_col = re.match(r'\(k-per-col \(col (\d+)\) \(num (\d+)\)', line)
            if match_col:
                col, num = map(int, match_col.groups())
                col_counts[col] = num

    return grid, row_counts, col_counts

def draw_battlefield(grid, row_counts, col_counts, size=10):
    fig, ax = plt.subplots(figsize=(8, 8))
    ax.set_xlim(0, size)
    ax.set_ylim(0, size)
    ax.set_xticks(range(size))
    ax.set_yticks(range(size))
    ax.set_xticklabels(range(size))
    ax.set_yticklabels(range(size))
    ax.grid(True)

    for (i, j), content in grid.items():
        if content == "boat":
            rect = patches.Rectangle((j, size - 1 - i), 1, 1, linewidth=1, edgecolor='black', facecolor='blue')
            ax.add_patch(rect)
        elif content == "water":
            circ = patches.Circle((j + 0.5, size - 1 - i + 0.5), 0.3, linewidth=1, edgecolor='black', facecolor='lightgray')
            ax.add_patch(circ)
        else:
            ax.text(j + 0.5, size - 1 - i + 0.5, "?", ha='center', va='center')

    # Conteggi laterali
    for i in range(size):
        ax.text(size + 0.2, size - 1 - i + 0.5, f"{row_counts.get(i, 0)}", va='center', fontsize=12)
    for j in range(size):
        ax.text(j + 0.5, -0.5, f"{col_counts.get(j, 0)}", ha='center', fontsize=12)

    ax.set_aspect('equal')
    plt.title("Battaglia Navale - Visualizzazione Griglia")
    plt.axis('off')
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    clips_file = "battle-2025/progect/Soluzione1/case6.clp"  # usa slash o stringa raw!
    grid, row_counts, col_counts = parse_clips_file(clips_file)
    draw_battlefield(grid, row_counts, col_counts)

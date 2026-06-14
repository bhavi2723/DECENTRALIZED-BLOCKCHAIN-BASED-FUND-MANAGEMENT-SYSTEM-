import re
with open('django_error.html', 'r', encoding='utf-8') as f:
    text = f.read()

# Find the frame for views.py
matches = re.finditer(r'<span class="fname">([^<]+views\.py)</span>, line (\d+), in (\w+)', text)
found_views = False
for m in matches:
    print('Error in', m.group(1), 'at line', m.group(2), 'in', m.group(3))
    found_views = True

# Also find locals for the views.py frame
parts = text.split('<table class="vars">')
if len(parts) > 1:
    print('\nLocals from views.py frame (approx):')
    for row in re.findall(r'<tr>\s*<td>([^<]+)</td>\s*<td class="code"><pre>([^<]*)</pre></td>', parts[-2]):
        print(f'{row[0]}: {row[1][:200]}')

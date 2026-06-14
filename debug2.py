import os
with open('django_error.html', 'r', encoding='utf-8') as f:
    text = f.read()

lines = text.split('\n')
for i, line in enumerate(lines):
    if 'views.py' in line and 'in base' in line:
        print("FOUND", line.strip())
        for j in range(i, min(len(lines), i+30)):
            if 'class="context-line"' in lines[j] or 'class="code"' in lines[j]:
                # strip html tags
                import re
                clean = re.sub('<[^<]+>', '', lines[j]).strip()
                print(clean)
        break

import re
text = open('django_error.html', 'r', encoding='utf-8').read()
matches = re.finditer(r'<code class="fname">([^<]+)</code>, line (\d+), in (\w+)', text)
for m in matches:
    name = m.group(1).split('\\')[-1]
    print(name, 'line', m.group(2), 'in', m.group(3))

import re
text = open('django_error.html', 'r', encoding='utf-8').read()
matches = re.finditer(r'<table class="vars">(.+?)</table>', text, re.DOTALL)
for m in matches:
    table = m.group(1)
    if 'contract_balance_wei' in table or 'docIds' in table or 'donations_count' in table:
        print('FOUND LOCALS FOR BASE:')
        for row in re.finditer(r'<tr>\s*<td>([^<]+)</td>\s*<td class="code"><pre>([^<]+)</pre></td>', table):
            print(f'{row.group(1).strip()}: {row.group(2).strip()[:100]}')
        break

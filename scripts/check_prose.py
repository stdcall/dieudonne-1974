"""Advisory Russian prose check: Vale parses Typst through typst2vast."""
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def main():
    missing = [name for name in ('vale', 'typst2vast') if not shutil.which(name)]
    if missing:
        print('Prose check unavailable: ' + ', '.join(missing))
        return
    sources = sorted((ROOT / 'content').rglob('*.typ'))
    result = subprocess.run(
        ['vale', '--config', str(ROOT / 'checks/vale/.vale.ini'),
         '--output', 'JSON', *map(str, sources)],
        capture_output=True, text=True)
    if result.returncode > 1 or not result.stdout.strip():
        raise SystemExit(result.stderr or result.stdout or 'Vale returned no JSON')
    report = json.loads(result.stdout)
    findings = [(Path(name).relative_to(ROOT), issue)
                for name, issues in report.items() for issue in issues]
    for name, issue in findings:
        print(f'{name}:{issue["Line"]}:{issue["Span"][0]} '
              f'{issue["Check"]}: {issue["Message"]}')
    print(f'Vale: {len(findings)} findings (advisory)')


if __name__ == '__main__':
    main()

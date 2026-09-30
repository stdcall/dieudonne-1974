"""Checks of errata markup and bindings between Lean proofs and passages."""
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts'))
from project import tool_env, cache_path  # noqa: E402


class EditionChecks(unittest.TestCase):
    def test_corrections_schema_and_markup(self):
        entries = json.loads((ROOT / 'corrections.json').read_text())['entries']
        ids = [entry['id'] for entry in entries]
        self.assertEqual(len(ids), len(set(ids)))
        required = {'id', 'printed_page', 'section', 'place', 'original',
                    'corrected', 'reason', 'verified_by'}
        for entry in entries:
            self.assertEqual(set(entry), required)
            for name in required:
                self.assertIsInstance(entry[name], str)
                self.assertTrue(entry[name].strip(), (entry['id'], name))
            self.assertNotEqual(entry['original'], entry['corrected'])
        cache_path().mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(dir=cache_path()) as folder:
            source = Path(folder) / 'fields.typ'
            source.write_text(
                '#import ' + json.dumps(str(ROOT / 'content/main-defs.typ')) +
                ' as defs\n'
                '#let scope = dictionary(defs)\n'
                '#let markup(value) = eval(value, mode: "markup", scope: scope)\n'
                '#set text(font: "Libertinus Serif", lang: "ru")\n'
                '#show math.equation: set text(font: "STIX Two Math")\n'
                '#for entry in json(' + json.dumps(str(ROOT / 'corrections.json')) +
                ').entries {\n'
                '  for key in ("original", "corrected", "reason") {\n'
                '    block(markup(entry.at(key)))\n'
                '  }\n'
                '}\n')
            result = subprocess.run(
                ['typst', 'compile', '--root', '/', str(source),
                 str(Path(folder) / 'fields.pdf')],
                cwd=ROOT, env=tool_env(), capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertNotIn('warning:', result.stderr)

    def test_lean_manifest_binds_existing_passages(self):
        path = ROOT / 'checks/lean/check_axioms.py'
        spec = importlib.util.spec_from_file_location('edition_lean', path)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        records, problems = module.load_records()
        self.assertTrue(records)
        self.assertEqual(problems, [])


if __name__ == '__main__':
    unittest.main()

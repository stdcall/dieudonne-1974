"""Readable Unicode for this book's group notation in PDF bookmarks only."""
import re


GROUP = re.compile(
    r'(?<!\w)(PGL|PSL|GL|SL|GU|PU|PΩ|PSp|Sp|U|O|T|Ω|Z)'
    r'(\+?)(n|2m)(\+?)(?!\w)')
SUBSCRIPT = {'n': 'ₙ', '2m': '₂ₘ'}


def unicode_outline_title(title):
    """Restore indices lost by plain-text extraction of math headings.

    Group names stay upright. Unsupported notation and non-math titles
    are kept verbatim; typeset headings and page contents are not touched.
    """
    if not GROUP.search(title):
        return title

    def group(match):
        name, before, index, after = match.groups()
        return name + SUBSCRIPT[index] + ('⁺' if before or after else '')

    title = GROUP.sub(group, title)
    title = re.sub(r'([ₙₘ⁺])\s+\(', r'\1(', title)
    title = re.sub(r'\(K,\s*([fQ])\)', r'(K, \1)', title)
    title = re.sub(r'\s*([∩=])\s*', r' \1 ', title)
    return title

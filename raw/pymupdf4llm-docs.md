---
title: "PyMuPDF4LLM - PyMuPDF documentation"
token: "1666"
source_link: "https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/"
topic: "pdf-llm-ingestion"
tags: ["source/web", "privacy/public", "ingest", "pdf", "llm", "extraction"]
generated_at: "2026-05-19T06:25:43Z"
source: "web"
---
pymupdf.io






[English](javaScript:changeLanguage('en'))
[日本語](javaScript:changeLanguage('ja'))
[한국어](javaScript:changeLanguage('ko'))

[Find **#pymupdf** on **Discord**](https://discord.gg/TSpYGBW4eq)

[Try our forum! ![MuPDF Forum link logo](https://pymupdf.readthedocs.io/en/latest/_static/forum-logo.gif)](https://forum.mupdf.com)

# PyMuPDF4LLM[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#id1 "Link to this heading")

PyMuPDF4LLM is a lightweight extension for PyMuPDF that turns PDFs into clean, structured data with minimal setup. It includes layout analysis *without* any GPU requirement.

PyMuPDF4LLM makes it easy to extract document content in the format you need for **LLM** & **RAG** environments. It supports structured data extraction to [Markdown](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#extracting-as-md), [JSON](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#extracting-as-json) and [TXT](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#extracting-as-txt), as well as [LlamaIndex](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#integration-with-llamaindex) and [LangChain](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#integration-with-langchain) integration.

Important

You can also extend the supported file types to also include **Office** document formats (DOC/DOCX, XLS/XLSX, PPT/PPTX, HWP/HWPX) by [using PyMuPDF Pro with PyMuPDF4LLM](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#using-pymupdf4llm-with-pymupdfpro).

## Features[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#features "Link to this heading")

> - Support for Markdown, JSON and plain text output formats.
> - Support for multi-column pages.
> - Support for image and vector graphics extraction.
> - Layout analysis for better semantic understanding of document structure.
> - Support for page chunking output.
> - Automatic detection of pages which profit from OCR and support for various OCR engines.
> - Integration with [LlamaIndex](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#integration-with-llamaindex) & [LangChain](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#integration-with-langchain).

## API[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#api "Link to this heading")

See: [The PyMuPDF4LLM API](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html).

## Installation[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#installation "Link to this heading")

Install the package via **pip** with:

```
pip install pymupdf4llm
```

## Extracting[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#extracting "Link to this heading")

### As **Markdown**[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#as-markdown "Link to this heading")

To retrieve your document content in **Markdown** use the [`to_markdown()`](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html#to_markdown "to_markdown") method as follows:

```
import pymupdf4llm
md = pymupdf4llm.to_markdown("input.pdf")
```

### As **JSON**[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#as-json "Link to this heading")

To retrieve your document content in **JSON** use the [`to_json()`](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html#to_json "to_json") method as follows:

```
import pymupdf4llm
json = pymupdf4llm.to_json("input.pdf")
```

The JSON export will give you bounding box information and layout data for each element on the page. This can be used to create your own custom output formats or to simply have more detailed information about the document structure for RAG workflows & LLM integrations.

### As **TXT**[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#as-txt "Link to this heading")

To retrieve your document content in **TXT** use the [`to_text()`](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html#to_text "to_text") method as follows:

```
import pymupdf4llm
txt = pymupdf4llm.to_text("input.pdf")
```

---

Note

Instead of using filename strings as above, one can also provide a [PyMuPDF Document](https://pymupdf.readthedocs.io/en/latest/document.html#document).

Finally we can save the output to an external file as follows:

```
from pathlib import Path
suffix = ".md" # or ".json" or ".txt"
Path(doc.name).with_suffix(suffix).write_bytes(md.encode())
```

### Headers & Footers[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#headers-footers "Link to this heading")

Many documents will have header and footer information on each page of a PDF which you may or may not want to include. This information can be repetitive and simply not needed ( e.g. the same logo and document title or page number information is not always required when it comes to extracting the document content ).

PyMuPDF4LLM is trained in detecting these typical document elements and able to omit them.

So in this case we can adjust our API calls to ignore these elements as follows:

```
md = pymupdf4llm.to_markdown(doc, header=False, footer=False)
```

Note

Please note that page `header` / `footer` exclusion is not applicable to JSON output as it aims to always represent all data for the included pages. Please refer to [The PyMuPDF4LLM API](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html) for more.

## Integrations[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#integrations "Link to this heading")

### With **LlamaIndex**[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#with-llamaindex "Link to this heading")

PyMuPDF4LLM supports direct conversion to a **LlamaIndex** document. A document is first converted into **Markdown** format and then a **LlamaIndex** document is returned as follows:

```
import pymupdf4llm
llama_reader = pymupdf4llm.LlamaMarkdownReader()
llama_docs = llama_reader.load_data("input.pdf")
```

### With **LangChain**[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#with-langchain "Link to this heading")

PyMuPDF4LLM also supports **LangChain** integration, see the [PyMuPDF4LLM Document Loader](https://docs.langchain.com/oss/python/integrations/providers/pymupdf4llm/) for more details.

## Using with PyMuPDF Pro[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#using-with-pymupdf-pro "Link to this heading")

For **Office** document support, PyMuPDF4LLM works seamlessly with PyMuPDF Pro. Assuming you have [PyMuPDF Pro](https://pymupdf.readthedocs.io/en/latest/pymupdf-pro/index.html) installed you will be able to work with **Office** documents as expected:

```
import pymupdf4llm
import pymupdf.pro
pymupdf.pro.unlock()
md = pymupdf4llm.to_markdown("sample.doc")
```

## PyMuPDF4LLM & PyMuPDF Layout[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#pymupdf4llm-pymupdf-layout "Link to this heading")

By default PyMuPDF4LLM includes a [layout analysis module](https://pypi.org/project/pymupdf-layout/) to enhance output results. To disable this module you can do so by calling the [`use_layout()`](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/api.html#use_layout "use_layout") method.

## OCR[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#ocr "Link to this heading")

PyMuPDF4LLM includes built-in OCR support for scanned documents and image-based PDFs. By default, OCR runs **automatically** when needed — you don’t have to opt in. For more control, you can force OCR on specific pages, disable it entirely, or swap in a different OCR engine using the adaptor interface.

Note

If you want to use an OCR engine other than Tesseract, see [OCR Engines](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#ocr-engines) for details.

### Hybrid OCR strategy[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#hybrid-ocr-strategy "Link to this heading")

PyMuPDF4LLM applies OCR only when it is genuinely required to obtain the complete text of a PDF page. If a page already contains sufficient extractable text, OCR is skipped entirely — avoiding unnecessary work and eliminating the risk of degrading high-quality digital text.

When OCR is needed, PyMuPDF4LLM automatically selects the most suitable OCR plugin available in the runtime environment, balancing detection accuracy with processing speed.

Its built-in OCR plugins implement a Hybrid OCR strategy: only those regions lacking extractable, legible text are passed to the OCR engine. This selective approach typically reduces OCR processing time by around 50% while improving recognition accuracy, since the engine focuses exclusively on the problematic regions. The recognized text is then merged back into the original page, enriching it without disturbing existing digital content.

---

### Auto-OCR Behaviour[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#auto-ocr-behaviour "Link to this heading")

PyMuPDF4LLM inspects each page before extracting text. If a page contains **no selectable text** — meaning all content is rasterised into images — OCR is triggered automatically for that page.

Pages that contain native text only are never sent through OCR. This keeps processing fast and avoids degrading already-clean text.

```
import pymupdf4llm

# OCR runs automatically on any page with no selectable text
md_text = pymupdf4llm.to_markdown("scanned-document.pdf")
```

The resulting Markdown is seamless — pages extracted via OCR and pages extracted natively are combined into a single output with no distinction between them.

---

### How OCR is Triggered[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#how-ocr-is-triggered "Link to this heading")

There are two scenarios where OCR is applied automatically:

**No text at all** — if a page contains roughly no text but is covered with images or many character-sized vectors, PyMuPDF4LLM checks whether text is *probably* detectable on the page. This distinguishes image-based text (e.g. a scanned document) from ordinary pictures like photographs.

**Garbled text** — if a page does contain text but too many characters are unreadable (e.g. `"�����"`), OCR is applied **for the affected text areas only**, not the full page. This preserves already-readable text, images, and vectors while recovering only what is broken.

---

### Forcing OCR[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#forcing-ocr "Link to this heading")

In some cases you may want to force OCR even on pages that contain selectable text — for example, when the native text layer is corrupt, misencoded, or misaligned with the visual content.

Use `force_ocr=True` to bypass the auto-detection check entirely:

```
md_text = pymupdf4llm.to_markdown("document.pdf", force_ocr=True)
```

Warning

Forcing OCR on clean, text-based PDFs will slow down processing significantly and may reduce output quality. Only use `force_ocr=True` when you have reason to distrust the native text layer.

You can also force OCR on specific pages rather than the whole document:

```
md_text = pymupdf4llm.to_markdown(
    "document.pdf",
    pages=[2, 3, 4],
    force_ocr=True
)
```

---

### Disabling OCR[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#disabling-ocr "Link to this heading")

To prevent OCR from running at all — even on pages with no selectable text — set `use_ocr=False`:

```
md_text = pymupdf4llm.to_markdown("document.pdf", use_ocr=False)
```

Pages with no selectable text will return empty strings in this mode. This is useful when you know your documents are always text-based, or when you want to handle OCR yourself in a downstream step.

---

### OCR Engines[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#ocr-plugins "Link to this heading")

Other OCR Engines (OCR Adaptors or Plugins) can be used with PyMuPDF4LLM.

See [OCR Plugins](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/ocr-plugins.html) for details on how to use different OCR engines with PyMuPDF4LLM, including Tesseract, RapidOCR, and how to implement your own custom OCR function.

### OCR Language Support[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#ocr-language-support "Link to this heading")

When using the default Tesseract adaptor, you can specify one or more languages using Tesseract’s language codes.

Specify the language to be used by the Tesseract OCR engine. Default is `"eng"` (English). Make sure that the respective language data files are installed. Remember to use correct Tesseract language codes. Multiple languages can be specified by concatenating the respective codes with a plus sign `"+"`, for example `"eng+deu"` for English and German.

```
md_text = pymupdf4llm.to_markdown("multilingual.pdf",
                                   ocr_language="eng+deu")
```

Tesseract language packs must be installed on your system. For example, on Ubuntu:

```
sudo apt install tesseract-ocr-deu tesseract-ocr-fra
```

See the page on [installing Tesseract language packs](https://pymupdf.readthedocs.io/en/latest/ocr/tesseract-language-packs.html#tesseract-language-packs) for further details.

---

### Performance Tips[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#performance-tips "Link to this heading")

OCR is the most compute-intensive part of the extraction pipeline. A few ways to keep it fast:

- **Process only the pages you need** using the `pages` parameter to avoid running OCR on the entire document.
- **Cache results** — write the output to disk after the first run so you don’t re-process the same file.
- **Use** `force_ocr=False` (the default) so clean pages skip OCR entirely.
- **Resize images before passing to OCR** — very high DPI scans can slow Tesseract down without improving accuracy.

---

## Further Resources[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#further-resources "Link to this heading")

### Sample code[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#sample-code "Link to this heading")

- [Command line RAG Chatbot with PyMuPDF](https://github.com/pymupdf/RAG/tree/main/examples/country-capitals)
- [Example of a Browser Application using LangChain and PyMuPDF](https://github.com/pymupdf/RAG/tree/main/examples/GUI)

### Blogs[¶](https://pymupdf.readthedocs.io/en/latest/pymupdf4llm/#blogs "Link to this heading")

- [RAG/LLM and PDF: Enhanced Text Extraction](https://artifex.com/blog/rag-llm-and-pdf-enhanced-text-extraction)
- [Creating a RAG Chatbot with ChatGPT and PyMuPDF](https://artifex.com/blog/creating-a-rag-chatbot-with-chatgpt-and-pymupdf)
- [Building a RAG Chatbot GUI with the ChatGPT API and PyMuPDF](https://artifex.com/blog/building-a-rag-chatbot-gui-with-the-chatgpt-api-and-pymupdf)
- [RAG/LLM and PDF: Conversion to Markdown Text with PyMuPDF](https://artifex.com/blog/rag-llm-and-pdf-conversion-to-markdown-text-with-pymupdf)

---

This software is provided AS-IS with no warranty, either express or implied. This software is distributed under license and may not be copied, modified or distributed except as expressly authorized under the terms of that license. Refer to licensing information at [artifex.com](https://www.artifex.com?utm_source=rtd-pymupdf&utm_medium=rtd&utm_content=footer-link) or contact Artifex Software Inc., 39 Mesa Street, Suite 108A, San Francisco CA 94129, United States for further information.

This documentation covers all versions up to 1.27.2.3.

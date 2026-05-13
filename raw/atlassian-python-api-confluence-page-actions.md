---
title: "Atlassian Python API Confluence page actions"
token: "3555"
source_link: "https://atlassian-python-api.readthedocs.io/confluence.html"
source_links: ["https://atlassian-python-api.readthedocs.io/confluence.html", "https://atlassian-python-api.readthedocs.io/_static/pygments.css?v=5ecbeea2", "https://atlassian-python-api.readthedocs.io/_static/basic.css?v=b08954a9", "https://atlassian-python-api.readthedocs.io/_static/alabaster.css?v=27fed22d", "https://atlassian-python-api.readthedocs.io/genindex.html", "https://atlassian-python-api.readthedocs.io/search.html", "https://atlassian-python-api.readthedocs.io/crowd.html", "https://atlassian-python-api.readthedocs.io/jira.html", "https://atlassian-python-api.readthedocs.io/_static/custom.css", "https://atlassian-python-api.readthedocs.io/index.html", "https://atlassian-python-api.readthedocs.io/bitbucket.html", "https://atlassian-python-api.readthedocs.io/bamboo.html", "https://atlassian-python-api.readthedocs.io/service_desk.html", "https://atlassian-python-api.readthedocs.io/xray.html", "https://atlassian-python-api.readthedocs.io/cloud_admin.html", "https://www.sphinx-doc.org/", "https://alabaster.readthedocs.io", "https://atlassian-python-api.readthedocs.io/_sources/confluence.rst.txt"]
topic: "ai-automation"
tags: ["ingest", "web", "source/web", "privacy/public", "fetched", "ai-automation", "atlassian-python-api-readthedocs-io"]
generated_at: "2026-05-13T22:27:57Z"
---

# Atlassian Python API Confluence page actions

Source URL: https://atlassian-python-api.readthedocs.io/confluence.html
Fetched URL: https://atlassian-python-api.readthedocs.io/confluence.html
Content-Type: text/html

## Source Content

```html
<!DOCTYPE html>

<html lang="en" data-content_root="./">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Confluence module &#8212; Atlassian Python API 4.0.8 documentation</title>
    <link rel="stylesheet" type="text/css" href="_static/pygments.css?v=5ecbeea2" />
    <link rel="stylesheet" type="text/css" href="_static/basic.css?v=b08954a9" />
    <link rel="stylesheet" type="text/css" href="_static/alabaster.css?v=27fed22d" />
    <script src="_static/documentation_options.js?v=1097caeb"></script>
    <script src="_static/doctools.js?v=fd6eb6e6"></script>
    <script src="_static/sphinx_highlight.js?v=6ffebe34"></script>
    <link rel="index" title="Index" href="genindex.html" />
    <link rel="search" title="Search" href="search.html" />
    <link rel="next" title="Crowd module" href="crowd.html" />
    <link rel="prev" title="Jira module" href="jira.html" />
   
  <link rel="stylesheet" href="_static/custom.css" type="text/css" />
  

  
  

  <script async type="text/javascript" src="/_/static/javascript/readthedocs-addons.js"></script><meta name="readthedocs-project-slug" content="atlassian-python-api" /><meta name="readthedocs-version-slug" content="latest" /><meta name="readthedocs-resolver-filename" content="/confluence.html" /><meta name="readthedocs-http-status" content="200" /></head><body>
  

    <div class="document">
      <div class="documentwrapper">
        <div class="bodywrapper">
          

          <div class="body" role="main">
            
  <section id="confluence-module">
<h1>Confluence module<a class="headerlink" href="#confluence-module" title="Link to this heading">¶</a></h1>
<p>The Confluence module now provides both Cloud and Server implementations
with dedicated APIs for each platform.</p>
<section id="new-implementation">
<h2>New Implementation<a class="headerlink" href="#new-implementation" title="Link to this heading">¶</a></h2>
<p>The new Confluence implementation follows the same pattern as other modules
with dedicated Cloud and Server classes:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">atlassian.confluence</span><span class="w"> </span><span class="kn">import</span> <span class="n">ConfluenceCloud</span><span class="p">,</span> <span class="n">ConfluenceServer</span>

<span class="c1"># For Confluence Cloud</span>
<span class="n">confluence_cloud</span> <span class="o">=</span> <span class="n">ConfluenceCloud</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s2">&quot;https://your-domain.atlassian.net&quot;</span><span class="p">,</span>
    <span class="n">token</span><span class="o">=</span><span class="s2">&quot;your-api-token&quot;</span>
<span class="p">)</span>

<span class="c1"># For Confluence Server</span>
<span class="n">confluence_server</span> <span class="o">=</span> <span class="n">ConfluenceServer</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s2">&quot;https://your-confluence-server.com&quot;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s2">&quot;your-username&quot;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s2">&quot;your-password&quot;</span>
<span class="p">)</span>
</pre></div>
</div>
</section>
<section id="cloud-vs-server-differences">
<h2>Cloud vs Server Differences<a class="headerlink" href="#cloud-vs-server-differences" title="Link to this heading">¶</a></h2>
<div class="line-block">
<div class="line">Feature | Cloud | Server |</div>
<div class="line">Authentication | API Token | Username/Password |</div>
<div class="line">API Version | v2 | v1.0 |</div>
<div class="line">API Root | <cite>wiki/api/v2</cite> | <cite>rest/api/1.0</cite> |</div>
<div class="line">Content IDs | UUID strings | Numeric IDs |</div>
<div class="line">Space IDs | UUID strings | Space keys |</div>
</div>
</section>
<section id="common-operations">
<h2>Common Operations<a class="headerlink" href="#common-operations" title="Link to this heading">¶</a></h2>
<p>Both implementations support:</p>
<ul class="simple">
<li><p>Content management (create, read, update, delete)</p></li>
<li><p>Space management</p></li>
<li><p>User and group management</p></li>
<li><p>Label management</p></li>
<li><p>Attachment handling</p></li>
<li><p>Comment management</p></li>
<li><p>Search functionality</p></li>
<li><p>Page properties</p></li>
<li><p>Export capabilities</p></li>
</ul>
</section>
<section id="server-specific-features">
<h2>Server-Specific Features<a class="headerlink" href="#server-specific-features" title="Link to this heading">¶</a></h2>
<p>The Server implementation includes additional features:</p>
<ul class="simple">
<li><p>Draft content management</p></li>
<li><p>Trash content management</p></li>
<li><p>Reindex operations</p></li>
<li><p>Space permissions</p></li>
<li><p>Space settings</p></li>
</ul>
</section>
<section id="legacy-implementation">
<h2>Legacy Implementation<a class="headerlink" href="#legacy-implementation" title="Link to this heading">¶</a></h2>
<p>The original Confluence implementation is still available
for backward compatibility.</p>
</section>
<section id="get-page-info">
<h2>Get page info<a class="headerlink" href="#get-page-info" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Check page exists</span>
<span class="c1"># type of the page, &#39;page&#39; or &#39;blogpost&#39;. Defaults to &#39;page&#39;</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">page_exists</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="nb">type</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Provide content by type (page, blog, comment)</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_child_by_type</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="nb">type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Provide content id from search result by title and space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_id</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">title</span><span class="p">)</span>

<span class="c1"># Provide space key from content id</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_space</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Returns the list of labels on a piece of Content</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_by_title</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get page by ID</span>
<span class="c1"># Example request URI(s):</span>
<span class="c1">#    http://example.com/confluence/rest/api/content/1234?expand=space,body.view,version,container</span>
<span class="c1">#    http://example.com/confluence/rest/api/content/1234?status=any</span>
<span class="c1">#    page_id: Content ID</span>
<span class="c1">#    status: (str) list of Content statuses to filter results on. Default value: [current]</span>
<span class="c1">#    version: (int)</span>
<span class="c1">#    expand: OPTIONAL: A comma separated list of properties to expand on the content.</span>
<span class="c1">#                   Default value: history,space,version</span>
<span class="c1">#                   We can also specify some extensions such as extensions.inlineProperties</span>
<span class="c1">#                   (for getting inline comment-specific properties) or extensions.resolution</span>
<span class="c1">#                   for the resolution status of each comment in the results</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_by_id</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">version</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># The list of labels on a piece of Content</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_labels</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">prefix</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get draft page by ID</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_draft_page_by_id</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="s1">&#39;draft&#39;</span><span class="p">)</span>

<span class="c1"># Get all page by label</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_pages_by_label</span><span class="p">(</span><span class="n">label</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get all pages from Space</span>
<span class="c1"># content_type can be &#39;page&#39; or &#39;blogpost&#39;. Defaults to &#39;page&#39;</span>
<span class="c1"># expand is a comma separated list of properties to expand on the content.</span>
<span class="c1"># max limit is 100. For more you have to loop over start values.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_pages_from_space</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">)</span>

<span class="c1"># Get all pages from space as Generator</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_pages_from_space_as_generator</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">)</span>

<span class="c1"># Get list of pages from trash</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_pages_from_space_trash</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="s1">&#39;trashed&#39;</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">)</span>

<span class="c1"># Get list of draft pages from space</span>
<span class="c1"># Use case is cleanup old drafts from Confluence</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_draft_pages_from_space</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="s1">&#39;draft&#39;</span><span class="p">)</span>

<span class="c1"># Search list of draft pages by space key</span>
<span class="c1"># Use case is cleanup old drafts from Confluence</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_draft_pages_from_space_through_cql</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="s1">&#39;draft&#39;</span><span class="p">)</span>

<span class="c1"># Info about all restrictions by operation</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_restrictions_for_content</span><span class="p">(</span><span class="n">content_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="page-actions">
<h2>Page actions<a class="headerlink" href="#page-actions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Create page from scratch</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">create_page</span><span class="p">(</span><span class="n">space</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">body</span><span class="p">,</span> <span class="n">parent_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="nb">type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">,</span> <span class="n">representation</span><span class="o">=</span><span class="s1">&#39;storage&#39;</span><span class="p">,</span> <span class="n">editor</span><span class="o">=</span><span class="s1">&#39;v2&#39;</span><span class="p">,</span> <span class="n">full_width</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># This method removes a page, if it has recursive flag, method removes including child pages</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">recursive</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Remove any content</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_content</span><span class="p">(</span><span class="n">content_id</span><span class="p">):</span>

<span class="c1"># Remove page from trash</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_page_from_trash</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Remove page as draft</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_page_as_draft</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Update page if already exist</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">update_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">body</span><span class="p">,</span> <span class="n">parent_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="nb">type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">,</span> <span class="n">representation</span><span class="o">=</span><span class="s1">&#39;storage&#39;</span><span class="p">,</span> <span class="n">minor_edit</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">full_width</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Update page or create page if it is not exists</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">update_or_create</span><span class="p">(</span><span class="n">parent_id</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">body</span><span class="p">,</span> <span class="n">representation</span><span class="o">=</span><span class="s1">&#39;storage&#39;</span><span class="p">,</span> <span class="n">full_width</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Append body to page if already exist</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">append_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">append_body</span><span class="p">,</span> <span class="n">parent_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="nb">type</span><span class="o">=</span><span class="s1">&#39;page&#39;</span><span class="p">,</span> <span class="n">representation</span><span class="o">=</span><span class="s1">&#39;storage&#39;</span><span class="p">,</span> <span class="n">minor_edit</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Set the page (content) property e.g. add hash parameters</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_page_property</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">data</span><span class="p">)</span>

<span class="c1"># Delete the page (content) property e.g. delete key of hash</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">delete_page_property</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">page_property</span><span class="p">)</span>

<span class="c1"># Move page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">move_page</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">page_id</span><span class="p">,</span> <span class="n">target_title</span><span class="p">,</span> <span class="n">position</span><span class="o">=</span><span class="s2">&quot;append&quot;</span><span class="p">)</span>

<span class="c1"># Get the page (content) property e.g. get key of hash</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_property</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">page_property_key</span><span class="p">)</span>

<span class="c1"># Get the page (content) properties</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_properties</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Get page ancestors</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_page_ancestors</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Attach (upload) a file to a page, if it exists it will update the</span>
<span class="c1"># automatically version the new file and keep the old one</span>
<span class="c1"># content_type is default to &quot;application/binary&quot;</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">attach_file</span><span class="p">(</span><span class="n">filename</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">page_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">title</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">space</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">comment</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Attach (upload) a content to a page, if it exists it will update the</span>
<span class="c1"># automatically version the new file and keep the old one</span>
<span class="c1"># content_type is default to &quot;application/binary&quot;</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">attach_content</span><span class="p">(</span><span class="n">content</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">page_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">title</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">space</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">comment</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Download attachments from a page to local system. If path is None, current working directory will be used.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">download_attachments_from_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">path</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove completely a file if version is None or delete version</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">delete_attachment</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">filename</span><span class="p">,</span> <span class="n">version</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove completely a file if version is None or delete version</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">delete_attachment_by_id</span><span class="p">(</span><span class="n">attachment_id</span><span class="p">,</span> <span class="n">version</span><span class="p">)</span>

<span class="c1"># Keep last versions</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_page_attachment_keep_version</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">filename</span><span class="p">,</span> <span class="n">keep_last_versions</span><span class="p">)</span>

<span class="c1"># Get attachment history</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_attachment_history</span><span class="p">(</span><span class="n">attachment_id</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">200</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">)</span>

<span class="c1"># Get attachment for content</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_attachments_from_content</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">filename</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">media_type</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Check has unknown attachment error on page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">has_unknown_attachment_error</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Export page as PDF</span>
<span class="c1"># api_version needs to be set to &#39;cloud&#39; when exporting from Confluence Cloud</span>
<span class="o">.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">export_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Set a label on the page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_page_label</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">label</span><span class="p">)</span>

<span class="c1"># Delete Confluence page label</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_page_label</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">label</span><span class="p">)</span>

<span class="c1"># Add comment into page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">add_comment</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">text</span><span class="p">)</span>

 <span class="c1"># Fetch tables from Confluence page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_tables_from_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Get regex matches from Confluence page</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">scrap_regex_from_page</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">regex</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="confluence-whiteboards">
<h2>Confluence Whiteboards<a class="headerlink" href="#confluence-whiteboards" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Create  new whiteboard  - cloud only</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">create_whiteboard</span><span class="p">(</span><span class="n">spaceId</span><span class="p">,</span> <span class="n">title</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">parentId</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Delete existing whiteboard - cloud only</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">delete_whiteboard</span><span class="p">(</span><span class="n">whiteboard_id</span><span class="p">)</span>

<span class="c1"># Get whiteboard by id  - cloud only!</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_whiteboard</span><span class="p">(</span><span class="n">whiteboard_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="template-actions">
<h2>Template actions<a class="headerlink" href="#template-actions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Updating a content template</span>
<span class="n">template_id</span> <span class="o">=</span> <span class="s2">&quot;&lt;string&gt;&quot;</span>
<span class="n">name</span> <span class="o">=</span> <span class="s2">&quot;&lt;string&gt;&quot;</span>
<span class="n">body</span> <span class="o">=</span> <span class="p">{</span><span class="s2">&quot;value&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;representation&quot;</span><span class="p">:</span> <span class="s2">&quot;view&quot;</span><span class="p">}</span>
<span class="n">template_type</span> <span class="o">=</span> <span class="s2">&quot;page&quot;</span>
<span class="n">description</span> <span class="o">=</span> <span class="s2">&quot;&lt;string&gt;&quot;</span>
<span class="n">labels</span> <span class="o">=</span> <span class="p">[{</span><span class="s2">&quot;prefix&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;name&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;id&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;label&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">}]</span>
<span class="n">space</span> <span class="o">=</span> <span class="s2">&quot;&lt;key_string&gt;&quot;</span>

<span class="n">confluence</span><span class="o">.</span><span class="n">create_or_update_template</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">body</span><span class="p">,</span> <span class="n">template_type</span><span class="p">,</span> <span class="n">template_id</span><span class="p">,</span> <span class="n">description</span><span class="p">,</span> <span class="n">labels</span><span class="p">,</span> <span class="n">space</span><span class="p">)</span>

<span class="c1"># Creating a new content template</span>
<span class="n">name</span> <span class="o">=</span> <span class="s2">&quot;&lt;string&gt;&quot;</span>
<span class="n">body</span> <span class="o">=</span> <span class="p">{</span><span class="s2">&quot;value&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;representation&quot;</span><span class="p">:</span> <span class="s2">&quot;view&quot;</span><span class="p">}</span>
<span class="n">template_type</span> <span class="o">=</span> <span class="s2">&quot;page&quot;</span>
<span class="n">description</span> <span class="o">=</span> <span class="s2">&quot;&lt;string&gt;&quot;</span>
<span class="n">labels</span> <span class="o">=</span> <span class="p">[{</span><span class="s2">&quot;prefix&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;name&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;id&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">,</span> <span class="s2">&quot;label&quot;</span><span class="p">:</span> <span class="s2">&quot;&lt;string&gt;&quot;</span><span class="p">}]</span>
<span class="n">space</span> <span class="o">=</span> <span class="s2">&quot;&lt;key_string&gt;&quot;</span>

<span class="n">confluence</span><span class="o">.</span><span class="n">create_or_update_template</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">body</span><span class="p">,</span> <span class="n">template_type</span><span class="p">,</span> <span class="n">description</span><span class="o">=</span><span class="n">description</span><span class="p">,</span> <span class="n">labels</span><span class="o">=</span><span class="n">labels</span><span class="p">,</span> <span class="n">space</span><span class="o">=</span><span class="n">space</span><span class="p">)</span>

<span class="c1"># Get a template by its ID</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_content_template</span><span class="p">(</span><span class="n">template_id</span><span class="p">)</span>

<span class="c1"># Get all global content templates</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_content_templates</span><span class="p">()</span>

<span class="c1"># Get content templates in a space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_content_templates</span><span class="p">(</span><span class="n">space</span><span class="p">)</span>

<span class="c1"># Get all global blueprint templates</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_blueprint_templates</span><span class="p">()</span>

<span class="c1"># Get all blueprint templates in a space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_blueprint_templates</span><span class="p">(</span><span class="n">space</span><span class="p">)</span>

<span class="c1"># Removing a template</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_template</span><span class="p">(</span><span class="n">template_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="get-spaces-info">
<h2>Get spaces info<a class="headerlink" href="#get-spaces-info" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all spaces with provided limit</span>
<span class="c1"># additional info, e.g. metadata, icon, description, homepage</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_spaces</span><span class="p">(</span><span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get information about a space through space key</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s1">&#39;description.plain,homepage&#39;</span><span class="p">)</span>

<span class="c1"># Get space content (configuring by the expand property)</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_space_content</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">depth</span><span class="o">=</span><span class="s2">&quot;all&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">,</span> <span class="n">content_type</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s2">&quot;body.storage&quot;</span><span class="p">)</span>

<span class="c1"># Get Space permissions set based on json-rpc call</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_space_permissions</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>

<span class="c1"># Get Space export download url</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_space_export</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">export_type</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="space">
<h2>Space<a class="headerlink" href="#space" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Archive the given Space identified by spaceKey.</span>
<span class="c1"># This method is idempotent i.e.,</span>
<span class="c1"># if the Space is already archived then no action will be taken.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">archive_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>

<span class="c1"># Get trash contents of space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_trashed_contents_by_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">cursor</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">100</span><span class="p">)</span>

<span class="c1"># Remove all trash contents of space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_trashed_contents_by_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="get-space-permissions">
<h2>Get space permissions<a class="headerlink" href="#get-space-permissions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Returns list of permissions granted to users and groups in the particular space.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_space_permissions</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>

<span class="c1"># Sets permissions to multiple users/groups in the given space.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_permissions_to_multiple_items_for_space</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">group_name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">operations</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get permissions granted to anonymous user for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_permissions_granted_to_anonymous_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>

<span class="c1"># Grant permissions to anonymous user in the given space.</span>
<span class="c1"># Operation doesn&#39;t override existing permissions</span>
<span class="c1"># will only add those one that weren&#39;t granted before.</span>
<span class="c1"># Multiple permissions could be passed in one request.</span>
<span class="c1"># Supported targetType and operationKey pairs:</span>
<span class="c1">#    space read</span>
<span class="c1">#    space administer</span>
<span class="c1">#    space export</span>
<span class="c1">#    space restrict</span>
<span class="c1">#    space delete_own</span>
<span class="c1">#    space delete_mail</span>
<span class="c1">#    page create</span>
<span class="c1">#    page delete</span>
<span class="c1">#    blogpost create</span>
<span class="c1">#    blogpost delete</span>
<span class="c1">#    comment create</span>
<span class="c1">#    comment delete</span>
<span class="c1">#    attachment create</span>
<span class="c1">#    attachment delete</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_permissions_to_anonymous_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">operations</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove permissions granted to anonymous user for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_permissions_granted_to_anonymous_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">)</span>

<span class="c1"># Get permissions granted to group for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_permissions_granted_to_group_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">)</span>

<span class="c1"># Grant permissions to group in the given space.</span>
<span class="c1"># Operation doesn&#39;t override existing permissions</span>
<span class="c1"># will only add those one that weren&#39;t granted before.</span>
<span class="c1"># Multiple permissions could be passed in one request.</span>
<span class="c1"># Supported targetType and operationKey pairs:</span>
<span class="c1">#    space read</span>
<span class="c1">#    space administer</span>
<span class="c1">#    space export</span>
<span class="c1">#    space restrict</span>
<span class="c1">#    space delete_own</span>
<span class="c1">#    space delete_mail</span>
<span class="c1">#    page create</span>
<span class="c1">#    page delete</span>
<span class="c1">#    blogpost create</span>
<span class="c1">#    blogpost delete</span>
<span class="c1">#    comment create</span>
<span class="c1">#    comment delete</span>
<span class="c1">#    attachment create</span>
<span class="c1">#    attachment delete</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_permissions_to_group_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">,</span> <span class="n">operations</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove permissions granted to group for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_permissions_from_group_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">group_name</span><span class="p">)</span>

<span class="c1"># Get permissions granted to user for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_permissions_granted_to_user_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">)</span>

<span class="c1"># Grant permissions to user in the given space.</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_permissions_to_user_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">,</span> <span class="n">operations</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove permissions granted to user for the given space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_permissions_from_user_for_space</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">)</span>

<span class="c1"># Add permissions to a space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">add_space_permissions</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">,</span> <span class="n">group_name</span><span class="p">,</span> <span class="n">operations</span><span class="p">)</span>

<span class="c1"># Remove permissions from a space</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_space_permissions</span><span class="p">(</span><span class="n">space_key</span><span class="p">,</span> <span class="n">user_key</span><span class="p">,</span> <span class="n">group_name</span><span class="p">,</span> <span class="n">permission</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="users-and-groups">
<h2>Users and Groups<a class="headerlink" href="#users-and-groups" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all groups from Confluence User management</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_all_groups</span><span class="p">(</span><span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">1000</span><span class="p">)</span>

<span class="c1"># Get information about a user through username</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_user_details_by_username</span><span class="p">(</span><span class="n">username</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get information about a user through user key</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_user_details_by_userkey</span><span class="p">(</span><span class="n">userkey</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Change a user&#39;s password</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">change_user_password</span><span class="p">(</span><span class="n">username</span><span class="p">,</span> <span class="n">password</span><span class="p">)</span>

<span class="c1"># Change calling user&#39;s password</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">change_my_password</span><span class="p">(</span><span class="n">oldpass</span><span class="p">,</span> <span class="n">newpass</span><span class="p">)</span>

<span class="c1"># Add given user to a group</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">add_user_to_group</span><span class="p">(</span><span class="n">username</span><span class="p">,</span> <span class="n">group_name</span><span class="p">)</span>

<span class="c1"># Remove given user from a group</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_user_from_group</span><span class="p">(</span><span class="n">username</span><span class="p">,</span> <span class="n">group_name</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="cql">
<h2>CQL<a class="headerlink" href="#cql" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get results from cql search result with all related fields</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">cql</span><span class="p">(</span><span class="n">cql</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">include_archived_spaces</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">excerpt</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="other-actions">
<h2>Other actions<a class="headerlink" href="#other-actions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Clean all caches from cache management</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">clean_all_caches</span><span class="p">()</span>

<span class="c1"># Clean caches from cache management</span>
<span class="c1"># e.g.</span>
<span class="c1"># com.gliffy.cache.gon</span>
<span class="c1"># org.hibernate.cache.internal.StandardQueryCache_v5</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">clean_package_cache</span><span class="p">(</span><span class="n">cache_name</span><span class="o">=</span><span class="s1">&#39;com.gliffy.cache.gon&#39;</span><span class="p">)</span>

<span class="c1"># Convert to Confluence XHTML format from wiki style</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">convert_wiki_to_storage</span><span class="p">(</span><span class="n">wiki</span><span class="p">)</span>

<span class="c1"># Get page history</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">history</span><span class="p">(</span><span class="n">page_id</span><span class="p">)</span>

<span class="c1"># Get content history by version number</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">get_content_history_by_version_number</span><span class="p">(</span><span class="n">content_id</span><span class="p">,</span> <span class="n">version_number</span><span class="p">)</span>

<span class="c1"># Remove content history. It works as experimental method</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">remove_content_history</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">version_number</span><span class="p">)</span>

<span class="c1"># Compare content and check is already updated or not</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">is_page_content_is_already_updated</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">body</span><span class="p">)</span>

<span class="c1"># Add inline task setting checkbox method</span>
<span class="n">confluence</span><span class="o">.</span><span class="n">set_inline_tasks_checkbox</span><span class="p">(</span><span class="n">page_id</span><span class="p">,</span> <span class="n">task_id</span><span class="p">,</span> <span class="n">status</span><span class="p">)</span>
</pre></div>
</div>
</section>
</section>


          </div>
          
        </div>
      </div>
      <div class="sphinxsidebar" role="navigation" aria-label="Main">
        <div class="sphinxsidebarwrapper">
<h1 class="logo"><a href="index.html">Atlassian Python API</a></h1>









<search id="searchbox" style="display: none" role="search">
    <div class="searchformwrapper">
    <form class="search" action="search.html" method="get">
      <input type="text" name="q" aria-labelledby="searchlabel" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" placeholder="Search"/>
      <input type="submit" value="Go" />
    </form>
    </div>
</search>
<script>document.getElementById('searchbox').style.display = "block"</script><h3>Navigation</h3>
<ul class="current">
<li class="toctree-l1"><a class="reference internal" href="jira.html">Jira module</a></li>
<li class="toctree-l1 current"><a class="current reference internal" href="#">Confluence module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="#new-implementation">New Implementation</a></li>
<li class="toctree-l2"><a class="reference internal" href="#cloud-vs-server-differences">Cloud vs Server Differences</a></li>
<li class="toctree-l2"><a class="reference internal" href="#common-operations">Common Operations</a></li>
<li class="toctree-l2"><a class="reference internal" href="#server-specific-features">Server-Specific Features</a></li>
<li class="toctree-l2"><a class="reference internal" href="#legacy-implementation">Legacy Implementation</a></li>
<li class="toctree-l2"><a class="reference internal" href="#get-page-info">Get page info</a></li>
<li class="toctree-l2"><a class="reference internal" href="#page-actions">Page actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="#confluence-whiteboards">Confluence Whiteboards</a></li>
<li class="toctree-l2"><a class="reference internal" href="#template-actions">Template actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="#get-spaces-info">Get spaces info</a></li>
<li class="toctree-l2"><a class="reference internal" href="#space">Space</a></li>
<li class="toctree-l2"><a class="reference internal" href="#get-space-permissions">Get space permissions</a></li>
<li class="toctree-l2"><a class="reference internal" href="#users-and-groups">Users and Groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="#cql">CQL</a></li>
<li class="toctree-l2"><a class="reference internal" href="#other-actions">Other actions</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="crowd.html">Crowd module</a></li>
<li class="toctree-l1"><a class="reference internal" href="bitbucket.html">BitBucket module</a></li>
<li class="toctree-l1"><a class="reference internal" href="bamboo.html">Bamboo module</a></li>
<li class="toctree-l1"><a class="reference internal" href="service_desk.html">Jira Service Desk module</a></li>
<li class="toctree-l1"><a class="reference internal" href="xray.html">Xray module</a></li>
<li class="toctree-l1"><a class="reference internal" href="cloud_admin.html">Cloud Admin module</a></li>
</ul>

<div class="relations">
<h3>Related Topics</h3>
<ul>
  <li><a href="index.html">Documentation overview</a><ul>
      <li>Previous: <a href="jira.html" title="previous chapter">Jira module</a></li>
      <li>Next: <a href="crowd.html" title="next chapter">Crowd module</a></li>
  </ul></li>
</ul>
</div>








        </div>
      </div>
      <div class="clearer"></div>
    </div>
    <div class="footer">
      &#169;APACHE LICENSE, VERSION 2.0.
      
      |
      Powered by <a href="https://www.sphinx-doc.org/">Sphinx 9.1.0</a>
      &amp; <a href="https://alabaster.readthedocs.io">Alabaster 1.0.0</a>
      
      |
      <a href="_sources/confluence.rst.txt"
          rel="nofollow">Page source</a>
    </div>

    

    
  </body>
</html>
```

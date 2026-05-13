---
title: "Atlassian Jira module docs"
token: "5266"
source_link: "https://atlassian-python-api.readthedocs.io/jira.html"
source_links: ["https://atlassian-python-api.readthedocs.io/jira.html", "https://atlassian-python-api.readthedocs.io/_static/pygments.css?v=5ecbeea2", "https://atlassian-python-api.readthedocs.io/_static/basic.css?v=b08954a9", "https://atlassian-python-api.readthedocs.io/_static/alabaster.css?v=27fed22d", "https://atlassian-python-api.readthedocs.io/genindex.html", "https://atlassian-python-api.readthedocs.io/search.html", "https://atlassian-python-api.readthedocs.io/confluence.html", "https://atlassian-python-api.readthedocs.io/index.html", "https://atlassian-python-api.readthedocs.io/_static/custom.css", "https://atlassian-python-api.readthedocs.io/crowd.html", "https://atlassian-python-api.readthedocs.io/bitbucket.html", "https://atlassian-python-api.readthedocs.io/bamboo.html", "https://atlassian-python-api.readthedocs.io/service_desk.html", "https://atlassian-python-api.readthedocs.io/xray.html", "https://atlassian-python-api.readthedocs.io/cloud_admin.html", "https://www.sphinx-doc.org/", "https://alabaster.readthedocs.io", "https://atlassian-python-api.readthedocs.io/_sources/jira.rst.txt"]
topic: "ai-automation"
tags: ["ingest", "web", "source/web", "privacy/public", "fetched", "ai-automation", "atlassian-python-api-readthedocs-io"]
generated_at: "2026-05-13T22:27:55Z"
---

# Atlassian Jira module docs

Source URL: https://atlassian-python-api.readthedocs.io/jira.html
Fetched URL: https://atlassian-python-api.readthedocs.io/jira.html
Content-Type: text/html

## Source Content

```html
<!DOCTYPE html>

<html lang="en" data-content_root="./">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Jira module &#8212; Atlassian Python API 4.0.8 documentation</title>
    <link rel="stylesheet" type="text/css" href="_static/pygments.css?v=5ecbeea2" />
    <link rel="stylesheet" type="text/css" href="_static/basic.css?v=b08954a9" />
    <link rel="stylesheet" type="text/css" href="_static/alabaster.css?v=27fed22d" />
    <script src="_static/documentation_options.js?v=1097caeb"></script>
    <script src="_static/doctools.js?v=fd6eb6e6"></script>
    <script src="_static/sphinx_highlight.js?v=6ffebe34"></script>
    <link rel="index" title="Index" href="genindex.html" />
    <link rel="search" title="Search" href="search.html" />
    <link rel="next" title="Confluence module" href="confluence.html" />
    <link rel="prev" title="Welcome to Atlassian Python API’s documentation!" href="index.html" />
   
  <link rel="stylesheet" href="_static/custom.css" type="text/css" />
  

  
  

  <script async type="text/javascript" src="/_/static/javascript/readthedocs-addons.js"></script><meta name="readthedocs-project-slug" content="atlassian-python-api" /><meta name="readthedocs-version-slug" content="latest" /><meta name="readthedocs-resolver-filename" content="/jira.html" /><meta name="readthedocs-http-status" content="200" /></head><body>
  

    <div class="document">
      <div class="documentwrapper">
        <div class="bodywrapper">
          

          <div class="body" role="main">
            
  <section id="jira-module">
<h1>Jira module<a class="headerlink" href="#jira-module" title="Link to this heading">¶</a></h1>
<section id="get-issues-from-jql-search-result-with-all-related-fields">
<h2>Get issues from jql search result with all related fields<a class="headerlink" href="#get-issues-from-jql-search-result-with-all-related-fields" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="n">jql_request</span> <span class="o">=</span> <span class="s1">&#39;project = DEMO AND status NOT IN (Closed, Resolved) ORDER BY issuekey&#39;</span>
<span class="n">issues</span> <span class="o">=</span> <span class="n">jira</span><span class="o">.</span><span class="n">jql</span><span class="p">(</span><span class="n">jql_request</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">issues</span><span class="p">)</span>

<span class="c1"># Or if dealing with pagination</span>
<span class="n">issues</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">isLast</span> <span class="o">=</span> <span class="kc">False</span>
<span class="n">nextPageToken</span> <span class="o">=</span> <span class="kc">None</span>

<span class="k">while</span> <span class="ow">not</span> <span class="n">isLast</span><span class="p">:</span>
    <span class="n">response</span> <span class="o">=</span> <span class="n">jira</span><span class="o">.</span><span class="n">enhanced_jql</span><span class="p">(</span><span class="n">jql_request</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="s2">&quot;id,summary&quot;</span> <span class="n">nextPageToken</span><span class="o">=</span><span class="n">nextPageToken</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s1">&#39;names&#39;</span><span class="p">)</span>
    <span class="n">issues</span><span class="o">.</span><span class="n">extend</span><span class="p">(</span><span class="n">response</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">&#39;issues&#39;</span><span class="p">))</span>
    <span class="n">isLast</span> <span class="o">=</span> <span class="n">response</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">&#39;isLast&#39;</span><span class="p">)</span>
    <span class="k">if</span> <span class="ow">not</span> <span class="n">isLast</span><span class="p">:</span>
        <span class="n">nextPageToken</span> <span class="o">=</span> <span class="n">response</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">&#39;nextPageToken&#39;</span><span class="p">)</span>

<span class="c1"># Check issues against JQL</span>
<span class="c1"># Checks whether one or more issues would be returned by one or more JQL queries.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">match_jql</span><span class="p">(</span><span class="n">issue_ids</span><span class="p">,</span> <span class="n">jqls</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="reindex-jira">
<h2>Reindex Jira<a class="headerlink" href="#reindex-jira" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Reindexing Jira</span>
<span class="n">jira</span><span class="o">.</span><span class="n">reindex</span><span class="p">()</span>

<span class="c1"># Reindex status</span>
<span class="n">jira</span><span class="o">.</span><span class="n">reindex_status</span><span class="p">()</span>

<span class="c1"># Reindex type</span>
<span class="n">jira</span><span class="o">.</span><span class="n">reindex_with_type</span><span class="p">(</span><span class="n">indexing_type</span><span class="o">=</span><span class="s2">&quot;BACKGROUND_PREFERRED&quot;</span><span class="p">)</span>
<span class="sd">&quot;&quot;&quot;</span>
<span class="sd">FOREGROUND - runs a lock/full reindexing</span>
<span class="sd">BACKGROUND - runs a background reindexing.</span>
<span class="sd">             If JIRA fails to finish the background reindexing, respond with 409 Conflict (error message).</span>
<span class="sd">BACKGROUND_PREFERRED  - If possible do a background reindexing.</span>
<span class="sd">                        If it&#39;s not possible (due to an inconsistent index), do a foreground reindexing.</span>
<span class="sd">&quot;&quot;&quot;</span>
</pre></div>
</div>
</section>
<section id="manage-permissions">
<h2>Manage Permissions<a class="headerlink" href="#manage-permissions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get permissions</span>
<span class="n">jira</span><span class="o">.</span><span class="n">permissions</span><span class="p">(</span><span class="n">permissions</span><span class="p">,</span> <span class="n">project_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">project_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">issue_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">issue_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,)</span>

<span class="c1"># Get all permissions</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_permissions</span><span class="p">()</span>
</pre></div>
</div>
</section>
<section id="application-properties">
<h2>Application properties<a class="headerlink" href="#application-properties" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get an application property</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_property</span><span class="p">(</span><span class="n">key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">permission_level</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">key_filter</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Set an application property</span>
<span class="n">jira</span><span class="o">.</span><span class="n">set_property</span><span class="p">(</span><span class="n">property_id</span><span class="p">,</span> <span class="n">value</span><span class="p">)</span>

<span class="c1"># Returns the properties that are displayed on the &quot;General Configuration &gt; Advanced Settings&quot; page.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_advanced_settings</span><span class="p">()</span>
</pre></div>
</div>
</section>
<section id="manage-users">
<h2>Manage users<a class="headerlink" href="#manage-users" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get myself</span>
<span class="n">jira</span><span class="o">.</span><span class="n">myself</span><span class="p">()</span>

<span class="c1"># Get user</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user</span><span class="p">(</span><span class="n">account_id</span><span class="p">)</span>

<span class="c1"># Remove user</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_remove</span><span class="p">(</span><span class="n">username</span><span class="p">)</span>

<span class="c1"># Deactivate user. Works from 8.3.0 release</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_deactivate</span><span class="p">(</span><span class="n">username</span><span class="p">)</span>

<span class="c1"># Get web sudo cookies using normal http request</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_get_websudo</span><span class="p">()</span>

<span class="c1"># Fuzzy search using emailAddress or displayName for Jira Cloud</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">query</span><span class="o">=</span><span class="s2">&quot;a.user@example.com&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">include_inactive_users</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">query</span><span class="o">=</span><span class="s2">&quot;a.user&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">include_inactive_users</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">query</span><span class="o">=</span><span class="s2">&quot;a user&quot;</span><span class="p">)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">account_id</span><span class="o">=</span><span class="s2">&quot;a-users-account-id&quot;</span><span class="p">)</span>
<span class="c1"># for DC edition</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">username</span><span class="o">=</span><span class="s2">&quot;a.user&quot;</span><span class="p">)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">username</span><span class="o">=</span><span class="s2">&quot;a user&quot;</span><span class="p">)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">user_find_by_user_string</span><span class="p">(</span><span class="n">username</span><span class="o">=</span><span class="s2">&quot;a&quot;</span><span class="p">)</span>

<span class="c1"># Get groups of a user. This API is only available for Jira Cloud platform.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_user_groups</span><span class="p">(</span><span class="n">account_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-groups">
<h2>Manage groups<a class="headerlink" href="#manage-groups" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Create a group</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_group</span><span class="p">(</span><span class="n">name</span><span class="p">)</span>

<span class="c1"># Delete a group</span>
<span class="c1"># If you delete a group and content is restricted to that group, the content will be hidden from all users</span>
<span class="c1"># To prevent this, use this parameter to specify a different group to transfer the restrictions</span>
<span class="c1"># (comments and worklogs only) to</span>
<span class="n">jira</span><span class="o">.</span><span class="n">remove_group</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">swap_group</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get all users from group</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_users_from_group</span><span class="p">(</span><span class="n">group</span><span class="p">,</span> <span class="n">include_inactive_users</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

<span class="c1"># Add given user to a group</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_user_to_group</span><span class="p">(</span><span class="n">username</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">group_name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">account_id</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Remove given user from a group</span>
<span class="n">jira</span><span class="o">.</span><span class="n">remove_user_from_group</span><span class="p">(</span><span class="n">username</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">group_name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">account_id</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-projects">
<h2>Manage projects<a class="headerlink" href="#manage-projects" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all projects</span>
<span class="c1"># Returns all projects which are visible for the currently logged in user.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">projects</span><span class="p">(</span><span class="n">included_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get all project alternative call</span>
<span class="c1"># Returns all projects which are visible for the currently logged in user.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_projects</span><span class="p">(</span><span class="n">included_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get all projects only for Jira Cloud</span>
<span class="c1"># Returns all projects which are visible for the currently logged in user.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">projects_from_cloud</span><span class="p">(</span><span class="n">included_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get one page of projects</span>
<span class="c1"># Returns a paginated list of projects visible for the currently logged in user.</span>
<span class="c1"># Use the url formatting to get a specific page as shown here:</span>
<span class="c1"># url = f&quot;{self.resource_url(&quot;project/search&quot;)}?startAt={start_at}&amp;maxResults={max_results}&quot;</span>
<span class="c1"># Defaults to the first page, which returns a nextPage url when available.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">projects_paginated</span><span class="p">(</span><span class="n">included_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">url</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get all projects only for Jira Server</span>
<span class="c1"># Returns all projects which are visible for the currently logged in user.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">projects_from_server</span><span class="p">(</span><span class="n">included_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Delete project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_project</span><span class="p">(</span><span class="n">key</span><span class="p">)</span>

<span class="c1"># Archive Project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">archive_project</span><span class="p">(</span><span class="n">key</span><span class="p">)</span>

<span class="c1"># Get project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">project</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get project info</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get project components using project key</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_components</span><span class="p">(</span><span class="n">key</span><span class="p">)</span>

<span class="c1"># Get a full representation of a the specified project&#39;s versions</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_versions</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Returns all versions for the specified project. Results are paginated.</span>
<span class="c1"># Results can be ordered by the following fields: sequence, name, startDate, releaseDate.</span>
<span class="c1"># Results can be filtered by the following fields: query, status.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_versions_paginated</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">order_by</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">query</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">status</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Add missing version to project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_version</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">project_id</span><span class="p">,</span> <span class="n">version</span><span class="p">,</span> <span class="n">is_archived</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">is_released</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Update an existing version</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_version</span><span class="p">(</span><span class="n">version</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">description</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">is_archived</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">is_released</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start_date</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">release_date</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get project leaders</span>
<span class="n">jira</span><span class="o">.</span><span class="n">project_leaders</span><span class="p">()</span>

<span class="c1"># Get last project issuekey</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_issuekey_last</span><span class="p">(</span><span class="n">project</span><span class="p">)</span>

<span class="c1"># Get all project issue keys.</span>
<span class="c1"># JIRA Cloud API can return up to  100 results  in one API call.</span>
<span class="c1"># If your project has more than 100 issues see following community discussion:</span>
<span class="c1"># https://community.atlassian.com/t5/Jira-Software-questions/Is-there-a-limit-to-the-number-of-quot-items-quot-returned-from/qaq-p/1317195</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_issuekey_all</span><span class="p">(</span><span class="n">project</span><span class="p">)</span>

<span class="c1"># Get project issues count</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_issues_count</span><span class="p">(</span><span class="n">project</span><span class="p">)</span>

<span class="c1"># Get all project issues</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_project_issues</span><span class="p">(</span><span class="n">project</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="s1">&#39;*all&#39;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">500</span><span class="p">)</span>

<span class="c1"># Get all assignable users for project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_assignable_users_for_project</span><span class="p">(</span><span class="n">project_key</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

<span class="c1"># Update a project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_project</span><span class="p">(</span><span class="n">project_key</span><span class="p">,</span> <span class="n">data</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s1">&#39;lead,description&#39;</span><span class="p">)</span>

<span class="c1"># Get project permission scheme</span>
<span class="c1"># Use &#39;expand&#39; to get details (default is None)</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_permission_scheme</span><span class="p">(</span><span class="n">project_id_or_key</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s1">&#39;permissions,user,group,projectRole,field,all&#39;</span><span class="p">)</span>

<span class="c1"># Get the issue security scheme for project.</span>
<span class="c1"># Returned if the user has the administrator permission or if the scheme is used in a project in which the</span>
<span class="c1"># user has the administrative permission.</span>
<span class="c1"># Use only_levels=True for get the only levels entries</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_project_issue_security_scheme</span><span class="p">(</span><span class="n">project_id_or_key</span><span class="p">,</span> <span class="n">only_levels</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Resource for associating notification schemes and projects.</span>
<span class="c1"># Gets a notification scheme associated with the project.</span>
<span class="c1"># Follow the documentation of /notificationscheme/{id} resource for all details about returned value.</span>
<span class="c1"># Use &#39;expand&#39; to get details (default is None)  possible values are notificationSchemeEvents,user,group,projectRole,field,all</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_priority_scheme_of_project</span><span class="p">(</span><span class="n">project_key_or_id</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Returns a list of active users who have browse permission for a project that matches the search string for username.</span>
<span class="c1"># Using &quot; &quot; string (space) for username gives All the active users who have browse permission for a project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_users_with_browse_permission_to_a_project</span><span class="p">(</span><span class="n">username</span><span class="p">,</span> <span class="n">issue_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">project_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">100</span><span class="p">)</span>

<span class="c1"># Get existing custom fields or find by filter</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_custom_fields</span><span class="p">(</span><span class="n">search</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">):</span>

<span class="c1"># Returns a full representation of a Custom Field Option that has the given id.</span>
<span class="n">option_id</span> <span class="o">=</span> <span class="mi">10001</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_custom_field_option</span><span class="p">(</span><span class="n">option_id</span><span class="p">)</span>

<span class="c1"># Returns full list of Custom Field Options in a specified project.</span>
<span class="n">field_id</span> <span class="o">=</span> <span class="mi">10000</span>
<span class="n">project_id</span> <span class="o">=</span> <span class="mi">1234</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_custom_field_options</span><span class="p">(</span><span class="n">field_id</span><span class="p">,</span> <span class="n">project_id</span><span class="p">,</span> <span class="n">issue_type_id</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-issues">
<h2>Manage issues<a class="headerlink" href="#manage-issues" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get issue by key</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue</span><span class="p">(</span><span class="n">key</span><span class="p">)</span>

<span class="c1"># Get issue field value</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_field_value</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">field</span><span class="p">)</span>

<span class="c1"># Update issue field</span>
<span class="n">fields</span> <span class="o">=</span> <span class="p">{</span><span class="s1">&#39;summary&#39;</span><span class="p">:</span> <span class="s1">&#39;New summary&#39;</span><span class="p">}</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_issue_field</span><span class="p">(</span><span class="n">key</span><span class="p">,</span> <span class="n">fields</span><span class="p">,</span> <span class="n">notify_users</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="c1"># Bulk update issue field</span>
<span class="n">jira</span><span class="o">.</span><span class="n">bulk_update_issue_field</span><span class="p">(</span><span class="n">key_list</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="s2">&quot;*all&quot;</span><span class="p">)</span>

<span class="c1"># Append value to issue field</span>
<span class="n">field</span> <span class="o">=</span> <span class="s2">&quot;customfield_10000&quot;</span>
<span class="n">value</span> <span class="o">=</span> <span class="p">{</span><span class="s2">&quot;name&quot;</span><span class="p">:</span> <span class="s2">&quot;username&quot;</span><span class="p">}</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_field_value_append</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">,</span> <span class="n">field</span><span class="p">,</span> <span class="n">value</span><span class="p">,</span> <span class="n">notify_users</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="c1"># Check issue exists</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_exists</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Check issue deleted</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_deleted</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Update issue fields and history metadata</span>
<span class="n">issue_key</span><span class="o">=</span><span class="s2">&quot;PROJECT-123&quot;</span><span class="p">,</span>
<span class="n">fields</span><span class="o">=</span><span class="p">{</span><span class="s2">&quot;summary&quot;</span><span class="p">:</span> <span class="s2">&quot;Updated summary&quot;</span><span class="p">,</span> <span class="s2">&quot;priority&quot;</span><span class="p">:</span> <span class="p">{</span><span class="s2">&quot;id&quot;</span><span class="p">:</span> <span class="s2">&quot;2&quot;</span><span class="p">}},</span>
<span class="n">update</span><span class="o">=</span><span class="p">{</span>
    <span class="s2">&quot;labels&quot;</span><span class="p">:</span> <span class="p">[{</span><span class="s2">&quot;add&quot;</span><span class="p">:</span> <span class="s2">&quot;triaged&quot;</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;remove&quot;</span><span class="p">:</span> <span class="s2">&quot;blocker&quot;</span><span class="p">}],</span>
    <span class="s2">&quot;timetracking&quot;</span><span class="p">:</span> <span class="p">[{</span><span class="s2">&quot;edit&quot;</span><span class="p">:</span> <span class="p">{</span><span class="s2">&quot;originalEstimate&quot;</span><span class="p">:</span> <span class="s2">&quot;2d&quot;</span><span class="p">,</span> <span class="s2">&quot;remainingEstimate&quot;</span><span class="p">:</span> <span class="s2">&quot;1d&quot;</span><span class="p">}}]</span>
<span class="p">},</span>
<span class="n">history_metadata</span><span class="o">=</span><span class="p">{</span>
    <span class="s2">&quot;activityDescription&quot;</span><span class="p">:</span> <span class="s2">&quot;Updated via API&quot;</span><span class="p">,</span>
    <span class="s2">&quot;actor&quot;</span><span class="p">:</span> <span class="p">{</span><span class="s2">&quot;id&quot;</span><span class="p">:</span> <span class="s2">&quot;user123&quot;</span><span class="p">,</span> <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;application-user&quot;</span><span class="p">},</span>
    <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;custom-update&quot;</span>
<span class="p">},</span>
<span class="n">properties</span><span class="o">=</span><span class="p">[</span>
    <span class="p">{</span><span class="s2">&quot;key&quot;</span><span class="p">:</span> <span class="s2">&quot;customKey1&quot;</span><span class="p">,</span> <span class="s2">&quot;value&quot;</span><span class="p">:</span> <span class="s2">&quot;Custom Value 1&quot;</span><span class="p">}</span>
<span class="p">]</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_update</span><span class="p">(</span><span class="n">issue_key</span><span class="p">:</span> <span class="nb">str</span><span class="p">,</span> <span class="n">fields</span><span class="p">:</span> <span class="n">Union</span><span class="p">[</span><span class="nb">str</span><span class="p">,</span> <span class="nb">dict</span><span class="p">],</span> <span class="n">update</span><span class="p">:</span> <span class="nb">dict</span> <span class="o">=</span> <span class="kc">None</span><span class="p">,</span> <span class="n">history_metadata</span><span class="p">:</span> <span class="nb">dict</span> <span class="o">=</span> <span class="kc">None</span><span class="p">,</span> <span class="n">properties</span><span class="p">:</span> <span class="nb">list</span> <span class="o">=</span> <span class="kc">None</span><span class="p">,</span> <span class="n">notify_users</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span><span class="p">)</span>

<span class="c1"># Assign issue to user</span>
<span class="n">jira</span><span class="o">.</span><span class="n">assign_issue</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">account_id</span><span class="p">)</span>

<span class="c1"># Create issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_create</span><span class="p">(</span><span class="n">fields</span><span class="p">)</span>

<span class="c1"># Issue create or update</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_create_or_update</span><span class="p">(</span><span class="n">fields</span><span class="p">)</span>

<span class="c1"># Get issue transitions</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_transitions</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Get issue status change log</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_status_changelog</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Get status ID from name</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_status_id_from_name</span><span class="p">(</span><span class="n">status_name</span><span class="p">)</span>

<span class="c1"># Get transition id to status name</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_transition_id_to_status_name</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">status_name</span><span class="p">)</span>

<span class="c1"># Transition issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_transition</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">status</span><span class="p">)</span>

<span class="c1"># Set issue status</span>
<span class="n">jira</span><span class="o">.</span><span class="n">set_issue_status</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">status_name</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Set issue status by transition_id</span>
<span class="n">jira</span><span class="o">.</span><span class="n">set_issue_status_by_transition_id</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">transition_id</span><span class="p">)</span>

<span class="c1"># Get issue status</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_status</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Get Issue Link</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_link</span><span class="p">(</span><span class="n">link_id</span><span class="p">)</span>

<span class="c1"># Get Issue Edit Meta</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_editmeta</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Creates an issue or a sub-task from a JSON representation</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_issue</span><span class="p">(</span><span class="n">fields</span><span class="p">,</span> <span class="n">update_history</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">history</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
<span class="n">example</span><span class="p">:</span>
            <span class="n">fields</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">(</span><span class="n">summary</span><span class="o">=</span><span class="s1">&#39;Into The Night&#39;</span><span class="p">,</span>
                          <span class="n">project</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">(</span><span class="n">key</span><span class="o">=</span><span class="s1">&#39;APA&#39;</span><span class="p">),</span>
                          <span class="n">issuetype</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">(</span><span class="n">name</span><span class="o">=</span><span class="s1">&#39;Story&#39;</span><span class="p">)</span>
                          <span class="p">)</span>
            <span class="n">update</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">(</span><span class="n">issuelinks</span><span class="o">=</span><span class="p">{</span>
                <span class="s2">&quot;add&quot;</span><span class="p">:</span> <span class="p">{</span>
                    <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="p">{</span>
                        <span class="s2">&quot;name&quot;</span><span class="p">:</span> <span class="s2">&quot;Child-Issue&quot;</span>
                        <span class="p">},</span>
                    <span class="s2">&quot;inwardIssue&quot;</span><span class="p">:</span> <span class="p">{</span>
                        <span class="s2">&quot;key&quot;</span><span class="p">:</span> <span class="s2">&quot;ISSUE-KEY&quot;</span>
                        <span class="p">}</span>
                    <span class="p">}</span>
                <span class="p">}</span>
            <span class="p">)</span>
            <span class="n">jira</span><span class="o">.</span><span class="n">create_issue</span><span class="p">(</span><span class="n">fields</span><span class="o">=</span><span class="n">fields</span><span class="p">,</span> <span class="n">update</span><span class="o">=</span><span class="n">update</span><span class="p">)</span>

<span class="c1"># Get issue create meta, deprecated on Cloud and from Jira 9.0</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_createmeta</span><span class="p">(</span><span class="n">project</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s2">&quot;projects.issuetypes.fields&quot;</span><span class="p">)</span>

<span class="c1"># Get create metadata issue types for a project</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_createmeta_issuetypes</span><span class="p">(</span><span class="n">project</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Get create field metadata for a project and issue type id</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_createmeta_fieldtypes</span><span class="p">(</span><span class="n">project</span><span class="p">,</span> <span class="n">issue_type_id</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Create Issue Link</span>
<span class="n">data</span> <span class="o">=</span> <span class="p">{</span>
        <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="p">{</span><span class="s2">&quot;name&quot;</span><span class="p">:</span> <span class="s2">&quot;Duplicate&quot;</span> <span class="p">},</span>
        <span class="s2">&quot;inwardIssue&quot;</span><span class="p">:</span> <span class="p">{</span> <span class="s2">&quot;key&quot;</span><span class="p">:</span> <span class="s2">&quot;HSP-1&quot;</span><span class="p">},</span>
        <span class="s2">&quot;outwardIssue&quot;</span><span class="p">:</span> <span class="p">{</span><span class="s2">&quot;key&quot;</span><span class="p">:</span> <span class="s2">&quot;MKY-1&quot;</span><span class="p">},</span>
        <span class="s2">&quot;comment&quot;</span><span class="p">:</span> <span class="p">{</span> <span class="s2">&quot;body&quot;</span><span class="p">:</span> <span class="s2">&quot;Linked related issue!&quot;</span><span class="p">,</span>
                     <span class="s2">&quot;visibility&quot;</span><span class="p">:</span> <span class="p">{</span> <span class="s2">&quot;type&quot;</span><span class="p">:</span> <span class="s2">&quot;group&quot;</span><span class="p">,</span> <span class="s2">&quot;value&quot;</span><span class="p">:</span> <span class="s2">&quot;jira-software-users&quot;</span> <span class="p">}</span>
        <span class="p">}</span>
<span class="p">}</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_issue_link</span><span class="p">(</span><span class="n">data</span><span class="p">)</span>

<span class="c1"># Remove Issue Link</span>
<span class="n">jira</span><span class="o">.</span><span class="n">remove_issue_link</span><span class="p">(</span><span class="n">link_id</span><span class="p">)</span>

<span class="c1"># Create or Update Issue Remote Links</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_or_update_issue_remote_links</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">link_url</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">global_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">relationship</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">icon_url</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">icon_title</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">status_resolved</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Get Issue Remote Link by link ID</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_remote_link_by_id</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">link_id</span><span class="p">)</span>

<span class="c1"># Update Issue Remote Link by link ID</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_issue_remote_link_by_id</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">link_id</span><span class="p">,</span> <span class="n">url</span><span class="p">,</span> <span class="n">title</span><span class="p">,</span> <span class="n">global_id</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">relationship</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

<span class="c1"># Delete Issue Remote Links</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_issue_remote_link_by_id</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">link_id</span><span class="p">)</span>

<span class="c1"># Export Issues to csv</span>
<span class="n">jira</span><span class="o">.</span><span class="n">csv</span><span class="p">(</span><span class="n">jql</span><span class="p">,</span> <span class="n">all_fields</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>

<span class="c1"># Add watcher to an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_add_watcher</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">user</span><span class="p">)</span>

<span class="c1"># Remove watcher from an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_delete_watcher</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">user</span><span class="p">)</span>

<span class="c1"># Get watchers for an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_get_watchers</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Archive an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_archive</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">)</span>

<span class="c1"># Restore an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_restore</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">)</span>

<span class="c1"># Add Comments</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_add_comment</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">,</span> <span class="s2">&quot;This is a sample comment string.&quot;</span><span class="p">)</span>

<span class="c1"># Edit Comments</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_edit_comment</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">comment_id</span><span class="p">,</span> <span class="n">comment</span><span class="p">,</span> <span class="n">visibility</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">notify_users</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="c1"># Issue Comments</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_get_comments</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">)</span>

<span class="c1"># Get issue comment by id</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_get_comment</span><span class="p">(</span><span class="n">issue_id_or_key</span><span class="p">,</span> <span class="n">comment_id</span><span class="p">)</span>

<span class="c1"># Get comments over all issues by ids</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issues_get_comments_by_id</span><span class="p">(</span><span class="n">comment_id</span><span class="p">,</span> <span class="p">[</span><span class="n">comment_id</span><span class="o">...</span><span class="p">])</span>

<span class="c1"># Get change history for an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_changelog</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Get property keys from an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_property_keys</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Set issue property</span>
<span class="n">data</span> <span class="o">=</span> <span class="p">{</span> <span class="s2">&quot;Foo&quot;</span><span class="p">:</span> <span class="s2">&quot;Bar&quot;</span> <span class="p">}</span>
<span class="n">jira</span><span class="o">.</span><span class="n">set_issue_property</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">property_key</span><span class="p">,</span> <span class="n">data</span><span class="p">)</span>

<span class="c1"># Get issue property</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_property</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">property_key</span><span class="p">)</span>

<span class="c1"># Delete issue property</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_issue_property</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">property_key</span><span class="p">)</span>

<span class="c1"># Get worklog for an issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_get_worklog</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>

<span class="c1"># Create a new worklog entry for an issue</span>
<span class="c1"># started is a date string in the format %Y-%m-%dT%H:%M:%S.000+0000%z</span>
<span class="n">jira</span><span class="o">.</span><span class="n">issue_worklog</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">started</span><span class="p">,</span> <span class="n">time_in_sec</span><span class="p">)</span>

<span class="c1"># Scrap regex matches from issue description and comments:</span>
<span class="n">jira</span><span class="o">.</span><span class="n">scrap_regex_from_issue</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">regex</span><span class="p">)</span>

<span class="c1"># Get a list that contains the tree structure of the root issue, with all subtasks and inward linked issues.</span>
<span class="c1"># (!) Function only returns child issues from the same Jira instance or from an instance to which the API key has access.</span>
<span class="c1"># :param issue_key: Jira issue key</span>
<span class="c1"># :param tree: list to store the tree structure for recursion. Do not change it.</span>
<span class="c1"># :param depth: current depth of the tree for recursion. Do not change it.</span>
<span class="c1"># :return: list of dictionaries containing the tree structure. Dictionary element contains a key (parent issue) and value (child issue).</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_tree_recursive</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">tree</span><span class="o">=</span><span class="p">[],</span> <span class="n">depth</span><span class="o">=</span><span class="mi">0</span><span class="p">)</span>

<span class="c1"># Returns full information about visible fields that can be autocompleted in JQL.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_autocomplete_data</span><span class="p">()</span>

<span class="c1"># Returns auto complete suggestions for JQL search.</span>
<span class="n">field_name</span> <span class="o">=</span> <span class="s2">&quot;Custom Field&quot;</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_autocomplete_suggestion</span><span class="p">(</span><span class="n">field_name</span><span class="p">,</span> <span class="n">field_value</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">predicate_name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">predicate_value</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="epic-issues">
<h2>Epic Issues<a class="headerlink" href="#epic-issues" title="Link to this heading">¶</a></h2>
<p><em>Uses the Jira Agile API</em></p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Move issues to backlog</span>
<span class="n">jira</span><span class="o">.</span><span class="n">move_issues_to_backlog</span><span class="p">(</span><span class="n">issue_keys</span><span class="p">)</span>

<span class="c1"># Add issues to backlog</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_issues_to_backlog</span><span class="p">(</span><span class="n">issue_keys</span><span class="p">)</span>

<span class="c1"># Get agile board by filter id</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board_by_filter_id</span><span class="p">(</span><span class="n">filter_id</span><span class="p">)</span>

<span class="c1"># Issues within an Epic</span>
<span class="n">jira</span><span class="o">.</span><span class="n">epic_issues</span><span class="p">(</span><span class="n">epic_key</span><span class="p">)</span>

<span class="c1"># Returns all epics from the board, for the given board Id.</span>
<span class="c1"># This only includes epics that the user has permission to view.</span>
<span class="c1"># Note, if the user does not have permission to view the board, no epics will be returned at all.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_epics</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">done</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="p">)</span>

<span class="c1"># Returns all issues that belong to an epic on the board,</span>
<span class="c1"># for the given epic Id and the board Id.</span>
<span class="c1"># This only includes issues that the user has permission to view.</span>
<span class="c1"># Issues returned from this resource include Agile fields, like sprint, closedSprints, flagged, and epic.</span>
<span class="c1"># By default, the returned issues are ordered by rank.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issues_for_epic</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">epic_id</span><span class="p">,</span> <span class="n">jql</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span> <span class="n">validate_query</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="s2">&quot;*all&quot;</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-boards">
<h2>Manage Boards<a class="headerlink" href="#manage-boards" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Board</span>
 <span class="c1"># Creates a new board. Board name, type and filter Id is required.</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">create_agile_board</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="nb">type</span><span class="p">,</span> <span class="n">filter_id</span><span class="p">,</span> <span class="n">location</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

 <span class="c1"># Returns all boards.</span>
 <span class="c1"># This only includes boards that the user has permission to view.</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_all_agile_boards</span><span class="p">(</span><span class="n">board_name</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">project_key</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">board_type</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

 <span class="c1"># Delete agile board by id</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">delete_agile_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">)</span>

 <span class="c1"># Get agile board by id</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">)</span>

 <span class="c1"># Get issues for backlog</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_issues_for_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">start_at</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">max_results</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">jql</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span>
                           <span class="n">validate_query</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span>
                           <span class="n">override_screen_security</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">override_editable_flag</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

 <span class="c1"># Get issues for board</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_issues_for_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">jql</span><span class="p">,</span> <span class="n">fields</span><span class="o">=</span><span class="s2">&quot;*all&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">expand</span><span class="o">=</span><span class="kc">None</span><span class="p">)</span>

 <span class="c1"># Get agile board configuration by board id</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board_configuration</span><span class="p">(</span><span class="n">board_id</span><span class="p">)</span>

 <span class="c1"># Gets a list of all the board properties</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board_properties</span><span class="p">(</span><span class="n">board_id</span><span class="p">)</span>

 <span class="c1"># Sets the value of the specified board&#39;s property.</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">set_agile_board_property</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">property_key</span><span class="p">)</span>

 <span class="c1"># Get Agile board property</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board_property</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">property_key</span><span class="p">)</span>

 <span class="c1"># Delete Agile board property</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">delete_agile_board_property</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">property_key</span><span class="p">)</span>

 <span class="c1"># Get Agile board refined velocity</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">get_agile_board_refined_velocity</span><span class="p">(</span><span class="n">board_id</span><span class="p">)</span>

 <span class="c1"># Set Agile board refined velocity</span>
 <span class="n">jira</span><span class="o">.</span><span class="n">set_agile_board_refined_velocity</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">refined_velocity</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-sprints">
<h2>Manage Sprints<a class="headerlink" href="#manage-sprints" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all sprints from board</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_sprints_from_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

<span class="c1"># Get all issues for sprint in board</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_issues_for_sprint_in_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

<span class="c1"># Get all versions for sprint in board</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_all_versions_from_board</span><span class="p">(</span><span class="n">board_id</span><span class="p">,</span> <span class="n">released</span><span class="o">=</span><span class="s2">&quot;true&quot;</span><span class="p">,</span> <span class="n">start</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">limit</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span>

<span class="c1"># Create sprint</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_sprint</span><span class="p">(</span><span class="n">sprint_name</span><span class="p">,</span> <span class="n">origin_board_id</span><span class="p">,</span>  <span class="n">start_datetime</span><span class="p">,</span> <span class="n">end_datetime</span><span class="p">,</span> <span class="n">goal</span><span class="p">)</span>

<span class="c1"># Rename sprint</span>
<span class="n">jira</span><span class="o">.</span><span class="n">rename_sprint</span><span class="p">(</span><span class="n">sprint_id</span><span class="p">,</span> <span class="n">name</span><span class="p">,</span> <span class="n">start_date</span><span class="p">,</span> <span class="n">end_date</span><span class="p">)</span>

<span class="c1"># Add/Move Issues to sprint</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_issues_to_sprint</span><span class="p">(</span><span class="n">sprint_id</span><span class="p">,</span> <span class="n">issues_list</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-dashboards">
<h2>Manage dashboards<a class="headerlink" href="#manage-dashboards" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get dashboard by ID</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_dashboard</span><span class="p">(</span><span class="n">dashboard_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="attachments-actions">
<h2>Attachments actions<a class="headerlink" href="#attachments-actions" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Add attachment to issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_attachment</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">filename</span><span class="p">)</span>

<span class="c1"># Add attachment (IO Object) to issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">add_attachment_object</span><span class="p">(</span><span class="n">issue_key</span><span class="p">,</span> <span class="n">attachment</span><span class="p">)</span>

<span class="c1"># Download attachments from the issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">download_attachments_from_issue</span><span class="p">(</span><span class="n">issue</span><span class="p">,</span> <span class="n">path</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">):</span>

<span class="c1"># Get list of attachments ids from issue</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_attachments_ids_from_issue</span><span class="p">(</span><span class="n">issue_key</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="manage-components">
<h2>Manage components<a class="headerlink" href="#manage-components" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get component</span>
<span class="n">jira</span><span class="o">.</span><span class="n">component</span><span class="p">(</span><span class="n">component_id</span><span class="p">)</span>

<span class="c1"># Create component</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_component</span><span class="p">(</span><span class="n">component</span><span class="p">)</span>

<span class="c1"># Update component</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_component</span><span class="p">(</span><span class="n">component</span><span class="p">,</span> <span class="n">component_id</span><span class="p">)</span>

<span class="c1"># Delete component</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_component</span><span class="p">(</span><span class="n">component_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="upload-jira-plugin">
<h2>Upload Jira plugin<a class="headerlink" href="#upload-jira-plugin" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="n">upload_plugin</span><span class="p">(</span><span class="n">plugin_path</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="issue-link-types">
<h2>Issue link types<a class="headerlink" href="#issue-link-types" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get Issue link types</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_link_types</span><span class="p">():</span>

<span class="c1"># Create Issue link types</span>
<span class="n">jira</span><span class="o">.</span><span class="n">create_issue_link_type</span><span class="p">(</span><span class="n">data</span><span class="p">):</span>
<span class="sd">&quot;&quot;&quot;Create a new issue link type.</span>
<span class="sd">    :param data:</span>
<span class="sd">            {</span>
<span class="sd">                &quot;name&quot;: &quot;Duplicate&quot;,</span>
<span class="sd">                &quot;inward&quot;: &quot;Duplicated by&quot;,</span>
<span class="sd">                &quot;outward&quot;: &quot;Duplicates&quot;</span>
<span class="sd">            }</span>
<span class="sd">&quot;&quot;&quot;</span>

<span class="c1"># Get issue link type by id</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_link_type</span><span class="p">(</span><span class="n">issue_link_type_id</span><span class="p">):</span>

<span class="c1"># Delete issue link type</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_issue_link_type</span><span class="p">(</span><span class="n">issue_link_type_id</span><span class="p">):</span>

<span class="c1"># Update issue link type</span>
<span class="n">jira</span><span class="o">.</span><span class="n">update_issue_link_type</span><span class="p">(</span><span class="n">issue_link_type_id</span><span class="p">,</span> <span class="n">data</span><span class="p">):</span>
</pre></div>
</div>
</section>
<section id="issue-security-schemes">
<h2>Issue security schemes<a class="headerlink" href="#issue-security-schemes" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all security schemes.</span>
<span class="c1"># Returned if the user has the administrator permission or if the scheme is used in a project in which the</span>
<span class="c1"># user has the administrative permission.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_security_schemes</span><span class="p">()</span>

<span class="c1"># Get issue security scheme.</span>
<span class="c1"># Returned if the user has the administrator permission or if the scheme is used in a project in which the</span>
<span class="c1"># user has the administrative permission.</span>
<span class="c1"># Use only_levels=True for get the only levels entries</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_issue_security_scheme</span><span class="p">(</span><span class="n">scheme_id</span><span class="p">,</span> <span class="n">only_levels</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="cluster-methods-only-for-dc-edition">
<h2>Cluster methods (only for DC edition)<a class="headerlink" href="#cluster-methods-only-for-dc-edition" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get all cluster nodes.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_cluster_all_nodes</span><span class="p">()</span>

<span class="c1"># Request current index from node (the request is processed asynchronously).</span>
<span class="n">jira</span><span class="o">.</span><span class="n">request_current_index_from_node</span><span class="p">(</span><span class="n">node_id</span><span class="p">)</span>

<span class="c1"># Get cluster nodes where alive = True</span>
<span class="n">jira</span><span class="o">.</span><span class="n">get_cluster_alive_nodes</span><span class="p">()</span>

<span class="c1"># Change the node&#39;s state to offline if the node is reporting as active, but is not alive</span>
<span class="n">jira</span><span class="o">.</span><span class="n">set_node_to_offline</span><span class="p">(</span><span class="n">node_id</span><span class="p">)</span>

<span class="c1">#  Delete the node from the cluster if state of node is OFFLINE</span>
<span class="n">jira</span><span class="o">.</span><span class="n">delete_cluster_node</span><span class="p">(</span><span class="n">node_id</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="health-checks-methods-only-for-on-prem-edition">
<h2>Health checks methods (only for on-prem edition)<a class="headerlink" href="#health-checks-methods-only-for-on-prem-edition" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Get health status of Jira.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">health_check</span><span class="p">()</span>

<span class="c1"># Health check: Duplicate user accounts detail</span>
<span class="n">jira</span><span class="o">.</span><span class="n">duplicated_account_checks_detail</span><span class="p">()</span>

<span class="c1"># Health check: Duplicate user accounts by flush</span>
<span class="n">jira</span><span class="o">.</span><span class="n">duplicated_account_checks_flush</span><span class="p">()</span>

<span class="c1"># Health check: Duplicate user accounts count</span>
<span class="n">jira</span><span class="o">.</span><span class="n">duplicated_account_checks_count</span><span class="p">()</span>
</pre></div>
</div>
</section>
<section id="tempo">
<h2>TEMPO<a class="headerlink" href="#tempo" title="Link to this heading">¶</a></h2>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Find existing worklogs with the search parameters.</span>
<span class="c1"># Look at the tempo docs for additional information:</span>
<span class="c1"># https://www.tempo.io/server-api-documentation/timesheets#operation/searchWorklogs</span>
<span class="c1"># NOTE: check if you are using correct types for the parameters!</span>
<span class="c1">#     :param date_from: string From Date</span>
<span class="c1">#     :param date_to: string To Date</span>
<span class="c1">#     :param worker: Array of strings</span>
<span class="c1">#     :param taskId: Array of integers</span>
<span class="c1">#     :param taskKey: Array of strings</span>
<span class="c1">#     :param projectId: Array of integers</span>
<span class="c1">#     :param projectKey: Array of strings</span>
<span class="c1">#     :param teamId: Array of integers</span>
<span class="c1">#     :param roleId: Array of integers</span>
<span class="c1">#     :param accountId: Array of integers</span>
<span class="c1">#     :param accountKey: Array of strings</span>
<span class="c1">#     :param filterId: Array of integers</span>
<span class="c1">#     :param customerId: Array of integers</span>
<span class="c1">#     :param categoryId: Array of integers</span>
<span class="c1">#     :param categoryTypeId: Array of integers</span>
<span class="c1">#     :param epicKey: Array of strings</span>
<span class="c1">#     :param updatedFrom: string</span>
<span class="c1">#     :param includeSubtasks: boolean</span>
<span class="c1">#     :param pageNo: integer</span>
<span class="c1">#     :param maxResults: integer</span>
<span class="c1">#     :param offset: integer</span>
<span class="n">jira</span><span class="o">.</span><span class="n">tempo_4_timesheets_find_worklogs</span><span class="p">(</span><span class="n">date_from</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="n">date_to</span><span class="o">=</span><span class="kc">None</span><span class="p">,</span> <span class="o">**</span><span class="n">params</span><span class="p">)</span>

<span class="c1"># :PRIVATE:</span>
<span class="c1"># Get Tempo timesheet worklog by issue key or id.</span>
<span class="n">jira</span><span class="o">.</span><span class="n">tempo_timesheets_get_worklogs_by_issue</span><span class="p">(</span><span class="n">issue</span><span class="p">)</span>
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
<li class="toctree-l1 current"><a class="current reference internal" href="#">Jira module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="#get-issues-from-jql-search-result-with-all-related-fields">Get issues from jql search result with all related fields</a></li>
<li class="toctree-l2"><a class="reference internal" href="#reindex-jira">Reindex Jira</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-permissions">Manage Permissions</a></li>
<li class="toctree-l2"><a class="reference internal" href="#application-properties">Application properties</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-users">Manage users</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-groups">Manage groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-projects">Manage projects</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-issues">Manage issues</a></li>
<li class="toctree-l2"><a class="reference internal" href="#epic-issues">Epic Issues</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-boards">Manage Boards</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-sprints">Manage Sprints</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-dashboards">Manage dashboards</a></li>
<li class="toctree-l2"><a class="reference internal" href="#attachments-actions">Attachments actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="#manage-components">Manage components</a></li>
<li class="toctree-l2"><a class="reference internal" href="#upload-jira-plugin">Upload Jira plugin</a></li>
<li class="toctree-l2"><a class="reference internal" href="#issue-link-types">Issue link types</a></li>
<li class="toctree-l2"><a class="reference internal" href="#issue-security-schemes">Issue security schemes</a></li>
<li class="toctree-l2"><a class="reference internal" href="#cluster-methods-only-for-dc-edition">Cluster methods (only for DC edition)</a></li>
<li class="toctree-l2"><a class="reference internal" href="#health-checks-methods-only-for-on-prem-edition">Health checks methods (only for on-prem edition)</a></li>
<li class="toctree-l2"><a class="reference internal" href="#tempo">TEMPO</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="confluence.html">Confluence module</a></li>
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
      <li>Previous: <a href="index.html" title="previous chapter">Welcome to Atlassian Python API’s documentation!</a></li>
      <li>Next: <a href="confluence.html" title="next chapter">Confluence module</a></li>
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
      <a href="_sources/jira.rst.txt"
          rel="nofollow">Page source</a>
    </div>

    

    
  </body>
</html>
```

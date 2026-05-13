---
title: "Atlassian Python API overview"
token: "1968"
source_link: "https://atlassian-python-api.readthedocs.io/"
source_links: ["https://atlassian-python-api.readthedocs.io/", "https://atlassian-python-api.readthedocs.io/_static/pygments.css?v=5ecbeea2", "https://atlassian-python-api.readthedocs.io/_static/basic.css?v=b08954a9", "https://atlassian-python-api.readthedocs.io/_static/alabaster.css?v=27fed22d", "https://atlassian-python-api.readthedocs.io/genindex.html", "https://atlassian-python-api.readthedocs.io/search.html", "https://atlassian-python-api.readthedocs.io/jira.html", "https://atlassian-python-api.readthedocs.io/_static/custom.css", "https://pypi.python.org/pypi/atlassian-python-api", "https://badge.fury.io/py/atlassian-python-api", "https://www.codacy.com/project/gonchik/atlassian-python-api/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=AstroMatt/atlassian-python-api&amp;utm_campaign=Badge_Grade_Dashboard", "https://atlassian-python-api.readthedocs.io/en/latest/?badge=latest", "https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html", "https://atlassian-python-api.readthedocs.io/confluence.html", "https://atlassian-python-api.readthedocs.io/crowd.html", "https://atlassian-python-api.readthedocs.io/bitbucket.html", "https://atlassian-python-api.readthedocs.io/bamboo.html", "https://atlassian-python-api.readthedocs.io/service_desk.html", "https://atlassian-python-api.readthedocs.io/xray.html", "https://atlassian-python-api.readthedocs.io/cloud_admin.html", "https://www.sphinx-doc.org/", "https://alabaster.readthedocs.io", "https://atlassian-python-api.readthedocs.io/_sources/index.rst.txt"]
topic: "ai-automation"
tags: ["ingest", "web", "source/web", "privacy/public", "fetched", "ai-automation", "atlassian-python-api-readthedocs-io"]
generated_at: "2026-05-13T22:27:55Z"
---

# Atlassian Python API overview

Source URL: https://atlassian-python-api.readthedocs.io/
Fetched URL: https://atlassian-python-api.readthedocs.io/
Content-Type: text/html

## Source Content

```html
<!DOCTYPE html>

<html lang="en" data-content_root="./">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Welcome to Atlassian Python API’s documentation! &#8212; Atlassian Python API 4.0.8 documentation</title>
    <link rel="stylesheet" type="text/css" href="_static/pygments.css?v=5ecbeea2" />
    <link rel="stylesheet" type="text/css" href="_static/basic.css?v=b08954a9" />
    <link rel="stylesheet" type="text/css" href="_static/alabaster.css?v=27fed22d" />
    <script src="_static/documentation_options.js?v=1097caeb"></script>
    <script src="_static/doctools.js?v=fd6eb6e6"></script>
    <script src="_static/sphinx_highlight.js?v=6ffebe34"></script>
    <link rel="index" title="Index" href="genindex.html" />
    <link rel="search" title="Search" href="search.html" />
    <link rel="next" title="Jira module" href="jira.html" />
   
  <link rel="stylesheet" href="_static/custom.css" type="text/css" />
  

  
  

  <script async type="text/javascript" src="/_/static/javascript/readthedocs-addons.js"></script><meta name="readthedocs-project-slug" content="atlassian-python-api" /><meta name="readthedocs-version-slug" content="latest" /><meta name="readthedocs-resolver-filename" content="/" /><meta name="readthedocs-http-status" content="200" /></head><body>
  

    <div class="document">
      <div class="documentwrapper">
        <div class="bodywrapper">
          

          <div class="body" role="main">
            
  <p>You can adapt this file completely to your liking, but it should at least
contain the root <cite>toctree</cite> directive.</p>
<section id="welcome-to-atlassian-python-api-s-documentation">
<h1>Welcome to Atlassian Python API’s documentation!<a class="headerlink" href="#welcome-to-atlassian-python-api-s-documentation" title="Link to this heading">¶</a></h1>
<p><a class="reference external" href="https://pypi.python.org/pypi/atlassian-python-api"><img alt="Build status" src="https://github.com/atlassian-api/atlassian-python-api/workflows/Test/badge.svg?branch=master" /></a> <a class="reference external" href="https://badge.fury.io/py/atlassian-python-api"><img alt="PyPI version" src="https://badge.fury.io/py/atlassian-python-api.svg" /></a> <img alt="PyPI Downloads" src="https://pepy.tech/badge/atlassian-python-api/month" /> <a class="reference external" href="https://pypi.python.org/pypi/atlassian-python-api"><img alt="License" src="https://img.shields.io/pypi/l/atlassian-python-api.svg" /></a> <a class="reference external" href="https://www.codacy.com/project/gonchik/atlassian-python-api/dashboard?utm_source=github.com&amp;amp;utm_medium=referral&amp;amp;utm_content=AstroMatt/atlassian-python-api&amp;amp;utm_campaign=Badge_Grade_Dashboard"><img alt="Codacy Badge" src="https://api.codacy.com/project/badge/Grade/c822908f507544fe98ae37b25518ae3d" /></a> <a class="reference external" href="https://atlassian-python-api.readthedocs.io/en/latest/?badge=latest"><img alt="Documentation Status" src="https://readthedocs.org/projects/atlassian-python-api/badge/?version=latest" /></a></p>
<section id="getting-started">
<h2>Getting started<a class="headerlink" href="#getting-started" title="Link to this heading">¶</a></h2>
<p>Install package using pip:</p>
<p><code class="docutils literal notranslate"><span class="pre">pip</span> <span class="pre">install</span> <span class="pre">atlassian-python-api</span></code></p>
<p>Add a connection:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">Jira</span>
<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">Confluence</span>
<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">Crowd</span>
<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">Bitbucket</span>
<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">ServiceDesk</span>
<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">Xray</span>

<span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">)</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8090&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">)</span>

<span class="n">crowd</span> <span class="o">=</span> <span class="n">Crowd</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:4990&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;app-name&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;app-password&#39;</span>
<span class="p">)</span>

<span class="n">bitbucket</span> <span class="o">=</span> <span class="n">Bitbucket</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:7990&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">)</span>

<span class="n">service_desk</span> <span class="o">=</span> <span class="n">ServiceDesk</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">)</span>

<span class="n">xray</span> <span class="o">=</span> <span class="n">Xray</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="s1">&#39;admin&#39;</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="other-authentication-methods">
<h2>Other authentication methods<a class="headerlink" href="#other-authentication-methods" title="Link to this heading">¶</a></h2>
<p>Further authentication methods are available. For example OAuth can be used:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="n">oauth_dict</span> <span class="o">=</span> <span class="p">{</span>
    <span class="s1">&#39;access_token&#39;</span><span class="p">:</span> <span class="s1">&#39;access_token&#39;</span><span class="p">,</span>
    <span class="s1">&#39;access_token_secret&#39;</span><span class="p">:</span> <span class="s1">&#39;access_token_secret&#39;</span><span class="p">,</span>
    <span class="s1">&#39;consumer_key&#39;</span><span class="p">:</span> <span class="s1">&#39;consumer_key&#39;</span><span class="p">,</span>
    <span class="s1">&#39;key_cert&#39;</span><span class="p">:</span> <span class="s1">&#39;key_cert&#39;</span><span class="p">}</span>

<span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">oauth</span><span class="o">=</span><span class="n">oauth_dict</span><span class="p">)</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8090&#39;</span><span class="p">,</span>
    <span class="n">oauth</span><span class="o">=</span><span class="n">oauth_dict</span><span class="p">)</span>

<span class="n">bitbucket</span> <span class="o">=</span> <span class="n">Bitbucket</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:7990&#39;</span><span class="p">,</span>
    <span class="n">oauth</span><span class="o">=</span><span class="n">oauth_dict</span><span class="p">)</span>

<span class="n">service_desk</span> <span class="o">=</span> <span class="n">ServiceDesk</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">oauth</span><span class="o">=</span><span class="n">oauth_dict</span><span class="p">)</span>

<span class="n">xray</span> <span class="o">=</span> <span class="n">Xray</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">oauth</span><span class="o">=</span><span class="n">oauth_dict</span><span class="p">)</span>
</pre></div>
</div>
<p>OAuth 2.0 is also supported:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">atlassian.bitbucket</span><span class="w"> </span><span class="kn">import</span> <span class="n">Cloud</span>

<span class="c1"># token is a dictionary and must at least contain &quot;access_token&quot;</span>
<span class="c1"># and &quot;token_type&quot;.</span>
<span class="n">oauth2_dict</span> <span class="o">=</span> <span class="p">{</span>
    <span class="s2">&quot;client_id&quot;</span><span class="p">:</span> <span class="n">client_id</span><span class="p">,</span>
    <span class="s2">&quot;token&quot;</span><span class="p">:</span> <span class="n">token</span><span class="p">}</span>

<span class="n">bitbucket_cloud</span> <span class="o">=</span> <span class="n">Cloud</span><span class="p">(</span>
    <span class="n">oauth2</span><span class="o">=</span><span class="n">oauth2_dict</span><span class="p">)</span>

<span class="c1"># For a detailed example see bitbucket_oauth2.py in</span>
<span class="c1"># examples/bitbucket</span>
</pre></div>
</div>
<p>Or Kerberos <em>(installation with kerberos extra necessary)</em>:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">kerberos</span><span class="o">=</span><span class="p">{})</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8090&#39;</span><span class="p">,</span>
    <span class="n">kerberos</span><span class="o">=</span><span class="p">{})</span>

<span class="n">bitbucket</span> <span class="o">=</span> <span class="n">Bitbucket</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:7990&#39;</span><span class="p">,</span>
    <span class="n">kerberos</span><span class="o">=</span><span class="p">{})</span>

<span class="n">service_desk</span> <span class="o">=</span> <span class="n">ServiceDesk</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">kerberos</span><span class="o">=</span><span class="p">{})</span>

<span class="n">xray</span> <span class="o">=</span> <span class="n">Xray</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">kerberos</span><span class="o">=</span><span class="p">{})</span>
</pre></div>
</div>
<p>Or reuse cookie file:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">utils</span>
<span class="n">cookie_dict</span> <span class="o">=</span> <span class="n">utils</span><span class="o">.</span><span class="n">parse_cookie_file</span><span class="p">(</span><span class="s2">&quot;cookie.txt&quot;</span><span class="p">)</span>

<span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">cookies</span><span class="o">=</span><span class="n">cookie_dict</span><span class="p">)</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8090&#39;</span><span class="p">,</span>
    <span class="n">cookies</span><span class="o">=</span><span class="n">cookie_dict</span><span class="p">)</span>

<span class="n">bitbucket</span> <span class="o">=</span> <span class="n">Bitbucket</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:7990&#39;</span><span class="p">,</span>
    <span class="n">cookies</span><span class="o">=</span><span class="n">cookie_dict</span><span class="p">)</span>

<span class="n">service_desk</span> <span class="o">=</span> <span class="n">ServiceDesk</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">cookies</span><span class="o">=</span><span class="n">cookie_dict</span><span class="p">)</span>

<span class="n">xray</span> <span class="o">=</span> <span class="n">Xray</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;http://localhost:8080&#39;</span><span class="p">,</span>
    <span class="n">cookies</span><span class="o">=</span><span class="n">cookie_dict</span><span class="p">)</span>
</pre></div>
</div>
<p>Or using Personal Access Token
Note: this method is valid for Jira and Confluence (&lt;7.9) Data center / server editions only! For Jira cloud, see below.</p>
<p>First, create your access token (check <a class="reference external" href="https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html">https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html</a> for details)
Then, just provide the token to the constructor:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;https://your-jira-instance.company.com&#39;</span><span class="p">,</span>
    <span class="n">token</span><span class="o">=</span><span class="n">jira_access_token</span>
<span class="p">)</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;https://your-confluence-instance.company.com&#39;</span><span class="p">,</span>
    <span class="n">token</span><span class="o">=</span><span class="n">confluence_access_token</span>
<span class="p">)</span>
</pre></div>
</div>
<p>To authenticate to the Atlassian Cloud APIs Jira, Confluence, ServiceDesk:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Obtain an API token from: https://id.atlassian.com/manage-profile/security/api-tokens</span>
<span class="c1"># You cannot log-in with your regular password to these services.</span>

<span class="n">jira</span> <span class="o">=</span> <span class="n">Jira</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;https://your-domain.atlassian.net&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="n">atlassian_username</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="n">atlassian_api_token</span><span class="p">,</span>
    <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="n">confluence</span> <span class="o">=</span> <span class="n">Confluence</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;https://your-domain.atlassian.net&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="n">atlassian_username</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="n">atlassian_api_token</span><span class="p">,</span>
    <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="n">service_desk</span> <span class="o">=</span> <span class="n">ServiceDesk</span><span class="p">(</span>
    <span class="n">url</span><span class="o">=</span><span class="s1">&#39;https://your-domain.atlassian.net&#39;</span><span class="p">,</span>
    <span class="n">username</span><span class="o">=</span><span class="n">atlassian_username</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="n">atlassian_api_token</span><span class="p">,</span>
    <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
<p>And to Bitbucket Cloud:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="c1"># Log-in with E-Mail / Username and regular password</span>
<span class="c1"># or with Username and App password.</span>
<span class="c1"># Get App password from https://bitbucket.org/account/settings/app-passwords/.</span>
<span class="c1"># Log-in with E-Mail and App password not possible.</span>
<span class="c1"># Username can be found here: https://bitbucket.org/account/settings/</span>

<span class="kn">from</span><span class="w"> </span><span class="nn">atlassian.bitbucket</span><span class="w"> </span><span class="kn">import</span> <span class="n">Cloud</span>

<span class="n">bitbucket</span> <span class="o">=</span> <span class="n">Cloud</span><span class="p">(</span>
    <span class="n">username</span><span class="o">=</span><span class="n">bitbucket_email</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="n">bitbucket_password</span><span class="p">,</span>
    <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>

<span class="n">bitbucket_app_pw</span> <span class="o">=</span> <span class="n">Cloud</span><span class="p">(</span>
    <span class="n">username</span><span class="o">=</span><span class="n">bitbucket_username</span><span class="p">,</span>
    <span class="n">password</span><span class="o">=</span><span class="n">bitbucket_app_password</span><span class="p">,</span>
    <span class="n">cloud</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</section>
<section id="getting-started-with-cloud-admin-module">
<h2>Getting started with Cloud Admin module<a class="headerlink" href="#getting-started-with-cloud-admin-module" title="Link to this heading">¶</a></h2>
<p>Add a connection:</p>
<div class="highlight-python notranslate"><div class="highlight"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">atlassian</span><span class="w"> </span><span class="kn">import</span> <span class="n">CloudAdminOrgs</span><span class="p">,</span> <span class="n">CloudAdminUsers</span>

<span class="n">cloud_admin_orgs</span> <span class="o">=</span> <span class="n">CloudAdminOrgs</span><span class="p">(</span>
    <span class="n">admin</span><span class="o">-</span><span class="n">api</span><span class="o">-</span><span class="n">key</span><span class="o">=</span><span class="n">admin</span><span class="o">-</span><span class="n">api</span><span class="o">-</span><span class="n">key</span><span class="p">)</span>

<span class="n">cloud_admin_users</span> <span class="o">=</span> <span class="n">CloudAdminUsers</span><span class="p">(</span>
    <span class="n">admin</span><span class="o">-</span><span class="n">api</span><span class="o">-</span><span class="n">key</span><span class="o">=</span><span class="n">admin</span><span class="o">-</span><span class="n">api</span><span class="o">-</span><span class="n">key</span><span class="p">)</span>
</pre></div>
</div>
<div class="toctree-wrapper compound">
<ul>
<li class="toctree-l1"><a class="reference internal" href="jira.html">Jira module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="jira.html#get-issues-from-jql-search-result-with-all-related-fields">Get issues from jql search result with all related fields</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#reindex-jira">Reindex Jira</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-permissions">Manage Permissions</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#application-properties">Application properties</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-users">Manage users</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-groups">Manage groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-projects">Manage projects</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-issues">Manage issues</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#epic-issues">Epic Issues</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-boards">Manage Boards</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-sprints">Manage Sprints</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-dashboards">Manage dashboards</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#attachments-actions">Attachments actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#manage-components">Manage components</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#upload-jira-plugin">Upload Jira plugin</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#issue-link-types">Issue link types</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#issue-security-schemes">Issue security schemes</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#cluster-methods-only-for-dc-edition">Cluster methods (only for DC edition)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#health-checks-methods-only-for-on-prem-edition">Health checks methods (only for on-prem edition)</a></li>
<li class="toctree-l2"><a class="reference internal" href="jira.html#tempo">TEMPO</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="confluence.html">Confluence module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#new-implementation">New Implementation</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#cloud-vs-server-differences">Cloud vs Server Differences</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#common-operations">Common Operations</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#server-specific-features">Server-Specific Features</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#legacy-implementation">Legacy Implementation</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#get-page-info">Get page info</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#page-actions">Page actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#confluence-whiteboards">Confluence Whiteboards</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#template-actions">Template actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#get-spaces-info">Get spaces info</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#space">Space</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#get-space-permissions">Get space permissions</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#users-and-groups">Users and Groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#cql">CQL</a></li>
<li class="toctree-l2"><a class="reference internal" href="confluence.html#other-actions">Other actions</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="crowd.html">Crowd module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="crowd.html#manage-users">Manage users</a></li>
<li class="toctree-l2"><a class="reference internal" href="crowd.html#manage-groups">Manage groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="crowd.html#get-memberships">Get memberships</a></li>
<li class="toctree-l2"><a class="reference internal" href="crowd.html#healthcheck">Healthcheck</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="bitbucket.html">BitBucket module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#manage-projects">Manage projects</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#manage-repositories">Manage repositories</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#manage-code-insights">Manage Code Insights</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#groups-and-admins">Groups and admins</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#manage-code">Manage code</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#branch-permissions">Branch permissions</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#pull-request-management">Pull Request management</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#conditions-reviewers-management">Conditions-Reviewers management</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#bitbucket-cloud">Bitbucket Cloud</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#pipelines-management">Pipelines management</a></li>
<li class="toctree-l2"><a class="reference internal" href="bitbucket.html#manage-issues">Manage issues</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="bamboo.html">Bamboo module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#projects-plans">Projects &amp; Plans</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#branches">Branches</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#build-results">Build results</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#comments-labels">Comments &amp; Labels</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#deployments">Deployments</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#users-groups">Users &amp; Groups</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#agents">Agents</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#other-actions">Other actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#elastic-bamboo">Elastic Bamboo</a></li>
<li class="toctree-l2"><a class="reference internal" href="bamboo.html#plugins-information">Plugins information</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="service_desk.html">Jira Service Desk module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#get-info-about-service-desk">Get info about Service Desk</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#create-customer">Create customer</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#the-request-actions">The Request actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#manage-a-participants">Manage a Participants</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#request-types">Request types</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#transitions">Transitions</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#manage-the-organizations">Manage the Organizations</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#attachment-actions">Attachment actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#sla-actions">SLA actions</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#approvals">Approvals</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#queues">Queues</a></li>
<li class="toctree-l2"><a class="reference internal" href="service_desk.html#add-customers-to-given-service-desk">Add customers to given Service Desk</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="xray.html">Xray module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test">Manage Test</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test-steps">Manage Test Steps</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-pre-conditions">Manage Pre-conditions</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test-sets">Manage Test sets</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test-plans">Manage Test plans</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test-executions">Manage Test Executions</a></li>
<li class="toctree-l2"><a class="reference internal" href="xray.html#manage-test-runs">Manage Test Runs</a></li>
</ul>
</li>
<li class="toctree-l1"><a class="reference internal" href="cloud_admin.html">Cloud Admin module</a><ul>
<li class="toctree-l2"><a class="reference internal" href="cloud_admin.html#cloudadminorgs">CloudAdminOrgs</a></li>
<li class="toctree-l2"><a class="reference internal" href="cloud_admin.html#cloudadminusers">CloudAdminUsers</a></li>
</ul>
</li>
</ul>
</div>
</section>
</section>


          </div>
          
        </div>
      </div>
      <div class="sphinxsidebar" role="navigation" aria-label="Main">
        <div class="sphinxsidebarwrapper">
<h1 class="logo"><a href="#">Atlassian Python API</a></h1>









<search id="searchbox" style="display: none" role="search">
    <div class="searchformwrapper">
    <form class="search" action="search.html" method="get">
      <input type="text" name="q" aria-labelledby="searchlabel" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" placeholder="Search"/>
      <input type="submit" value="Go" />
    </form>
    </div>
</search>
<script>document.getElementById('searchbox').style.display = "block"</script><h3>Navigation</h3>
<ul>
<li class="toctree-l1"><a class="reference internal" href="jira.html">Jira module</a></li>
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
  <li><a href="#">Documentation overview</a><ul>
      <li>Next: <a href="jira.html" title="next chapter">Jira module</a></li>
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
      <a href="_sources/index.rst.txt"
          rel="nofollow">Page source</a>
    </div>

    

    
  </body>
</html>
```

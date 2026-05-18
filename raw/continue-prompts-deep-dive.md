---
title: "How to Create and Manage Prompts in Continue | Continue Docs"
token: "642"
source_link: "https://docs.continue.dev/customize/deep-dives/prompts"
topic: "unclassified"
tags: []
generated_at: "2026-05-18T17:20:21Z"
source: "web"
---
# How to Create and Manage Prompts in Continue

Copy page

Prompts are used to kick off tasks for Agent mode, Plan mode, and Chat mode

Prompts are included as user messages and are especially useful as instructions for repetitive and/or complex tasks.

## [Slash Commands](https://docs.continue.dev/customize/deep-dives/prompts#slash-commands)

By setting `invokable` to `true`, you make the markdown file a prompt, which will be available when you type `/` in Chat, Plan, and Agent mode.

```
---
name: Explain invokable
description: Explains what happens when you set invokable to true
invokable: true
---

Explain that when `invokable` is set to `true`, a slash command becomes available in the IDE extensions and CLI
```

These slash commands can be combined with other instructions, including highlighted code, to provide additional context.

## [Example: `Create Supabase functions` prompt](https://docs.continue.dev/customize/deep-dives/prompts#example-create-supabase-functions-prompt)

Here is a prompt that generates high-quality PostgreSQL functions that adhere to best practices:

```
---
name: Create Supabase functions
description: Guidelines for writing Supabase database functions
invokable: true
---

# Database: Create functions

You're a Supabase Postgres expert in writing database functions. Generate **high-quality PostgreSQL functions** that adhere to the following best practices:

## General Guidelines

1. **Default to `SECURITY INVOKER`:**

   - Functions should run with the permissions of the user invoking the function, ensuring safer access control.
   - Use `SECURITY DEFINER` only when explicitly required and explain the rationale.

2. **Set the `search_path` Configuration Parameter:**

   - Always set `search_path` to an empty string (`set search_path = '';`).
   - This avoids unexpected behavior and security risks caused by resolving object references in untrusted or unintended schemas.
   - Use fully qualified names (e.g., `schema_name.table_name`) for all database objects referenced within the function.

3. **Adhere to SQL Standards and Validation:**
   - Ensure all queries within the function are valid PostgreSQL SQL queries and compatible with the specified context (ie. Supabase).

...
```

You can read the rest of the `Create Supabase functions` prompt [here](http://continue.dev/supabase/create-functions)

If you are using a local `config.yaml`, you can add it to your config like this:

```
...

prompts:
  - uses: supabase/create-functions

...
```

If you are using Continue Mission Control, you can add it to your config by selecting "Use Rule" [here](https://continue.dev/supabase/create-functions)

To use this prompt, you can open Chat / Agent / Edit, type `/`, select the prompt, and type out any additional instructions you'd like to add.

## [Using a prompt with `cn (TUI mode)`](https://docs.continue.dev/customize/deep-dives/prompts#using-a-prompt-with-cn-tui-mode)

You can run this command to start [cn](https://docs.continue.dev/guides/cli) with the [Create Supabase functions](http://continue.dev/supabase/create-functions) prompt.

```
cn --prompt supabase/create-functions "I need a function that checks for the health status"
```

Alternatively, you can start [cn](https://docs.continue.dev/guides/cli) and then type `/` to manually invoke the prompt yourself.

## [Using a prompt to kick off a Continuous AI workflow with `cn (Headless mode)](https://docs.continue.dev/customize/deep-dives/prompts#using-a-prompt-to-kick-off-a-continuous-ai-workflow-with-cn-headless-mode)

You can kick off Continuous AI workflows using a prompt with [cn](https://docs.continue.dev/guides/cli) by adding the `-p` flag.

For example, say you are building a SaaS application and must repeatedly create custom Supabase validation functions for each new feature that accepts user input.

These functions require you to interpret business requirements, implement complex cross-table logic (like checking user permissions, tier limits, and time-based restrictions), and make judgment calls about edge cases.

Each function is unique enough that it can't be templated or scripted. This is where kicking off a Continuous AI workflow to get you started can be quite helpful.

Here is a command that you could run whenever you have a new feature:

```
 cn -p --prompt supabase/create-functions "I need a function for the new feature on my current branch similar to my existing database functions"
```

You can see the entire `Create Supabase functions` prompt [here](http://continue.dev/supabase/create-functions)

When you run this workflow, [cn](https://docs.continue.dev/guides/cli) will checkout your current branch, explore the new and existing code, and then draft a function for you.

You will then be able to review the implementation and improve it before you merge the new feature.

[Rules](https://docs.continue.dev/customize/deep-dives/rules)[Autocomplete](https://docs.continue.dev/customize/deep-dives/autocomplete)

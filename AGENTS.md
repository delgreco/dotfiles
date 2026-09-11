# Agent Instructions

- Do not restart ngnix, Apache or Starman services yourself; instead prompt me when they need restarting.
- Do not try to read an .env file.  Look for .env.example to learn about the available environmental variables.
- Do not use environmental variables that are not listed as available in .env.example.  If you want to add a new variable, prompt me for approval.
- Maintain a HISTORY.md file into which each summary is prepended (newest changes go first) after coding actions.  Do not suggest edits to past history entries.
- If there is a test suite, only run it in entirety when necessary.
- When considering solutions, favor those which result in less code while never sacrificing functionality.
- After summarizing changes, provide a one line git commit message in this format:

```
    git ci -am "[the message]"
```

...but allow me to commit manually.

# Coding Standards

- Do not hardcode email addresses; suggest environmental variables to handle these.
- Put application JavaScript in external .js files. Do not use inline event handlers (onclick, onchange, etc.). Avoid inline `<script>` blocks except for very small, page-specific configuration or initialization that genuinely needs server-rendered values.
- Write code with spaces inside parentheses
- elsifs and elses should always get a new line as in:

```
    if ( true ) {
    }
    elsif ( undef ) {
    }
    else {
    }
```

- Use whitespace between operators as in

```
    if ( ! $active ) {
```

## Perl-specific standards

- Maintain inline POD comments above each subroutine to explain its function
- Define any SQL code in a variable using indented HEREDOCs as in:

```
    my $sql = <<~"SQL";
    SELECT column FROM table WHERE id = ?
    SQL
```

    

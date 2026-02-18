source ~/.bash_profile

# careful using AI
export GEMINI_SANDBOX=sandbox-exec
#Built-in profiles (set via SEATBELT_PROFILE env var):
export SEATBELT_PROFILE=restrictive-open
# permissive-open (default): Write restrictions, network allowed
# permissive-closed: Write restrictions, no network
# permissive-proxied: Write restrictions, network via proxy
# restrictive-open: Strict restrictions, network allowed
# restrictive-closed: Maximum restrictions


autoload -U colors
colors
export PROMPT=$'%{\e[1;31m%}%n%{\e[0m%}@%{\e[0;36m%}%m %{\e[0m%}%{\e[0;32m%}[%~]%{\e[0m%}: '

PATH=/opt/homebrew/bin:$PATH

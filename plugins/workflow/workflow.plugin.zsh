# ============================================================
#  ck-dev — CosmaKeri Developer Workflow Plugin
#  Oh My Zsh custom plugin
#
#  Install: cp ck-dev.plugin.zsh ~/.oh-my-zsh/custom/plugins/ck-dev/
#           then add 'ck-dev' to plugins=() in ~/.zshrc
#
#  CosmaKeri Technologies (Pvt) Ltd
#  Ordered by Legacy. Driven by Innovation.
# ============================================================

# ── BASE PATHS ───────────────────────────────────────────────
CK_ROOT="$HOME/Development/CosmaKeri"
CK_CLIENTS="$HOME/Development/Clients"
CK_PERSONAL="$HOME/Development/Personal"

# ── INTERNAL: scaffold Code/Documents/Design ─────────────────
# Usage: _ck_scaffold <full_path>
_ck_scaffold() {
    local path="$1"
    mkdir -p "$path"/{Code,Documents,Design}
    mkdir -p "$path"/Documents/{Contracts,Proposals,Invoices,Notes}
    echo "✓  Scaffolded: $path"
}

# ── NEW CK PROJECT ────────────────────────────────────────────
# Creates a CosmaKeri own product under ~/Development/CosmaKeri/Code/
# Usage: new-ck-project ck-pay
#        new-ck-project ck-labs-experiment
new-ck-project() {
    local repoName="$1"

    if [ -z "$repoName" ]; then
        echo "Usage: new-ck-project <repo-name>"
        echo "Example: new-ck-project ck-pay"
        return 1
    fi

    # Enforce ck- prefix
    if [[ "$repoName" != ck-* ]]; then
        echo "⚠  CosmaKeri repos must be prefixed with 'ck-'"
        echo "   Suggested name: ck-$repoName"
        return 1
    fi

    local projectPath="$CK_ROOT/Code/$repoName"

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"
    cd "$projectPath" || return 1

    # Git init
    git init
    echo "# $repoName" > README.md
    echo "" >> README.md
    echo "CosmaKeri Technologies (Pvt) Ltd" >> README.md
    git add README.md
    git commit -m "init: $repoName"

    echo "✓  CK project created: $projectPath"
    echo "✓  Git initialised with initial commit"
}

# ── NEW CLIENT ────────────────────────────────────────────────
# Creates a full client folder under ~/Development/Clients/
# Usage: new-client Acme
#        new-client "Zesco Power"
new-client() {
    local clientName="$1"

    if [ -z "$clientName" ]; then
        echo "Usage: new-client <ClientName>"
        echo "Example: new-client Acme"
        return 1
    fi

    local clientPath="$CK_CLIENTS/$clientName"

    if [ -d "$clientPath" ]; then
        echo "⚠  Client already exists: $clientPath"
        return 1
    fi

    _ck_scaffold "$clientPath"
    echo "✓  Client created: $clientPath"
    echo "   Structure: Code/ Documents/ Design/"
    echo "   Documents: Contracts/ Proposals/ Invoices/ Notes/"
}

# ── NEW CLIENT PROJECT ────────────────────────────────────────
# Creates a repo inside an existing client's Code/ folder
# Enforces client- prefix naming convention
# Usage: new-client-project Acme frontend
#        new-client-project Acme backend
#        new-client-project Acme admin
new-client-project() {
    local clientName="$1"
    local projectType="$2"

    if [ -z "$clientName" ] || [ -z "$projectType" ]; then
        echo "Usage: new-client-project <ClientName> <type>"
        echo "Example: new-client-project Acme frontend"
        echo "Types:   frontend · backend · admin · mobile · api · docs"
        return 1
    fi

    # Normalise client name to lowercase for repo naming
    local clientSlug=$(echo "$clientName" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    local repoName="client-$clientSlug-$projectType"
    local clientPath="$CK_CLIENTS/$clientName"
    local projectPath="$clientPath/Code/$repoName"

    if [ ! -d "$clientPath" ]; then
        echo "⚠  Client not found: $clientPath"
        echo "   Run: new-client $clientName"
        return 1
    fi

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"
    cd "$projectPath" || return 1

    # Git init
    git init
    echo "# $repoName" > README.md
    echo "" >> README.md
    echo "Client project — CosmaKeri Technologies (Pvt) Ltd" >> README.md
    git add README.md
    git commit -m "init: $repoName"

    echo "✓  Client project created: $projectPath"
    echo "✓  Repo name: $repoName"
    echo "✓  Git initialised with initial commit"
}

# ── NEW PERSONAL PROJECT ──────────────────────────────────────
# Creates a personal project under ~/Development/Personal/
# Usage: new-personal-project my-experiment
new-personal-project() {
    local projectName="$1"

    if [ -z "$projectName" ]; then
        echo "Usage: new-personal-project <project-name>"
        return 1
    fi

    local projectPath="$CK_PERSONAL/$projectName"

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"/{Code,Documents}
    cd "$projectPath" || return 1
    git init
    echo "✓  Personal project created: $projectPath"
}

# ── LIST PROJECTS ─────────────────────────────────────────────
# Lists all CosmaKeri, client, and personal projects
# Usage: ck-list
ck-list() {
    echo ""
    echo "── CosmaKeri Projects ───────────────────────"
    if [ -d "$CK_ROOT/Code" ]; then
        ls "$CK_ROOT/Code" 2>/dev/null | sed 's/^/   /'
    else
        echo "   none"
    fi

    echo ""
    echo "── Clients ──────────────────────────────────"
    if [ -d "$CK_CLIENTS" ]; then
        for client in "$CK_CLIENTS"/*/; do
            clientName=$(basename "$client")
            echo "   $clientName"
            if [ -d "$client/Code" ]; then
                ls "$client/Code" 2>/dev/null | sed 's/^/     └─ /'
            fi
        done
    else
        echo "   none"
    fi

    echo ""
    echo "── Personal ─────────────────────────────────"
    if [ -d "$CK_PERSONAL" ]; then
        ls "$CK_PERSONAL" 2>/dev/null | sed 's/^/   /'
    else
        echo "   none"
    fi
    echo ""
}

# ── NAVIGATION ALIASES ────────────────────────────────────────
alias ck="cd $CK_ROOT"
alias ck-code="cd $CK_ROOT/Code"
alias ck-docs="cd $CK_ROOT/Documents"
alias ck-design="cd $CK_ROOT/Design"
alias clients="cd $CK_CLIENTS"
alias personal="cd $CK_PERSONAL"
alias dev="cd $HOME/Development"

# ── QUICK OPEN ────────────────────────────────────────────────
# Open any project folder in VS Code
# Usage: ck-open ck-website
#        ck-open Acme frontend
ck-open() {
    local target=""

    if [ -z "$1" ]; then
        echo "Usage: ck-open <ck-repo-name>"
        echo "       ck-open <ClientName> <type>"
        return 1
    fi

    if [ -n "$2" ]; then
        # Client project
        local clientSlug=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
        target="$CK_CLIENTS/$1/Code/client-$clientSlug-$2"
    elif [[ "$1" == ck-* ]]; then
        # CK project
        target="$CK_ROOT/Code/$1"
    else
        # Client folder
        target="$CK_CLIENTS/$1"
    fi

    if [ ! -d "$target" ]; then
        echo "⚠  Not found: $target"
        return 1
    fi

    code "$target"
    echo "✓  Opened in VS Code: $target"
}

# ── DOCKER ALIASES ────────────────────────────────────────────
alias aws='docker run --rm -ti -v $(pwd)/aws:/root/.aws -v $(pwd)/fs:/aws amazon/aws-cli'
alias composer='docker run --rm --interactive --tty -v $(pwd):/app composer'

# ── GIT SHORTCUTS ─────────────────────────────────────────────
alias gs='git status'
alias gl='git log --oneline --graph --decorate -10'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gaa='git add .'
alias gcm='git commit -m'

# ── HELP ──────────────────────────────────────────────────────
ck-help() {
    echo ""
    echo "  ck-dev — CosmaKeri Developer Plugin"
    echo "  ────────────────────────────────────────────────────"
    echo ""
    echo "  SCAFFOLD"
    echo "  new-ck-project <repo>           new CosmaKeri product"
    echo "  new-client <Name>               new client folder"
    echo "  new-client-project <Name> <type> new repo in client"
    echo "  new-personal-project <name>     new personal project"
    echo ""
    echo "  NAVIGATE"
    echo "  dev                             ~/Development"
    echo "  ck                              ~/Development/CosmaKeri"
    echo "  ck-code                         ~/Development/CosmaKeri/Code"
    echo "  ck-docs                         ~/Development/CosmaKeri/Documents"
    echo "  ck-design                       ~/Development/CosmaKeri/Design"
    echo "  clients                         ~/Development/Clients"
    echo "  personal                        ~/Development/Personal"
    echo ""
    echo "  OVERVIEW"
    echo "  ck-list                         list all projects"
    echo "  ck-open <repo>                  open in VS Code"
    echo "  ck-open <Client> <type>         open client project"
    echo ""
    echo "  GIT"
    echo "  gs  gl  gp  gpl  gco  gcb  gaa  gcm"
    echo ""
}

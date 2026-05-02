# ============================================================
#  workflow — CosmaKeri Developer Workflow Plugin
#  Oh My Zsh custom plugin
#
#  Install:
#    cp workflow.plugin.zsh ~/.oh-my-zsh/custom/plugins/workflow/
#    Add 'workflow' to plugins=() in ~/.zshrc
#    source ~/.zshrc
#
#  CosmaKeri Technologies (Pvt) Ltd
#  Ordered by Legacy. Driven by Innovation.
# ============================================================

# ── DIRECTORY STRUCTURE ──────────────────────────────────────
#
#  ~/Development/
#  ├── CosmaKeri/
#  │   ├── CK/                        CosmaKeri own work
#  │   │   ├── Code/                  all CK repos and code
#  │   │   │   ├── Templates/         reusable project starters
#  │   │   │   │   └── ck-template-*  NestJS, React, Fullstack etc
#  │   │   │   ├── Products/          multi-repo sub-brands
#  │   │   │   │   └── Pay/           each product gets its own folder
#  │   │   │   │       └── ck-pay-*   backend, frontend, admin, infra
#  │   │   │   └── ck-*               active single repos sit flat here
#  │   │   │       e.g. ck-website, ck-infra, ck-docs
#  │   │   ├── Documents/             company-level written records
#  │   │   │   ├── Legal/             cert of incorporation, CR forms, DCIPO
#  │   │   │   ├── Finance/           Wave exports, receipts, tax records
#  │   │   │   ├── Admin/             compliance tracker, board resolutions
#  │   │   │   └── Proposals/         reusable proposal and contract templates
#  │   │   └── Design/                brand and visual assets
#  │   │       ├── Logos/             all logo variants — svg, png, dark, light, universal
#  │   │       ├── Brand/             colour palette, typography, brand guidelines
#  │   │       └── Marketing/         website copy drafts, social assets, banners
#  │   │
#  │   └── Clients/                   one folder per client engagement
#  │       └── ClientName/
#  │           ├── Code/              client repos sit flat here
#  │           │   └── client-name-*  frontend, backend, admin etc
#  │           ├── Documents/         all written records for this engagement
#  │           │   ├── Contracts/     signed service agreements
#  │           │   ├── Proposals/     scoping documents and quotes
#  │           │   ├── Invoices/      all invoices sent to this client
#  │           │   └── Notes/         meeting notes, requirements, decisions
#  │           └── Design/            visual assets for or from this client
#  │               ├── Mockups/       wireframes and UI mockups
#  │               ├── Assets/        exported assets and deliverable files
#  │               └── Guidelines/    brand guidelines received from client
#  │
#  └── Personal/                      personal projects — not CosmaKeri work
#      ├── Code/
#      └── Documents/
#
# ─────────────────────────────────────────────────────────────

CK_DEV="$HOME/Development"
CK_ROOT="$HOME/Development/CosmaKeri"
CK_COMPANY="$HOME/Development/CosmaKeri/CK"
CK_CODE="$HOME/Development/CosmaKeri/CK/Code"
CK_TEMPLATES="$HOME/Development/CosmaKeri/CK/Code/Templates"
CK_PRODUCTS="$HOME/Development/CosmaKeri/CK/Code/Products"
CK_CLIENTS="$HOME/Development/CosmaKeri/Clients"
CK_PERSONAL="$HOME/Development/Personal"

# ── BOOTSTRAP ────────────────────────────────────────────────
# Creates the full directory structure from scratch
# Usage: ck-bootstrap
ck-bootstrap() {
    echo "  Bootstrapping CosmaKeri directory structure..."
    echo ""

    mkdir -p "$CK_CODE"/{Templates,Products}
    mkdir -p "$CK_COMPANY"/Documents/{Legal,Finance,Admin,Proposals}
    mkdir -p "$CK_COMPANY"/Design/{Logos,Brand,Marketing}
    mkdir -p "$CK_ROOT"/Development/CosmaKeri/Clients
    mkdir -p "$CK_PERSONAL"/{Code,Documents}

    echo "✓  ~/Development/CosmaKeri/CK/Code/"
    echo "     ├── Templates/    reusable project starters (ck-template-*)"
    echo "     └── Products/     multi-repo sub-brands (Pay, Labs etc)"
    echo ""
    echo "✓  ~/Development/CosmaKeri/CK/Documents/"
    echo "     ├── Legal/        cert of incorporation, CR forms, DCIPO"
    echo "     ├── Finance/      Wave exports, receipts, tax records"
    echo "     ├── Admin/        compliance tracker, board resolutions"
    echo "     └── Proposals/    reusable proposal and contract templates"
    echo ""
    echo "✓  ~/Development/CosmaKeri/CK/Design/"
    echo "     ├── Logos/        all logo variants — svg, png, dark, light, universal"
    echo "     ├── Brand/        colour palette, typography, guidelines"
    echo "     └── Marketing/    website copy, social assets, banners"
    echo ""
    echo "✓  ~/Development/CosmaKeri/Clients"
    echo ""
    echo "✓  ~/Development/Personal/"
    echo "     ├── Code/"
    echo "     └── Documents/"
    echo ""
    echo "  Run 'ck-new-client <Name>' to add your first client."
}

# ── INTERNAL: scaffold Code/Documents/Design ─────────────────
# Shared internal scaffold — not called directly
# Usage: _ck_scaffold <full_path> <context: ck|client>
_ck_scaffold() {
    local dir="$1"
    local context="$2"

    if [ "$context" = "ck" ]; then
        mkdir -p "$dir/Code"/{Templates,Products}
        mkdir -p "$dir/Documents"/{Legal,Finance,Admin,Proposals}
        mkdir -p "$dir/Design"/{Logos,Brand,Marketing}
    else
        mkdir -p "$dir/Code"
        mkdir -p "$dir/Documents"/{Contracts,Proposals,Invoices,Notes}
        mkdir -p "$dir/Design"/{Mockups,Assets,Guidelines}
    fi
}

# ── NEW CK PROJECT ────────────────────────────────────────────
# Creates a new single-repo CK project under CK/Code/ (flat)
# Use this for: ck-website, ck-infra, ck-docs etc
# Usage: ck-new-project ck-website
#        ck-new-project ck-infra
ck-new-project() {
    local repoName="$1"

    if [ -z "$repoName" ]; then
        echo "Usage: ck-new-project <repo-name>"
        echo "Example: ck-new-project ck-infra"
        return 1
    fi

    if [[ "$repoName" != ck-* ]]; then
        echo "⚠  CosmaKeri repos must be prefixed with 'ck-'"
        echo "   Suggested name: ck-$repoName"
        return 1
    fi

    if [[ "$repoName" == ck-template-* ]]; then
        echo "⚠  Template repos belong in Templates/ — use ck-new-template instead"
        return 1
    fi

    local projectPath="$CK_CODE/$repoName"

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"
    cd "$projectPath" || return 1

    git init
    echo "# $repoName" > README.md
    echo "" >> README.md
    echo "CosmaKeri Technologies (Pvt) Ltd" >> README.md
    git add README.md
    git commit -m "init: $repoName"

    echo "✓  CK project created: $projectPath"
    echo "✓  Git initialised with initial commit"
}

# ── NEW CK TEMPLATE ───────────────────────────────────────────
# Creates a reusable starter under CK/Code/Templates/
# Use this for: ck-template-nestjs, ck-template-react, ck-template-fullstack
# Usage: ck-new-template ck-template-nestjs
ck-new-template() {
    local repoName="$1"

    if [ -z "$repoName" ]; then
        echo "Usage: ck-new-template <repo-name>"
        echo "Example: ck-new-template ck-template-nestjs"
        return 1
    fi

    if [[ "$repoName" != ck-template-* ]]; then
        echo "⚠  Template repos must be prefixed with 'ck-template-'"
        echo "   Suggested name: ck-template-$repoName"
        return 1
    fi

    local templatePath="$CK_TEMPLATES/$repoName"

    if [ -d "$templatePath" ]; then
        echo "⚠  Template already exists: $templatePath"
        return 1
    fi

    mkdir -p "$templatePath"
    cd "$templatePath" || return 1

    git init
    echo "# $repoName" > README.md
    echo "" >> README.md
    echo "Reusable starter template — CosmaKeri Technologies (Pvt) Ltd" >> README.md
    git add README.md
    git commit -m "init: $repoName"

    echo "✓  Template created: $templatePath"
    echo "✓  Git initialised with initial commit"
}

# ── NEW CK PRODUCT ────────────────────────────────────────────
# Creates a repo inside a sub-brand product folder under CK/Code/Products/
# Use this for multi-repo products: Pay, Labs, Build etc
# Usage: ck-new-product Pay backend
#        ck-new-product Pay frontend
#        ck-new-product Labs api
ck-new-product() {
    local productName="$1"
    local repoType="$2"

    if [ -z "$productName" ] || [ -z "$repoType" ]; then
        echo "Usage: ck-new-product <ProductName> <type>"
        echo "Example: ck-new-product Pay backend"
        echo "Types:   backend · frontend · admin · mobile · api · docs · infra"
        return 1
    fi

    local productSlug=$(echo "$productName" | tr '[:upper:]' '[:lower:]')
    local repoName="ck-$productSlug-$repoType"
    local productPath="$CK_PRODUCTS/$productName"
    local repoPath="$productPath/$repoName"

    if [ -d "$repoPath" ]; then
        echo "⚠  Repo already exists: $repoPath"
        return 1
    fi

    mkdir -p "$repoPath"
    cd "$repoPath" || return 1

    git init
    echo "# $repoName" > README.md
    echo "" >> README.md
    echo "CosmaKeri $productName — CosmaKeri Technologies (Pvt) Ltd" >> README.md
    git add README.md
    git commit -m "init: $repoName"

    echo "✓  Product repo created: $repoPath"
    echo "✓  Repo name: $repoName"
    echo "✓  Git initialised with initial commit"
}

# ── NEW CLIENT ────────────────────────────────────────────────
# Creates a full client folder with Code/Documents/Design structure
# Usage: ck-new-client Acme
#        ck-new-client "Zesco Power"
ck-new-client() {
    local clientName="$1"

    if [ -z "$clientName" ]; then
        echo "Usage: ck-new-client <ClientName>"
        echo "Example: ck-new-client Acme"
        return 1
    fi

    local clientPath="$CK_CLIENTS/$clientName"

    if [ -d "$clientPath" ]; then
        echo "⚠  Client already exists: $clientPath"
        return 1
    fi

    _ck_scaffold "$clientPath" "client"

    echo "✓  Client created: $clientPath"
    echo ""
    echo "   Code/                  client repos go here (client-name-type)"
    echo "   Documents/"
    echo "     ├── Contracts/       signed service agreements"
    echo "     ├── Proposals/       scoping documents and quotes"
    echo "     ├── Invoices/        all invoices sent to this client"
    echo "     └── Notes/           meeting notes, requirements, decisions"
    echo "   Design/"
    echo "     ├── Mockups/         wireframes and UI mockups"
    echo "     ├── Assets/          exported assets and deliverable files"
    echo "     └── Guidelines/      brand guidelines received from client"
}

# ── NEW CLIENT PROJECT ────────────────────────────────────────
# Creates a repo inside an existing client's Code/ folder
# Enforces client-name-type naming convention
# Usage: ck-new-client-project Acme frontend
#        ck-new-client-project Acme backend
ck-new-client-project() {
    local clientName="$1"
    local projectType="$2"

    if [ -z "$clientName" ] || [ -z "$projectType" ]; then
        echo "Usage: ck-new-client-project <ClientName> <type>"
        echo "Example: ck-new-client-project Acme frontend"
        echo "Types:   frontend · backend · admin · mobile · api · docs"
        return 1
    fi

    local clientSlug=$(echo "$clientName" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    local repoName="client-$clientSlug-$projectType"
    local clientPath="$CK_CLIENTS/$clientName"
    local projectPath="$clientPath/Code/$repoName"

    if [ ! -d "$clientPath" ]; then
        echo "⚠  Client not found: $clientPath"
        echo "   Run: ck-new-client $clientName"
        return 1
    fi

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"
    cd "$projectPath" || return 1

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
# Creates a personal project under Personal/Code/
# Usage: new-personal-project my-experiment
new-personal-project() {
    local projectName="$1"

    if [ -z "$projectName" ]; then
        echo "Usage: new-personal-project <project-name>"
        return 1
    fi

    local projectPath="$CK_PERSONAL/Code/$projectName"

    if [ -d "$projectPath" ]; then
        echo "⚠  Project already exists: $projectPath"
        return 1
    fi

    mkdir -p "$projectPath"
    cd "$projectPath" || return 1
    git init
    echo "✓  Personal project created: $projectPath"
}

# ── LIST ──────────────────────────────────────────────────────
# Lists all CK, client, and personal projects
# Usage: ck-list
ck-list() {
    echo ""
    echo "── CK ───────────────────────────────────────"

    if [ -d "$CK_CODE" ]; then
        for item in "$CK_CODE"/*/; do
            local name=$(basename "$item")
            if [ "$name" = "Templates" ]; then
                if [ "$(ls -A "$CK_TEMPLATES" 2>/dev/null)" ]; then
                    echo "   Templates/"
                    ls "$CK_TEMPLATES" 2>/dev/null | sed 's/^/     └─ /'
                fi
            elif [ "$name" = "Products" ]; then
                if [ "$(ls -A "$CK_PRODUCTS" 2>/dev/null)" ]; then
                    echo "   Products/"
                    for product in "$CK_PRODUCTS"/*/; do
                        echo "     └─ $(basename "$product")"
                        ls "$product" 2>/dev/null | sed 's/^/          └─ /'
                    done
                fi
            else
                echo "   $name"
            fi
        done
    else
        echo "   none — run ck-bootstrap first"
    fi

    echo ""
    echo "── Clients ──────────────────────────────────"
    if [ -d "$CK_CLIENTS" ] && [ "$(ls -A "$CK_CLIENTS" 2>/dev/null)" ]; then
        for client in "$CK_CLIENTS"/*/; do
            local clientName=$(basename "$client")
            echo "   $clientName"
            if [ -d "$client/Code" ] && [ "$(ls -A "$client/Code" 2>/dev/null)" ]; then
                ls "$client/Code" 2>/dev/null | sed 's/^/     └─ /'
            fi
        done
    else
        echo "   none — run ck-new-client <Name> to add one"
    fi

    echo ""
    echo "── Personal ─────────────────────────────────"
    if [ -d "$CK_PERSONAL/Code" ] && [ "$(ls -A "$CK_PERSONAL/Code" 2>/dev/null)" ]; then
        ls "$CK_PERSONAL/Code" 2>/dev/null | sed 's/^/   /'
    else
        echo "   none"
    fi
    echo ""
}

# ── NAVIGATION ALIASES ────────────────────────────────────────
alias dev="cd $CK_DEV"
alias ck="cd $CK_COMPANY"
alias ck-code="cd $CK_CODE"
alias ck-templates="cd $CK_TEMPLATES"
alias ck-products="cd $CK_PRODUCTS"
alias ck-docs="cd $CK_COMPANY/Documents"
alias ck-design="cd $CK_COMPANY/Design"
alias ck-clients="cd $CK_CLIENTS"
alias personal="cd $CK_PERSONAL"

# ── OPEN IN VS CODE ───────────────────────────────────────────
# Opens any project in VS Code
# Usage: ck-open ck-website
#        ck-open template nestjs          → opens ck-template-nestjs
#        ck-open product Pay backend      → opens ck-pay-backend
#        ck-open client Acme frontend     → opens client-acme-frontend
ck-open() {
    local context="$1"
    local target=""

    case "$context" in
        template)
            target="$CK_TEMPLATES/ck-template-$2"
            ;;
        product)
            local productSlug=$(echo "$2" | tr '[:upper:]' '[:lower:]')
            target="$CK_PRODUCTS/$2/ck-$productSlug-$3"
            ;;
        client)
            local clientSlug=$(echo "$2" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            target="$CK_CLIENTS/$2/Code/client-$clientSlug-$3"
            ;;
        ck-*)
            target="$CK_CODE/$context"
            ;;
        *)
            echo "Usage:"
            echo "  ck-open ck-<repo>                    open a flat CK repo"
            echo "  ck-open template <name>              open Templates/ck-template-<name>"
            echo "  ck-open product <Product> <type>     open Products/<Product>/ck-product-<type>"
            echo "  ck-open client <Client> <type>       open Clients/<Client>/Code/client-<name>-<type>"
            return 1
            ;;
    esac

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
    echo "  workflow — CosmaKeri Developer Plugin"
    echo "  ────────────────────────────────────────────────────────────"
    echo ""
    echo "  BOOTSTRAP"
    echo "  ck-bootstrap                             create full directory structure"
    echo ""
    echo "  SCAFFOLD — CK"
    echo "  ck-new-project <repo>                    new flat CK repo"
    echo "  ck-new-template <repo>                   new starter in Code/Templates/"
    echo "  ck-new-product <Product> <type>          new repo in Code/Products/Product/"
    echo ""
    echo "  SCAFFOLD — CLIENTS"
    echo "  ck-new-client <Name>                     new client with full structure"
    echo "  ck-new-client-project <Name> <type>      new repo in Clients/Name/Code/"
    echo ""
    echo "  SCAFFOLD — PERSONAL"
    echo "  new-personal-project <name>                   new personal project"
    echo ""
    echo "  NAVIGATE"
    echo "  dev              ~/Development"
    echo "  ck               ~/Development/CosmaKeri/CK"
    echo "  ck-code          ~/Development/CosmaKeri/CK/Code"
    echo "  ck-templates     ~/Development/CosmaKeri/CK/Code/Templates"
    echo "  ck-products      ~/Development/CosmaKeri/CK/Code/Products"
    echo "  ck-docs          ~/Development/CosmaKeri/CK/Documents"
    echo "  ck-design        ~/Development/CosmaKeri/CK/Design"
    echo "  ck-clients       ~/Development/CosmaKeri/Clients"
    echo "  personal         ~/Development/Personal"
    echo ""
    echo "  OVERVIEW"
    echo "  ck-list                                  list all projects"
    echo "  ck-open ck-<repo>                        open flat CK repo in VS Code"
    echo "  ck-open template <name>                  open template in VS Code"
    echo "  ck-open product <Product> <type>         open product repo in VS Code"
    echo "  ck-open client <Client> <type>           open client repo in VS Code"
    echo ""
    echo "  GIT"
    echo "  gs  gl  gp  gpl  gco  gcb  gaa  gcm"
    echo ""
    echo "  DOCKER"
    echo "  aws <command>        composer <command>"
    echo ""
}

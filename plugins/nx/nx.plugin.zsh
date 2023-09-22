# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
nx-new-workspace () {
    if [ -z "$1" ]; then
        echo "Please provide project name."
    else
        wget -q --spider http://google.com
        if [ $? -eq 0 ]; then
            echo "Online using npx to create project" &&
            npx create-nx-workspace "$1" &&
            cd "$1"
        else
            echo "Please connect to the internet to create the app"
        fi
    fi
}

nx-add-core-packages () {
    yarn add @nestjs/config joi typeorm-naming-strategies bcrypt
}

nx-add-graphql () {
    yarn add @nestjs/graphql graphql-tools graphql apollo-server-express
}

nx-add-restful () {
    yarn add @nestjsx/crud @nestjsx/crud-request class-transformer class-validator @nestjsx/crud-typeorm @nestjs/typeorm typeorm @nestjs/swagger
}

nx-add-app () {
    nx generate @nrwl/nest:app "$1"
}

nx-add-nest-lib () {
    nx generate @nrwl/nest:lib "$1"
}

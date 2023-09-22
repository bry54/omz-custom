# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
new-laravel-sail-app () {
    defaultServices=mysql,redis,mailpit
    if [ -z "$1" ]; then
        echo "Please provide project name."
    else
        wget -q --spider http://google.com
        if [ $? -eq 0 ]; then
            echo "Online using laravel online script to create project"
            curl -s "https://laravel.build/$1?with$defaultServices" | bash
        else
            echo "Please connect to the internet to create the app"
        fi
    fi
}

new-laravel-composer-app () {
    if [ -z "$1" ]; then
        echo "Please provide project name."
    else
        wget -q --spider http://google.com
        if [ $? -eq 0 ]; then
            echo "Online using laravel online script to create project"
            composer create-project laravel/laravel $1
        else
            echo "Please connect to the internet to create the app"
        fi
    fi
}

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

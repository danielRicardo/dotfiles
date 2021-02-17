function install_module
        grep \<module\> pom.xml | sed -E 's/<.*>(.*)<.*>/\1/g' | fzf | xargs -I MODULE mvn install -U -pl MODULE -am
end

#!/bin/bash

setup() {
    printer "🔨 Setting up the repo"
    git submodule update --init --recursive
    handler
}

articles() {
    printer "📚 Generating documentation"
    mkdir -p ./dist
    pandoc ./docs/articles/$2.md \
        -o ./dist/$2.pdf \
        --from=markdown \
        --template=./pandoc-latex-template/template-multi-file/eisvogel.latex \
        --pdf-engine=xelatex \
        --filter=pandoc-latex-environment \
        --listings
    handler
}

project_work() {
    printer "📄 Generating Project Work report"
    cat ./docs/report/md/*.md > ./docs/report/Project_Work.md
    pandoc ./docs/report/Project_Work.md \
        -o ./dist/content.pdf \
        --from=markdown \
        --template=./pandoc-latex-template/template-multi-file/eisvogel.latex \
        --pdf-engine=xelatex \
        --filter=pandoc-latex-environment \
        --listings
    pdfunite \
        ./dist/front.pdf \
        ./dist/content.pdf \
        ./dist/Project_Work.pdf
    handler
}

# TODO: Remove in production
commit() {
    printer "📦 Committing changes"
    git add .
    git commit -m updates
    git push
    handler
}

printer() {
    echo ""
    echo $1
    echo ""
}

handler() {
    if [ $? -eq 0 ]; then
        printer "✅ Process completed successfully"
    else
        printer "❌ An error occurred during the process"
        exit 1
    fi
}

case $1 in
    setup)
        setup
        ;;
    articles)
        articles $@
        ;;
    project_work)
        project_work
        ;;
    commit)  # TODO: Remove in production
        commit
        ;;
    *)
        echo "Usage: $0 {setup|articles|project_work}"
        ;;
esac

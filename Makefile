DEPLOY_DIR = .deploy
DEPLOY_BRANCH = gh-pages
ORIGIN_URL = `git config --get remote.origin.url`
COMMIT_MESSAGE = "Updated site on `date +%m-%d-%Y`."

.PHONY: build deploy

all: build

build:
	jekyll --no-auto

deploy:	build $(DEPLOY_DIR)
	rm -rf $(DEPLOY_DIR)/*
	cp -R _site/* $(DEPLOY_DIR)/
	cd $(DEPLOY_DIR); \
		git add .; \
		git add --update; \
		git commit -m $(COMMIT_MESSAGE); \
		git push --force origin $(DEPLOY_BRANCH)

$(DEPLOY_DIR):
	rm -rf $(DEPLOY_DIR)
	git clone $(ORIGIN_URL) $(DEPLOY_DIR)
	cd $(DEPLOY_DIR) && git checkout -B $(DEPLOY_BRANCH)

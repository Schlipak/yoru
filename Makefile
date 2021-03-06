NAME 					= yoru
SKEL_DIRS 		= lib/ test/ src/ tmp/
ESLINT_DIRS 	= test/ src/

EXEC_BABEL 		= ./node_modules/.bin/babel
EXEC_WEBPACK 	= ./node_modules/.bin/webpack

ECHO 					= `which echo` -e

all: 			eslint babel

eslint:
					@$(ECHO) "[\033[1;35mCHECK\033[0m] Running ESLint"
					@./node_modules/eslint/bin/eslint.js $(ESLINT_DIRS) $(NAME).js

test:
					@npm test

babel: 		clean
					@$(ECHO) "[\033[1;34mTRANS\033[0m] Running Babel"
					@$(EXEC_BABEL) $(NAME).js src/ --out-dir tmp/
					@$(ECHO) "[\033[1;34mPACK\033[0m] Running Webpack"
					@$(EXEC_WEBPACK) tmp/yoru.js dist/yoru.pkg.js
					@$(ECHO) "[\033[1;34mMIN\033[0m] Running Uglify"
					@./node_modules/.bin/uglifyjs dist/yoru.pkg.js > dist/yoru.pkg.min.js
					@$(ECHO) "[\033[1;32mOK\033[0m] All done!"

bin:
					@make -C bin/

clean:
					@$(ECHO) "[\033[1;31mRM\033[0m] Clean dist/ tmp/"
					@rm -rf dist/* tmp/*

skel:
					mkdir -p $(SKEL_DIRS) dist/
					touch $(NAME).js

.PHONY: all eslint test babel bin clean skel

SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
PROJECT_PATH=`dirname "$SCRIPT_PATH"`

rm -rf $PROJECT_PATH/tmp \
  && mkdir -p $PROJECT_PATH/tmp \
  && curl -s https://api.github.com/repos/swagger-api/swagger-ui/releases/latest | jq '.tarball_url' -r | wget -c -O $PROJECT_PATH/tmp/swagger-ui.tgz -i - \
  && cd $PROJECT_PATH/tmp \
  && tar -xf swagger-ui.tgz \
  && mv `realpath swagger-api-swagger-ui-*` $PROJECT_PATH/tmp/swagger-ui-release \
  && cd swagger-ui-release \
  && wget -O $PROJECT_PATH/tmp/swagger-ui-release/src/plugins/topbar/logo_small.svg https://aasaam.github.io/information/logo/aasaam.svg \
  && cd $PROJECT_PATH \
  && cp $PROJECT_PATH/patch/_type.scss $PROJECT_PATH/tmp/swagger-ui-release/src/style/_type.scss \
  && cat $PROJECT_PATH/patch/patch.scss >> $PROJECT_PATH/tmp/swagger-ui-release/src/style/_variables.scss \
  && cd $PROJECT_PATH/tmp/swagger-ui-release \
  && npm install \
  && npm run build \
  && rm -rf $PROJECT_PATH/tmp/swagger-ui-release/dist/index.html \
  && cp $PROJECT_PATH/tmp/swagger-ui-release/dist/* $PROJECT_PATH/ -rf \
  && rm -rf $PROJECT_PATH/favicon-*.png

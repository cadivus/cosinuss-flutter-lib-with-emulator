module.exports = {
  root: true,
  env: {
    es6: true,
    es2017: true,
    node: true,
    mocha: true,
  },
  extends: ["eslint:recommended", "google", "prettier"],
  rules: {
    quotes: ["error", "double"],
    "require-jsdoc" : 0,
  },
  parser: "@babel/eslint-parser",
  parserOptions: {
    sourceType: 'module',
    requireConfigFile: false,
  },
};

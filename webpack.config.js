var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: ["./web/static/js/app.js", "./web/static/css/app.sass"],
    output: {
        path: "./priv/static",
        filename: "js/app.js"
    },
    loaders: [
        {
            test: /\.sass$/i,
            loader: ExtractTextPlugin.extract("style", "css!sass?indentedSyntax")
        },
        {
            test: /\.jsx?$/,
            loader: 'babel',
            exclude: /(node_modules|bower_components)/,
            include: __dirname,
            query: {
                presets: ['es2015']
            }
        }
    ],
    extensions: ["", ".js", ".sass", ".jsx"],
    plugins: [
        new ExtractTextPlugin("css/app.css"),
        new CopyWebpackPlugin([{from: "./web/static/assets"}])
    ],
    resolve: {
        modulesDirectories: ["node_modules", __dirname + "/web/static/js"]
    }
};

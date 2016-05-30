var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: ["./web/static/js/app.js", "./web/static/css/app.sass"],
    output: {
        path: "./priv/static",
        filename: "js/app.js"
    },
    module: {
        loaders: [
            {
                test: /\.sass$/,
                loader: ExtractTextPlugin.extract("style", "css!sass?indentedSyntax!")
            },
            {
                test: /\.jsx?$/,
                loader: 'babel',
                exclude: /(node_modules|bower_components|semantic)/,
                include: __dirname,
                query: {
                    presets: ['es2015']
                }
            },
            {
                test: /\.(eot|woff|woff2|ttf|svg|png|jpg|gif)/,
                loader: 'url-loader?limit=30000&name=[name]-[hash].[ext]'
            }
        ]
    },
    extensions: ["", ".js", ".sass", ".jsx", ".css"],
    plugins: [
        new ExtractTextPlugin("css/app.css"),
        new CopyWebpackPlugin([{from: "./web/static/assets"}])
    ],
    resolve: {
        modulesDirectories: ["node_modules", __dirname + "/web/static/js", __dirname + "/web/static/vendor/semantic/dist"]
    }
};

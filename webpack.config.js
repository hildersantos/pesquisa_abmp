var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var webpack = require('webpack');

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
                test: /\.(eot|woff|woff2|ttf|svg)/,
                loader: 'url-loader?limit=30000&name=../fonts/[name]-[hash].[ext]'
            },
            {
                test: /\.(png|jpg|gif)/,
                loader: 'url-loader?limit=30000&name=images/[name]-[hash].[ext]'
            }
        ]
    },
    extensions: ["", ".js", ".sass", ".jsx", ".css"],
    plugins: [
        new ExtractTextPlugin("css/app.css"),
        new CopyWebpackPlugin([{from: "./web/static/assets"}]),
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery"
        })
    ],
    resolve: {
        modulesDirectories: ["node_modules", __dirname + "/web/static/js", __dirname + "/web/static/vendor/semantic/dist"]
    }
};

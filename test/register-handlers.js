// If you're using with streamline, you *must* register streamline first:
require('streamline').register({})
path = require('path')

// Register coffee-coverage if coverage is enabled.
if(process.env.COVERAGE) {
    require('coffee-coverage').register({
        path: 'abbr',
        basePath: path.join( __dirname, "../lib"),
//        exclude: ['/test', '/node_modules', '/.git'],
        initAll: true,
        streamlinejs: true
    })

    // kill logging during coverage tests.
    stub = function() {}
    methods = ['log','info','warn','error','dir','trace']
    for( i in methods )
        global.console[methods[i]] = stub
}

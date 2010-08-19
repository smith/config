var stdin = process.openStdin(), body = [];

stdin.on("data", function (chunk) { body.push(chunk); });

stdin.on("end", function () {
    var puts = require("sys").puts,
        JSLINT = require("./jslint-core").JSLINT,
        ok = JSLINT(body.join("\n")),
        error, errorCount;

    if (!ok) {
        errorCount = JSLINT.errors.length;
        for (var i = 0; i < errorCount; i += 1) {
            error = JSLINT.errors[i];
            if (error && error.reason && error.reason.match(/^Stopping/) === null) {
                puts([error.line, error.character, error.reason].join(":"));
            }
        }
    }
});

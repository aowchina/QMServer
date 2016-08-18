var fs = require('fs');
var util = require('util');
var crypto = require("crypto");

function ConsistentHash(file)
{
    var self = this;
    var continuum = [];
    var totalWeight = 0;
    var numInst = 0;

    var configContent = fs.readFileSync(file);
    var instanceConfig = JSON.parse(configContent);
    for (var i in instanceConfig) {
        totalWeight += instanceConfig[i].weight;
        numInst ++;
    }

    for (var i in instanceConfig) {
        var pct = instanceConfig[i].weight / totalWeight;
        instanceConfig[i].index = i;
        var ks = Math.floor(pct * 40 * numInst);

        for (var k = 0; k < ks; k ++) {
            var ss = util.format("%s:%d:%d", JSON.stringify(instanceConfig[i]), k, i);
            var md5 = crypto.createHash('md5').update(ss, 'utf8').digest();
            var md5d = crypto.createHash('md5').update(ss).digest("hex");
            for (var h = 0; h < 4; h ++) {
                var point = ((md5[3+h*4] << 24)
                        | (md5[2+h*4] << 16)
                        | (md5[1+h*4] << 8)
                        | md5[h*4]) >>> 0;
                continuum.push({
                    'point' : point,
                    'node' : instanceConfig[i]
                });
            }
        }
    }

    continuum = continuum.sort(function(first, second){
        if (first.point == second.point) return 0;
        if (first.point < second.point) return -1;
        else return 1; 
    });

    self._continuum = continuum;
}

ConsistentHash.prototype.getInstance = function(key)
{
    var self = this;
    
    var digest = crypto.createHash("md5").update(key).digest();
    var point = (((digest[3] << 24)
                | (digest[2] << 16)
                | (digest[1] << 8)
                | digest[0])) >>> 0;

    var continuum = self._continuum;
    var high = continuum.length;
    var low = 0;

    var result = 0;
    while (true) {
        var mid = Math.floor((low + high) / 2);
        if (mid == continuum.length) {
            result = 0;
            break;
        }

        var midval = continuum[mid].point;
        var midval1 = mid == 0 ? 0 : continuum[mid - 1].point;

        if (point <= midval && point > midval1) {
            result = mid;
            break;
        }

        if (midval < point) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }

        if (low > high) {
            result = 0;
            break;
        }
    }
    return continuum[result];
}

exports.ConsistentHash = ConsistentHash;

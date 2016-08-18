var mymongo = require('../common/mymongo');

var signUpSchema = new mymongo.Schema({
    userId : { type : String, index : true, unique: true },
    name : {type:String},
    lastSignInTime : { type: Date, default: "1970-1-1" }
});
var SignUp = mymongo.model('SignIn', signUpSchema);

function signUp(userId,name,callback){
    var obj = new SignUp();
    obj.userId = userId;
    obj.name = name;
    obj.save(function(err){
        if(err){
            console.log(err);
        }else{
            callback(name+" insert success");
        }
    });
}

function signIn(userId){
    SignUp.findOne({userId:userId},function(err,data){
        if(err){
            console.log('signin fail');
        }else{
            console.log('signup success '+data);
        }
    });
}

exports.signUp = signUp;
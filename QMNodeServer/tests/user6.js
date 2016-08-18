    var text = '<b style="font-family: \'Helvetica Neue\';">1：竞彩足球</b><div style="font-family: \'Helvetica Neue\';">&nbsp; &nbsp; &nbsp;胜平负玩法';
        text += '</div><div style="font-family: \'Helvetica Neue\';">&nbsp; &nbsp; &nbsp;比分玩法';
        text += '</div><div style="font-family: \'Helvetica Neue\';">&nbsp; &nbsp; &nbsp;<span style="color: rgb(43, 43, 43);">总进球数玩法</span>';
        text += '</div><div style="font-family: \'Helvetica Neue\';"><span style="color: rgb(43, 43, 43);">&nbsp; &nbsp; &nbsp;半全场胜平负玩法</span>';
        text += '</div>';

function stripHTML(data){
    var re= "/<\S[^><]*>/g";
    for (i=0; i<data.length; i++) {
        data=data.replace(re, "");
    }
    return data;
}

console.log(stripHTML(text));


今日铺排：

- web筛查。[ok]
- 错误码说明整理。[ok]
- 历史数据查询过滤。[ok]
- 部署线上环境。
- 上线进度安排。
- ios版本深度使用。
- 总结。
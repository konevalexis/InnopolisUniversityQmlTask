import QtQuick 2.12
import konev.io 1.0
import "convert.js" as Convert

ListModel {
    id: jsonListModel
    property var jsonObject

    function fillModel(){
        for(let i = 0; i < Object.values(jsonObject).length; i++){
            if(typeof(Object.values(jsonObject)[i]) === 'number'){
                if(Object.values(jsonObject)[i] % 1 === 0)
                    jsonListModel.append({
                                       key : Object.keys(jsonObject)[i],
                                       type : 'integer',
                                       value : String(Object.values(jsonObject)[i])
                                    })
                else jsonListModel.append({
                                        key : Object.keys(jsonObject)[i],
                                        type : 'float',
                                        value : String(Object.values(jsonObject)[i])
                                     })

            } else jsonListModel.append({
                                key : Object.keys(jsonObject)[i],
                                type : typeof(Object.values(jsonObject)[i]),
                                value : String(Object.values(jsonObject)[i])
                             })
        }
    }
    function jsonToModel(jsonString){
        jsonObject = JSON.parse(jsonString)
        fillModel()
    }
    function modelToJson(){
        jsonObject = {}

        var currentValue;
        for(var i = 0; i < count; i++){
            currentValue = jsonListModel.get(i).value
            switch(get(i).type){
                case 'integer' :
                    if(Number(currentValue) % 1 !== 0 || Number.isNaN(Number(currentValue)) || Number(currentValue) === null){
                        console.error("value of " + Object.keys(jsonListModel.jsonObject)[i] + " is not correct")
                        return
                    }
                    jsonObject[get(i).key] = Number(get(i).value)
                    break
                case 'float' :
                    if(Number.isNaN(Number(currentValue)) || Number(currentValue) === null){
                        console.error("value of " + Object.keys(jsonListModel.jsonObject)[i] + " is not correct")
                        return
                    }
                    jsonObject[get(i).key] = Number(get(i).value)
                    break
                case 'boolean' :
                    jsonObject[get(i).key] = Convert.stringToBoolean(get(i).value)
                    break
                case 'string' :
                    jsonObject[get(i).key] = get(i).value
                    break
            }
        }
        return JSON.stringify(jsonObject, null, '\t')
    }
}

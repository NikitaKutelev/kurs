import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.15
import QtQml.Models 2.15
import org.julialang 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Dialog {
        anchors.centerIn: parent
        id: dialog
        title: "Ошибка"
        modal: true
        Text{
            id: wrmes
        }
        standardButtons: Dialog.Ok
    }
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        id: formavvoda
        width: {
            if (mtr2.visible == true){
                (grid.columns + 1) * 45 + (grid2.columns + 1) * 45 + 200
            }
            else{
                (grid.columns + 1) * 45 + 200
                }
            }
        height: {
            if (grid.rows < grid2.rows){
                (grid2.rows + 1) * 20 + 100
            }
            else{
                (grid.rows + 1) * 20 + 100
                }
            }
        spacing: 20
        ColumnLayout{
            Text{
                text: "Матрица А"
            }
            GridLayout {
                id: grid
                columns: 2
                rows: 2
                Repeater{
                    id: mtr1
                    model: 4
                    delegate: Rectangle{
                        clip:true
                        height: 20
                        width: 45
                        border.color: "black"
                        TextInput{
                            id:vvod
                            anchors.centerIn: parent
                            overwriteMode: true
                            width: parent.width
                            color:"black"
                            maximumLength:5
                            autoScroll: true
                            text: "1"
                            validator: RegularExpressionValidator { regularExpression: /^\s*[\d]+([.][\d]+)?\s*$/}
                        }
                    }
                }
            }
            Row {
                Layout.alignment: Qt.AlignHCenter
                ComboBox {
                    id: msizer
                    width: 60
                    height: 30
                    textRole: "text"
                    valueRole: "value"
                    onCurrentValueChanged: {
                        grid.rows = 0
                        mtr1.model = 0
                        grid.rows = msizer.currentValue
                        mtr1.model = msizer.currentValue * msizec.currentValue
                    }
                    model: [
                        { value: 2, text: qsTr("2") },
                        { value: 3, text: qsTr("3") },
                        { value: 4, text: qsTr("4") },
                        { value: 5, text: qsTr("5") },
                        { value: 6, text: qsTr("6") }
                    ]
                }

                Text {
                    text: "x"
                }
                ComboBox {
                    id: msizec
                    textRole: "text"
                    valueRole: "value"
                    width: 60
                    height: 30
                    onCurrentValueChanged: {
                        grid.columns = 0
                        mtr1.model = 0
                        grid.columns = msizec.currentValue
                        mtr1.model = msizer.currentValue * msizec.currentValue
                    }

                    model: [
                        { value: 2, text: qsTr("2") },
                        { value: 3, text: qsTr("3") },
                        { value: 4, text: qsTr("4") },
                        { value: 5, text: qsTr("5") },
                        { value: 6, text: qsTr("6") }
                    ]
                }
            }
        }
        ColumnLayout{
            id: smatrb
            visible: false
            Text{
                text: "Матрица B"
            }

            GridLayout {
                width: 50
                id: grid2
                columns: 2
                rows: 2
                Repeater{
                    id: mtr2
                    model: 4
                    delegate: Rectangle{
                        height: 20
                        width: 45
                        border.color: "black"
                        TextInput{
                            id:vvod2
                            anchors.centerIn: parent
                            overwriteMode: true
                            width: parent.width
                            color:"black"
                            maximumLength:5
                            autoScroll: true
                            text: "1"
                            validator: RegularExpressionValidator { regularExpression: /^\s*[\d]+([.][\d]+)?\s*$/}
                        }
                    }
                }
            }
            Row {
                Layout.alignment: Qt.AlignHCenter
                ComboBox {
                    id: msizer2
                    width: 60
                    height: 30
                    textRole: "text"
                    valueRole: "value"
                    onCurrentValueChanged: {
                        grid2.rows = 0
                        mtr2.model = 0
                        grid2.rows = msizer2.currentValue
                        mtr2.model = msizer2.currentValue * msizec2.currentValue
                    }
                    model: [
                        { value: 2, text: qsTr("2") },
                        { value: 3, text: qsTr("3") },
                        { value: 4, text: qsTr("4") },
                        { value: 5, text: qsTr("5") },
                        { value: 6, text: qsTr("6") }
                    ]
                }
                Text {
                    text: "x"
                }
                ComboBox {
                    id: msizec2
                    textRole: "text"
                    valueRole: "value"
                    width: 60
                    height: 30
                    onCurrentValueChanged: {
                        grid2.columns = 0
                        mtr2.model = 0
                        grid2.columns = msizec2.currentValue
                        mtr2.model = msizer2.currentValue * msizec2.currentValue
                    }
                    model: [
                        { value: 2, text: qsTr("2") },
                        { value: 3, text: qsTr("3") },
                        { value: 4, text: qsTr("4") },
                        { value: 5, text: qsTr("5") },
                        { value: 6, text: qsTr("6") }
                    ]
                }
            }
        }
        ColumnLayout {
            anchors.right: parent.right
            width: 140
            Switch {
                Layout.alignment: Qt.AlginTop
                id: sb
                visible: true
                text: qsTr("Матрица Б")
                onPositionChanged: {
                    if (sb.position == 1){
                        btcoup.visible = true
                        smatrb.visible = true
                        btsolo.visible = false
                        solooper.visible = false
                        matroper.visible = true
                    }
                    else{
                        smatrb.visible = false
                        btsolo.visible = true
                        btcoup.visible = false
                        solooper.visible = true
                        matroper.visible = false
                        sb.visible = true
                    }
                }
            }
            ComboBox {
                Layout.alignment: Qt.AlignVCenter
                visible: true
                Layout.preferredWidth: 150
                Layout.preferredHeight: 25
                id: solooper
                textRole: "text"
                valueRole: "value"
                model: [
                { value: 1, text: qsTr("Транспонирование") },
                { value: 2, text: qsTr("Определитель") },
                { value: 3, text: qsTr("След") },
                { value: 4, text: qsTr("Ранг") },
                { value: 5, text: qsTr("Обратная") }
                ]
            }
            ComboBox {
                Layout.alignment: Qt.AlignVCenter
                visible:false
                id:matroper
                Layout.preferredWidth: 60
                Layout.preferredHeight: 25
                textRole: "text"
                valueRole: "value"
                model: [
                    { value: 1, text: qsTr("*") },
                    { value: 2, text: qsTr("-") },
                    { value: 3, text: qsTr("+") }
                ]
            }
            Button {
                Layout.alignment: Qt.AlignBottom
                visible:false
                id: btcoup
                Layout.preferredWidth: 80
                Layout.preferredHeight: 20
                text: "Посчитать"
                onClicked: {
                    var chbA = false
                    var chbB = false
                    for (var ch = 0; ch < mtr1.model; ch++){
                        if (mtr1.itemAt(ch).children[0].text == ''){
                            chbA = true
                        }
                    }
                    for (var ch = 0; ch < mtr2.model; ch++){
                        if (mtr2.itemAt(ch).children[0].text == ''){
                            chbB = true
                        }
                    }
                    if ((chbA == true) || (chbB == true)){
                        dialog.open()
                        wrmes.text="Заполните матрицы полностью"
                    }
                    else{
                        var str =""
                        for (var i = 0; i < grid.rows; ++i){
                            for (var j = 0; j < grid.columns; ++j){
                                var k = 0
                                k = j + i * grid.columns
                                str = str + mtr1.itemAt(k).children[0].text + " "
                            }
                        }
                        var str2 =""
                        for (var i2 = 0; i2 < grid2.rows; ++i2){
                            for (var j2 = 0; j2 < grid2.columns; ++j2){
                                var k2 = 0
                                k2 = j2 + i2 * grid2.columns
                                str2 = str2 + mtr2.itemAt(k2).children[0].text + " "
                            }
                        }
                        switch ( matroper.currentValue ) {
                          case 1:
                              var mul = Julia.mul(str, grid.rows, grid.columns,str2, grid2.rows, grid2.columns)
                              if (grid.columns != grid2.rows){
                                  wrmes.text = mul
                                  dialog.open()
                                  break;
                              }
                              var strh = ""
                              for (var conv = 0; conv < mul.length; ++conv){
                                  strh = strh + mul[conv] + " "
                              }
                              var mul2 = Julia.transfake(strh,grid2.columns, grid.rows)
                              var a = Julia.transH(str, grid.rows, grid.columns)
                              var b = Julia.transH(str2, grid2.rows, grid2.columns)
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation: matroper.currentText, operstr:"Умножение матриц",
                                  outcolsB: grid2.columns, outrowsB: grid2.rows,outcolsOut: grid2.columns, outrowsOut:grid.rows, resout:" " })
                              listView1.arrA = a
                              listView1.arrB = b
                              listView1.arrO = mul2
                            break;
                          case 2:
                              var minus = Julia.minus(str, grid.rows, grid.columns,str2, grid2.rows, grid2.columns)
                              if ((grid.rows != grid2.rows) || (grid.columns != grid2.columns)){
                                  wrmes.text = minus
                                  dialog.open()
                                  break;
                              }
                              var strhm = ""
                              for (var conv = 0; conv < minus.length; ++conv){
                                  strhm = strhm + minus[conv] + " "
                              }
                              var minus2 = Julia.transfake(strhm,grid2.columns, grid.rows)
                              var a = Julia.transH(str, grid.rows, grid.columns)
                              var b = Julia.transH(str2, grid2.rows, grid2.columns)
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation: matroper.currentText, operstr:"Разность матриц",
                                  outcolsB: grid2.columns, outrowsB: grid2.rows,outcolsOut: grid2.columns, outrowsOut:grid.rows, resout:" " })
                              listView1.arrA = a
                              listView1.arrB = b
                              listView1.arrO = minus2
                            break;
                          case 3:
                              var plus = Julia.plus(str, grid.rows, grid.columns,str2, grid2.rows, grid2.columns)
                              if ((grid.rows != grid2.rows) || (grid.columns != grid2.columns)){
                                  wrmes.text = plus
                                  dialog.open()
                                  break;
                              }
                              var strhp = ""
                              for (var conv = 0; conv < plus.length; ++conv){
                                  strhp = strhp + plus[conv] + " "
                              }
                              var plus2 = Julia.transfake(strhp,grid2.columns, grid.rows)
                              var a = Julia.transH(str, grid.rows, grid.columns)
                              var b = Julia.transH(str2, grid2.rows, grid2.columns)
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation: matroper.currentText, operstr:"Сложение матриц",
                                  outcolsB: grid2.columns, outrowsB: grid2.rows,outcolsOut: grid2.columns, outrowsOut:grid.rows, resout:" " })
                              listView1.arrA = a
                              listView1.arrB = b
                              listView1.arrO = plus2
                            break;
                          }
                    }
                }
            }
            Button {
                visible:true
                id: btsolo
                Layout.alignment: Qt.AlignBottom
                Layout.preferredWidth: 80
                Layout.preferredHeight: 20
                text: "Посчитать"
                onClicked: {
                    var chb = false
                    for (var ch = 0; ch < mtr1.model; ch++){
                        if (mtr1.itemAt(ch).children[0].text == ''){
                            chb = true
                        }
                    }
                    if (chb == true){
                        dialog.open()
                        wrmes.text="Заполните матрицу А полностью"
                    }
                    else{
                        var str =""
                        for (var i = 0; i < grid.rows; ++i){
                            for (var j = 0; j < grid.columns; ++j){
                                var k = 0
                                k = j + i * grid.columns
                                str = str + mtr1.itemAt(k).children[0].text + " "
                            }
                        }
                        switch ( solooper.currentValue ) {
                          case 1:
                              var tr = Julia.transfake(str, grid.rows, grid.columns)
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation:" ", outcolsB: 0, outrowsB: 0,operstr:"Транспонирование",
                              outcolsOut: grid.rows, outrowsOut: grid.columns, resout:" " })
                              var a1 = Julia.transH(str, grid.rows, grid.columns)
                              listView1.arrA = a1
                              listView1.arrO = tr
                            break;
                          case 2:
                              var det = Julia.det(str, grid.rows, grid.columns)
                              if (grid.rows != grid.columns){
                                  wrmes.text = det
                                  dialog.open()
                                  break;
                              }
                              var deta = '' + det;
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation:" ", outcolsB: 0, outrowsB: 0,operstr:"Определитель",
                              outcolsOut: 0, outrowsOut: 0, resout: deta })
                              var a2 = Julia.transH(str, grid.rows, grid.columns)
                              listView1.arrA = a2
                            break;
                          case 3:
                              var tr = Julia.tr(str, grid.rows, grid.columns)
                              if (grid.rows != grid.columns){
                                  wrmes.text = tr
                                  dialog.open()
                                  break;
                              }
                              var tra = '' + tr;
                              listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation:" ", outcolsB: 0, outrowsB: 0,operstr:"След",
                              outcolsOut: 0, outrowsOut: 0, resout: tra })
                              var a3 = Julia.transH(str, grid.rows, grid.columns)
                              listView1.arrA = a3
                              break;
                        case 4:
                            var rang = Julia.rang(str, grid.rows, grid.columns)
                            var ranga = '' + rang;
                            listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation:" ", outcolsB: 0, outrowsB: 0,operstr:"Ранг",
                            outcolsOut: 0, outrowsOut: 0, resout: ranga })
                            var a4 = Julia.transH(str, grid.rows, grid.columns)
                            listView1.arrA = a4
                            break;
                        case 5:
                            var obr = Julia.obr(str, grid.rows, grid.columns)
                            if (typeof(obr) == typeof("str")){
                                wrmes.text = obr
                                dialog.open()
                                break;
                            }
                            var stro=""
                            for (var conv = 0; conv < obr.length; ++conv){
                                stro = stro + obr[conv] + " "
                            }
                            var obr2 = Julia.transfake(stro, grid.rows, grid.columns)
                            listModel.insert(0,{outcolsA: grid.columns, outrowsA: grid.rows, operation:" ", outcolsB: 0, outrowsB: 0,operstr:"Обратная матрица",
                            outcolsOut: grid.rows, outrowsOut: grid.columns, resout:" " })
                            var a5 = Julia.transH(str, grid.rows, grid.columns)
                            listView1.arrA = a5
                            listView1.arrO = obr2
                            break;
                        }
                    }
                }
            }
        }
    }
/////Вывод///////
    // ListView для представления данных в виде списка

    ListView {
        clip: true
        id: listView1
        anchors.top: formavvoda.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        property var arrA: []
        property var arrB: []
        property var arrO: []
        delegate: Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            height: {
                Math.max(outrowsA, outrowsB, outrowsOut) * 20 + 50
            }
            ColumnLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    id:operviv
                    color:"grey"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: operstr
                }
                RowLayout{
                    GridLayout {
                        id: gridmatrA
                        columns: outcolsA
                        rows: outrowsA
                        Repeater{
                            id: mtrA
                            model: outcolsA * outrowsA
                            Component.onCompleted: {
                                var arrA = listView1.arrA
                                console.log("pzpzppzA",arrA)
                                for (var it = 0; it < arrA.length; ++it){
                                    mtrA.itemAt(it).children[0].text = arrA[it]
                                }
                            }
                            delegate: Rectangle{
                                height: 20
                                width: 45
                                border.color: "black"
                                Text{
                                    maximumLineCount: 3
                                    anchors.centerIn: parent
                                    text: "1ggg"
                                }
                            }
                        }
                    }
                    Text {
                        text: operation
                    }
                    GridLayout {
                        id: gridmatrB
                        columns: outcolsB
                        rows: outrowsB
                        Repeater{
                            id: mtrB
                            model: outcolsB * outrowsB
                            Component.onCompleted: {
                                var arrB = listView1.arrB
                                console.log("pzpzppzB",arrB)
                                for (var it = 0; it < arrB.length; ++it){
                                    mtrB.itemAt(it).children[0].text = arrB[it]
                                }
                            }
                            delegate: Rectangle{
                                height: 20
                                width: 45
                                border.color: "black"
                                Text{
                                    maximumLineCount: 3
                                    anchors.centerIn: parent
                                    text: "1ggg"
                                }
                            }
                        }
                    }
                    Text{
                        text: "="
                    }
                    GridLayout {
                        id: gridout
                        columns: outcolsOut
                        rows: outrowsOut
                        Repeater{
                            id: mtrout
                            model: outcolsOut * outrowsOut
                            Component.onCompleted: {
                                var arrO = listView1.arrO
                                console.log("pzpzppzO",arrO)
                                for (var it = 0; it < arrO.length; ++it){
                                    mtrout.itemAt(it).children[0].text = Julia.float_to_frac(arrO[it])
                                }
                            }
                            delegate: Rectangle{
                                height: 20
                                width: 45
                                border.color: "black"
                                Text{
                                    maximumLineCount: 3
                                    anchors.centerIn: parent
                                    text: "1"
                                }
                            }
                        }
                    }
                    Text{
                        id:ressolo
                        text: resout
                    }
                }
            }
        }
        model: ListModel {
            id: listModel
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "To-Do List"

    ListModel {
        id: taskModel
        ListElement { task: "Пример задачи"; completed: false }
    }

    Column {
        anchors.fill: parent
        spacing: 10
        padding: 20

        Text {
            text: "To-Do List"
            font.pointSize: 24
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: taskInput
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Введите задачу"
        }

        Button {
            text: "Добавить"
            onClicked: {
                if (taskInput.text !== "") {
                    taskModel.append({"task": taskInput.text, "completed": false})
                    taskInput.text = ""
                }
            }
        }

        Button {
            text: "Удалить выполненные"
            onClicked: {
                for (var i = taskModel.count - 1; i >= 0; i--) {
                    if (taskModel.get(i).completed) {
                        taskModel.remove(i)
                    }
                }
            }
        }

        ListView {
            id: taskListView
            width: parent.width
            height: 300
            model: taskModel

            delegate: Item {
                width: parent.width
                height: 50

                Row {
                    spacing: 10
                    anchors.centerIn: parent

                    CheckBox {
                        checked: model.completed
                        onCheckedChanged: {
                            model.completed = checked
                        }
                    }

                    Text {
                        text: model.task
                        width: parent.width * 0.5
                        color: model.completed ? "green" : "black"
                    }

                    Button {
                        text: "Удалить"
                        onClicked: {
                            taskModel.remove(index)
                        }
                    }
                }
            }
        }
    }
}

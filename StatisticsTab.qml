import QtQuick 2.7
import QtCharts 2.0
import QtQuick.Controls 2.0

Item {

    anchors.fill: parent

    ChartView {

        anchors.fill: parent

        BarSeries {
            id: bars

        }
    }
    VBarModelMapper {
        id: mapper
        model: statistics
        firstBarSetColumn: 0
        lastBarSetColumn: 0
        firstRow: 0
        series: bars
        onRowCountChanged: {
            console.log("COUNT CHANGED");
        }
    }


    Button {
        onPressed: {
            statistics.add(120,
                           new Date().toLocaleDateString("yy.MMM.dd"),
                           7,
                           500,
                           false);
        }
    }
}



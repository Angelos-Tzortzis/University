# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'c:\Users\user\Documents\University\hci_project\main_window.ui'
#
# Created by: PyQt5 UI code generator 5.15.9
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(720, 480)
        MainWindow.setStyleSheet("background-color:rgb(48, 48, 48)")
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.Title = QtWidgets.QLabel(self.centralwidget)
        self.Title.setGeometry(QtCore.QRect(260, 60, 200, 32))
        font = QtGui.QFont()
        font.setFamily("TimeBurner")
        font.setPointSize(16)
        font.setBold(True)
        font.setWeight(75)
        self.Title.setFont(font)
        self.Title.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.Title.setStyleSheet("color: rgp(0, 1, 2)")
        self.Title.setAlignment(QtCore.Qt.AlignCenter)
        self.Title.setObjectName("Title")
        self.enterButton = QtWidgets.QPushButton(self.centralwidget)
        self.enterButton.setGeometry(QtCore.QRect(310, 120, 100, 35))
        font = QtGui.QFont()
        font.setFamily("TimeBurner")
        font.setPointSize(14)
        font.setBold(True)
        font.setWeight(75)
        self.enterButton.setFont(font)
        self.enterButton.setStyleSheet("color: white;\n"
"                        background-color:rgb(85, 85, 255);\n"
"                        border-radius: 10;\n"
"                    ")
        self.enterButton.setObjectName("enterButton")
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.Title.setText(_translate("MainWindow", "<html><head/><body><p><span style=\"\n"
"                        color:#ffffff;\">Virtual\n"
"                        Assistant</span></p></body></html>"))
        self.enterButton.setText(_translate("MainWindow", "Enter"))

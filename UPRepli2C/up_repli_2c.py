# -*- coding: utf-8 -*-
"""
/***************************************************************************
 UPRepli2C
                                 A QGIS plugin
 Replicate Shape file to the C drive for 3D city modeling
                              -------------------
        begin                : 2016-08-21
        git sha              : $Format:%H$
        copyright            : (C) 2016 by Toshio Yamazaki / UPCS
        email                : lisa9500jp@gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
"""
# IMPORT MODULES
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from qgis.core import *
from qgis.gui import *

import sys
import os
import shutil

# Initialize Qt resources from file resources.py
import resources

# Import the code for the dialog
from up_repli_2c_dialog import UPRepli2CDialog


class UPRepli2C:
    """QGIS Plugin Implementation."""

    def __init__(self, iface):
        """Constructor.

        :param iface: An interface instance that will be passed to this class
            which provides the hook by which you can manipulate the QGIS
            application at run time.
        :type iface: QgsInterface
        """
        # Save reference to the QGIS interface
        self.iface = iface
        # initialize plugin directory
        self.plugin_dir = os.path.dirname(__file__)
        # initialize locale
        locale = QSettings().value('locale/userLocale')[0:2]
        locale_path = os.path.join(
            self.plugin_dir,
            'i18n',
            'UPRepli2C_{}.qm'.format(locale))

        if os.path.exists(locale_path):
            self.translator = QTranslator()
            self.translator.load(locale_path)

            if qVersion() > '4.3.3':
                QCoreApplication.installTranslator(self.translator)

        # Create the dialog (after translation) and keep reference
        self.dlg = UPRepli2CDialog()

        # Declare instance attributes
        self.actions = []
        self.menu = self.tr(u'&Up Repli 2C')
        # TODO: We are going to let the user set this up in a future iteration
        self.toolbar = self.iface.addToolBar(u'UPRepli2C')
        self.toolbar.setObjectName(u'UPRepli2C')

    # noinspection PyMethodMayBeStatic
    def tr(self, message):
        """Get the translation for a string using Qt translation API.

        We implement this ourselves since we do not inherit QObject.

        :param message: String for translation.
        :type message: str, QString

        :returns: Translated version of message.
        :rtype: QString
        """
        # noinspection PyTypeChecker,PyArgumentList,PyCallByClass
        return QCoreApplication.translate('UPRepli2C', message)


    def add_action(
        self,
        icon_path,
        text,
        callback,
        enabled_flag=True,
        add_to_menu=True,
        add_to_toolbar=True,
        status_tip=None,
        whats_this=None,
        parent=None):
        """Add a toolbar icon to the toolbar.

        :param icon_path: Path to the icon for this action. Can be a resource
            path (e.g. ':/plugins/foo/bar.png') or a normal file system path.
        :type icon_path: str

        :param text: Text that should be shown in menu items for this action.
        :type text: str

        :param callback: Function to be called when the action is triggered.
        :type callback: function

        :param enabled_flag: A flag indicating if the action should be enabled
            by default. Defaults to True.
        :type enabled_flag: bool

        :param add_to_menu: Flag indicating whether the action should also
            be added to the menu. Defaults to True.
        :type add_to_menu: bool

        :param add_to_toolbar: Flag indicating whether the action should also
            be added to the toolbar. Defaults to True.
        :type add_to_toolbar: bool

        :param status_tip: Optional text to show in a popup when mouse pointer
            hovers over the action.
        :type status_tip: str

        :param parent: Parent widget for the new action. Defaults None.
        :type parent: QWidget

        :param whats_this: Optional text to show in the status bar when the
            mouse pointer hovers over the action.

        :returns: The action that was created. Note that the action is also
            added to self.actions list.
        :rtype: QAction
        """

        icon = QIcon(icon_path)
        action = QAction(icon, text, parent)
        action.triggered.connect(callback)
        action.setEnabled(enabled_flag)

        if status_tip is not None:
            action.setStatusTip(status_tip)

        if whats_this is not None:
            action.setWhatsThis(whats_this)

        if add_to_toolbar:
            self.toolbar.addAction(action)

        if add_to_menu:
            self.iface.addPluginToMenu(
                self.menu,
                action)

        self.actions.append(action)

        return action

    def initGui(self):
        """Create the menu entries and toolbar icons inside the QGIS GUI."""

        icon_path = ':/plugins/UPRepli2C/icon.png'
        self.add_action(
            icon_path,
            text=self.tr(u'Up Repli 2C'),
            callback=self.run,
            parent=self.iface.mainWindow())


    def unload(self):
        """Removes the plugin menu item and icon from QGIS GUI."""
        for action in self.actions:
            self.iface.removePluginMenu(
                self.tr(u'&Up Repli 2C'),
                action)
            self.iface.removeToolBarIcon(action)
        # remove the toolbar
        del self.toolbar

    def tatemonoFunc(self):
        # ファイル選択ダイアログを表示し，テキストブラウザにファイル名を入力
        self.fil = QFileDialog.getOpenFileName(parent=None, caption='Open Shapefiles', directory='.', filter='Shapefiles(*.shp)')
        filInfo = QFileInfo(self.fil)
        self.filename = filInfo.fileName()
        self.dlg.tatemonoBrowser.setText(self.filename)

        # shpファイル・dbfファイル・shxファイルの名称を変更する
        shpName = filInfo.fileName()
        dbfName = shpName.replace('.shp', '.dbf')
        shxName = shpName.replace('.shp', '.shx')

        dirName = os.path.dirname(self.fil)

        self.shpFile = dirName + "/" + shpName
        self.dbfFile = dirName + "/" + dbfName
        self.shxFile = dirName + "/" + shxName

    def hyoukouFunc(self):
        # ファイル選択ダイアログを表示し，テキストブラウザにファイル名を入力
        self.fil2 = QFileDialog.getOpenFileName(parent=None, caption='Open Shapefiles', directory='.', filter='Shapefiles(*.shp)')
        filInfo2 = QFileInfo(self.fil2)
        self.filename2 = filInfo2.fileName()
        self.dlg.hyoukouBrowser.setText(self.filename2)

        # shpファイル・dbfファイル・shxファイルの名称を変更する
        shpName2 = filInfo2.fileName()
        dbfName2 = shpName2.replace('.shp', '.dbf')
        shxName2 = shpName2.replace('.shp', '.shx')

        dirName = os.path.dirname(self.fil)

        self.shpFile2 = dirName + "/" + shpName2
        self.dbfFile2 = dirName + "/" + dbfName2
        self.shxFile2 = dirName + "/" + shxName2


    def run(self):
        """Run method that performs all the real work"""
        # show the dialog
        self.dlg.show()

        # 建築物の外周線の選択ボタンをクリックしてファイル選択ダイアログを表示
        self.dlg.tatemonoButton.clicked.connect(self.tatemonoFunc)

        # 標高メッシュの選択ボタンをクリックしてファイル選択ダイアログを表示
        self.dlg.hyoukouButton.clicked.connect(self.hyoukouFunc)

        # Run the dialog event loop
        result = self.dlg.exec_()
        # See if OK was pressed
        if result:
            # Do something useful here - delete the line containing pass and
            # substitute with your code.
            # pass

            # C:\にdataディレクトリがなければ作成する
            dirs = os.listdir("C:/")
            if 'data' not in dirs:
                os.mkdir("C:/data")

            # C:\dataに建築物の外周線ファイルをbuildingにリネームしてコピーする
            shutil.copyfile(self.shpFile, "C:/data/building.shp")
            shutil.copyfile(self.dbfFile, "C:/data/building.dbf")
            shutil.copyfile(self.shxFile, "C:/data/building.shx")

            # C:\dataに標高メッシュファイルをhyoukouにリネームしてコピーする
            shutil.copyfile(self.shpFile2, "C:/data/hyoukou_mesh.shp")
            shutil.copyfile(self.dbfFile2, "C:/data/hyoukou_mesh.dbf")
            shutil.copyfile(self.shxFile2, "C:/data/hyoukou_mesh.shx")

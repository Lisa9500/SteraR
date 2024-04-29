# -*- coding: utf-8 -*-
"""
/***************************************************************************
 UPRepli2C
                                 A QGIS plugin
 =Replicate Shape file to the C drive to PostGIS
                             -------------------
        begin                : 2016-08-24
        copyright            : (C) 2016 by Toshio Yamazaki / UPCS
        email                : lisa9500jp@gmail.com
        git sha              : $Format:%H$
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 This script initializes the plugin, making it known to QGIS.
"""


# noinspection PyPep8Naming
def classFactory(iface):  # pylint: disable=invalid-name
    """Load UPRepli2C class from file UPRepli2C.

    :param iface: A QGIS interface instance.
    :type iface: QgsInterface
    """
    #
    from .up_repli_2c import UPRepli2C
    return UPRepli2C(iface)

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671C2DE319
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 06:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfJUETZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 00:19:25 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:41382
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbfJUETY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:24 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2019 00:19:10 EDT
Received: from localhost.localdomain ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MP2oifB4Hr3FgMP35iDyat; Sun, 20 Oct 2019 21:12:04 -0700
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 8/8] iio: position: Add support for Azoteq IQS624/625 angle sensor
Date:   Sun, 20 Oct 2019 23:11:23 -0500
Message-Id: <1571631083-4962-9-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571631083-4962-1-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
X-CMAE-Envelope: MS4wfCrKAUq7cK63kIZBAVZ3DeYhkNHems3Cp8/Ghwy/Higeru/SSzta8+3iOHp8rgw2EL6mOdAYGmCVCo3KMkZrRHYyGgOU1+gIzUF+JSDZb5KMdjFLS8B0
 a1lp6pTrN9N3/WmMHpWIxtOCg1CeMyf9fkSmOPVjHH3FUWDxJ3sdUiNJouyYnoOqON+IyWnhS6wrNDXKunN8erVI3fMoHmXXs7x+suFUXtG6IZrVS290crSM
 zTwpYDScAVj2s+indksHrJOkWQ0uU6sIStabUDkEfC/mYBZ+SE0E2V/M/OMyF+2KQkV4n2gtrikdPa9PJ2ixWHgy2wszRyyn9wq+2QdlqY+O2f9hWhBR9GfP
 fY5r0ArZGa8AajBfH8HoT2pRfeDaHaQ0TaFL1UUeb64Qf2LIGjzP1ASLOMwbPQGNAlBrazyIRd6MFcGHAFXvwWlXG+urrZlwCh2pEWkZpaikmkv3k2sJLcTN
 j1VQJLBO0RS6DIqfMZyDlTGNCVT98mMuInqqfzStp9S+IrETNvLeOngZ0cB/no4tUgfYwoKDGMEaqnTdrTILHe+Y6gRbumAg7kieN2YMovWkKiiYpjl+ZY7P
 jGdOZ7gmQgHcKgNRzx6WDvpqetI2RjSGiGNfjUuA3kK9heqKUiOGowetCDogwzPNiZUr3HS2vfipcr7rm0hERsmKOYyBQhBVtoa1LA9V320RRbBtsD9WTNCv
 oRpAh5TE4XWqnsAULuPqiNrL5G4T3fNixSKj2Tb8TCySty231k4jBQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS624 and IQS625 angular position
sensors, capable of reporting the angle of a rotating shaft down to 1 and
10 degrees of accuracy, respectively.

This patch also introduces a home for linear and angular position sensors.
Unlike resolvers, they are typically contactless and use the Hall effect.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/iio/Kconfig               |   1 +
 drivers/iio/Makefile              |   1 +
 drivers/iio/position/Kconfig      |  19 +++
 drivers/iio/position/Makefile     |   7 +
 drivers/iio/position/iqs624-pos.c | 302 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 330 insertions(+)
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5bd5185..d5c073a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
+source "drivers/iio/position/Kconfig"
 source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index bff682a..1712011 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -31,6 +31,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += position/
 obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
new file mode 100644
index 0000000..ed9f975
--- /dev/null
+++ b/drivers/iio/position/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Linear and angular position sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Linear and angular position sensors"
+
+config IQS624_POS
+	tristate "Azoteq IQS624/625 angular position sensor"
+	depends on MFD_IQS62X
+	help
+	  Say Y here if you want to build support for the Azoteq IQS624
+	  and IQS625 angular position sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs624-pos.
+
+endmenu
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
new file mode 100644
index 0000000..3cbe7a7
--- /dev/null
+++ b/drivers/iio/position/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO linear and angular position sensors
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
new file mode 100644
index 0000000..d975065
--- /dev/null
+++ b/drivers/iio/position/iqs624-pos.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS624/625 Angular Position Sensor
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS624_POS_DEG_OUT			0x16
+
+#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE2			100000
+
+struct iqs624_pos_private {
+	struct iqs62x_core *iqs62x;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool event_en;
+	union {
+		u16 angle;
+		u8 interval;
+	};
+};
+
+static int iqs624_pos_init(struct iqs624_pos_private *iqs624_pos)
+{
+	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
+	unsigned int val;
+	int error;
+	__le16 val_buf;
+
+	if (iqs62x->dev_desc->prod_num == IQS624_PROD_NUM) {
+		error = regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT,
+					&val_buf, sizeof(val_buf));
+		if (error)
+			return error;
+
+		iqs624_pos->angle = le16_to_cpu(val_buf);
+	} else {
+		error = regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
+				    &val);
+		if (error)
+			return error;
+
+		iqs624_pos->interval = val;
+	}
+
+	mutex_lock(&iqs624_pos->lock);
+
+	/*
+	 * The IQS625 reports angular position in the form of coarse intervals,
+	 * so only interval change events are unmasked. Conversely, the IQS624
+	 * reports angular position down to one degree of resolution, so wheel
+	 * movement events are unmasked instead.
+	 */
+	error = regmap_update_bits(iqs62x->map, IQS624_HALL_UI,
+				   iqs62x->dev_desc->prod_num ==
+				   IQS624_PROD_NUM ? IQS624_HALL_UI_WHL_EVENT :
+						     IQS624_HALL_UI_INT_EVENT,
+				   iqs624_pos->event_en ? 0 : 0xFF);
+
+	mutex_unlock(&iqs624_pos->lock);
+
+	return error;
+}
+
+static int iqs624_pos_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data = context;
+	struct iqs624_pos_private *iqs624_pos;
+	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
+	int error;
+
+	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
+				  notifier);
+	indio_dev = iio_priv_to_dev(iqs624_pos);
+	iqs62x = iqs624_pos->iqs62x;
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		error = iqs624_pos_init(iqs624_pos);
+		if (error) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to re-initialize device: %d\n", error);
+			return NOTIFY_BAD;
+		}
+
+		return NOTIFY_OK;
+	}
+
+	if (iqs62x->dev_desc->prod_num == IQS624_PROD_NUM) {
+		if (event_data->ui_data == iqs624_pos->angle)
+			return NOTIFY_DONE;
+
+		iqs624_pos->angle = event_data->ui_data;
+	} else {
+		if (event_data->interval == iqs624_pos->interval)
+			return NOTIFY_DONE;
+
+		iqs624_pos->interval = event_data->interval;
+	}
+
+	if (!iqs624_pos->event_en)
+		return NOTIFY_OK;
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
+					    IIO_EV_TYPE_CHANGE,
+					    IIO_EV_DIR_NONE),
+		       iio_get_time_ns(indio_dev));
+
+	return NOTIFY_OK;
+}
+
+static void iqs624_pos_notifier_unregister(void *context)
+{
+	struct iqs624_pos_private *iqs624_pos = context;
+	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
+	int error;
+
+	error = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
+						   &iqs624_pos->notifier);
+	if (error)
+		dev_err(indio_dev->dev.parent,
+			"Failed to unregister notifier: %d\n", error);
+}
+
+static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
+	int error;
+	__le16 val_buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iqs62x->dev_desc->prod_num == IQS624_PROD_NUM) {
+			error = regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT,
+						&val_buf, sizeof(val_buf));
+			if (error)
+				return error;
+
+			*val = le16_to_cpu(val_buf);
+		} else {
+			error = regmap_read(iqs62x->map,
+					    iqs62x->dev_desc->interval, val);
+			if (error)
+				return error;
+		}
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (iqs62x->dev_desc->prod_num == IQS624_PROD_NUM) {
+			*val = IQS624_POS_SCALE1;
+		} else {
+			error = regmap_read(iqs62x->map, IQS624_INTERVAL_DIV,
+					    val);
+			if (error)
+				return error;
+
+			*val *= IQS624_POS_SCALE1;
+		}
+
+		*val2 = IQS624_POS_SCALE2;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+
+	return iqs624_pos->event_en;
+}
+
+static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 int state)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
+	int error;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	error = regmap_update_bits(iqs62x->map, IQS624_HALL_UI,
+				   iqs62x->dev_desc->prod_num ==
+				   IQS624_PROD_NUM ? IQS624_HALL_UI_WHL_EVENT :
+						     IQS624_HALL_UI_INT_EVENT,
+				   state ? 0 : 0xFF);
+	if (!error)
+		iqs624_pos->event_en = state;
+
+	mutex_unlock(&iqs624_pos->lock);
+
+	return error;
+}
+
+static const struct iio_info iqs624_pos_info = {
+	.read_raw = &iqs624_pos_read_raw,
+	.read_event_config = iqs624_pos_read_event_config,
+	.write_event_config = iqs624_pos_write_event_config,
+};
+
+static const struct iio_event_spec iqs624_pos_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_NONE,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec iqs624_pos_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = iqs624_pos_events,
+		.num_event_specs = ARRAY_SIZE(iqs624_pos_events),
+	},
+};
+
+static int iqs624_pos_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs624_pos_private *iqs624_pos;
+	struct iio_dev *indio_dev;
+	int error;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->channels = iqs624_pos_channels;
+	indio_dev->num_channels = ARRAY_SIZE(iqs624_pos_channels);
+	indio_dev->name = iqs62x->dev_desc->dev_name;
+	indio_dev->info = &iqs624_pos_info;
+
+	iqs624_pos = iio_priv(indio_dev);
+	iqs624_pos->iqs62x = iqs62x;
+
+	mutex_init(&iqs624_pos->lock);
+
+	error = iqs624_pos_init(iqs624_pos);
+	if (error)
+		return error;
+
+	iqs624_pos->notifier.notifier_call = iqs624_pos_notifier;
+	error = blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
+						 &iqs624_pos->notifier);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&pdev->dev,
+					 iqs624_pos_notifier_unregister,
+					 iqs624_pos);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to add action: %d\n", error);
+		return error;
+	}
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs624_pos_platform_driver = {
+	.driver = {
+		.name	= IQS624_DRV_NAME_POS,
+	},
+	.probe		= iqs624_pos_probe,
+};
+module_platform_driver(iqs624_pos_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS624_DRV_NAME_POS);
-- 
2.7.4


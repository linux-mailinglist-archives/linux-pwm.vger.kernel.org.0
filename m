Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86FCDE2F8
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 06:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfJUETM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 00:19:12 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:56740
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbfJUETM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:12 -0400
Received: from localhost.localdomain ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MP2oifB4Hr3FgMP2viDyYA; Sun, 20 Oct 2019 21:11:54 -0700
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 2/8] mfd: Add support for Azoteq IQS620A/621/622/624/625
Date:   Sun, 20 Oct 2019 23:11:17 -0500
Message-Id: <1571631083-4962-3-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571631083-4962-1-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
X-CMAE-Envelope: MS4wfGWsfb62NDCWwpS6nClPLMOf1dTmNmUh67rXbPj6ws1wHo4XKp8DPtiJpuWx3ouWu7dN8lkNLC9d23j/uR+vxhImwWqNvMkglsJtsvy3vq9g/sN5pPuA
 ni0F44YX4BNfvGhDfaFsPV2cJKOphL1WqKwNjSx016oRqIVlKKlk9FxguwfSopf2ySu92ejkTg01yLq9x6Iue/Tcex8zbH5Via/m8SrJoiQH5CdLEHy1xh+D
 welr9PWimacOcjDl27OOszyrKJXWHyMbMHWR0z0xg9gcvugDMjUdJwSRlVh+fQEo2HIo/qSXsT4zxDmZC7qJKNqFAuz/qPvoCN/sO7/vfHaVd0amzwn4hUTE
 1z7flWHjTmmew0adGAcrcEJk4ii6woZC3pGao/lVdokIysF1QVEYNusCu9jOxKmMPBA6rDsF0pQuHnurERtKIYfvaYaE+lEftFX8L5/+u57GrX5He0390L8x
 d42t4/psHBN6as0TYOSlSDvyc65SodiDyrkf8L1BIOZrYTMfLe2rXWX0fKgJMYB7Rt529bb2bWr0z+V24v9TFr/08U04fIJcHkYebohXXRlb8kzurefvJjZj
 52B0DCjhz4EbmuWFOgDtw4WfbJ1HMoffc3v/aLAFOddCPRC0mTApi0cvNKhOBJfs7aIiXRJXgculsHKJjNa8a2njNW9rKzqe6nV7EYY31QNTPJ9s/y35xGv7
 HLYlnQTH6C5ji6DFdnv1PE3T1L54FKo031kuad+1mh7layFOd64lZw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for core functions common to all six-channel
members of the Azoteq ProxFusion family of sensor devices.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/mfd/Kconfig         |  13 +
 drivers/mfd/Makefile        |   2 +
 drivers/mfd/iqs62x-core.c   | 638 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/iqs62x-tables.c | 424 +++++++++++++++++++++++++++++
 include/linux/mfd/iqs62x.h  | 148 ++++++++++
 5 files changed, 1225 insertions(+)
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 include/linux/mfd/iqs62x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae24d3e..df391f7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -642,6 +642,19 @@ config MFD_IPAQ_MICRO
 	  AT90LS8535 microcontroller flashed with a special iPAQ
 	  firmware using the custom protocol implemented in this driver.
 
+config MFD_IQS62X
+	tristate "Azoteq IQS620A/621/622/624/625 core support"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build support for six-channel members of
+	  the Azoteq ProxFusion family of sensor devices. Additional options
+	  must be selected to enable device-specific functions.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called iqs62x.
+
 config MFD_JANZ_CMODIO
 	tristate "Janz CMOD-IO PCI MODULbus Carrier Board"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c1067ea..23dd71c6 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -256,3 +256,5 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 
+iqs62x-objs			:= iqs62x-core.o iqs62x-tables.o
+obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
diff --git a/drivers/mfd/iqs62x-core.c b/drivers/mfd/iqs62x-core.c
new file mode 100644
index 0000000..e2200c8
--- /dev/null
+++ b/drivers/mfd/iqs62x-core.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ *
+ * These devices rely on application-specific register settings and calibration
+ * data developed in and exported from a suite of GUIs offered by the vendor. A
+ * separate tool converts the GUIs' ASCII-based output into a standard firmware
+ * file parsed by the driver.
+ *
+ * Link to data sheets and GUIs: https://www.azoteq.com/products/proxfusion/
+ *
+ * Link to conversion tool: https://github.com/jlabundy/iqs62x-h2bin.git
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include <linux/mfd/iqs62x.h>
+
+#define IQS62X_PROD_NUM				0x00
+
+#define IQS62X_SYS_FLAGS			0x10
+#define IQS62X_SYS_FLAGS_IN_ATI			BIT(2)
+
+#define IQS622_PROX_SETTINGS_4			0x48
+#define IQS620_PROX_SETTINGS_4			0x50
+#define IQS620_PROX_SETTINGS_4_SAR_EN		BIT(7)
+
+#define IQS62X_SYS_SETTINGS			0xD0
+#define IQS62X_SYS_SETTINGS_SOFT_RESET		BIT(7)
+#define IQS62X_SYS_SETTINGS_ACK_RESET		BIT(6)
+#define IQS62X_SYS_SETTINGS_EVENT_MODE		BIT(5)
+#define IQS62X_SYS_SETTINGS_REDO_ATI		BIT(1)
+
+#define IQS62X_PWR_SETTINGS			0xD2
+#define IQS62X_PWR_SETTINGS_DIS_AUTO		BIT(5)
+#define IQS62X_PWR_SETTINGS_PWR_MODE_MASK	(BIT(4) | BIT(3))
+#define IQS62X_PWR_SETTINGS_PWR_MODE_HALT	(BIT(4) | BIT(3))
+#define IQS62X_PWR_SETTINGS_PWR_MODE_NORM	0
+
+#define IQS62X_OTP_CMD				0xF0
+#define IQS62X_OTP_CMD_FG3			0x13
+#define IQS62X_OTP_DATA				0xF1
+#define IQS62X_MAX_REG				0xFF
+
+#define IQS62X_HALL_CAL_MASK			0x0F
+
+#define IQS62X_ATI_TIMEOUT			10
+
+#define IQS62X_FW_REC_TYPE_INFO			0
+#define IQS62X_FW_REC_TYPE_PROD			1
+#define IQS62X_FW_REC_TYPE_HALL			2
+#define IQS62X_FW_REC_TYPE_MASK			3
+#define IQS62X_FW_REC_TYPE_DATA			4
+
+struct iqs62x_fw_rec {
+	u8 type;
+	u8 addr;
+	u8 len;
+	u8 data;
+} __packed;
+
+struct iqs62x_fw_blk {
+	struct list_head list;
+	u8 addr;
+	u8 mask;
+	u8 len;
+	u8 data[];
+};
+
+struct iqs62x_info {
+	u8 prod_num;
+	u8 sw_num;
+	u8 hw_num;
+} __packed;
+
+static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
+{
+	struct iqs62x_fw_blk *fw_blk;
+	unsigned int val;
+	int error, i;
+
+	list_for_each_entry(fw_blk, &iqs62x->fw_blk_head, list) {
+		if (fw_blk->mask)
+			error = regmap_update_bits(iqs62x->map, fw_blk->addr,
+						   fw_blk->mask, *fw_blk->data);
+		else
+			error = regmap_raw_write(iqs62x->map, fw_blk->addr,
+						 fw_blk->data, fw_blk->len);
+		if (error)
+			return error;
+	}
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS622_PROD_NUM:
+		error = regmap_read(iqs62x->map,
+				    iqs62x->dev_desc->prod_num ==
+				    IQS620_PROD_NUM ? IQS620_PROX_SETTINGS_4 :
+						      IQS622_PROX_SETTINGS_4,
+				    &val);
+		if (error)
+			return error;
+
+		if (val & IQS620_PROX_SETTINGS_4_SAR_EN)
+			iqs62x->ui_sel = IQS62X_UI_SAR1;
+		/* fall through */
+
+	case IQS621_PROD_NUM:
+		error = regmap_write(iqs62x->map, IQS620_GLBL_EVENT_MASK,
+				     IQS620_GLBL_EVENT_MASK_PMU |
+				     iqs62x->dev_desc->prox_mask |
+				     iqs62x->dev_desc->sar_mask |
+				     iqs62x->dev_desc->hall_mask |
+				     iqs62x->dev_desc->hyst_mask |
+				     iqs62x->dev_desc->temp_mask |
+				     iqs62x->dev_desc->als_mask |
+				     iqs62x->dev_desc->ir_mask);
+		if (error)
+			return error;
+		break;
+
+	default:
+		error = regmap_write(iqs62x->map, IQS624_HALL_UI,
+				     IQS624_HALL_UI_WHL_EVENT |
+				     IQS624_HALL_UI_INT_EVENT |
+				     IQS624_HALL_UI_AUTO_CAL);
+		if (error)
+			return error;
+
+		error = regmap_read(iqs62x->map, IQS624_INTERVAL_DIV, &val);
+		if (error)
+			return error;
+
+		if (val >= iqs62x->dev_desc->interval_div)
+			break;
+
+		error = regmap_write(iqs62x->map, IQS624_INTERVAL_DIV,
+				     iqs62x->dev_desc->interval_div);
+		if (error)
+			return error;
+	}
+
+	error = regmap_update_bits(iqs62x->map, IQS62X_SYS_SETTINGS,
+				   IQS62X_SYS_SETTINGS_ACK_RESET |
+				   IQS62X_SYS_SETTINGS_EVENT_MODE |
+				   IQS62X_SYS_SETTINGS_REDO_ATI, 0xFF);
+	if (error)
+		return error;
+
+	for (i = 0; i < IQS62X_ATI_TIMEOUT; i++) {
+		msleep(50);
+
+		error = regmap_read(iqs62x->map, IQS62X_SYS_FLAGS, &val);
+		if (error)
+			return error;
+
+		if (!(val & IQS62X_SYS_FLAGS_IN_ATI))
+			break;
+	}
+
+	if (i == IQS62X_ATI_TIMEOUT)
+		return -ETIME;
+
+	/*
+	 * The following delay accommodates the post-ATI stabilization time
+	 * specified in the data sheet (with additional margin).
+	 */
+	msleep(150);
+
+	return 0;
+}
+
+static int iqs62x_fw_parse(struct iqs62x_core *iqs62x,
+			   const struct firmware *fw)
+{
+	struct i2c_client *client = iqs62x->client;
+	struct iqs62x_fw_rec *fw_rec;
+	struct iqs62x_fw_blk *fw_blk;
+	unsigned int hall_cal_index = 0;
+	size_t pos = 0;
+	int error = 0;
+	u8 mask, len;
+	u8 *data;
+
+	while (pos < fw->size) {
+		if (pos + sizeof(*fw_rec) > fw->size) {
+			error = -EINVAL;
+			break;
+		}
+		fw_rec = (struct iqs62x_fw_rec *)(fw->data + pos);
+		pos += sizeof(*fw_rec);
+
+		if (pos + fw_rec->len - 1 > fw->size) {
+			error = -EINVAL;
+			break;
+		}
+		pos += fw_rec->len - 1;
+
+		switch (fw_rec->type) {
+		case IQS62X_FW_REC_TYPE_INFO:
+			continue;
+
+		case IQS62X_FW_REC_TYPE_PROD:
+			if (fw_rec->data == iqs62x->dev_desc->prod_num)
+				continue;
+
+			dev_err(&client->dev,
+				"Incompatible product number: 0x%02X\n",
+				fw_rec->data);
+			error = -EINVAL;
+			break;
+
+		case IQS62X_FW_REC_TYPE_HALL:
+			if (!hall_cal_index) {
+				error = regmap_write(iqs62x->map,
+						     IQS62X_OTP_CMD,
+						     IQS62X_OTP_CMD_FG3);
+				if (error)
+					break;
+
+				error = regmap_read(iqs62x->map,
+						    IQS62X_OTP_DATA,
+						    &hall_cal_index);
+				if (error)
+					break;
+
+				hall_cal_index &= IQS62X_HALL_CAL_MASK;
+				if (!hall_cal_index) {
+					dev_err(&client->dev,
+						"Uncalibrated device\n");
+					error = -ENODATA;
+					break;
+				}
+			}
+
+			if (hall_cal_index > fw_rec->len) {
+				error = -EINVAL;
+				break;
+			}
+
+			mask = 0;
+			data = &fw_rec->data + hall_cal_index - 1;
+			len = sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_MASK:
+			if (fw_rec->len < (sizeof(mask) + sizeof(*data))) {
+				error = -EINVAL;
+				break;
+			}
+
+			mask = fw_rec->data;
+			data = &fw_rec->data + sizeof(mask);
+			len = sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_DATA:
+			mask = 0;
+			data = &fw_rec->data;
+			len = fw_rec->len;
+			break;
+
+		default:
+			dev_err(&client->dev,
+				"Unrecognized record type: 0x%02X\n",
+				fw_rec->type);
+			error = -EINVAL;
+		}
+
+		if (error)
+			break;
+
+		fw_blk = devm_kzalloc(&client->dev,
+				      struct_size(fw_blk, data, len),
+				      GFP_KERNEL);
+		if (!fw_blk) {
+			error = -ENOMEM;
+			break;
+		}
+
+		fw_blk->addr = fw_rec->addr;
+		fw_blk->mask = mask;
+		fw_blk->len = len;
+		memcpy(fw_blk->data, data, len);
+
+		list_add(&fw_blk->list, &iqs62x->fw_blk_head);
+	}
+
+	release_firmware(fw);
+
+	return error;
+}
+
+static irqreturn_t iqs62x_irq(int irq, void *context)
+{
+	struct iqs62x_core *iqs62x = context;
+	struct iqs62x_event_data event_data;
+	struct iqs62x_event_desc event_desc;
+	enum iqs62x_event_reg event_reg;
+	unsigned long event_flags = 0;
+	int error, i, j;
+	u8 event_map[IQS62X_EVENT_SIZE];
+
+	/*
+	 * The device asserts the RDY output to signal the beginning of a
+	 * communication window, which is closed by an I2C stop condition.
+	 * As such, all interrupt status is captured in a single read and
+	 * broadcast to any interested sub-device drivers.
+	 */
+	error = regmap_raw_read(iqs62x->map, IQS62X_SYS_FLAGS,
+				event_map, sizeof(event_map));
+	if (error)
+		return IRQ_NONE;
+
+	for (i = 0; i < sizeof(event_map); i++) {
+		event_reg = iqs62x->dev_desc->event_regs[iqs62x->ui_sel][i];
+
+		switch (event_reg) {
+		case IQS62X_EVENT_UI_LO:
+			event_data.ui_data = get_unaligned_le16(&event_map[i]);
+			/* fall through */
+		case IQS62X_EVENT_UI_HI:
+		case IQS62X_EVENT_NONE:
+		case IQS62X_EVENT_GLBL:
+			continue;
+
+		case IQS62X_EVENT_TEMP:
+			event_data.temp_flags = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_ALS:
+			event_data.als_flags = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_IR:
+			event_data.ir_flags = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_INTER:
+			event_data.interval = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_HYST:
+			event_map[i] <<= iqs62x->dev_desc->hyst_shift;
+			/* fall through */
+		case IQS62X_EVENT_WHEEL:
+		case IQS62X_EVENT_HALL:
+		case IQS62X_EVENT_PROX:
+		case IQS62X_EVENT_SYS:
+			break;
+		}
+
+		for (j = 0; j < IQS62X_NUM_EVENTS; j++) {
+			event_desc = iqs62x_events[j];
+
+			if (event_desc.reg != event_reg)
+				continue;
+
+			if ((event_map[i] & event_desc.mask) == event_desc.val)
+				event_flags |= BIT(j);
+		}
+	}
+
+	/*
+	 * The device resets itself in response to the I2C master stalling
+	 * communication beyond a timeout. In this case, all registers are
+	 * restored and any interested sub-device drivers are notified.
+	 */
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		dev_err(&iqs62x->client->dev, "Unexpected device reset\n");
+
+		error = iqs62x_dev_init(iqs62x);
+		if (error) {
+			dev_err(&iqs62x->client->dev,
+				"Failed to re-initialize device: %d\n", error);
+			return IRQ_NONE;
+		}
+	}
+
+	error = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
+					     &event_data);
+	if (error & NOTIFY_STOP_MASK)
+		return IRQ_NONE;
+
+	/*
+	 * Once the communication window is closed, a small delay is added to
+	 * ensure the device's RDY output has been deasserted by the time the
+	 * interrupt handler returns.
+	 */
+	usleep_range(50, 100);
+
+	return IRQ_HANDLED;
+}
+
+static void iqs62x_fw_load(const struct firmware *fw, void *context)
+{
+	struct iqs62x_core *iqs62x = context;
+	struct i2c_client *client = iqs62x->client;
+	int error;
+
+	if (fw) {
+		error = iqs62x_fw_parse(iqs62x, fw);
+		if (error) {
+			dev_err(&client->dev, "Failed to parse firmware: %d\n",
+				error);
+			goto err_out;
+		}
+	}
+
+	error = iqs62x_dev_init(iqs62x);
+	if (error) {
+		dev_err(&client->dev, "Failed to initialize device: %d\n",
+			error);
+		goto err_out;
+	}
+
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, iqs62x_irq, IRQF_ONESHOT,
+					  client->name, iqs62x);
+	if (error) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
+		goto err_out;
+	}
+
+	error = devm_mfd_add_devices(&client->dev, -1,
+				     iqs62x->dev_desc->sub_devs,
+				     iqs62x->dev_desc->num_sub_devs,
+				     NULL, 0, NULL);
+	if (error)
+		dev_err(&client->dev, "Failed to add devices: %d\n", error);
+
+err_out:
+	complete_all(&iqs62x->fw_done);
+}
+
+static int __maybe_unused iqs62x_suspend(struct device *dev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
+	int error;
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	/*
+	 * As per the data sheet, automatic mode switching must be disabled
+	 * before the device is placed in or taken out of halt mode.
+	 */
+	error = regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				   IQS62X_PWR_SETTINGS_DIS_AUTO,
+				   IQS62X_PWR_SETTINGS_DIS_AUTO);
+	if (error)
+		return error;
+
+	return regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_HALT);
+}
+
+static int __maybe_unused iqs62x_resume(struct device *dev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
+	int error;
+
+	error = regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				   IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				   IQS62X_PWR_SETTINGS_PWR_MODE_NORM);
+	if (error)
+		return error;
+
+	return regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_DIS_AUTO, 0);
+}
+
+static SIMPLE_DEV_PM_OPS(iqs62x_pm, iqs62x_suspend, iqs62x_resume);
+
+static const struct regmap_config iqs62x_map_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= IQS62X_MAX_REG,
+};
+
+static int iqs62x_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct iqs62x_core *iqs62x;
+	struct iqs62x_info info;
+	unsigned int val;
+	int error, i, j;
+	const char *fw_file = NULL;
+
+	iqs62x = devm_kzalloc(&client->dev, sizeof(*iqs62x), GFP_KERNEL);
+	if (!iqs62x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iqs62x);
+	iqs62x->client = client;
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
+	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
+	init_completion(&iqs62x->fw_done);
+
+	iqs62x->map = devm_regmap_init_i2c(client, &iqs62x_map_config);
+	if (IS_ERR(iqs62x->map)) {
+		error = PTR_ERR(iqs62x->map);
+		dev_err(&client->dev, "Failed to initialize register map: %d\n",
+			error);
+		return error;
+	}
+
+	error = regmap_raw_read(iqs62x->map, IQS62X_PROD_NUM, &info,
+				sizeof(info));
+	if (error)
+		return error;
+
+	for (i = 0; i < IQS62X_NUM_DEV; i++) {
+		if (info.prod_num == iqs62x_devs[i].prod_num)
+			iqs62x->dev_desc = &iqs62x_devs[i];
+		else
+			continue;
+
+		if (info.sw_num >= iqs62x->dev_desc->sw_num)
+			iqs62x->sw_num = info.sw_num;
+		else
+			continue;
+
+		for (j = 0; j < iqs62x->dev_desc->num_cal_regs; j++) {
+			error = regmap_read(iqs62x->map,
+					    iqs62x->dev_desc->cal_regs[j],
+					    &val);
+			if (error)
+				return error;
+
+			if (!val)
+				break;
+		}
+
+		if (j == iqs62x->dev_desc->num_cal_regs)
+			break;
+	}
+
+	if (!iqs62x->dev_desc) {
+		dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
+			info.prod_num);
+		return -EINVAL;
+	}
+
+	if (!iqs62x->sw_num) {
+		dev_err(&client->dev, "Unrecognized software number: 0x%02X\n",
+			info.sw_num);
+		return -EINVAL;
+	}
+
+	if (i == IQS62X_NUM_DEV) {
+		dev_err(&client->dev, "Uncalibrated device\n");
+		return -ENODATA;
+	}
+
+	error = regmap_write(iqs62x->map, IQS62X_SYS_SETTINGS,
+			     IQS62X_SYS_SETTINGS_SOFT_RESET);
+	if (error)
+		return error;
+	usleep_range(10000, 10100);
+
+	device_property_read_string(&client->dev, "linux,fw-file", &fw_file);
+
+	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+					fw_file ? : iqs62x->dev_desc->fw_file,
+					&client->dev, GFP_KERNEL, iqs62x,
+					iqs62x_fw_load);
+	if (error)
+		dev_err(&client->dev, "Failed to request firmware: %d\n",
+			error);
+
+	return error;
+}
+
+static int iqs62x_remove(struct i2c_client *client)
+{
+	struct iqs62x_core *iqs62x = i2c_get_clientdata(client);
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	return 0;
+}
+
+static const struct i2c_device_id iqs62x_id[] = {
+	{ "iqs620a", 0 },
+	{ "iqs621", 1 },
+	{ "iqs622", 2 },
+	{ "iqs624", 3 },
+	{ "iqs625", 4 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, iqs62x_id);
+
+static const struct of_device_id iqs62x_of_match[] = {
+	{ .compatible = "azoteq,iqs620a" },
+	{ .compatible = "azoteq,iqs621" },
+	{ .compatible = "azoteq,iqs622" },
+	{ .compatible = "azoteq,iqs624" },
+	{ .compatible = "azoteq,iqs625" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iqs62x_of_match);
+
+static struct i2c_driver iqs62x_i2c_driver = {
+	.driver = {
+		.name		= "iqs62x",
+		.of_match_table = iqs62x_of_match,
+		.pm		= &iqs62x_pm,
+	},
+	.id_table	= iqs62x_id,
+	.probe		= iqs62x_probe,
+	.remove		= iqs62x_remove,
+};
+module_i2c_driver(iqs62x_i2c_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/iqs62x-tables.c b/drivers/mfd/iqs62x-tables.c
new file mode 100644
index 0000000..12300b7
--- /dev/null
+++ b/drivers/mfd/iqs62x-tables.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/iqs62x.h>
+
+static const struct mfd_cell iqs620at_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs620a-keys",
+	},
+	{
+		.name = IQS620_DRV_NAME_PWM,
+		.of_compatible = "azoteq,iqs620a-pwm",
+	},
+	{
+		.name = IQS620_DRV_NAME_TEMP,
+	},
+};
+
+static const struct mfd_cell iqs620a_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs620a-keys",
+	},
+	{
+		.name = IQS620_DRV_NAME_PWM,
+		.of_compatible = "azoteq,iqs620a-pwm",
+	},
+};
+
+static const struct mfd_cell iqs621_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs621-keys",
+	},
+	{
+		.name = IQS621_DRV_NAME_ALS,
+	},
+};
+
+static const struct mfd_cell iqs622_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs622-keys",
+	},
+	{
+		.name = IQS622_DRV_NAME_PROX,
+		.of_compatible = "azoteq,iqs622-prox",
+	},
+};
+
+static const struct mfd_cell iqs624_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs624-keys",
+	},
+	{
+		.name = IQS624_DRV_NAME_POS,
+	},
+};
+
+static const struct mfd_cell iqs625_sub_devs[] = {
+	{
+		.name = IQS62X_DRV_NAME_KEYS,
+		.of_compatible = "azoteq,iqs625-keys",
+	},
+	{
+		.name = IQS624_DRV_NAME_POS,
+	},
+};
+
+static const u8 iqs620at_cal_regs[] = { 0xC2, 0xC3, 0xC4, };
+static const u8 iqs621_cal_regs[] = { 0x82, 0x83, };
+
+static const enum iqs62x_event_reg iqs620a_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_GLBL,	/* 0x11 */
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HALL,	/* 0x16 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_TEMP,	/* 0x19 */
+		IQS62X_EVENT_UI_LO,	/* 0x1A */
+		IQS62X_EVENT_UI_HI,	/* 0x1B */
+	},
+	[IQS62X_UI_SAR1] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_GLBL,	/* 0x11 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HALL,	/* 0x16 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_TEMP,	/* 0x19 */
+		IQS62X_EVENT_UI_LO,	/* 0x1A */
+		IQS62X_EVENT_UI_HI,	/* 0x1B */
+	},
+};
+
+static const enum iqs62x_event_reg iqs621_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_GLBL,	/* 0x11 */
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_ALS,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const enum iqs62x_event_reg iqs622_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_GLBL,	/* 0x11 */
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_IR,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+	[IQS62X_UI_SAR1] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_GLBL,	/* 0x11 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_IR,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const enum iqs62x_event_reg iqs624_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_WHEEL,	/* 0x14 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_UI_LO,	/* 0x16 */
+		IQS62X_EVENT_UI_HI,	/* 0x17 */
+		IQS62X_EVENT_INTER,	/* 0x18 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const enum iqs62x_event_reg iqs625_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_PROX,	/* 0x11 */
+		IQS62X_EVENT_INTER,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+enum {
+	IQS620AT_DEV,
+	IQS620A_DEV,
+	IQS621_DEV,
+	IQS622_DEV,
+	IQS624_DEV,
+	IQS625_DEV,
+};
+
+const struct iqs62x_dev_desc iqs62x_devs[IQS62X_NUM_DEV] = {
+	[IQS620AT_DEV] = {
+		.dev_name	= "iqs620at",
+		.sub_devs	= iqs620at_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs620at_sub_devs),
+
+		.prod_num	= IQS620_PROD_NUM,
+		.sw_num		= 0x08,
+		.cal_regs	= iqs620at_cal_regs,
+		.num_cal_regs	= ARRAY_SIZE(iqs620at_cal_regs),
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1) | BIT(7),
+		.hall_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.hall_flags	= 0x16,
+
+		.fw_file	= "iqs620a.bin",
+		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS620A_DEV] = {
+		.dev_name	= "iqs620a",
+		.sub_devs	= iqs620a_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs620a_sub_devs),
+
+		.prod_num	= IQS620_PROD_NUM,
+		.sw_num		= 0x08,
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1) | BIT(7),
+		.hall_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.hall_flags	= 0x16,
+
+		.fw_file	= "iqs620a.bin",
+		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS621_DEV] = {
+		.dev_name	= "iqs621",
+		.sub_devs	= iqs621_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs621_sub_devs),
+
+		.prod_num	= IQS621_PROD_NUM,
+		.sw_num		= 0x09,
+		.cal_regs	= iqs621_cal_regs,
+		.num_cal_regs	= ARRAY_SIZE(iqs621_cal_regs),
+
+		.prox_mask	= BIT(0),
+		.hall_mask	= BIT(1),
+		.als_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.hall_flags	= 0x19,
+		.hyst_shift	= 5,
+
+		.fw_file	= "iqs621.bin",
+		.event_regs	= &iqs621_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS622_DEV] = {
+		.dev_name	= "iqs622",
+		.sub_devs	= iqs622_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs622_sub_devs),
+
+		.prod_num	= IQS622_PROD_NUM,
+		.sw_num		= 0x06,
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1),
+		.hall_mask	= BIT(2),
+		.als_mask	= BIT(3),
+		.ir_mask	= BIT(4),
+
+		.hall_flags	= 0x19,
+
+		.fw_file	= "iqs622.bin",
+		.event_regs	= &iqs622_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS624_DEV] = {
+		.dev_name	= "iqs624",
+		.sub_devs	= iqs624_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs624_sub_devs),
+
+		.prod_num	= IQS624_PROD_NUM,
+		.sw_num		= 0x0B,
+
+		.interval	= 0x18,
+		.interval_div	= 3,
+
+		.fw_file	= "iqs624.bin",
+		.event_regs	= &iqs624_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS625_DEV] = {
+		.dev_name	= "iqs625",
+		.sub_devs	= iqs625_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs625_sub_devs),
+
+		.prod_num	= IQS625_PROD_NUM,
+		.sw_num		= 0x0B,
+
+		.interval	= 0x12,
+		.interval_div	= 10,
+
+		.fw_file	= "iqs625.bin",
+		.event_regs	= &iqs625_event_regs[IQS62X_UI_PROX],
+	},
+};
+EXPORT_SYMBOL_GPL(iqs62x_devs);
+
+const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS] = {
+	[IQS62X_EVENT_PROX_CH0_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(4),
+		.val	= BIT(4),
+	},
+	[IQS62X_EVENT_PROX_CH0_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(0),
+		.val	= BIT(0),
+	},
+	[IQS62X_EVENT_PROX_CH1_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(5),
+		.val	= BIT(5),
+	},
+	[IQS62X_EVENT_PROX_CH1_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(1),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_PROX_CH2_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(6),
+		.val	= BIT(6),
+	},
+	[IQS62X_EVENT_PROX_CH2_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(2),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_HYST_POS_T] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(6) | BIT(7),
+		.val	= BIT(6),
+	},
+	[IQS62X_EVENT_HYST_POS_P] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(5) | BIT(7),
+		.val	= BIT(5),
+	},
+	[IQS62X_EVENT_HYST_NEG_T] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(6) | BIT(7),
+		.val	= BIT(6) | BIT(7),
+	},
+	[IQS62X_EVENT_HYST_NEG_P] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(5) | BIT(7),
+		.val	= BIT(5) | BIT(7),
+	},
+	[IQS62X_EVENT_SAR1_ACT] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(4),
+		.val	= BIT(4),
+	},
+	[IQS62X_EVENT_SAR1_QRD] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(2),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_SAR1_MOVE] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(1),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_SAR1_HALT] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(0),
+		.val	= BIT(0),
+	},
+	[IQS62X_EVENT_WHEEL_UP] = {
+		.reg	= IQS62X_EVENT_WHEEL,
+		.mask	= BIT(7) | BIT(6),
+		.val	= BIT(7),
+	},
+	[IQS62X_EVENT_WHEEL_DN] = {
+		.reg	= IQS62X_EVENT_WHEEL,
+		.mask	= BIT(7) | BIT(6),
+		.val	= BIT(7) | BIT(6),
+	},
+	[IQS62X_EVENT_HALL_N_T] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(2) | BIT(0),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_HALL_N_P] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(1) | BIT(0),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_HALL_S_T] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(2) | BIT(0),
+		.val	= BIT(2) | BIT(0),
+	},
+	[IQS62X_EVENT_HALL_S_P] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(1) | BIT(0),
+		.val	= BIT(1) | BIT(0),
+	},
+	[IQS62X_EVENT_SYS_RESET] = {
+		.reg	= IQS62X_EVENT_SYS,
+		.mask	= BIT(7),
+		.val	= BIT(7),
+	},
+};
+EXPORT_SYMBOL_GPL(iqs62x_events);
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
new file mode 100644
index 0000000..01d0f5b
--- /dev/null
+++ b/include/linux/mfd/iqs62x.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ */
+
+#ifndef __LINUX_MFD_IQS62X_H
+#define __LINUX_MFD_IQS62X_H
+
+#define IQS620_PROD_NUM				0x41
+#define IQS621_PROD_NUM				0x46
+#define IQS622_PROD_NUM				0x42
+#define IQS624_PROD_NUM				0x43
+#define IQS625_PROD_NUM				0x4E
+
+#define IQS624_HALL_UI				0x70
+#define IQS624_HALL_UI_WHL_EVENT		BIT(4)
+#define IQS624_HALL_UI_INT_EVENT		BIT(3)
+#define IQS624_HALL_UI_AUTO_CAL			BIT(2)
+
+#define IQS624_INTERVAL_DIV			0x7D
+
+#define IQS620_GLBL_EVENT_MASK			0xD7
+#define IQS620_GLBL_EVENT_MASK_PMU		BIT(6)
+
+#define IQS62X_NUM_DEV				6
+#define IQS62X_NUM_KEYS				16
+#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 5)
+
+#define IQS62X_EVENT_SIZE			12
+
+#define IQS62X_DRV_NAME_KEYS			"iqs62x-keys"
+#define IQS620_DRV_NAME_TEMP			"iqs620at-temp"
+#define IQS620_DRV_NAME_PWM			"iqs620a-pwm"
+#define IQS621_DRV_NAME_ALS			"iqs621-als"
+#define IQS622_DRV_NAME_PROX			"iqs622-prox"
+#define IQS624_DRV_NAME_POS			"iqs624-pos"
+
+enum iqs62x_ui_sel {
+	IQS62X_UI_PROX,
+	IQS62X_UI_SAR1,
+};
+
+enum iqs62x_event_reg {
+	IQS62X_EVENT_NONE,
+	IQS62X_EVENT_SYS,
+	IQS62X_EVENT_GLBL,
+	IQS62X_EVENT_PROX,
+	IQS62X_EVENT_HYST,
+	IQS62X_EVENT_HALL,
+	IQS62X_EVENT_TEMP,
+	IQS62X_EVENT_ALS,
+	IQS62X_EVENT_IR,
+	IQS62X_EVENT_WHEEL,
+	IQS62X_EVENT_INTER,
+	IQS62X_EVENT_UI_LO,
+	IQS62X_EVENT_UI_HI,
+};
+
+enum iqs62x_event_flag {
+	/* keys */
+	IQS62X_EVENT_PROX_CH0_T,
+	IQS62X_EVENT_PROX_CH0_P,
+	IQS62X_EVENT_PROX_CH1_T,
+	IQS62X_EVENT_PROX_CH1_P,
+	IQS62X_EVENT_PROX_CH2_T,
+	IQS62X_EVENT_PROX_CH2_P,
+	IQS62X_EVENT_HYST_POS_T,
+	IQS62X_EVENT_HYST_POS_P,
+	IQS62X_EVENT_HYST_NEG_T,
+	IQS62X_EVENT_HYST_NEG_P,
+	IQS62X_EVENT_SAR1_ACT,
+	IQS62X_EVENT_SAR1_QRD,
+	IQS62X_EVENT_SAR1_MOVE,
+	IQS62X_EVENT_SAR1_HALT,
+	IQS62X_EVENT_WHEEL_UP,
+	IQS62X_EVENT_WHEEL_DN,
+
+	/* switches */
+	IQS62X_EVENT_HALL_N_T,
+	IQS62X_EVENT_HALL_N_P,
+	IQS62X_EVENT_HALL_S_T,
+	IQS62X_EVENT_HALL_S_P,
+
+	/* everything else */
+	IQS62X_EVENT_SYS_RESET,
+};
+
+struct iqs62x_event_data {
+	u16 ui_data;
+	union {
+		u8 temp_flags;
+		u8 als_flags;
+		u8 ir_flags;
+		u8 interval;
+	};
+};
+
+struct iqs62x_event_desc {
+	enum iqs62x_event_reg reg;
+	u8 mask;
+	u8 val;
+};
+
+struct iqs62x_dev_desc {
+	const char *dev_name;
+	const struct mfd_cell *sub_devs;
+	int num_sub_devs;
+
+	u8 prod_num;
+	u8 sw_num;
+	const u8 *cal_regs;
+	int num_cal_regs;
+
+	u8 prox_mask;
+	u8 sar_mask;
+	u8 hall_mask;
+	u8 hyst_mask;
+	u8 temp_mask;
+	u8 als_mask;
+	u8 ir_mask;
+
+	u8 hall_flags;
+	u8 hyst_shift;
+	u8 interval;
+	u8 interval_div;
+
+	const char *fw_file;
+	const enum iqs62x_event_reg (*event_regs)[IQS62X_EVENT_SIZE];
+};
+
+struct iqs62x_core {
+	const struct iqs62x_dev_desc *dev_desc;
+	struct i2c_client *client;
+	struct regmap *map;
+	struct blocking_notifier_head nh;
+	struct list_head fw_blk_head;
+	struct completion fw_done;
+	enum iqs62x_ui_sel ui_sel;
+	u8 sw_num;
+};
+
+extern const struct iqs62x_dev_desc iqs62x_devs[IQS62X_NUM_DEV];
+extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];
+
+#endif /* __LINUX_MFD_IQS62X_H */
-- 
2.7.4


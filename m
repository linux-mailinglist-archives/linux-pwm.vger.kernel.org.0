Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2221039D35
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfFHLYD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 07:24:03 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46625 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726945AbfFHLYC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 07:24:02 -0400
X-UUID: 38abf42867234b6693b131d4e19b29d4-20190608
X-UUID: 38abf42867234b6693b131d4e19b29d4-20190608
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 882599171; Sat, 08 Jun 2019 19:23:49 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Jun
 2019 19:23:48 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 8 Jun 2019 19:23:46 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [2/2] drm/panel: support for AUO kd101n80-45na wuxga dsi video mode panel
Date:   Sat, 8 Jun 2019 19:23:42 +0800
Message-ID: <20190608112342.64416-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608112342.64416-1-jitao.shi@mediatek.com>
References: <20190608112342.64416-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add driver for AUO kd101n80-45na panel.
This panel supports the resolution 1200x1920, dsi video mode
and 4 lanes.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-auo-kd101n80-45na.c   | 352 ++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-auo-kd101n80-45na.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e36dbb4df867..f5cd5af9ce42 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -272,4 +272,14 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
 	help
 	  Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
 	  Video Mode panel
+
+config DRM_PANEL_AUO_KD101N80_45NA
+	tristate "AUO KD101N80_45NA 1200x1920 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to support for AUO KD101N80_45NA WUXGA PANEL
+	  DSI Video Mode panel
+
 endmenu
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 78e3dc376bdd..1056933bdf2e 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
 obj-$(CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA) += panel-truly-nt35597.o
+obj-$(CONFIG_DRM_PANEL_AUO_KD101N80_45NA) += panel-auo-kd101n80-45na.o
diff --git a/drivers/gpu/drm/panel/panel-auo-kd101n80-45na.c b/drivers/gpu/drm/panel/panel-auo-kd101n80-45na.c
new file mode 100644
index 000000000000..ab7bfc059e8a
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-auo-kd101n80-45na.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct auo_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	struct backlight_device *backlight;
+	struct regulator *pp1800;
+	struct regulator *avee;
+	struct regulator *avdd;
+	struct gpio_desc *enable_gpio;
+
+	bool prepared;
+	bool enabled;
+
+	const struct drm_display_mode *mode;
+};
+
+static inline struct auo_panel *to_auo_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct auo_panel, base);
+}
+
+static int auo_panel_init(struct auo_panel *auo)
+{
+	struct drm_panel *panel = &auo->base;
+	int err;
+
+	err = mipi_dsi_dcs_exit_sleep_mode(auo->dsi);
+	if (err < 0) {
+		DRM_DEV_ERROR(panel->dev, "failed to exit sleep mode: %d\n",
+			      err);
+		return err;
+	}
+
+	/* T3.1*/
+	msleep(120);
+
+	err = mipi_dsi_dcs_set_display_on(auo->dsi);
+	if (err < 0) {
+		DRM_DEV_ERROR(panel->dev, "failed to set display on: %d\n",
+			      err);
+	}
+	/* T3.1 + T3.2: > 200ms */
+	msleep(120);
+
+	return err;
+}
+
+static int auo_panel_off(struct auo_panel *auo)
+{
+	struct mipi_dsi_device *dsi = auo->dsi;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int auo_panel_disable(struct drm_panel *panel)
+{
+	struct auo_panel *auo = to_auo_panel(panel);
+
+	if (!auo->enabled)
+		return 0;
+
+	backlight_disable(auo->backlight);
+
+	auo->enabled = false;
+
+	return 0;
+}
+
+static int auo_panel_unprepare(struct drm_panel *panel)
+{
+	struct auo_panel *auo = to_auo_panel(panel);
+	int ret;
+
+	if (!auo->prepared)
+		return 0;
+
+	ret = auo_panel_off(auo);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
+		return ret;
+	}
+
+	msleep(150);
+	regulator_disable(auo->avee);
+	regulator_disable(auo->avdd);
+	usleep_range(5000, 7000);
+	regulator_disable(auo->pp1800);
+	if (auo->enable_gpio)
+		gpiod_set_value(auo->enable_gpio, 0);
+
+	auo->prepared = false;
+
+	return 0;
+}
+
+static int auo_panel_prepare(struct drm_panel *panel)
+{
+	struct auo_panel *auo = to_auo_panel(panel);
+	int ret;
+
+	if (auo->prepared)
+		return 0;
+
+	if (auo->enable_gpio) {
+		gpiod_set_value(auo->enable_gpio, 0);
+		usleep_range(1000, 1500);
+	}
+
+	ret = regulator_enable(auo->pp1800);
+	if (ret < 0)
+		return ret;
+	ret = regulator_enable(auo->avdd);
+	if (ret < 0)
+		goto poweroff1v8;
+	ret = regulator_enable(auo->avee);
+	if (ret < 0)
+		goto poweroffavdd;
+
+	if (auo->enable_gpio) {
+		gpiod_set_value(auo->enable_gpio, 1);
+		usleep_range(10000, 12000);
+	}
+
+	ret = auo_panel_init(auo);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to init panel: %d\n", ret);
+		goto poweroff;
+	}
+
+	auo->prepared = true;
+
+	return 0;
+
+poweroff:
+	regulator_disable(auo->avee);
+poweroffavdd:
+	regulator_disable(auo->avdd);
+poweroff1v8:
+	usleep_range(5000, 7000);
+	regulator_disable(auo->pp1800);
+	if (auo->enable_gpio)
+		gpiod_set_value(auo->enable_gpio, 0);
+	return ret;
+}
+
+static int auo_panel_enable(struct drm_panel *panel)
+{
+	struct auo_panel *auo = to_auo_panel(panel);
+	int ret;
+
+	if (auo->enabled)
+		return 0;
+
+	ret = backlight_enable(auo->backlight);
+	if (ret) {
+		DRM_DEV_ERROR(panel->drm->dev,
+			      "Failed to enable backlight %d\n", ret);
+		return ret;
+	}
+
+	auo->enabled = true;
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock = 157000,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 80,
+	.hsync_end = 1200 + 80 + 24,
+	.htotal = 1200 + 80 + 24 + 36,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 16,
+	.vsync_end = 1920 + 16 + 4,
+	.vtotal = 1920 + 16 + 4 + 16,
+	.vrefresh = 60,
+};
+
+static int auo_panel_get_modes(struct drm_panel *panel)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	if (!mode) {
+		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
+			default_mode.hdisplay, default_mode.vdisplay,
+			default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(panel->connector, mode);
+
+	panel->connector->display_info.width_mm = 135;
+	panel->connector->display_info.height_mm = 216;
+	panel->connector->display_info.bpc = 8;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs auo_panel_funcs = {
+	.disable = auo_panel_disable,
+	.unprepare = auo_panel_unprepare,
+	.prepare = auo_panel_prepare,
+	.enable = auo_panel_enable,
+	.get_modes = auo_panel_get_modes,
+};
+
+static int auo_panel_add(struct auo_panel *auo)
+{
+	struct device *dev = &auo->dsi->dev;
+
+	auo->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(auo->avdd))
+		return PTR_ERR(auo->avdd);
+
+	auo->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(auo->avee))
+		return PTR_ERR(auo->avee);
+
+	auo->pp1800 = devm_regulator_get(dev, "pp1800");
+	if (IS_ERR(auo->pp1800))
+		return PTR_ERR(auo->pp1800);
+
+	auo->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(auo->enable_gpio)) {
+		dev_err(dev, "cannot get reset-gpios %ld\n",
+			PTR_ERR(auo->enable_gpio));
+		auo->enable_gpio = NULL;
+	} else {
+		gpiod_set_value(auo->enable_gpio, 0);
+	}
+
+	auo->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(auo->backlight))
+		return PTR_ERR(auo->backlight);
+
+	drm_panel_init(&auo->base);
+	auo->base.funcs = &auo_panel_funcs;
+	auo->base.dev = &auo->dsi->dev;
+
+	return drm_panel_add(&auo->base);
+}
+
+static void auo_panel_del(struct auo_panel *auo)
+{
+	if (auo->base.dev)
+		drm_panel_remove(&auo->base);
+}
+
+static int auo_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct auo_panel *auo;
+	int ret;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		 MIPI_DSI_MODE_LPM;
+
+	auo = devm_kzalloc(&dsi->dev, sizeof(*auo), GFP_KERNEL);
+	if (!auo)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, auo);
+
+	auo->dsi = dsi;
+
+	ret = auo_panel_add(auo);
+	if (ret < 0)
+		return ret;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int auo_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct auo_panel *auo = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = auo_panel_disable(&auo->base);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	auo_panel_del(auo);
+
+	return 0;
+}
+
+static void auo_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct auo_panel *auo = mipi_dsi_get_drvdata(dsi);
+
+	auo_panel_disable(&auo->base);
+}
+
+static const struct of_device_id auo_of_match[] = {
+	{ .compatible = "auo,kd101n80-45na", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, auo_of_match);
+
+static struct mipi_dsi_driver auo_panel_driver = {
+	.driver = {
+		.name = "panel-auo-kd101n80-45na",
+		.of_match_table = auo_of_match,
+	},
+	.probe = auo_panel_probe,
+	.remove = auo_panel_remove,
+	.shutdown = auo_panel_shutdown,
+};
+module_mipi_dsi_driver(auo_panel_driver);
+
+MODULE_AUTHOR("Jitao Shi <jitao.shi@mediatek.com>");
+MODULE_DESCRIPTION("AUO kd101n80-45na wuxga (1200x1920) video mode panel driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.21.0


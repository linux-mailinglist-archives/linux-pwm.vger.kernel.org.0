Return-Path: <linux-pwm+bounces-2510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D090D41B
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9124128822A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE02D15FA95;
	Tue, 18 Jun 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEfz7/0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3D156F55;
	Tue, 18 Jun 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719216; cv=none; b=AAnxqRCGlti6RSb50cBLtoN/setJFX8THDn8YgFjVIM7geT4L5PjPbkeaC8HHAxo8i3sS8SoEIqG6Tu24qQMWSg3iexLNcwq2d6t5zVUsV0LA1+VZ60ntIf0RwEEcPW9WwR+uhUpmARpr5M6ocMeBdvepYX7qv+OykExt+cBwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719216; c=relaxed/simple;
	bh=ue3MHT37XXyjNHrxkEj2M0Jd6XrwxyplbB2podMmaEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjTTJw2R4kLi7sYKTXEzFiSZ74bPmLO8ME6UMdVNR4NBxStSlXOPtifJvDNpZpSEK8tMnRk6vTFUIpcgJ10c9DeS0MjCjYDAdwzvogcDntsEmU6DGbdSHvLLwwe+5X+kCoxWF5cz0euCV1DY/ZNNt/zxyBC7GBY6OBFdgmsEKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLEfz7/0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe785b234so54404021fa.1;
        Tue, 18 Jun 2024 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719213; x=1719324013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id8Hhvq/bt2h6K3B8/2c/eaipM1A6Vdbe4bbmJMwPG4=;
        b=mLEfz7/0zeymZ25fXYENu1S6DJpAEKHnqxPkyGkP7R5efYz7ou8/RxNFsvfAZwsRCs
         st48CKtHpDisUep98tR8PJ6+cxu54GpzBOviZ6G73qK5CxuTWzBsEpLrUSW54j7jMCGR
         ZcmEdEZaEr+0+sIt3YiSiuHR5RtetDR7hX+ZFd1rIRdoHK0Cx/azutbezYKpNqxzPUgZ
         6sx6pN3pWIeRzL7N+b1BvvW6iuYUmK4t8lmzGGJkjroPoLQQf15tlBj3w4hId2blOVku
         Iuf+LII10Lb6N7I+kCXfMRbhM47kCNbU1FL+z+ll09zfgnSFpzNG+gINU2XE/U8Ox/vG
         o0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719213; x=1719324013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id8Hhvq/bt2h6K3B8/2c/eaipM1A6Vdbe4bbmJMwPG4=;
        b=iGQwYHEE6lKg5raGZfg2PRwyYhUEUd2QQuy1kzRSotljzLD7uIyZ2MGgnNJI5j7T36
         XROXdAjL1ioaADxbIkngypPzw/+UR9y/8sjBUjUYnMUWJlWhXnYdsbEGMfW5g7nw7WXW
         xdHRuzW4U1CVhDpI6jCayHpsHxtU8UFhx3FxIUwsioNWgA+6QuCyzRSdLp+rgqubQUdF
         V38OQtUa3H+icHlmcn7bRN/88KlEpCEV4RWYvWBt5Zsk18H642JZ8DhQ4rSYkE5aWpQk
         JhNWDNgcJWZc7O8bbq+lV+fi/gab+Rk+TK4SVHZ1ucukV1zoCQPlDYeJXfvP3TtYLXqU
         TcGg==
X-Forwarded-Encrypted: i=1; AJvYcCUrNp/He9YupVom4hrAHJvLodmtM22xG2Ml1evLT2UVD34gmFh26hQ7VdWuTfMHme+uTmFtvIpDFdy9Fz+WaOsDjANWsbhIL1J26c5cd5IoH7KHKy+WKlr9sqqoAOufcPcBXz41iBJsTdpQxoaX6zusL/YnUwllfToGX5d0ak4YN7pT50Jah/CD1j2tJcRQsZ+0s/JeaMJ03hY9r1eTbHVyIshBmtMzAdga64Ufg2lxyBVmloSVNWdgzEi5DIM+dhI7BhNfi8dRoHEz4pwio/mckGwSGOyhyDAPX3Gb5JsY+HG7csSde19LHqd5aE/Mgh8IPeNCh0WLthB4JNJkJACyXFQ6Ta92xunbYyFcZcYIEzpaIyOV6FIStYZKAhSQ+JwoKWI6vb2CxbUGEQ00+YkktDz3nmSx
X-Gm-Message-State: AOJu0YzTcEj162wRKwGlUBOb26fH368VVvPoerHiUj7JY0j3y+HNGmYz
	uYB8qyTM2Wy/gwhkx5iPqLMOWtMT4WpVKNdFTR2warTCbeXxgNKkKRGaN2nM
X-Google-Smtp-Source: AGHT+IFGWxNTJWKfvtYtwaUhf5eCQI0VCQBJSAVikp2hNnHlatQzSXBxjfytMltsZ1/pvjUqZscsTQ==
X-Received: by 2002:a2e:3519:0:b0:2ec:30ee:6972 with SMTP id 38308e7fff4ca-2ec30ee69b1mr28595351fa.24.1718719212474;
        Tue, 18 Jun 2024 07:00:12 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:12 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:45 +0300
Subject: [PATCH v3 11/23] drm/panel: Add support for S6E3HA8 panel driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-11-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=15491;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=ue3MHT37XXyjNHrxkEj2M0Jd6XrwxyplbB2podMmaEI=;
 b=jhF8wZ+oXwUHKCr1cjS4cFqpVzhkjkOtp0p6gy65qFozWvPJJ4ZFnD1XBs+P424Y43p0ESGFP
 XNz3UQCUSTOCQ2MjR042xoIzVbaIvVzVnWtz5BDQCJjsLvwB805bP6R
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for MIPI-DSI based S6E3HA8 AMOLED panel
driver. This panel has 1440x2960 resolution, 5.8-inch physical
size, and can be found in starqltechn device.
Brightness regulation is not yet supported.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 426 ++++++++++++++++++++++++++
 4 files changed, 435 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92a5d0a56353..fae3b8ea9ce4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7154,6 +7154,7 @@ DRM DRIVER FOR SAMSUNG S6E3HA8 PANELS
 M:	Dzmitry Sankouski <dsankouski@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
 
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 2ae0eb0638f3..903fc8c155c0 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -651,6 +651,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
+config DRM_PANEL_SAMSUNG_S6E3HA8
+	tristate "Samsung S6E3HA8 DSI video mode panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+
 config DRM_PANEL_SAMSUNG_S6E63J0X03
 	tristate "Samsung S6E63J0X03 DSI command mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f0203f6e02f4..71774cc5820a 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D27A1) += panel-samsung-s6d27a1.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0) += panel-samsung-s6d7aa0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7) += panel-samsung-s6e3fa7.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8) += panel-samsung-s6e3ha8.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI) += panel-samsung-s6e63m0-spi.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
new file mode 100644
index 000000000000..49d629643171
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+ *  Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct s6e3ha8 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct drm_dsc_config dsc;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[3];
+};
+
+static inline
+struct s6e3ha8 *to_s6e3ha8_amb577px01_wqhd(struct drm_panel *panel)
+{
+	return container_of(panel, struct s6e3ha8, panel);
+}
+
+#define s6e3ha8_call_write_func(ret, func) do {	\
+	ret = (func);				\
+	if (ret < 0)				\
+		return ret;			\
+} while (0)
+
+static int s6e3ha8_test_key_on_lvl1(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0x9f, 0xa5, 0xa5 };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+	return 0;
+}
+
+static int s6e3ha8_test_key_off_lvl1(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0x9f, 0x5a, 0x5a };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+	return 0;
+}
+
+static int s6e3ha8_test_key_on_lvl2(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0xf0, 0x5a, 0x5a };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+}
+
+static int s6e3ha8_test_key_off_lvl2(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0xf0, 0xa5, 0xa5 };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+}
+
+static int s6e3ha8_test_key_on_lvl3(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0xfc, 0x5a, 0x5a };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+}
+
+static int s6e3ha8_test_key_off_lvl3(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0xfc, 0xa5, 0xa5 };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+}
+
+static int s6e3ha8_afc_off(struct mipi_dsi_device *dsi)
+{
+	static const u8 d[] = { 0xe2, 0x00, 0x00 };
+
+	return mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));
+	return 0;
+}
+
+static int s6e3ha8_power_on(struct s6e3ha8 *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int s6e3ha8_power_off(struct s6e3ha8 *ctx)
+{
+	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+}
+
+static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5000, 6000);
+}
+
+static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	s6e3ha8_test_key_on_lvl1(dsi);
+	s6e3ha8_test_key_on_lvl2(dsi);
+
+	ret = mipi_dsi_compression_mode(dsi, true);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set compression mode: %d\n", ret);
+		return ret;
+	}
+
+	s6e3ha8_test_key_off_lvl2(dsi);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	usleep_range(5000, 6000);
+
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xf2, 0x13);
+	s6e3ha8_test_key_off_lvl2(dsi);
+
+	usleep_range(10000, 11000);
+
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xf2, 0x13);
+	s6e3ha8_test_key_off_lvl2(dsi);
+
+	/* OMOK setting 1 (Initial setting) - Scaler Latch Setting Guide */
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x07);
+	/* latch setting 1 : Scaler on/off & address setting & PPS setting -> Image update latch */
+	mipi_dsi_generic_write_seq(dsi, 0xf2, 0x3c, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x0b);
+	/* latch setting 2 : Ratio change mode -> Image update latch */
+	mipi_dsi_generic_write_seq(dsi, 0xf2, 0x30);
+	/* OMOK setting 2 - Seamless setting guide : WQHD */
+	mipi_dsi_generic_write_seq(dsi, 0x2a, 0x00, 0x00, 0x05, 0x9f); /* CASET */
+	mipi_dsi_generic_write_seq(dsi, 0x2b, 0x00, 0x00, 0x0b, 0x8f); /* PASET */
+	mipi_dsi_generic_write_seq(dsi, 0xba, 0x01); /* scaler setup : scaler off */
+	s6e3ha8_test_key_off_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00); /* TE Vsync ON */
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xed, 0x4c); /* ERR_FG */
+	s6e3ha8_test_key_off_lvl2(dsi);
+	s6e3ha8_test_key_on_lvl3(dsi);
+	/* FFC Setting 897.6Mbps */
+	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x0d, 0x10, 0xb4, 0x3e, 0x01);
+	s6e3ha8_test_key_off_lvl3(dsi);
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xb9,
+				   0x00, 0xb0, 0x81, 0x09, 0x00, 0x00, 0x00,
+				   0x11, 0x03); /* TSP HSYNC Setting */
+	s6e3ha8_test_key_off_lvl2(dsi);
+	s6e3ha8_test_key_on_lvl2(dsi);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xf6, 0x43);
+	s6e3ha8_test_key_off_lvl2(dsi);
+	s6e3ha8_test_key_on_lvl2(dsi);
+	/* Brightness condition set */
+	mipi_dsi_generic_write_seq(dsi, 0xca,
+				   0x07, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x00, 0x0c); /* AID Set : 0% */
+	mipi_dsi_generic_write_seq(dsi, 0xb5,
+				   0x19, 0xdc, 0x16, 0x01, 0x34, 0x67, 0x9a,
+				   0xcd, 0x01, 0x22, 0x33, 0x44, 0x00, 0x00,
+				   0x05, 0x55, 0xcc, 0x0c, 0x01, 0x11, 0x11,
+				   0x10); /* MPS/ELVSS Setting */
+	mipi_dsi_generic_write_seq(dsi, 0xf4, 0xeb, 0x28); /* VINT */
+	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x03); /* Gamma, LTPS(AID) update */
+	s6e3ha8_test_key_off_lvl2(dsi);
+	s6e3ha8_test_key_off_lvl1(dsi);
+
+	return 0;
+}
+
+static int s6e3ha8_enable(struct drm_panel *panel)
+{
+	struct s6e3ha8 *ctx = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	int ret;
+
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_on_lvl1(dsi));
+	s6e3ha8_call_write_func(ret, mipi_dsi_dcs_set_display_on(dsi));
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_off_lvl1(dsi));
+
+	return 0;
+}
+
+static int s6e3ha8_disable(struct drm_panel *panel)
+{
+	struct s6e3ha8 *ctx = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	int ret;
+
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_on_lvl1(dsi));
+	s6e3ha8_call_write_func(ret, mipi_dsi_dcs_set_display_off(dsi));
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_off_lvl1(dsi));
+	msleep(20);
+
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_on_lvl2(dsi));
+	s6e3ha8_call_write_func(ret, s6e3ha8_afc_off(dsi));
+	s6e3ha8_call_write_func(ret, s6e3ha8_test_key_off_lvl2(dsi));
+
+	msleep(160);
+
+	return 0;
+}
+
+static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
+{
+	struct s6e3ha8 *ctx = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	struct drm_dsc_picture_parameter_set pps;
+	int ret;
+
+	s6e3ha8_power_on(ctx);
+	msleep(120);
+	s6e3ha8_amb577px01_wqhd_reset(ctx);
+	ret = s6e3ha8_amb577px01_wqhd_on(ctx);
+
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		goto err;
+	}
+
+	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
+
+	s6e3ha8_test_key_on_lvl1(dsi);
+	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
+		return ret;
+	}
+	s6e3ha8_test_key_off_lvl1(dsi);
+
+	ret = mipi_dsi_compression_mode(ctx->dsi, true);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable compression mode: %d\n", ret);
+		return ret;
+	}
+
+
+	msleep(28);
+
+	return 0;
+err:
+	s6e3ha8_power_off(ctx);
+	return ret;
+}
+
+static int s6e3ha8_amb577px01_wqhd_unprepare(struct drm_panel *panel)
+{
+	struct s6e3ha8 *ctx = to_s6e3ha8_amb577px01_wqhd(panel);
+
+	return s6e3ha8_power_off(ctx);
+}
+
+static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
+	.clock = (1440 + 116 + 44 + 120) * (2960 + 120 + 80 + 124) * 60 / 1000,
+	.hdisplay = 1440,
+	.hsync_start = 1440 + 116,
+	.hsync_end = 1440 + 116 + 44,
+	.htotal = 1440 + 116 + 44 + 120,
+	.vdisplay = 2960,
+	.vsync_start = 2960 + 120,
+	.vsync_end = 2960 + 120 + 80,
+	.vtotal = 2960 + 120 + 80 + 124,
+	.width_mm = 64,
+	.height_mm = 132,
+};
+
+static int s6e3ha8_amb577px01_wqhd_get_modes(struct drm_panel *panel,
+					     struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &s6e3ha8_amb577px01_wqhd_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
+	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
+	.unprepare = s6e3ha8_amb577px01_wqhd_unprepare,
+	.get_modes = s6e3ha8_amb577px01_wqhd_get_modes,
+	.enable = s6e3ha8_enable,
+	.disable = s6e3ha8_disable,
+};
+
+static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct s6e3ha8 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->supplies[0].supply = "vdd3";
+	ctx->supplies[1].supply = "vci";
+	ctx->supplies[2].supply = "vddr";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
+		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	drm_panel_init(&ctx->panel, dev, &s6e3ha8_amb577px01_wqhd_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
+
+	drm_panel_add(&ctx->panel);
+
+	/* This panel only supports DSC; unconditionally enable it */
+	dsi->dsc = &ctx->dsc;
+
+	ctx->dsc.dsc_version_major = 1;
+	ctx->dsc.dsc_version_minor = 1;
+
+	ctx->dsc.slice_height = 40;
+	ctx->dsc.slice_width = 720;
+	WARN_ON(1440 % ctx->dsc.slice_width);
+	ctx->dsc.slice_count = 1440 / ctx->dsc.slice_width;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
+	ctx->dsc.block_pred_enable = true;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void s6e3ha8_amb577px01_wqhd_remove(struct mipi_dsi_device *dsi)
+{
+	struct s6e3ha8 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
+	{ .compatible = "samsung,s6e3ha8" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
+
+static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
+	.probe = s6e3ha8_amb577px01_wqhd_probe,
+	.remove = s6e3ha8_amb577px01_wqhd_remove,
+	.driver = {
+		.name = "panel-s6e3ha8",
+		.of_match_table = s6e3ha8_amb577px01_wqhd_of_match,
+	},
+};
+module_mipi_dsi_driver(s6e3ha8_amb577px01_wqhd_driver);
+
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for S6E3HA8 panel");
+MODULE_LICENSE("GPL");

-- 
2.39.2



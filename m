Return-Path: <linux-pwm+bounces-9304-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9wcBqUNMmphuAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9304-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 04:59:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82447696346
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 04:59:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XW0EIwWO;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9304-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9304-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B03B13014683
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAB3009E1;
	Wed, 17 Jun 2026 02:59:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372643064AE
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jun 2026 02:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665182; cv=none; b=XYoXEUBd6R8lCOPcjtK+cPslfBaFUKF3Fsgm4SoOp0e0hzNxMjI2pew3w7OZ3WXqAJHchKDqYZsYrPF9ngLVeajMZQwG3bq2saNB7AhjOPTnwpi1gKMs8EzhBPEnKMrbPEkt5lykMcRtLG+E52AC7TCrY/jpAspSMOya2wBOyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665182; c=relaxed/simple;
	bh=Nmvw2oQbQwBoDitHnKw0YxFXGwZb2YjOckUU6YYV1zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsKVd7TR22j2pdZoNYYA/jBZyIM82wCZ31UlZ+Iw9nrS0CEZPJKef69wL3/FZFvtoEiP7NYaN64JKb3yK11xAITvQFkpsWMHLnMYKWyO5Nhl/UdxJPaw0bRy+L3FeVzrO/PkmGJOkhQe0hT2o/R66rHLR87OYRPdrY8Ix+lvanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW0EIwWO; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84232e83ca9so2543429b3a.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2026 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665181; x=1782269981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlq7rf7D7jnIOwcFham5QcmoXd7kahsZXkCesqlAf3g=;
        b=XW0EIwWOIH63b4Tw2EQ7Akhl2seHBWAUNyyI3WK9tDBl5LzbSujSQfCgMxEw1KkF0J
         HuNKDvlaxbDDA0YNY0Ozrg4kRDrLVMSGL2eYVSsw86vbLBpA/ykydBn/41Jjed/uCdOg
         96FlCVAi/t3rjUA0GswtjAtjs7cCVoHol07EIqW3Bs9YqCqLNqUXGCMZeUW8858cR14P
         oedb90O4hlgJuK6WrQ7XAv8DHR6frZbykNbRfaKoxbhokMU1mhsU0SmzyFJPJQI6BUVX
         jwSYKv3TMi7tJi3FdlzL6Ua0gWnP61PyCvNMCgnzOFzLx7+ES138TSg92JDkfTDgk4GR
         /V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665181; x=1782269981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qlq7rf7D7jnIOwcFham5QcmoXd7kahsZXkCesqlAf3g=;
        b=sjqIl29wjYqDTd/kc2rgeYR1FqGgSVovhs6vdAxMhSKEJafJpa3AN2QTck2QEQndgG
         CSfqjnSL9DKZEPju8cj4OeQ+6+JbKHmQKV6dkFkyqfEn7h2qDJQ/uuwp2psG3WGc/bXc
         AxdvoPcED5OmYj+3rUSNiQPAOs+Loz0/W4QT96GkT2N9dortYOeNNu03zRj7YXnLe947
         /5g2GBUkLXvHwn4egvJFsGmvM2RRlgb05fNOuT9WftMkI3Pb6wbIfsKvgS5Txn6BUCay
         iLf5ZBMkenReexSCzMVItJSzw1rMYCiWtmcL3KQWKZUSTsg+Pv9sev76cJZXyYjcrqwg
         srYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+saVA5GlTf4VuZl0F59+KQbcJBzhIANdEVQUrA60xtddZR0qSjHF4x6A/jURPF9Nyd6CdJWQ18oFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB8gkkJ+cKZtU+TVTjlichqRUGX8l4fIvuOfrnPnAsV5Z05LK
	p81h5ham5reP8wq44lKtCfvkJ020CwOpju0Qs8XCY7s5uHCzvojZCHbh
X-Gm-Gg: Acq92OGUR8OaAngE6+dzdETt+9JtA+cON6fCcV0GJ/8RBONnyh9TOg1+iYYWjq6+j0i
	3oYAg9Lh3i2dfvYCfPQqGHPwuK7mG/P/f3NcH+2xHwb6hp/IMvUE7kaesCAw5/O+CaqbrgEWmJV
	6465D9uVkP1HxZfXmcX2lpAGhPrzfRW/o6EbeKy72UjRsy9UVVu/0Wl1guX+mGKwWZj0YZW1HJx
	WB1MDuifKxpywPeVYt7uZySBKSLUM92wubUBdIVRmeSYl3xemLoslS5ZdPkinoiNb2qJW+W1rPM
	iXj//mBeONUvQm+WqlK7y1ke8NVKqX9ghRskmizp0I4C4JjojDkHCgB2b6kA81H2YORBD8YSXS2
	sR+GQZQrRoEXYJYcBSYfN2JrR7jW1V6be/yjUVKrWy/Guoclc092hlzQ9llk23dZTBZVLBLwEds
	X8hXqq397hVZzehyb7Y6tVUcdMD+FGP1wRLjcSvg/bZABQqM7shx6dXLnZFLCdbmTw+LiCUV7cT
	H0=
X-Received: by 2002:a05:6a00:80a:b0:842:5719:455c with SMTP id d2e1a72fcca58-84524561f5bmr1631613b3a.25.1781665180476;
        Tue, 16 Jun 2026 19:59:40 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc825csm14212821b3a.36.2026.06.16.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:59:40 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Wed, 17 Jun 2026 10:59:25 +0800
Message-Id: <20260617025925.2539334-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617025925.2539334-1-cwweng.linux@gmail.com>
References: <20260617025925.2539334-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,nuvoton.com,gmail.com,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9304-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cwweng@nuvoton.com,m:cwweng.linux@gmail.com,m:tgamblin@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:cwwenglinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nuvoton.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82447696346

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add a PWM framework driver for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels. The hardware supports
up, down and up-down counter types, auto-reload and one-shot modes, and
independent and complementary output modes. This driver configures all
channels to up-counting mode, auto-reload mode and independent output mode.

The waveform generator is configured to drive the output high at the zero
point and low at the compare-up point. In up-counting mode the counter
counts from 0 to PERIOD inclusive, so the PWM period is PERIOD + 1 cycles.
With the selected waveform actions, CMPDAT = 0 generates 0% duty cycle and
CMPDAT > PERIOD generates 100% duty cycle. Limit PERIOD to 0xfffe so that
CMPDAT = 0xffff can be used for the full-duty case.

PERIOD and CMPDAT updates are buffered by the hardware and take effect at
the end of the current period because IMMLDENn is left disabled. When the
PWM output is disabled, POENn is cleared and the output pin is put into
tri-state.

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 drivers/pwm/Kconfig      |   9 +
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ma35d1.c | 344 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/pwm/pwm-ma35d1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..355131e6efac 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -463,6 +463,15 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
+config PWM_MA35D1
+	tristate "Nuvoton MA35D1 PWM support"
+	depends on ARCH_MA35 || COMPILE_TEST
+	help
+	  Generic PWM framework driver for Nuvoton MA35D1.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ma35d1.
+
 config PWM_MAX7360
 	tristate "MAX7360 PWMs"
 	depends on MFD_MAX7360
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..7ad761ea27d1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
 obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
new file mode 100644
index 000000000000..c07eedeca035
--- /dev/null
+++ b/drivers/pwm/pwm-ma35d1.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Nuvoton MA35D1 PWM controller
+ *
+ * Copyright (C) 2026 Nuvoton Corporation
+ *               Chi-Wen Weng <cwweng@nuvoton.com>
+ *
+ * Reference Manual:
+ * https://www.nuvoton.com.cn/resource-download.jsp?tp_GUID=DA05-MA35D16
+ *
+ * Limitations:
+ * - The hardware supports 6 PWM channels.
+ * - The hardware supports up, down and up-down counter types. This driver
+ *   configures all channels to up-counting mode.
+ * - The hardware supports auto-reload and one-shot counter modes. This driver
+ *   configures all channels to auto-reload mode.
+ * - The hardware supports independent and complementary output modes. This
+ *   driver configures all channels to independent output mode.
+ * - The hardware supports programmable waveform actions at zero, period and
+ *   compare points. This driver uses zero point high and compare-up point low
+ *   actions for normal PWM output.
+ * - In up-counting mode, the counter counts from 0 to PERIOD inclusive. With
+ *   zero point high and compare-up point low actions, CMPDAT = 0 produces 0%
+ *   duty and CMPDAT > PERIOD produces 100% duty.
+ * - The driver limits PERIOD to 0xfffe so that CMPDAT can be set greater than
+ *   PERIOD to generate a 100% duty cycle.
+ * - Period and duty cycle changes are buffered by hardware and take effect at
+ *   the end of the current period because IMMLDENn is left disabled.
+ * - Polarity changes are applied directly and may cause a transient output
+ *   change if the PWM output is running.
+ * - When disabled, the output pin is put in tri-state by clearing POENn.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define MA35D1_REG_PWM_CTL0			0x00
+#define MA35D1_REG_PWM_CTL1			0x04
+#define MA35D1_REG_PWM_CNTEN			0x20
+#define MA35D1_REG_PWM_PERIOD(ch)		(0x30 + 4 * (ch))
+#define MA35D1_REG_PWM_CMPDAT(ch)		(0x50 + 4 * (ch))
+#define MA35D1_REG_PWM_WGCTL0			0xb0
+#define MA35D1_REG_PWM_WGCTL1			0xb4
+#define MA35D1_REG_PWM_POLCTL			0xd4
+#define MA35D1_REG_PWM_POEN			0xd8
+
+#define MA35D1_PWM_CTL1_CNTMODE_MASK(ch)	BIT(16 + (ch))
+#define MA35D1_PWM_CTL1_OUTMODE_MASK(ch)	BIT(24 + ((ch) / 2))
+
+#define MA35D1_PWM_WGCTL_ACTION_MASK		0x3
+#define MA35D1_PWM_WGCTL_ACTION_LOW		1
+#define MA35D1_PWM_WGCTL_ACTION_HIGH		2
+
+#define MA35D1_PWM_WGCTL_ZERO_HIGH(ch)		\
+	(MA35D1_PWM_WGCTL_ACTION_HIGH << (2 * (ch)))
+#define MA35D1_PWM_WGCTL_CMP_UP_LOW(ch)		\
+	(MA35D1_PWM_WGCTL_ACTION_LOW << (2 * (ch)))
+
+#define MA35D1_PWM_CNTEN_EN(ch)			BIT(ch)
+#define MA35D1_PWM_POEN_EN(ch)			BIT(ch)
+#define MA35D1_PWM_POLCTL_INV(ch)		BIT(ch)
+
+#define MA35D1_PWM_MAX_CMPDAT			0xffff
+#define MA35D1_PWM_MAX_PERIOD			0xfffe
+#define MA35D1_PWM_MAX_PERIOD_CYCLES		(MA35D1_PWM_MAX_PERIOD + 1)
+#define MA35D1_PWM_NUM_CHANNELS			6
+
+struct nuvoton_pwm {
+	void __iomem *base;
+	unsigned long clkrate;
+};
+
+static inline struct nuvoton_pwm *nuvoton_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static inline u32 nuvoton_pwm_ctl1_cnttype_mask(unsigned int ch)
+{
+	return MA35D1_PWM_WGCTL_ACTION_MASK << (2 * ch);
+}
+
+static inline u32 nuvoton_pwm_wgctl_zero_mask(unsigned int ch)
+{
+	return MA35D1_PWM_WGCTL_ACTION_MASK << (2 * ch);
+}
+
+static inline u32 nuvoton_pwm_wgctl_period_mask(unsigned int ch)
+{
+	return MA35D1_PWM_WGCTL_ACTION_MASK << (16 + 2 * ch);
+}
+
+static inline u32 nuvoton_pwm_wgctl_cmp_up_mask(unsigned int ch)
+{
+	return MA35D1_PWM_WGCTL_ACTION_MASK << (2 * ch);
+}
+
+static inline u32 nuvoton_pwm_wgctl_cmp_down_mask(unsigned int ch)
+{
+	return MA35D1_PWM_WGCTL_ACTION_MASK << (16 + 2 * ch);
+}
+
+static inline u32 nuvoton_pwm_readl(struct nuvoton_pwm *nvtpwm,
+				    unsigned int offset)
+{
+	return readl(nvtpwm->base + offset);
+}
+
+static inline void nuvoton_pwm_writel(struct nuvoton_pwm *nvtpwm,
+				      unsigned int offset, u32 value)
+{
+	writel(value, nvtpwm->base + offset);
+}
+
+static inline void nuvoton_pwm_rmw(struct nuvoton_pwm *nvtpwm,
+				   unsigned int offset, u32 mask, u32 value)
+{
+	u32 reg;
+
+	reg = nuvoton_pwm_readl(nvtpwm, offset);
+	reg &= ~mask;
+	reg |= value & mask;
+	nuvoton_pwm_writel(nvtpwm, offset, reg);
+}
+
+static void nuvoton_pwm_init(struct nuvoton_pwm *nvtpwm)
+{
+	u32 ctl1_mask = 0;
+	u32 wgctl0_mask = 0;
+	u32 wgctl0_val = 0;
+	u32 wgctl1_mask = 0;
+	u32 wgctl1_val = 0;
+	int ch;
+
+	for (ch = 0; ch < MA35D1_PWM_NUM_CHANNELS; ch++) {
+		/* CNTTYPEn = 00: up counter type */
+		ctl1_mask |= nuvoton_pwm_ctl1_cnttype_mask(ch);
+
+		/* CNTMODEn = 0: auto-reload mode */
+		ctl1_mask |= MA35D1_PWM_CTL1_CNTMODE_MASK(ch);
+
+		/* ZPCTLn = 10: output high at zero point */
+		wgctl0_mask |= nuvoton_pwm_wgctl_zero_mask(ch);
+		wgctl0_val |= MA35D1_PWM_WGCTL_ZERO_HIGH(ch);
+
+		/* PRDPCTLn = 00: do nothing at period point */
+		wgctl0_mask |= nuvoton_pwm_wgctl_period_mask(ch);
+
+		/* CMPUCTLn = 01: output low at compare up point */
+		wgctl1_mask |= nuvoton_pwm_wgctl_cmp_up_mask(ch);
+		wgctl1_val |= MA35D1_PWM_WGCTL_CMP_UP_LOW(ch);
+
+		/* CMPDCTLn = 00: do nothing at compare down point */
+		wgctl1_mask |= nuvoton_pwm_wgctl_cmp_down_mask(ch);
+	}
+
+	for (ch = 0; ch < MA35D1_PWM_NUM_CHANNELS; ch += 2) {
+		/* OUTMODEn = 0: independent mode */
+		ctl1_mask |= MA35D1_PWM_CTL1_OUTMODE_MASK(ch);
+	}
+
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CTL1, ctl1_mask, 0);
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL0,
+			wgctl0_mask, wgctl0_val);
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL1,
+			wgctl1_mask, wgctl1_val);
+}
+
+static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm = nuvoton_pwm_from_chip(chip);
+	u32 ch = pwm->hwpwm;
+	u64 duty_cycles, period_cycles;
+	u32 cmpdat, period;
+
+	if (!state->enabled) {
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN,
+				MA35D1_PWM_POEN_EN(ch), 0);
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CNTEN,
+				MA35D1_PWM_CNTEN_EN(ch), 0);
+
+		return 0;
+	}
+
+	period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+					    state->period,
+					    NSEC_PER_SEC);
+	if (!period_cycles)
+		return -EINVAL;
+
+	if (period_cycles > MA35D1_PWM_MAX_PERIOD_CYCLES)
+		period_cycles = MA35D1_PWM_MAX_PERIOD_CYCLES;
+
+	duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+					  state->duty_cycle,
+					  NSEC_PER_SEC);
+	if (duty_cycles > period_cycles)
+		duty_cycles = period_cycles;
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
+				MA35D1_PWM_POLCTL_INV(ch), 0);
+	else
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
+				MA35D1_PWM_POLCTL_INV(ch),
+				MA35D1_PWM_POLCTL_INV(ch));
+
+	/*
+	 * In up-counting mode the counter counts from 0 to PERIOD inclusive.
+	 * With zero point high and compare-up point low actions:
+	 * - CMPDAT = 0 produces 0% duty.
+	 * - CMPDAT > PERIOD produces 100% duty.
+	 * PERIOD is limited to 0xfffe, so duty_cycles can be written directly
+	 * to CMPDAT and still fit in the 16-bit compare field for 100% duty.
+	 */
+	period = period_cycles - 1;
+	cmpdat = duty_cycles;
+
+	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_PERIOD(ch), period);
+	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_CMPDAT(ch), cmpdat);
+
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CNTEN,
+			MA35D1_PWM_CNTEN_EN(ch), MA35D1_PWM_CNTEN_EN(ch));
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN,
+			MA35D1_PWM_POEN_EN(ch), MA35D1_PWM_POEN_EN(ch));
+
+	return 0;
+}
+
+static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm = nuvoton_pwm_from_chip(chip);
+	u32 ch = pwm->hwpwm;
+	u32 cmpdat, cnten, period, poen, polctl;
+	u64 duty_cycles, period_cycles;
+
+	cnten = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CNTEN);
+	poen = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_POEN);
+	polctl = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_POLCTL);
+	period = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_PERIOD(ch)) &
+		 MA35D1_PWM_MAX_CMPDAT;
+	cmpdat = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CMPDAT(ch)) &
+		 MA35D1_PWM_MAX_CMPDAT;
+
+	period_cycles = period + 1;
+	if (cmpdat > period)
+		duty_cycles = period_cycles;
+	else
+		duty_cycles = cmpdat;
+
+	state->enabled = (cnten & MA35D1_PWM_CNTEN_EN(ch)) &&
+			 (poen & MA35D1_PWM_POEN_EN(ch));
+	state->polarity = (polctl & MA35D1_PWM_POLCTL_INV(ch)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->period = DIV64_U64_ROUND_UP(period_cycles * NSEC_PER_SEC,
+					   nvtpwm->clkrate);
+	state->duty_cycle = DIV64_U64_ROUND_UP(duty_cycles * NSEC_PER_SEC,
+					       nvtpwm->clkrate);
+
+	return 0;
+}
+
+static const struct pwm_ops nuvoton_pwm_ops = {
+	.apply = nuvoton_pwm_apply,
+	.get_state = nuvoton_pwm_get_state,
+};
+
+static int nuvoton_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct nuvoton_pwm *nvtpwm;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, MA35D1_PWM_NUM_CHANNELS,
+				  sizeof(*nvtpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	nvtpwm = nuvoton_pwm_from_chip(chip);
+
+	nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(nvtpwm->base))
+		return PTR_ERR(nvtpwm->base);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Unable to get the clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to get exclusive clock rate\n");
+
+	nvtpwm->clkrate = clk_get_rate(clk);
+	if (!nvtpwm->clkrate)
+		return dev_err_probe(dev, -EINVAL,
+				     "PWM clock rate is zero\n");
+
+	if (nvtpwm->clkrate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "PWM clock out of range (%lu)\n",
+				     nvtpwm->clkrate);
+
+	nuvoton_pwm_init(nvtpwm);
+
+	chip->ops = &nuvoton_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id nuvoton_pwm_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
+
+static struct platform_driver nuvoton_pwm_driver = {
+	.probe = nuvoton_pwm_probe,
+	.driver = {
+		.name = "nuvoton-pwm",
+		.of_match_table = nuvoton_pwm_of_match,
+	},
+};
+module_platform_driver(nuvoton_pwm_driver);
+
+MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



Return-Path: <linux-pwm+bounces-4273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46789E6966
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 09:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC89167A91
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43241E0490;
	Fri,  6 Dec 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2tJnm+K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199891DBB3A;
	Fri,  6 Dec 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475329; cv=none; b=ZtCYvaCd0/jJaFqoY/2ppHlPAG4eY9/gt8TB1jW4MyU3OM/cpEqHpBZUEMTcCYPPCvomDYyuPmB7duzvGVZ3J+vJN/4aBLS+/M1Py4NH/co+xujfUK8C8INpMbzAcPOKNQfckCCSxnbHSYY6Hldgz4BgXz0j6ZBKjZDG4DRO7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475329; c=relaxed/simple;
	bh=dpabMgkKG1KitgXEDdoTutm1B3Ihq61MnxQbt6enQCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/Oh5fHlpSrSxA1iXu+3K25PpqWqkNIVVJcTsyMCWkB2yzhDiNDNRCktkwMF5neG29j5cXjZGEKb0aYXdZvYoMyWVrpuDBx0AnD+vdaJUt9rQ+wstHVR/oP6U01rE1AZNiP94G2SgGhnlJbxMsUsE8rb+hhUE5/PeGGfoCd7EjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2tJnm+K; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1298135a91.3;
        Fri, 06 Dec 2024 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733475326; x=1734080126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXzBDmYmAYiTEiNeSDk23tSQ42obw3PMZqIoeDF1+Gw=;
        b=j2tJnm+KuoiHpOfx3kPz3UYSkfh62hDqvAsoC//tH4U8cIDa8f1xPVmxE6JRzbg0rX
         JrIc4St8h8YPYiXb1NjbbMmp6Fg0LSD6yZ0hVyJwIU32X9a9ldHMuqYE+Zy8upwKM5vb
         87LyA2PMOUNNgivTwHPGzBqyXq1lBIzcdHdv1UQBXVKGLwnCfnF4MbqqSvTOLZZnsqsk
         bkLHB+fyvtLXLV20cP/DUSL28TVJQ3yDru1KHego5BDvGMnFD5EhK08i7GVaBwT8kHMo
         IfXbbFBw+tUl2com4ZpQi7MIA9fBg+7DIXUy3OtRTElwom+xKlJamAdgRmp3mtBSkxHg
         eWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475326; x=1734080126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXzBDmYmAYiTEiNeSDk23tSQ42obw3PMZqIoeDF1+Gw=;
        b=MQTOVHB5BFU2RWvaKCr4GFKA3qHKezAvXatJQzpFoyzhWuyR3PDb3LVJOgGGqLu9VG
         hSHT0MSinaqUOLqFBnsjKB5I+OAElgqARf714l2WyPbil9j7wtwO/fL0XeChxQ+tMws0
         jvk5NiCZs2dnbxoSpH0W7T0+WYXh65fXv9Dz6BrQvqSrk8qpn1ezuYVzl1vQ+eaAioGR
         XAUBOQ5sdhttxk9cVW7MgPiutyxaJSpGjK4RHzkmMdvbrsN7xxF0EkNlUWaRgeqoBqaa
         OeN9llv+FKt34djWj0qYp/KN+seT+m73YNLO/zTiLGw/dtE1fXXTkYcN6gyecV/iczCF
         HFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHHyxDBocxcfTjpR3ETh9H3bMZo8qTTkhQ3iprlw8f4AsDNUILow6Itu/Fzx545LMprlALGw1997lT@vger.kernel.org, AJvYcCWQCdweaLxUg1cDqQhmC32q40/UVihpWxlKlxGPY1Obw304FE8Q4BouB4KsksnUQPK8wg1T0hNqnpL+@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNPPciGvOA2PdKlliDD7hLDDLh6VD5drmc/7I6Cxxf5R4FDWY
	ndngeDozppNux0LBd1XIQqQxgCrBd8RyXxnoHFg/WTYw2UDI9+XR
X-Gm-Gg: ASbGnct877oabjOy7G0cdXnHr8BkmxKaxKhRRfpf83tWdxRjsdGxQR0P9j7TNPGwb+D
	aaFKxdid8SE3T+YLmtyY+oDk9R5DXT4aMb6JnR0da60GLMP8xv2SZJZDxBas1vFu1a1hmU7UYbE
	JiFzvDy/wBcULh2FLFkZ1gwwmfaZF12BQ+T7NtFqnnhwQWZDC0km1w/Q5izx7ZjUIh3ruyULj3h
	exBsd21DMkKX9NrtZWkn979iYFzmfy9yY9sJYmPycei1mf/2ZoiZCYdkAerRJo0WcbvIcbJoe7e
	0YF5cQmlu01HIp+f2ZWWDhfkmqzy75iOI85XUw==
X-Google-Smtp-Source: AGHT+IFt1vV18k4dYxA/UZ0/gooX1mzCL2kGcZVlW0cdLXLI3lYqX+tdAlh93E2m8aPP+pmfkxlYiQ==
X-Received: by 2002:a17:90b:5204:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2ef6a6bdc2amr4041200a91.17.1733475325861;
        Fri, 06 Dec 2024 00:55:25 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270795d6sm4548157a91.42.2024.12.06.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:55:25 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH v3 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Fri,  6 Dec 2024 16:55:01 +0800
Message-Id: <20241206085501.2623772-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206085501.2623772-1-cwweng.linux@gmail.com>
References: <20241206085501.2623772-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a generic PWM framework driver for Nuvoton MA35D1 PWM controller.

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
---
 drivers/pwm/Kconfig      |   9 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ma35d1.c | 179 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/pwm/pwm-ma35d1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..97b9e83af020 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -411,6 +411,15 @@ config PWM_LPSS_PLATFORM
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
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..c1d3a1d8add0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
new file mode 100644
index 000000000000..380f17b20a3d
--- /dev/null
+++ b/drivers/pwm/pwm-ma35d1.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Nuvoton MA35D1 PWM controller
+ *
+ * Copyright (C) 2024 Nuvoton Corporation
+ *               Chi-Wen Weng <cwweng@nuvoton.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/* The following are registers address offset for MA35D1 PWM controller */
+#define MA35D1_REG_PWM_CTL0            (0x00)
+#define MA35D1_REG_PWM_CNTEN           (0x20)
+#define MA35D1_REG_PWM_PERIOD0         (0x30)
+#define MA35D1_REG_PWM_CMPDAT0         (0x50)
+#define MA35D1_REG_PWM_WGCTL0          (0xB0)
+#define MA35D1_REG_PWM_POLCTL          (0xD4)
+#define MA35D1_REG_PWM_POEN            (0xD8)
+
+/* The following are register address of MA35D1 PWM controller */
+#define MA35D1_PWM_CH_REG_SIZE         4
+#define MA35D1_PWM_CMPDAT0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_CMPDAT0 + \
+					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
+#define MA35D1_PWM_CNTEN_ADDR(base)           ((base) + MA35D1_REG_PWM_CNTEN)
+#define MA35D1_PWM_PERIOD0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_PERIOD0 + \
+					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
+#define MA35D1_PWM_POEN_ADDR(base)            ((base) + MA35D1_REG_PWM_POEN)
+#define MA35D1_PWM_POLCTL_ADDR(base)          ((base) + MA35D1_REG_PWM_POLCTL)
+
+#define MA35D1_PWM_MAX_COUNT           0xFFFF
+#define MA35D1_PWM_TOTAL_CHANNELS      6
+
+struct nuvoton_pwm {
+	void __iomem *base;
+	u64 clkrate;
+};
+
+static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm;
+	u32 ch = pwm->hwpwm;
+
+	nvtpwm = to_nuvoton_pwm(chip);
+	if (state->enabled) {
+		u64 duty_cycles, period_cycles;
+
+		/* Calculate the duty and period cycles */
+		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+						  state->duty_cycle, NSEC_PER_SEC);
+		if (duty_cycles > MA35D1_PWM_MAX_COUNT)
+			duty_cycles = MA35D1_PWM_MAX_COUNT;
+
+		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+						    state->period, NSEC_PER_SEC);
+		if (period_cycles > MA35D1_PWM_MAX_COUNT)
+			period_cycles = MA35D1_PWM_MAX_COUNT;
+
+		/* Write the duty and period cycles to registers */
+		writel(duty_cycles, MA35D1_PWM_CMPDAT0_ADDR(nvtpwm->base, ch));
+		writel(period_cycles, MA35D1_PWM_PERIOD0_ADDR(nvtpwm->base, ch));
+		/* Enable counter */
+		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) | BIT(ch),
+		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
+		/* Enable output */
+		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) | BIT(ch),
+		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));
+	} else {
+		/* Disable counter */
+		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) & ~BIT(ch),
+		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
+		/* Disable output */
+		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) & ~BIT(ch),
+		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));
+	}
+
+	/* Set polarity state to register */
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) & ~BIT(ch),
+		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));
+	else
+		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) | BIT(ch),
+		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));
+
+	return 0;
+}
+
+static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm;
+	u32 duty_cycles, period_cycles, cnten, outen, polarity;
+	u32 ch = pwm->hwpwm;
+
+	nvtpwm = to_nuvoton_pwm(chip);
+
+	cnten = readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
+	outen = readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base));
+	duty_cycles = readl(MA35D1_PWM_CMPDAT0_ADDR(nvtpwm->base, ch));
+	period_cycles = readl(MA35D1_PWM_PERIOD0_ADDR(nvtpwm->base, ch));
+	polarity = readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) & BIT(ch);
+
+	state->enabled = (cnten & BIT(ch)) && (outen & BIT(ch));
+	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
+	state->period = DIV64_U64_ROUND_UP((u64)period_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
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
+	struct pwm_chip *chip;
+	struct nuvoton_pwm *nvtpwm;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, MA35D1_PWM_TOTAL_CHANNELS, sizeof(*nvtpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	nvtpwm = to_nuvoton_pwm(chip);
+
+	nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(nvtpwm->base))
+		return PTR_ERR(nvtpwm->base);
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the clock");
+
+	nvtpwm->clkrate = clk_get_rate(clk);
+	if (nvtpwm->clkrate > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
+
+	chip->ops = &nuvoton_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
+
+	return 0;
+}
+
+static const struct of_device_id nuvoton_pwm_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-pwm" },
+	{}
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



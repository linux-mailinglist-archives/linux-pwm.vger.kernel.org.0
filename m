Return-Path: <linux-pwm+bounces-3697-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D69A3382
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 05:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF96B21521
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3814F9D9;
	Fri, 18 Oct 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYVwuHid"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13820E31D;
	Fri, 18 Oct 2024 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223357; cv=none; b=AZN+7bshNODznpkmbbLD6rW0fHb/xgJggeS4uAm8zeU+BJs4lxrFWpOO69zOAvZl+xg8we686HiGqCOkTacCJDkEs2YTSXzrQfNO0aTKQEjPtfMVqEgRxGDF/0p+AMLysR+NMa/Xq+jpz+yCFuQcywInCfiu1QogK5K/dxyExIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223357; c=relaxed/simple;
	bh=2ROPKV/YO+XfI7JnPAUC+T0ibiiKPFY8tNakO1iaveY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FP89XFkz8CFkZVk632LlWYrhemIkHYJLGR9PK6JnKkjXBGViznG97Y6J95QenHtVRDzki19Rs4Qc0H8at/z9x7lMJg9LuwPTpWoz+2yMcwkg22lIJm3gloQzkZPuEpaBWY89wA4QKLB7YjZeQfow4SNEbDPgoPaSz7qMgQyMt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYVwuHid; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4e481692so1446625b3a.1;
        Thu, 17 Oct 2024 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729223355; x=1729828155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coh1EnB/5gsirdiLvNmnevgbUAJ510gBOmPMlLkC3LY=;
        b=iYVwuHidJVzPwh/VMI8rAMWSicm8z0H0U02Dr4N7CpVWhuihH7zT4Hz5AzmVBiyamd
         M1wVOEZrYH+GabF8MByaUaBf+rPW7rp2mm08xndLOonVAy4ikeq+43OfJdJT1yNyOtS0
         NRR86o6/pFtRUevnSmHR+DHAGffyvHHcBSaHXO6vP9yfqDg1AEZzwFMLW36pGQ/6im2A
         ekAWUJ09JGSxH/W5NQWMGmwdKuKinYx2cUNDaDxzzQeLN/YHcs5PwsC5KzSYIU6PPmOT
         8upA8UFXckwHWeef/IrAkGHh4w+sjnl9lz3jpy5jM4yztRUaIPrFfGNRFYzC1In4nTIu
         B7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729223355; x=1729828155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coh1EnB/5gsirdiLvNmnevgbUAJ510gBOmPMlLkC3LY=;
        b=izBhtU/mwsdpv1o+lOxCyJkRuiOrTYQCC1dUbR2166XMGZEpcfJElUXu4Meoe5jjdf
         UAOr20OFiT3h0gat+le4ElhcJkzq3Qzgs7pghq5qs3IoMQEcxXnzQ8vXwKWWncz/4LWp
         rls5AWrgrZ7jPJy6KIUlX0CJwgaP/5cy5L02vCz5WGpTWZnQxWdRHoTeCmUQ06XZ4/2/
         o3614v29WqlSUud8enbSVpGb/lpuui/OVTWrsCBZro2FyBp2ylda7FngFgI7Sk+Ikez2
         +pVwdaF7g8rEhAGa3fntuEoChPlhKZ5KEwqV8BqNpNaYn8aFlI+gC6fs1+kxqk9RvsO/
         CrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZvSOk8PR9T1xSG2HucmkEF+gZ/UW9hpchzo19qiJxssU+s1ulJpchn7N1egG4khh23mM5dG3yP/kS@vger.kernel.org, AJvYcCXqbZ9mJu0ZiOTzDHkt08kWcwWpzpZp2cugMiOOScAyszWEII/+TXPtPdVR3RoB6USYAQPspRR9Bh1g@vger.kernel.org
X-Gm-Message-State: AOJu0YzoovUxg9AdrC3SSEuZ5TufVNnaOLvdaXS8fknkXm5Sx6MVYXXG
	LDIqL0qEtL8wAw1J4JkXhJ2L9pCy306qR6VpRYk5WhPVG6nmdir5
X-Google-Smtp-Source: AGHT+IHdjf5JFQy+j9k8j5918O8WPYIWFgxH8NYSJ0sf6bdKJ6T0JVtzhVCLLqpdNj3Vs6udtEPaxg==
X-Received: by 2002:a05:6a00:847:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-71ea31dcfbfmr1722794b3a.8.1729223354714;
        Thu, 17 Oct 2024 20:49:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333d6e2sm459066b3a.66.2024.10.17.20.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 20:49:14 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
Date: Fri, 18 Oct 2024 03:48:57 +0000
Message-Id: <20241018034857.568-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018034857.568-1-cwweng.linux@gmail.com>
References: <20241018034857.568-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a generic PWM framework driver for Nuvoton MA35D1
PWM controller.

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
---
 drivers/pwm/Kconfig      |   9 +++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ma35d1.c | 169 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
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
index 000000000000..dc2f1f494a91
--- /dev/null
+++ b/drivers/pwm/pwm-ma35d1.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Nuvoton MA35D1 PWM controller
+ *
+ * Copyright (C) 2024 Nuvoton Corporation
+ *               Chi-Wen Weng <cwweng@nuvoton.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/math64.h>
+
+/* The following are registers for PWM controller */
+#define REG_PWM_CTL0            (0x00)
+#define REG_PWM_CNTEN           (0x20)
+#define REG_PWM_PERIOD0         (0x30)
+#define REG_PWM_CMPDAT0         (0x50)
+#define REG_PWM_WGCTL0          (0xB0)
+#define REG_PWM_POLCTL          (0xD4)
+#define REG_PWM_POEN            (0xD8)
+
+#define PWM_TOTAL_CHANNELS      6
+#define PWM_CH_REG_SIZE         4
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
+	unsigned int ch = pwm->hwpwm;
+
+	nvtpwm = to_nuvoton_pwm(chip);
+	if (state->enabled) {
+		u64 duty_cycles, period_cycles;
+
+		/* Calculate the duty and period cycles */
+		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+						  state->duty_cycle, NSEC_PER_SEC);
+		if (duty_cycles > 0xFFFF)
+			duty_cycles = 0xFFFF;
+
+		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+						    state->period, NSEC_PER_SEC);
+		if (period_cycles > 0xFFFF)
+			period_cycles = 0xFFFF;
+
+		/* Write the duty and period cycles to registers */
+		writel(duty_cycles, nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
+		writel(period_cycles, nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
+		/* Enable counter */
+		writel(readl(nvtpwm->base + REG_PWM_CNTEN) | BIT(ch),
+		       nvtpwm->base + REG_PWM_CNTEN);
+		/* Enable output */
+		writel(readl(nvtpwm->base + REG_PWM_POEN) | BIT(ch),
+		       nvtpwm->base + REG_PWM_POEN);
+	} else {
+		/* Disable counter */
+		writel(readl(nvtpwm->base + REG_PWM_CNTEN) & ~BIT(ch),
+		       nvtpwm->base + REG_PWM_CNTEN);
+		/* Disable output */
+		writel(readl(nvtpwm->base + REG_PWM_POEN) & ~BIT(ch),
+		       nvtpwm->base + REG_PWM_POEN);
+	}
+
+	/* Set polarity state to register */
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		writel(readl(nvtpwm->base + REG_PWM_POLCTL) & ~BIT(ch),
+		       nvtpwm->base + REG_PWM_POLCTL);
+	else
+		writel(readl(nvtpwm->base + REG_PWM_POLCTL) | BIT(ch),
+		       nvtpwm->base + REG_PWM_POLCTL);
+
+	return 0;
+}
+
+static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm;
+	unsigned int duty_cycles, period_cycles, cnten, outen, polarity;
+	unsigned int ch = pwm->hwpwm;
+
+	nvtpwm = to_nuvoton_pwm(chip);
+
+	cnten = readl(nvtpwm->base + REG_PWM_CNTEN);
+	outen = readl(nvtpwm->base + REG_PWM_POEN);
+	duty_cycles = readl(nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
+	period_cycles = readl(nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
+	polarity = readl(nvtpwm->base + REG_PWM_POLCTL) & BIT(ch);
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
+	chip = devm_pwmchip_alloc(&pdev->dev, PWM_TOTAL_CHANNELS, sizeof(*nvtpwm));
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
+MODULE_ALIAS("platform:nuvoton-pwm");
+MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



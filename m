Return-Path: <linux-pwm+bounces-3769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874769AC8C1
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7A8B22231
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453921A76C7;
	Wed, 23 Oct 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSf8AVbr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6711B813;
	Wed, 23 Oct 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682380; cv=none; b=I6j71GWEvk2G03nQ6rxDi9x7F7llUR6LJyzY2GO44gT72xmXfBpnGPg4VhwMTE/DmUi3IWLg32B21XJLyNbum4cCyqhOEh+p2Rrv6R5+Yo70LljUNrpvDzQUIl00cJ9WHXgLnFRNvmpcrjBoEwPrLqDpDPJIjW/3MebbudJgP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682380; c=relaxed/simple;
	bh=tomDfqPdFM0tDWrIDWPOgHpsPRPeUXFaJZ/7oki03Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMe4temuM6FfvG0eezfgg4UtIt5U15i7C9chKmcZvPw6B6AD+MSpGgvumOttcuXBY67ElMmksy2/aEHVmTqxZ1BG6C5VEpmF50s9qRmiJDJG3xAyGeyfXs2UzcO0niaf//o7SwVsC3MTPmmIePGdYxrLSHgd31nDRxAetdWfY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSf8AVbr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so5265667a91.1;
        Wed, 23 Oct 2024 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729682378; x=1730287178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C8z0kUxphmO1mbzxm0HcdfPNxxCScQxUNHOYRipLFU=;
        b=kSf8AVbr7gsI2g6OwIQsPePhDxyGu62gpcQ8jzRJ1RwNKggbgdErPp14sOf9r77aVm
         VLryeJzSQYCsrf+VzRS0/Z6ntf04sBBYlWWjDpGd3zDaL/T7ZLS7ZzkMBAkQnrh0z8x+
         CVVn6670uXWdyma6qyv8hyeFTUkWvNJpo9yIBfC7ctNfqdAOu0Wp9btRsMgVKmxPaWpH
         zS1bIVg63d2w4/ZVUz33NOiLEfr9DYfRMpPqmHeapzPM0jO5gmiGcqSkkRWf87HLNypJ
         xqC0cd4gewfvC31LjnroX6sxGwVKdPXjPJqPxXikA6/nHo4XHe/uLLYsj1l4C1kLBsMp
         PqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729682378; x=1730287178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C8z0kUxphmO1mbzxm0HcdfPNxxCScQxUNHOYRipLFU=;
        b=Xvm8IaAleMCmM0C876lSCj8IlsEXJFPbNGsAXTf1iMwsPwwzn6GqEGwlnRUNprz7Mp
         ZwU/Jej25hrHi28RdEyV0ydwY2tEOBr38Aj1s68cbZrpY+ZvI2Nd8futfXwFD1af/LNA
         +W4+TBNAvhS2PMkHa83At3A7m0O0AwuZpPMtcS8rKMgPkO066N1SWBqeEm3FOfp2mmpx
         SsHnT2kUppMfiQ4+kR85obHsH6u4Mk2frQGRL3bo/oFD86L0Jf28yaOtj0bbx0KZzoRu
         VUAEJWehzARjiTZqJM5XVMP+QqkpyTpcRTInOaH+i2BGYCB7H26ol2oIqNTvF6GxQ5X/
         QYgg==
X-Forwarded-Encrypted: i=1; AJvYcCVksEu+mHQkfUOTc5xsxtG6+/ieeBWRf1qJwdypTiIf/VaJ73tqyTtemo2+iHa7fHoUTkTH/feuZtsD@vger.kernel.org, AJvYcCWTzfdPViL7yWXHAxKXSxpI+I0hdHBv74VN2hmeO/fb4P8S5qCUp4gNilDGderXxTVagMV5FzZ30Cp2@vger.kernel.org
X-Gm-Message-State: AOJu0YxYn4Y8ZEtS47c58B98XK36HOJ/gNiQf+s25sPfQvXE0OMMZXtH
	EPrvJeN5K7St8oSW2FUMM+vRMRAF6IqOT3p1tmoAqFAMNhkLxd9M
X-Google-Smtp-Source: AGHT+IHWkAom48nElv+CrCSKEuuG6+PM4jEwaw8EHQL7k37pr08zJu42eBeE0vJrs4cmc4YKknGc+g==
X-Received: by 2002:a17:90a:9e3:b0:2e7:6a44:daff with SMTP id 98e67ed59e1d1-2e76b5dd9aamr2507301a91.10.1729682377872;
        Wed, 23 Oct 2024 04:19:37 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfbeca4sm1123022a91.32.2024.10.23.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:19:37 -0700 (PDT)
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
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sean Young <sean@mess.org>
Subject: [PATCH v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Wed, 23 Oct 2024 19:18:41 +0800
Message-Id: <20241023111841.158049-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023111841.158049-1-cwweng.linux@gmail.com>
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sean Young <sean@mess.org>
Reviewed-by: "Uwe Kleine-Konig" <ukleinek@kernel.org>
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
index 000000000000..0c4eec4a0b07
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



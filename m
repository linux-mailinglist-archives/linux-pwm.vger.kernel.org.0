Return-Path: <linux-pwm+bounces-3667-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8999FD0D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51C1B2249A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622FD524F;
	Wed, 16 Oct 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6vSGs5V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9B21E3CD;
	Wed, 16 Oct 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038030; cv=none; b=d7LWuoLHTDQrjnbvz431iabJzjldicIen1/MYLQ7PxnzftGyw3X9aIjRcPqsigml6L9ppg+liz/MYk58wXOpkaNnTNF2uPOBKoULMXORFO65ergPKbiO3z6jB2kgypCRrOY66w2Er1NOFFS2XHdlTEZzSHI5DQDJoSH1zztZIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038030; c=relaxed/simple;
	bh=WJ+pDDYO9o+WoDmZ4X5dROVEVzJ4wwyDstMo2Vf+klo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3RURbIZ++lujHeu9WL19dSTcR1ig2tNFqMsmOtL+myt6foVtn//FqhisZozWEkDLE1YdNodE0RUCE4ADnRPQq314Ue1r8WKoIPc7jv2UN7jXZIQIPkYNXToJbEkfy31TWZZNxsc61NrdcCEQfAkDf61nPmTwwsXwKhxdA6CHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6vSGs5V; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e3e0a8aaabso2005307b6e.3;
        Tue, 15 Oct 2024 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729038027; x=1729642827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92VubGYyXALAVnQRA8GVr+urTCCGJBZXT1C9yLWdrMo=;
        b=D6vSGs5V5bwm8a1sW30o+g54UpTSM8KBQQMXaRZc+K92RfBr2gszfGc/kTyMACihjJ
         xYV9UutMQ2s/WEtcdwA7NluYi15PRlZOaRDNEQpB93kFm9Ks3u8pgG00I+gIhbFqVTm1
         j+gcmclVUkJ3wNT07O9LcB1xNMCzPUWs2DlClYUlU4aDyesl5ib84ezS5hoSlzzm7iNM
         x9f0Cb9YV2WbOms58WKM5xZrtAhEPxMxqRzq16tqeobI/xOiqf3dJFP2JHgczWitK2Kk
         /zl2W2ipX8mBKbtKZOIRhK/yopIhTgvLXAXLYRzgx+sLAYbfOEzHW3perFpgQMHFVE82
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729038027; x=1729642827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92VubGYyXALAVnQRA8GVr+urTCCGJBZXT1C9yLWdrMo=;
        b=Dmm+5WTjTQl395tn/KkZ4QDQ+i988WOOlhXzzlZd2zvHg8FxKUuRKd6za0no0yWnKx
         zb99UuOEJe5JF0El+ZlQIgeueOEydfYQVlGFY7MFeAfkqeqsOTJVbBIHz6+c2k2jeN7o
         UhiugJLiNocLNilU7P9kxK9+peJ9ssJAKygzKDo1049GXJ+lIrI2qOXHTNbAAXTKtJas
         jLZ2yeP8Nu5+G4HYto+8j38t7V34C2eNDcw6hplMrsSu1ms3A9LhCX0NkA50U2lmzRHL
         mbgNbRVkbtZMYgp+RqIm7jSycpM4eMJpxdWCk9RzoKdVRp/8vdam+UW3b6pQ66Hzb86Q
         qMDw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pREEiUIghwJo4yGBrJ0gYCBSjwkepzh9gr4X1XWwJr7Ji2xPQEJNvGUXbpVWBnZufvo5qJXH1tVv@vger.kernel.org, AJvYcCXRfo5AChQwRd2F5GMGDxR/gqhFR0QohOZz5HRT/dn8XmtOadXq3oPfGF+OI0aS/ggAcKVhsA3yQz2X@vger.kernel.org, AJvYcCXgMvTU+wTa+ckfCKp0dTaoB7Q3GKXTP4C3QeLLE50k5eNOrRbpyR7s5a9TE3TxvllXbt9TAiDND4Px3Adi@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCZDjRbjsZYr1d+/1Ul7VyYd9rS1llvzxAdLpdObute/rNm1m
	0cID3zt4/3MgvxeC4Cj9UjN4CUiDaFn2y2/CaTuLYkEymvN33rom
X-Google-Smtp-Source: AGHT+IGggwTQpU/fZt9x3V9eDWYPhRnofWhHB5l7vHyW3i3HG/9uWe1jwPwJPpk0YM/IQBBQqcKLgA==
X-Received: by 2002:a05:6808:1a02:b0:3e4:d683:c242 with SMTP id 5614622812f47-3e5d220de87mr9263719b6e.15.1729038027519;
        Tue, 15 Oct 2024 17:20:27 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e5e85e1c7fsm591950b6e.39.2024.10.15.17.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:20:26 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH v4 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Date: Wed, 16 Oct 2024 08:20:18 +0800
Message-Id: <cc69b47d068ff339db4c93d3103ed80d10a172d0.1729037302.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729037302.git.unicorn_wang@outlook.com>
References: <cover.1729037302.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add a PWM driver for PWM controller in Sophgo SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pwm/Kconfig             |  10 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c | 181 ++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..ec85f3895936 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -584,6 +584,16 @@ config PWM_SL28CPLD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sl28cpld.
 
+config PWM_SOPHGO_SG2042
+	tristate "Sophgo SG2042 PWM support"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  PWM driver for the PWM controller on Sophgo SG2042 SoC. The PWM
+	  controller supports outputing 4 channels of PWM waveforms.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm_sophgo_sg2042.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..539e0def3f82 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
+obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
new file mode 100644
index 000000000000..bed753877851
--- /dev/null
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2042 PWM Controller Driver
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ *
+ * Limitations:
+ * - After reset, the output of the PWM channel is always high.
+ *   The value of HLPERIOD/PERIOD is 0.
+ * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
+ *   output waveforms with the new configuration after completing
+ *   the running period.
+ * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
+ *   be stopped and the output is pulled to high.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#include <asm/div64.h>
+
+/*
+ * Offset RegisterName
+ * 0x0000 HLPERIOD0
+ * 0x0004 PERIOD0
+ * 0x0008 HLPERIOD1
+ * 0x000C PERIOD1
+ * 0x0010 HLPERIOD2
+ * 0x0014 PERIOD2
+ * 0x0018 HLPERIOD3
+ * 0x001C PERIOD3
+ * Four groups and every group is composed of HLPERIOD & PERIOD
+ */
+#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
+#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
+
+#define SG2042_PWM_CHANNELNUM	4
+
+/**
+ * struct sg2042_pwm_ddata - private driver data
+ * @base:		base address of mapped PWM registers
+ * @clk_rate_hz:	rate of base clock in HZ
+ */
+struct sg2042_pwm_ddata {
+	void __iomem *base;
+	unsigned long clk_rate_hz;
+};
+
+static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
+{
+	writel(period, base + SG2042_PERIOD(chan));
+	writel(hlperiod, base + SG2042_HLPERIOD(chan));
+}
+
+static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	u32 hlperiod;
+	u32 period;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
+	 * Period of One Cycle (period) = PERIOD x Period_clk
+	 */
+	period = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
+	hlperiod = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
+
+	if (hlperiod > period) {
+		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply current setting\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=%u, hlperiod=%u\n",
+		pwm->hwpwm, period, hlperiod);
+
+	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
+
+	return 0;
+}
+
+static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	unsigned int chan = pwm->hwpwm;
+	u32 hlperiod;
+	u32 period;
+
+	period = readl(ddata->base + SG2042_PERIOD(chan));
+	hlperiod = readl(ddata->base + SG2042_HLPERIOD(chan));
+
+	if (!period && !hlperiod)
+		state->enabled = false;
+	else
+		state->enabled = true;
+
+	state->period = DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->clk_rate_hz);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, ddata->clk_rate_hz);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_sg2042_ops = {
+	.apply = pwm_sg2042_apply,
+	.get_state = pwm_sg2042_get_state,
+};
+
+static const struct of_device_id sg2042_pwm_ids[] = {
+	{ .compatible = "sophgo,sg2042-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
+
+static int pwm_sg2042_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sg2042_pwm_ddata *ddata;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwmchip_get_drvdata(chip);
+
+	ddata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
+
+	clk = devm_clk_get_enabled(dev, "apb");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
+
+	ddata->clk_rate_hz = clk_get_rate(clk);
+	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
+
+	chip->ops = &pwm_sg2042_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver pwm_sg2042_driver = {
+	.driver	= {
+		.name = "sg2042-pwm",
+		.of_match_table = sg2042_pwm_ids,
+	},
+	.probe = pwm_sg2042_probe,
+};
+module_platform_driver(pwm_sg2042_driver);
+
+MODULE_AUTHOR("Chen Wang");
+MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1



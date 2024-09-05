Return-Path: <linux-pwm+bounces-3098-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A164D96D7FC
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBE1F252D4
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41D19B3E2;
	Thu,  5 Sep 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqyH/42m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB038199E95;
	Thu,  5 Sep 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538252; cv=none; b=twawvUho7ycr7BZWzkQGOEG7dl27I/gsWH7cDmtqL3JIEHmhipEZNtbJJS8tUSX8m/BQEOlz3vwMs+I9E+7sqWiXO1tuxcPOBzJdUgx/1oYzO+Aa9hmcJeyeZmXMc3oncD52KKNS7pRjUVs5c5EkMSOph6W9utzAvk16tsPhmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538252; c=relaxed/simple;
	bh=9L6fhXI0mohfxy8b5hB8nXfaYXrjFTBsgDp1M5qzBGc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcBaI7ifAuEa2pixaGAJBeZhi4nthWdeYovXEDNP5ryTucBt7vSjWMJjL6eCPUA8kQlhhqXiabwQCoV0LGA1pMPyzvKNesqmkug0ZQnk8Mpr5+DJWwxaXPU0qB299NdndqzuJl0XTcKqKYzAsWxLCdD1IgN6IJZO5aM1CLtNyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqyH/42m; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f6e65d605so404438a34.3;
        Thu, 05 Sep 2024 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538250; x=1726143050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK3IHackpoEuMNjncuXg3SKL/wNGnWCmIAq0L0PIah4=;
        b=JqyH/42ml22k5/+a/fmn/gNWxYmGUP6QxY/0DlttMBvaehVrWKTm48FTxnPTE7Kmax
         3G6Ts4d0BUG2WTA3dVNclsnL9FhlWt0+uxEbn/QLWXQIDXkOuiYdBG3g9nrgHIdUtSvA
         2dA0zc62OJ/BssIw5omoxAYQsxp0OAX569WB4qLe8tW0pLaVAZy/uHpQIi3fyw9u58KF
         0BtHlrysqFIxDF9g2CD9NZdR1tsuC89L4bS2kQxSpfp5h/URo/K6/An/5iQy+E7/shlg
         az2L14x/b7ytucrj/R1G/wAy3htt4ym8Pro60YMvV74SV3tL7/Sc6UHsoS/iWfiU+ugg
         9k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538250; x=1726143050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK3IHackpoEuMNjncuXg3SKL/wNGnWCmIAq0L0PIah4=;
        b=sfUEg/lkGzmIqQyvtFvJmkGtisHYRA+/18kVHInEQY/lNalU5a0rFU7OcCmjS807IW
         JJbfjCnCouLJlRTnL/+Maf8guTuX6+3dza8DLmL+tQcqFQyI2oi8MwFlN7caYKczqxLG
         gTSjhLI8M2C7967AueJPvfXXqGHh7OpJhJ/mQ/2IxV/AH0Ryh9f92RG6hlMtenbNEp1a
         /vlFh86RNySfXvZJUMMH9xPOIKRi63V4ogVY6+LOkyZjgZudsppg+E5/+3KBoCllpZWZ
         qv4+BbcWIY6jaP99RcGG3toxTqQm8gNM9P213+5zE/mxEbBdLGT/Zths1nSHNesMiprF
         xnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI0+QdPu9LgAzYyfEWM+gHTTJbSx0Zdu7IUoAmDO5/M/ELEELEOCN3k4tKSKwyvyvDqkFR9KuN3nkE@vger.kernel.org, AJvYcCUu2qaqlDvTjufl3Qrt3DIjuP4prvgpUsrJZBXbec7WZX+lkoh05YFTz+pWwP7lDye+My9lV2co8oaHbfPn@vger.kernel.org, AJvYcCVjjm7VycDZfBKXSfLFz6PjUcmoCt8vwR1jqden0YBKajdvCqVdGKDlpS2PXbtm6oELZuKqZlR+4Uk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eUJfK6PVK+YoVdM8mYYQ1ppBB6k7DXjyhY+HEsF720Goyk6S
	KUmPWDp7JBUMT+JSa3WRgXuU9BK0rHFo3eEQwn+vAuyKYNYUb6iIm3CAGeR+
X-Google-Smtp-Source: AGHT+IHh+BOXyYZhMqca+Gp9Z6ku4LYrEw/r5Gi1ZCkkbWzyDTxWRs1YU+MyFQM7QKIs4EIKe1PY/w==
X-Received: by 2002:a05:6830:d02:b0:70f:331e:90f6 with SMTP id 46e09a7af769-70f5c466677mr33305848a34.23.1725538249874;
        Thu, 05 Sep 2024 05:10:49 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671cf763sm3248566a34.80.2024.09.05.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:10:49 -0700 (PDT)
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
Subject: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
Date: Thu,  5 Sep 2024 20:10:42 +0800
Message-Id: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725536870.git.unicorn_wang@outlook.com>
References: <cover.1725536870.git.unicorn_wang@outlook.com>
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
 drivers/pwm/Kconfig             |   9 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c | 148 ++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3e53838990f5..6287d63a84fd 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -577,6 +577,15 @@ config PWM_SL28CPLD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sl28cpld.
 
+config PWM_SOPHGO_SG2042
+	tristate "Sophgo SG2042 PWM support"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  PWM driver for Sophgo SG2042 PWM controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm_sophgo_sg2042.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0be4f3e6dd43..ef2555e83183 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
+obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
new file mode 100644
index 000000000000..cf11ad54b4de
--- /dev/null
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2042 PWM Controller Driver
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
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
+#define REG_HLPERIOD	0x0
+#define REG_PERIOD	0x4
+
+#define REG_GROUP	0x8
+
+#define SG2042_PWM_CHANNELNUM	4
+
+/**
+ * struct sg2042_pwm_chip - private data of PWM chip
+ * @base:		base address of mapped PWM registers
+ * @base_clk:		base clock used to drive the pwm controller
+ */
+struct sg2042_pwm_chip {
+	void __iomem *base;
+	struct clk *base_clk;
+};
+
+static inline
+struct sg2042_pwm_chip *to_sg2042_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static void pwm_sg2042_config(void __iomem *base, unsigned int channo, u32 period, u32 hlperiod)
+{
+	writel(period, base + REG_GROUP * channo + REG_PERIOD);
+	writel(hlperiod, base + REG_GROUP * channo + REG_HLPERIOD);
+}
+
+static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_chip *sg2042_pwm = to_sg2042_pwm_chip(chip);
+	u32 hlperiod;
+	u32 period;
+	u64 f_clk;
+	u64 p;
+
+	if (!state->enabled) {
+		pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
+	 * Period of One Cycle (period) = PERIOD x Period_clk
+	 */
+	f_clk = clk_get_rate(sg2042_pwm->base_clk);
+
+	p = f_clk * state->period;
+	do_div(p, NSEC_PER_SEC);
+	period = (u32)p;
+
+	p = f_clk * state->duty_cycle;
+	do_div(p, NSEC_PER_SEC);
+	hlperiod = (u32)p;
+
+	dev_dbg(pwmchip_parent(chip), "chan[%d]: period=%u, hlperiod=%u\n",
+		pwm->hwpwm, period, hlperiod);
+
+	pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, period, hlperiod);
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_sg2042_ops = {
+	.apply		= pwm_sg2042_apply,
+};
+
+static const struct of_device_id sg2042_pwm_match[] = {
+	{ .compatible = "sophgo,sg2042-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
+
+static int pwm_sg2042_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sg2042_pwm_chip *sg2042_pwm;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, SG2042_PWM_CHANNELNUM, sizeof(*sg2042_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sg2042_pwm = to_sg2042_pwm_chip(chip);
+
+	chip->ops = &pwm_sg2042_ops;
+
+	sg2042_pwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sg2042_pwm->base))
+		return PTR_ERR(sg2042_pwm->base);
+
+	sg2042_pwm->base_clk = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(sg2042_pwm->base_clk))
+		return dev_err_probe(dev, PTR_ERR(sg2042_pwm->base_clk),
+				     "failed to get base clk\n");
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
+
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static struct platform_driver pwm_sg2042_driver = {
+	.driver	= {
+		.name	= "sg2042-pwm",
+		.of_match_table = of_match_ptr(sg2042_pwm_match),
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



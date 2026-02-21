Return-Path: <linux-pwm+bounces-8143-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAUIC1z7mWngXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8143-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:37:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 539EF16D8A1
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5015B30CB922
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA6304BDF;
	Sat, 21 Feb 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0OxxraR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B8239E9A
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771699011; cv=none; b=ODoADI0nFKP/QJlWg8U3n+2zRohPId5/WIP2ZzOr2JbbmUEIHCEQc+kXPucJ87pklJ99h2cExdM6fAuQzk3ZlFjHsNzI4FKkhxc4zrMp4ccPuuQgvBkglrWO8Bge9lVGUCTP3SyFhdfLqWqE8lMET3m864Qj6VL/61+F9EeBbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771699011; c=relaxed/simple;
	bh=cPuwABD3BxA7XK/nQo/bSpX3OQDmvuaFsDh0+joeV2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2LVQER/3t/NPxJzhuVqkFiXsM5EZqEXp1hGxtIMw+INfWO1+jkrYGdTixZDelzPxpeaZ+K7DFimvJqwySG6Wf7b29y8oUhGbJ0dhMZNbSBGj/3cwd6W/WiTHn4mpKx8RAgpcLxkljOpBe1PO3OL36IgKMYFczzCyV2gTFrLTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0OxxraR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-386b553c70eso26565131fa.0
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771699008; x=1772303808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L52Z43AzVgP7smJzIu46FRnXF7SXcFTv57Ck1avw7s=;
        b=e0OxxraRvtJ+fVl43cpcn68ew1ab5wuOabHuKBtGqyRfg/6d1nybAwkmVsxXq6gILM
         3gracCttPvDXBVQxBvOKVvvdF4p6vmmJ2GvDbrEdRKwPeGd9+gZxSzdFLXiqlr6Pk6u9
         Ef4SZ/+ivaofKuP/pdrjCMtaLf+o/TJD+z+RMY32cirten0iZetkIHcjfQsDaa/1IAcO
         LzE7MmtLJgbMJLxIY0aHR/0ovMzSGjqNmlwifmXkXj59AlB6Zg/O/KxNQLXW4Im8vj/X
         Dze7EmGRk0qU85sA+J05ZwBfHRgRsp6d4fadvxwGlrXyqyeuy5M182cMZRXangkcamzs
         GeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771699008; x=1772303808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L52Z43AzVgP7smJzIu46FRnXF7SXcFTv57Ck1avw7s=;
        b=jy+u9asJ1JQ8h6Z6TkTDEsViNjmJTDfV7nSoAkJBm/w9AqJ8NcU16+XzSrEykyTYuD
         4W6ZAkbVL6lkNDp1Ex66uLCKnR9r0XQ+oA0BAi2VpTiLvuKFs+CUSeMV+X+rVZJE4JF3
         oGi+OqiVIrfagpJcR3nrWDz7GxzX/QuVLmSQyW1Sd5cy7FTqd0pceMxQzKnhwzQaeM9p
         BMEorOKgIII4sloAJjHOjpUUgbKNzItR7FiSCebc6h2YhBnrMgvMMVcNCDYwwquUCmv8
         6wMNQXyNWGHGGXFRijshLw1oaL6WhP4kUes7iSr3qkS6qlv4vxG49eV3kh5sXlb168lF
         Yt0w==
X-Forwarded-Encrypted: i=1; AJvYcCVPn5QDdCKwyd4VltN6IEjUWbgjv1sDMQSw/yFmdcGARSl9+SafSxr+PoBFkH62KJOztf0ZhmJmTfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeouW/C81lpJ+O9DJVuEsHsksBUXIuTvK9gvshLknJkGCCfL3
	vGvjsmDn3+2iRVhXdHWqccBEeV+r4uGhp/+tH2QvJyhoAE0FdCBJqu4=
X-Gm-Gg: AZuq6aJjNMng3Yquur+gEkvxw7v3pHMfCrlye2uAOqGjaKdozoI5v4mfHK4H/RbbmkW
	kko3QW8BIouI0n8//sJIoCLhKaeRdO/TPhwzv1W1a3QsEvyTLQyrQ+YhrEad7hchrtuOgUU8UgV
	j4FDcmgJrtA9Y8HtrUbxoSDQQMLR8Jf32QmjtZ2HWD1LQR+Dkcq15LnkdfznDgsbOxhLgjNu6HR
	h1c8jNfy9n+MKLxFHlFNfhhP/DZS6rbnChiMgiqnLUb0hfGZl+3yYqNs2/N7RCkKrPom06HUvhx
	FaBI4hBOP32ppz0EABFTv4UA3pjxYsYGiikBuIVZHTVLT3Gu4D3lqp1wM9kmxuGob5sTdUnRfKU
	AdkAYqhKLoSyvFYOwMyNx3CmKECParbFd0T4sKcNPSwIrSjfizNzkCtXvTcwNCup503mXpDZ0kI
	DSYXR6/O/GeO7yqhpdla23f8xknz1Da6wUrZLS
X-Received: by 2002:a2e:a99f:0:b0:36b:b0eb:9d64 with SMTP id 38308e7fff4ca-389a5be1c31mr11725601fa.30.1771699007817;
        Sat, 21 Feb 2026 10:36:47 -0800 (PST)
Received: from localhost.localdomain ([178.176.177.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7af19d4sm5006841fa.42.2026.02.21.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 10:36:47 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v13 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date: Sat, 21 Feb 2026 21:35:52 +0300
Message-Id: <20260221183609.95403-3-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260221183609.95403-1-privatesub2@gmail.com>
References: <20260221183609.95403-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-8143-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[privatesub2@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 539EF16D8A1
X-Rspamd-Action: no action

Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
controllers with ones supported by pwm-sun4i driver.

This patch adds a PWM controller driver for Allwinner's D1,
T113-S3 and R329 SoCs. The main difference between these SoCs
is the number of channels defined by the DT property.

Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 drivers/pwm/Kconfig     |  10 +
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-sun8i.c | 393 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun8i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..44d844eba589 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -736,6 +736,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN8I
+	tristate "Allwinner D1/T113s/R329 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun8i.
+
 config PWM_SUNPLUS
 	tristate "Sunplus PWM support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..ba2e0ec7fc17 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN8I)		+= pwm-sun8i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
new file mode 100644
index 000000000000..6e196f31314b
--- /dev/null
+++ b/drivers/pwm/pwm-sun8i.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
+ *
+ * Limitations:
+ * - When the parameters change, the current running period is not completed
+ *   and new settings are applied immediately.
+ * - The PWM output goes to a HIGH-Z state when the channel is disabled.
+ * - Changing the clock configuration (SUN8I_PWM_CLK_CFG)
+ *   may cause a brief output glitch.
+ *
+ * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define SUN8I_PWM_CLK_CFG(pair)			(0x20 + ((pair) * 0x4))
+#define SUN8I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
+#define SUN8I_PWM_CLK_SRC_HOSC			0x0
+#define SUN8I_PWM_CLK_SRC_BUS			0x1
+#define SUN8I_PWM_CLK_CFG_DIV_M			GENMASK(3, 0)
+#define SUN8I_PWM_CLK_DIV_M_MAX			8
+
+#define SUN8I_PWM_CLK_GATE			0x40
+#define SUN8I_PWM_CLK_GATE_BYPASS(chan)		BIT((chan) + 16)
+#define SUN8I_PWM_CLK_GATE_GATING(chan)		BIT(chan)
+
+#define SUN8I_PWM_ENABLE			0x80
+#define SUN8I_PWM_ENABLE_EN(chan)		BIT(chan)
+
+#define SUN8I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
+#define SUN8I_PWM_CTL_ACT_STA			BIT(8)
+#define SUN8I_PWM_CTL_PRESCAL_K			GENMASK(7, 0)
+#define SUN8I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN8I_PWM_CTL_PRESCAL_K)
+
+#define SUN8I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
+#define SUN8I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
+#define SUN8I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
+
+#define SUN8I_PWM_PCNTR_SIZE			BIT(16)
+
+/*
+ * SUN8I_PWM_MAGIC is used to quickly compute the values of the clock dividers
+ * div_m (SUN8I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN8I_PWM_CTL_PRESCAL_K)
+ * without using a loop. These dividers limit the # of cycles in a period
+ * to SUN8I_PWM_PCNTR_SIZE (65536) by applying a scaling factor of
+ * 1 / (div_m * (prescale_k + 1)) to the clock source.
+ *
+ * SUN8I_PWM_MAGIC is derived by solving for div_m and prescale_k
+ * such that for a given requested period,
+ *
+ * i) div_m is minimized for any prescale_k ≤ SUN8I_PWM_CTL_PRESCAL_K_MAX,
+ * ii) prescale_k is minimized.
+ *
+ * The derivation proceeds as follows, with val = # of cycles for requested
+ * period:
+ *
+ * for a given value of div_m we want the smallest prescale_k such that
+ *
+ * (val >> div_m) // (prescale_k + 1) ≤ 65536 (= SUN8I_PWM_PCNTR_SIZE)
+ *
+ * This is equivalent to:
+ *
+ * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
+ * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
+ * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
+ * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
+ *
+ * As prescale_k is integer, this becomes
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
+ *
+ * And is minimized at
+ *
+ * ((val >> div_m) - 65536) // 65537
+ *
+ * Now we pick the smallest div_m that satifies prescale_k ≤ 255
+ * (i.e SUN8I_PWM_CTL_PRESCAL_K_MAX),
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ 255
+ * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
+ * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
+ * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
+ * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
+ *
+ * Suggested by Uwe Kleine-König
+ */
+#define SUN8I_PWM_MAGIC				(255 * 65537 + 2 * 65536 + 1)
+#define SUN8I_PWM_DIV_CONST			65537
+
+struct sun8i_pwm_chip {
+	struct clk *clk_hosc, *clk_apb;
+	void __iomem *base;
+};
+
+static inline struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *chip,
+				   unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *chip,
+				     u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun8i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun8i_pwm_chip *sun8i_chip = to_sun8i_pwm_chip(chip);
+	u16 ent_cycle, act_cycle, prescale_k;
+	u64 clk_rate, tmp;
+	u8 div_m;
+	u32 val;
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	div_m = FIELD_GET(SUN8I_PWM_CLK_CFG_DIV_M, val);
+	if (div_m > SUN8I_PWM_CLK_DIV_M_MAX)
+		div_m = SUN8I_PWM_CLK_DIV_M_MAX;
+
+	/*
+	 * If CLK_CFG_SRC is 0, use the hosc clock;
+	 * otherwise (any nonzero value) use the APB clock.
+	 */
+	if (FIELD_GET(SUN8I_PWM_CLK_CFG_SRC, val) == 0)
+		clk_rate = clk_get_rate(sun8i_chip->clk_hosc);
+	else
+		clk_rate = clk_get_rate(sun8i_chip->clk_apb);
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CTL(pwm->hwpwm));
+	state->polarity = (SUN8I_PWM_CTL_ACT_STA & val) ?
+			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
+
+	prescale_k = FIELD_GET(SUN8I_PWM_CTL_PRESCAL_K, val) + 1;
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_ENABLE);
+	state->enabled = (SUN8I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PERIOD(pwm->hwpwm));
+	act_cycle = FIELD_GET(SUN8I_PWM_PERIOD_ACT_CYCLE, val);
+
+	ent_cycle = FIELD_GET(SUN8I_PWM_PERIOD_ENTIRE_CYCLE, val);
+
+	/*
+	 * The duration of the active phase should not be longer
+	 * than the duration of the period
+	 */
+	if (act_cycle > ent_cycle)
+		act_cycle = ent_cycle;
+
+	/*
+	 * We have act_cycle <= ent_cycle <= 0xffff, prescale_k <= 0x100,
+	 * div_m <= 8. So the multiplication fits into an u64 without
+	 * overflow.
+	 */
+	tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
+	tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
+
+	return 0;
+}
+
+static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sun8i_pwm_chip *sun8i_chip = to_sun8i_pwm_chip(chip);
+	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
+	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
+	u32 prescale_k, div_m;
+	u64 clk_src_rate;
+	u8 clk_src;
+
+	pwm_en = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_ENABLE);
+	clk_gate = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CLK_GATE);
+
+	if (!state->enabled) {
+		if (state->enabled != pwm->state.enabled) {
+			clk_gate &= ~SUN8I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+			pwm_en &= ~SUN8I_PWM_ENABLE_EN(pwm->hwpwm);
+			sun8i_pwm_writel(sun8i_chip, pwm_en, SUN8I_PWM_ENABLE);
+			sun8i_pwm_writel(sun8i_chip, clk_gate, SUN8I_PWM_CLK_GATE);
+		}
+		return 0;
+	}
+
+	ctl = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CTL(pwm->hwpwm));
+	clk_cfg = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	hosc_rate = clk_get_rate(sun8i_chip->clk_hosc);
+	bus_rate = clk_get_rate(sun8i_chip->clk_apb);
+
+	/*
+	 * Clock selection for a PWM pair:
+	 *
+	 * This PWM controller groups channels in pairs,
+	 * where CLK_SRC and DIV_M are shared between the two channels.
+	 * If the sibling channel is already enabled,
+	 * we must keep the existing clock configuration for this pair.
+	 *
+	 * If the sibling is disabled, we are free to pick a clock
+	 * for the pair. Using the faster clock source
+	 * improves the achievable maximum PWM frequency and generally
+	 * gives better duty_cycle resolution for a given period.
+	 */
+
+	if (pwm_en & SUN8I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
+		/* Use the current clock settings */
+		clk_src = FIELD_GET(SUN8I_PWM_CLK_CFG_SRC, clk_cfg);
+		clk_src_rate = clk_src == SUN8I_PWM_CLK_SRC_BUS ? bus_rate : hosc_rate;
+		val = mul_u64_u64_div_u64(state->period, clk_src_rate,
+					  NSEC_PER_SEC);
+
+		div_m = FIELD_GET(SUN8I_PWM_CLK_CFG_DIV_M, clk_cfg);
+	} else {
+		/* Use the faster clock source */
+		if (bus_rate > hosc_rate) {
+			clk_src = SUN8I_PWM_CLK_SRC_BUS;
+			clk_src_rate = bus_rate;
+		} else {
+			clk_src = SUN8I_PWM_CLK_SRC_HOSC;
+			clk_src_rate = hosc_rate;
+		}
+
+		val = mul_u64_u64_div_u64(state->period, clk_src_rate, NSEC_PER_SEC);
+		/*
+		 * If the calculated value is ≤ 1, the period is too short
+		 * for proper PWM operation
+		 */
+		if (val <= 1)
+			return -EINVAL;
+
+		div_m = fls(DIV_ROUND_DOWN_ULL(val, SUN8I_PWM_MAGIC));
+		if (div_m > SUN8I_PWM_CLK_DIV_M_MAX)
+			return -EINVAL;
+
+		/* Set up the CLK_DIV_M and clock CLK_SRC */
+		clk_cfg = FIELD_PREP(SUN8I_PWM_CLK_CFG_DIV_M, div_m);
+		clk_cfg |= FIELD_PREP(SUN8I_PWM_CLK_CFG_SRC, clk_src);
+
+		sun8i_pwm_writel(sun8i_chip, clk_cfg, SUN8I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	}
+
+	/* Calculate prescale_k and determine the number of cycles for a full PWM period */
+	ent_cycle = val >> div_m;
+	prescale_k = DIV_ROUND_DOWN_ULL(ent_cycle, SUN8I_PWM_DIV_CONST);
+	if (prescale_k > SUN8I_PWM_CTL_PRESCAL_K_MAX)
+		prescale_k = SUN8I_PWM_CTL_PRESCAL_K_MAX;
+
+	do_div(ent_cycle, prescale_k + 1);
+
+	/* ent_cycle must not be zero */
+	if (ent_cycle == 0)
+		return -EINVAL;
+
+	/* For N cycles, PPRx.PWM_ENTIRE_CYCLE = (N-1) */
+	reg_period = FIELD_PREP(SUN8I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1);
+
+	/* Calculate the active cycles (duty cycle) */
+	val = mul_u64_u64_div_u64(state->duty_cycle, clk_src_rate,
+				  NSEC_PER_SEC);
+	act_cycle = val >> div_m;
+	do_div(act_cycle, prescale_k + 1);
+
+	/*
+	 * The formula of the output period and the duty-cycle for PWM are as follows.
+	 * T period = PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CYCLE + 1)
+	 * T high-level = PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CYCLE
+	 * Duty-cycle = T high-level / T period
+	 */
+	reg_period |= FIELD_PREP(SUN8I_PWM_PERIOD_ACT_CYCLE, act_cycle);
+	sun8i_pwm_writel(sun8i_chip, reg_period, SUN8I_PWM_PERIOD(pwm->hwpwm));
+
+	ctl = FIELD_PREP(SUN8I_PWM_CTL_PRESCAL_K, prescale_k);
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		ctl |= SUN8I_PWM_CTL_ACT_STA;
+
+	sun8i_pwm_writel(sun8i_chip, ctl, SUN8I_PWM_CTL(pwm->hwpwm));
+
+	if (state->enabled != pwm->state.enabled) {
+		clk_gate &= ~SUN8I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
+		clk_gate |= SUN8I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+		pwm_en |= SUN8I_PWM_ENABLE_EN(pwm->hwpwm);
+		sun8i_pwm_writel(sun8i_chip, pwm_en, SUN8I_PWM_ENABLE);
+		sun8i_pwm_writel(sun8i_chip, clk_gate, SUN8I_PWM_CLK_GATE);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops sun8i_pwm_ops = {
+	.apply = sun8i_pwm_apply,
+	.get_state = sun8i_pwm_get_state,
+};
+
+static const struct of_device_id sun8i_pwm_dt_ids[] = {
+	{ .compatible = "allwinner,sun20i-d1-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
+
+static int sun8i_pwm_probe(struct platform_device *pdev)
+{
+	struct pwm_chip *chip;
+	struct sun8i_pwm_chip *sun8i_chip;
+	struct clk *clk_bus;
+	struct reset_control *rst;
+	u32 npwm;
+	int ret;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "allwinner,npwms", &npwm);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get allwinner,npwms\n");
+
+	if (npwm < 1 || npwm > 16)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid allwinner,npwms\n");
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun8i_chip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun8i_chip = to_sun8i_pwm_chip(chip);
+
+	sun8i_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun8i_chip->base))
+		return PTR_ERR(sun8i_chip->base);
+
+	clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
+	if (IS_ERR(clk_bus))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_bus),
+				     "Failed to get bus clock\n");
+
+	sun8i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
+	if (IS_ERR(sun8i_chip->clk_hosc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun8i_chip->clk_hosc),
+				     "Failed to get hosc clock\n");
+
+	ret = devm_clk_rate_exclusive_get(&pdev->dev, sun8i_chip->clk_hosc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get hosc exclusive rate\n");
+
+	sun8i_chip->clk_apb = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(sun8i_chip->clk_apb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun8i_chip->clk_apb),
+				     "Failed to get apb clock\n");
+
+	ret = devm_clk_rate_exclusive_get(&pdev->dev, sun8i_chip->clk_apb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get apb exclusive rate\n");
+
+	rst = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Failed to get reset control\n");
+
+	chip->ops = &sun8i_pwm_ops;
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver sun8i_pwm_driver = {
+	.driver = {
+		.name = "sun8i-pwm",
+		.of_match_table = sun8i_pwm_dt_ids,
+	},
+	.probe = sun8i_pwm_probe,
+};
+module_platform_driver(sun8i_pwm_driver);
+
+MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



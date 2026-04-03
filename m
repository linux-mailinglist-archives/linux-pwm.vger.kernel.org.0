Return-Path: <linux-pwm+bounces-8471-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N4hDxDQz2m50gYAu9opvQ
	(envelope-from <linux-pwm+bounces-8471-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:34:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84676395498
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857643051169
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD93C5529;
	Fri,  3 Apr 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BJQS5NNI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D63C4574
	for <linux-pwm@vger.kernel.org>; Fri,  3 Apr 2026 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226543; cv=none; b=GLQAgZr2DjBnXkN316zJnd2Rxnps7PMjG2wYyqrFs7JHLeBFgpJLA+HUc4BarRUK+0YchrBurzcWbCjgJkddbHthN+WCgaeoH/4Q5u20TbJnCgsVshCbyJAEEKdKE43cjatenmLkaPsSamjq+R37f5TGk2Qo+OFT9jMRdyy7eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226543; c=relaxed/simple;
	bh=Qj5E6yHNU8WD4PtmottpXplcpdDze6L6RS98ls6dgwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWib5VmX9dahdLe0dnqIU/FaRjBXA7ojm5raUUKUQhJbD+gk0yDBXXIAfp24sueOFm28Av3KIR4HNqKNq63BXmi+X6vF6VTUc3vqyJ5t/1MDrNUL/FctAyfcX2j1KDGVv/OIf9555skQHVklWHvWPqCHTAusKeZVWQzcs/5yWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BJQS5NNI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so17964845e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2026 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775226540; x=1775831340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhZwuIVjB4J+X/P3h/NptU2O5Fjzj5PnlbmODE1JC1Q=;
        b=BJQS5NNIjgWkIh4YcaXnn+4fwhcTsRycIslUUT9JoqegLgBOHRVsqypZ4ADeya2Rah
         VT42QQQfZvD68GK3uKm4unk72iza6iafWoO923vOVdYjuFNDhOv9k2amTJaj2PUEG1lc
         i3MZLfCSdaW/xJO7RJJB/122yEerTIWuZUAyYE46Hk+RdYlDIMynTM1yWSvnSQCsD15c
         BFBwb3qwkbpZ6WYz3O8aQL0/O5poqtWkV7HUb0fktdYa+jZ32rjAKwtLkeZmQ0vpINCm
         rtesO8RVNlPNegKIUxV/UAgmhryIzKNjqdkR18mBUjxHQbs05yQsXjLLQe9z68hSWbqB
         3aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226540; x=1775831340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhZwuIVjB4J+X/P3h/NptU2O5Fjzj5PnlbmODE1JC1Q=;
        b=WbRK4Ffx3Akg9KiPbegrPIFywYJAgrOHGvQ+hV69WZ4HGpJ8tl/WluVA9bImZF6KXC
         X8rlxknSLE9DEWWuy11f7qFCX8DLW6tRM3NViaqHmGru03MprhaQIR+JvqhslibvGGHm
         gW3Y2TP8emV9o7ohLJmXM+nrGxbKMf4tWgcTh41kjA95nywvQ/0X7yI00JSimKADuAgE
         xpj7EWEu0FAFokXxtbyGI7T2prYWRjAW/nVQPlIY+fKPGJ2h3Kto7wnsKeYWBXPvr2K9
         7kculyHXg6YNK2aoDwQVnatmqFv2k6SNxToTfK7IzJRl4mgvSB/CAVQob3tggF1MY7ZT
         rjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQtS1uXpcv/6nV8OTdLJIlpdPy2Yc0/R8bjxWcq2RsUNQNeMZKrmvs744XbrO/sTLVCvJfPM+gE1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+h2riHen5dkNa5ZXrDsI2EgAa+Hbupw8BtZ6g0zCczMSUpe4N
	sNtfNiWBego9oynte17OwpBPRBh1cO1S/J+uRN414rB/sUhGPpiykvhyhE5OoyR+2f8=
X-Gm-Gg: ATEYQzybntaM4qnuLR/scZyT5GgnotAjMb22uaePgZJZagyKhU2KMeeg4PHWfwAjlt1
	5pw4Ca+gM2KJy1BayREqK0zwmI7X59/mHTlX/TODqydkPjN7IMqnWWmRSNtR+bvqAqHQi6/ghZX
	51DQ2SmWG0X9s4GEOZUsWpxvWy1/LnJyHLpOf7sTMUfdNwCfztetWfM2WN/ktKCatMZtUFfefuL
	zl6MDqwbg310cpBppgY4XcvoVD5AgFK7EC6KtpuZ562sgEimWCppbSCqbnGZ7cxegPQw1iONcJe
	EOLzknxCk2lWdzlz135Lvse24oo7UdjxXbMCX8mM+m/9tx0J1/+7O2rFeaI34rLEuq77sv8b00T
	5wf7kDe1/T74An7QBLG6SERYlp/gtu4Mt4GbWKMTEdN1rPTLhbNst2A7FXNhvIA3SknqqHS9fmX
	7ruxTdN+QCp65r6k7HyH0GIcViiDA1rwArEc9VsA1AqsQZLJVHAWM8qbUPdOyzTcgcmFek2X+nv
	jwZQ4M=
X-Received: by 2002:a05:600c:4e86:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488997c9b69mr47679745e9.29.1775226539544;
        Fri, 03 Apr 2026 07:28:59 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm141359835e9.5.2026.04.03.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:28:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
Date: Fri,  3 Apr 2026 16:31:55 +0200
Message-ID: <28e29fbfc20c0b8a115d006233c2759d8f49e639.1775223441.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775223441.git.andrea.porta@suse.com>
References: <cover.1775223441.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8471-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid,thomasmore.be:email,suse.de:email]
X-Rspamd-Queue-Id: 84676395498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naushir Patuck <naush@raspberrypi.com>

The Raspberry Pi RP1 southbridge features an embedded PWM
controller with 4 output channels, alongside an RPM interface
to read the fan speed on the Raspberry Pi 5.

Add the supporting driver.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pwm/Kconfig   |  10 ++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-rp1.c | 244 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/pwm/pwm-rp1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376a..22e4fc6385da2 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -625,6 +625,16 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RP1
+	tristate "RP1 PWM support"
+	depends on MISC_RP1 || COMPILE_TEST
+	depends on HWMON
+	help
+	  PWM framework driver for Raspberry Pi RP1 controller
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rp1.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025d..895a7c42fe9c0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RP1)		+= pwm-rp1.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
new file mode 100644
index 0000000000000..0a1c1c1dd27e9
--- /dev/null
+++ b/drivers/pwm/pwm-rp1.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pwm-rp1.c
+ *
+ * Raspberry Pi RP1 PWM.
+ *
+ * Copyright © 2026 Raspberry Pi Ltd.
+ *
+ * Author: Naushir Patuck (naush@raspberrypi.com)
+ *
+ * Based on the pwm-bcm2835 driver by:
+ * Bart Tanghe <bart.tanghe@thomasmore.be>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define PWM_GLOBAL_CTRL		0x000
+#define PWM_CHANNEL_CTRL(x)	(0x014 + ((x) * 0x10))
+#define PWM_RANGE(x)		(0x018 + ((x) * 0x10))
+#define PWM_PHASE(x)		(0x01C + ((x) * 0x10))
+#define PWM_DUTY(x)		(0x020 + ((x) * 0x10))
+
+/* 8:FIFO_POP_MASK + 0:Trailing edge M/S modulation */
+#define PWM_CHANNEL_DEFAULT	(BIT(8) + BIT(0))
+#define PWM_CHANNEL_ENABLE(x)	BIT(x)
+#define PWM_POLARITY		BIT(3)
+#define SET_UPDATE		BIT(31)
+#define PWM_MODE_MASK		GENMASK(1, 0)
+
+#define NUM_PWMS		4
+
+struct rp1_pwm {
+	void __iomem	*base;
+	struct clk	*clk;
+};
+
+static const struct hwmon_channel_info * const rp1_fan_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	NULL
+};
+
+static umode_t rp1_fan_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	umode_t mode = 0;
+
+	if (type == hwmon_fan && attr == hwmon_fan_input)
+		mode = 0444;
+
+	return mode;
+}
+
+static int rp1_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
+
+	if (type != hwmon_fan || attr != hwmon_fan_input)
+		return -EOPNOTSUPP;
+
+	*val = readl(rp1->base + PWM_PHASE(2));
+
+	return 0;
+}
+
+static const struct hwmon_ops rp1_fan_hwmon_ops = {
+	.is_visible = rp1_fan_hwmon_is_visible,
+	.read = rp1_fan_hwmon_read,
+};
+
+static const struct hwmon_chip_info rp1_fan_hwmon_chip_info = {
+	.ops = &rp1_fan_hwmon_ops,
+	.info = rp1_fan_hwmon_info,
+};
+
+static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	u32 value;
+
+	value = readl(rp1->base + PWM_GLOBAL_CTRL);
+	value |= SET_UPDATE;
+	writel(value, rp1->base + PWM_GLOBAL_CTRL);
+}
+
+static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+
+	writel(PWM_CHANNEL_DEFAULT, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
+	return 0;
+}
+
+static void rp1_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	u32 value;
+
+	value = readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
+	value &= ~PWM_MODE_MASK;
+	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
+
+	rp1_pwm_apply_config(chip, pwm);
+}
+
+static int rp1_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	unsigned long clk_rate = clk_get_rate(rp1->clk);
+	unsigned long clk_period;
+	u32 value;
+
+	if (!clk_rate) {
+		dev_err(&chip->dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	/* set period and duty cycle */
+	clk_period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, clk_rate);
+
+	writel(DIV_ROUND_CLOSEST(state->duty_cycle, clk_period),
+	       rp1->base + PWM_DUTY(pwm->hwpwm));
+
+	writel(DIV_ROUND_CLOSEST(state->period, clk_period),
+	       rp1->base + PWM_RANGE(pwm->hwpwm));
+
+	/* set polarity */
+	value = readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		value &= ~PWM_POLARITY;
+	else
+		value |= PWM_POLARITY;
+	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
+
+	/* enable/disable */
+	value = readl(rp1->base + PWM_GLOBAL_CTRL);
+	if (state->enabled)
+		value |= PWM_CHANNEL_ENABLE(pwm->hwpwm);
+	else
+		value &= ~PWM_CHANNEL_ENABLE(pwm->hwpwm);
+	writel(value, rp1->base + PWM_GLOBAL_CTRL);
+
+	rp1_pwm_apply_config(chip, pwm);
+
+	return 0;
+}
+
+static const struct pwm_ops rp1_pwm_ops = {
+	.request = rp1_pwm_request,
+	.free = rp1_pwm_free,
+	.apply = rp1_pwm_apply,
+};
+
+static int rp1_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
+	struct pwm_chip *chip;
+	struct rp1_pwm *rp1;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, NUM_PWMS, sizeof(*rp1));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	rp1 = pwmchip_get_drvdata(chip);
+
+	rp1->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rp1->base))
+		return PTR_ERR(rp1->base);
+
+	rp1->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(rp1->clk))
+		return dev_err_probe(dev, PTR_ERR(rp1->clk), "clock not found\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, rp1->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "fail to get exclusive rate\n");
+
+	chip->ops = &rp1_pwm_ops;
+
+	platform_set_drvdata(pdev, chip);
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "rp1_fan_tach", rp1,
+							 &rp1_fan_hwmon_chip_info,
+							 NULL);
+
+	if (IS_ERR(hwmon_dev))
+		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
+				     "failed to register hwmon fan device\n");
+
+	return 0;
+}
+
+static int rp1_pwm_suspend(struct device *dev)
+{
+	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rp1->clk);
+
+	return 0;
+}
+
+static int rp1_pwm_resume(struct device *dev)
+{
+	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(rp1->clk);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rp1_pwm_pm_ops, rp1_pwm_suspend, rp1_pwm_resume);
+
+static const struct of_device_id rp1_pwm_of_match[] = {
+	{ .compatible = "raspberrypi,rp1-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rp1_pwm_of_match);
+
+static struct platform_driver rp1_pwm_driver = {
+	.probe = rp1_pwm_probe,
+	.driver = {
+		.name = "rp1-pwm",
+		.of_match_table = rp1_pwm_of_match,
+		.pm = pm_ptr(&rp1_pwm_pm_ops),
+	},
+};
+module_platform_driver(rp1_pwm_driver);
+
+MODULE_DESCRIPTION("RP1 PWM driver");
+MODULE_AUTHOR("Naushir Patuck <naush@raspberrypi.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.3



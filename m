Return-Path: <linux-pwm+bounces-8548-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEOcGD0E2WnolAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8548-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C773D8776
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1BE33047BFD
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A03CCA1C;
	Fri, 10 Apr 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C0pZfns8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79D3CD8B5
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830029; cv=none; b=I66FZIHGdKCVzo5gwuBbiuMAXklhuwPYIs4h/MsEfaLYSvR4HPKDEu1rYuoa4E+JBCqEra0/MaakoyQafOtGH9MN0CL2geyA1B7hKIhJc+RTQ5ZrIU1y2+0wqgBnGCJjekGxAqdLLuFT0EB5G6LSTrp7aAKLcGJxpnLhnUVR4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830029; c=relaxed/simple;
	bh=jfTieWK0v3wB1u8q3YW98anrGlNYzfKbPTAkMW7RJG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv0XxqCIWofYiQIEZdVYBQswVyzcg0PoJoKcGfL61efjYkdMvwopN1+q5KC9PqK12zfB2/Vj7MVfgRd5qASfVFlu16jAKAsNYYlcK7uqr5ikdC/ivagUaFZOyFYvrMSXkdc7z7NjEwpkVkWzlJPxwzbhlRxCxcmlzym/HMtBF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C0pZfns8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso32947065e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775830025; x=1776434825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFH9HkuqRORBaQ1DhfyanXw+/L8CLUaspI4xBL/ZFQc=;
        b=C0pZfns8WsfgNKKUXXTsZSgKv8aDFe1jkJ+twDWMFl3Ay5flYiFltdDT+Ki42J6ee0
         osj8G15CMpB8vQlUFcaDTCQmG2VdfXZ6JNAupsQe1lD+QhVprYAyKbI5EHEI+jzqGaaU
         TCe6Y01q4/MNKkyDk1xsMUv2q65SlV8/axzeyOVTVti1lJL///gYMJDygn0otMjOWyDN
         +juAL295lBFoFGJ6xGnwfIidvau3lCEztWoK/GdVs3kcW/0myN7d+Bl2nFCW7AeKAIpO
         huax9GNnTDmOQMDdL4tNDR5KMDamwyByhp2cIPHIAqw5hllfZBuxUZH2h+OkJcz3/kNF
         DQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830025; x=1776434825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFH9HkuqRORBaQ1DhfyanXw+/L8CLUaspI4xBL/ZFQc=;
        b=cW/lwvTE5CnA2e+WJLNLDRvXPyEePqT9JB+lhnML1jGHSFxJrBWcztkd+wI3X5SmzM
         +UklAqvwa5IIRxbHERJyYsUlH+BjQNKTragjfDLQ7ViAHd3pbry9u9lEn5eQsqcXmCnz
         USAoAyiLzeg2tyYhQBpmmP8HsEhcd2K4mkCM/q84G8l9zcVH/ufVgonCwOM+Rz5kz6/e
         HMtlgAFLmatOQ2sg0fMXR6C2rv7TpzT+WbzsvHRXANXtrt+GV0Fc5lN7BzLXyMVZ19O8
         x0HMHLMFl3dp+9E7WIfdyxhCyJsLo0yxlsonc15OjDiiELRnINM+2WuFBDGPwjq6HDJF
         jqJw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Vt94m4CjM6MUGedA35sgxt8w3lgPBHs0x+9eAk77wbcQ7cnDvN8z1MPc3TByKEnwSD9ltDzoDPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3MeuHgZKqGLKIA0y7Mf4gUg8VvMdDjNmOVvLnwJm1vx2M8cg
	z3wf0RK4rBfOLbI8FRQCc1XUgaBLFeuGX7q844y2PK4T/MztLnaw7NtWcV0ayRnI94I=
X-Gm-Gg: AeBDieu0KFBhmFeQEQg8JTPLzxw3Il0Hf+76AQtZwGvOGoTS9/16mj9cGdmHan6747y
	BblxxBE2o7dj5o38Ps6WyyRmzu7oCcB81witN13XRDWCjXeyyz6cOR8jcrWchJ5H+rGJ2oaCYi9
	A1vOKRaEbVocPcuvPQBNPuNEaMf6Lmc7SfPWFL+EgD3j6OKtkbbBsPn9qpxtcV06P2pUVHaf0aS
	mtl4pXyQsn12VAXlWyfG6fPRMrG1GvBfEJ8fUdBR0LulDH/ZT/H0rpPlEOxSTf0ZgS+l0hsXAin
	1+IAeI1Nw3Kc59Z0nKif/M5tfsUDLkPR3JcqU6+xpIy8Xq0FfhNCXp2vo43QZgiIgfmbJ3RFZPi
	uHXQ02QsWtOUOg7/lSdbWdQNX/DXmkEn5OnXgC5wYAa51j4qIsCpPdy+awrvJJdn0wRNSor032/
	4APKVn6cuNRGYij/qCB4viCNABSa9C6dbBgKMQ0nulHGIxDMlQyg==
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488d68820abmr45138605e9.27.1775830025295;
        Fri, 10 Apr 2026 07:07:05 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5344e28sm81284895e9.7.2026.04.10.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:07:04 -0700 (PDT)
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
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com
Subject: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
Date: Fri, 10 Apr 2026 16:09:58 +0200
Message-ID: <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775829499.git.andrea.porta@suse.com>
References: <cover.1775829499.git.andrea.porta@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8548-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C6C773D8776
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
 drivers/pwm/Kconfig   |   9 ++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-rp1.c | 344 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/pwm/pwm-rp1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376a..32031f2af75af 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -625,6 +625,15 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RASPBERRYPI_RP1
+	bool "RP1 PWM support"
+	depends on MISC_RP1 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	select MFD_SYSCON
+	help
+	  PWM framework driver for Raspberry Pi RP1 controller.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025d..59f29f60f9123 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+= pwm-rp1.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
new file mode 100644
index 0000000000000..b88c697d9567e
--- /dev/null
+++ b/drivers/pwm/pwm-rp1.c
@@ -0,0 +1,344 @@
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
+ *
+ * Datasheet: https://pip-assets.raspberrypi.com/categories/892-raspberry-pi-5/documents/RP-008370-DS-1-rp1-peripherals.pdf?disposition=inline
+ *
+ * Limitations:
+ * - Channels can be enabled/disabled and their duty cycle and period can
+ *   be updated glitchlessly. Update are synchronized with the next strobe
+ *   at the end of the current period of the respective channel, once the
+ *   update bit is set. The update flag is global, not per-channel.
+ * - Channels are phase-capable, but on RPi5, the firmware can use a channel
+ *   phase register to report the RPM of the fan connected to that PWM
+ *   channel. As a result, phase control will be ignored for now.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define RP1_PWM_GLOBAL_CTRL	0x000
+#define RP1_PWM_CHANNEL_CTRL(x)	(0x014 + ((x) * 0x10))
+#define RP1_PWM_RANGE(x)	(0x018 + ((x) * 0x10))
+#define RP1_PWM_PHASE(x)	(0x01C + ((x) * 0x10))
+#define RP1_PWM_DUTY(x)		(0x020 + ((x) * 0x10))
+
+/* 8:FIFO_POP_MASK + 0:Trailing edge M/S modulation */
+#define RP1_PWM_CHANNEL_DEFAULT		(BIT(8) + BIT(0))
+#define RP1_PWM_CHANNEL_ENABLE(x)	BIT(x)
+#define RP1_PWM_POLARITY		BIT(3)
+#define RP1_PWM_SET_UPDATE		BIT(31)
+#define RP1_PWM_MODE_MASK		GENMASK(1, 0)
+
+#define RP1_PWM_NUM_PWMS	4
+
+struct rp1_pwm {
+	struct regmap	*regmap;
+	struct clk	*clk;
+	unsigned long	clk_rate;
+	bool		clk_enabled;
+};
+
+struct rp1_pwm_waveform {
+	u32	period_ticks;
+	u32	duty_ticks;
+	bool	enabled;
+	bool	inverted_polarity;
+};
+
+static const struct regmap_config rp1_pwm_regmap_config = {
+	.reg_bits    = 32,
+	.val_bits    = 32,
+	.reg_stride  = 4,
+	.max_register = 0x60,
+};
+
+static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	u32 value;
+
+	/* update the changed registers on the next strobe to avoid glitches */
+	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
+	value |= RP1_PWM_SET_UPDATE;
+	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);
+}
+
+static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+
+	/* init channel to reset defaults */
+	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), RP1_PWM_CHANNEL_DEFAULT);
+	return 0;
+}
+
+static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
+				       struct pwm_device *pwm,
+				       const struct pwm_waveform *wf,
+				       void *_wfhw)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	struct rp1_pwm_waveform *wfhw = _wfhw;
+	u64 clk_rate = rp1->clk_rate;
+	u64 ticks;
+
+	ticks = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
+
+	if (ticks > U32_MAX)
+		ticks = U32_MAX;
+	wfhw->period_ticks = ticks;
+
+	if (wf->duty_offset_ns + wf->duty_length_ns >= wf->period_length_ns) {
+		ticks = mul_u64_u64_div_u64(wf->period_length_ns - wf->duty_length_ns,
+					    clk_rate, NSEC_PER_SEC);
+		wfhw->inverted_polarity = true;
+	} else {
+		ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
+		wfhw->inverted_polarity = false;
+	}
+
+	if (ticks > wfhw->period_ticks)
+		ticks = wfhw->period_ticks;
+	wfhw->duty_ticks = ticks;
+
+	wfhw->enabled = !!wfhw->duty_ticks;
+
+	return 0;
+}
+
+static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const void *_wfhw,
+					 struct pwm_waveform *wf)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	const struct rp1_pwm_waveform *wfhw = _wfhw;
+	u64 clk_rate = rp1->clk_rate;
+	u32 ticks;
+
+	memset(wf, 0, sizeof(*wf));
+
+	if (!wfhw->enabled)
+		return 0;
+
+	wf->period_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->period_ticks * NSEC_PER_SEC, clk_rate);
+
+	if (wfhw->inverted_polarity) {
+		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
+						      clk_rate);
+	} else {
+		wf->duty_offset_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
+						      clk_rate);
+		ticks = wfhw->period_ticks - wfhw->duty_ticks;
+		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)ticks * NSEC_PER_SEC, clk_rate);
+	}
+
+	return 0;
+}
+
+static int rp1_pwm_write_waveform(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  const void *_wfhw)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	const struct rp1_pwm_waveform *wfhw = _wfhw;
+	u32 value;
+
+	/* set period and duty cycle */
+	regmap_write(rp1->regmap,
+		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
+	regmap_write(rp1->regmap,
+		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
+
+	/* set polarity */
+	regmap_read(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), &value);
+	if (!wfhw->inverted_polarity)
+		value &= ~RP1_PWM_POLARITY;
+	else
+		value |= RP1_PWM_POLARITY;
+	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), value);
+
+	/* enable/disable */
+	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
+	if (wfhw->enabled)
+		value |= RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
+	else
+		value &= ~RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
+	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);
+
+	rp1_pwm_apply_config(chip, pwm);
+
+	return 0;
+}
+
+static int rp1_pwm_read_waveform(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 void *_wfhw)
+{
+	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
+	struct rp1_pwm_waveform *wfhw = _wfhw;
+	u32 value;
+
+	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
+	wfhw->enabled = !!(value & RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm));
+
+	regmap_read(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), &value);
+	wfhw->inverted_polarity = !!(value & RP1_PWM_POLARITY);
+
+	if (wfhw->enabled) {
+		regmap_read(rp1->regmap, RP1_PWM_RANGE(pwm->hwpwm), &wfhw->period_ticks);
+		regmap_read(rp1->regmap, RP1_PWM_DUTY(pwm->hwpwm), &wfhw->duty_ticks);
+	} else {
+		wfhw->period_ticks = 0;
+		wfhw->duty_ticks = 0;
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops rp1_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct rp1_pwm_waveform),
+	.request = rp1_pwm_request,
+	.round_waveform_tohw = rp1_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = rp1_pwm_round_waveform_fromhw,
+	.read_waveform = rp1_pwm_read_waveform,
+	.write_waveform = rp1_pwm_write_waveform,
+};
+
+static int rp1_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	unsigned long clk_rate;
+	struct pwm_chip *chip;
+	void __iomem	*base;
+	struct rp1_pwm *rp1;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	rp1 = pwmchip_get_drvdata(chip);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rp1->regmap = devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config);
+	if (IS_ERR(rp1->regmap))
+		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize regmap\n");
+
+	ret = of_syscon_register_regmap(np, rp1->regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register syscon\n");
+
+	rp1->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(rp1->clk))
+		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
+
+	ret = clk_prepare_enable(rp1->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock\n");
+	rp1->clk_enabled = true;
+
+	ret = devm_clk_rate_exclusive_get(dev, rp1->clk);
+	if (ret) {
+		dev_err_probe(dev, ret, "Fail to get exclusive rate\n");
+		goto err_disable_clk;
+	}
+
+	clk_rate = clk_get_rate(rp1->clk);
+	if (!clk_rate) {
+		ret = dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
+		goto err_disable_clk;
+	}
+	rp1->clk_rate = clk_rate;
+
+	chip->ops = &rp1_pwm_ops;
+
+	platform_set_drvdata(pdev, chip);
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to register PWM chip\n");
+		goto err_disable_clk;
+	}
+
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(rp1->clk);
+
+	return ret;
+}
+
+static int rp1_pwm_suspend(struct device *dev)
+{
+	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
+
+	if (rp1->clk_enabled) {
+		clk_disable_unprepare(rp1->clk);
+		rp1->clk_enabled = false;
+	}
+
+	return 0;
+}
+
+static int rp1_pwm_resume(struct device *dev)
+{
+	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(rp1->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock on resume: %d\n", ret);
+		return ret;
+	}
+
+	rp1->clk_enabled = true;
+
+	return 0;
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
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(rp1_pwm_driver);
+
+MODULE_DESCRIPTION("RP1 PWM driver");
+MODULE_AUTHOR("Naushir Patuck <naush@raspberrypi.com>");
+MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.3



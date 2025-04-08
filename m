Return-Path: <linux-pwm+bounces-5382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D82A808A7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0568C25BD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C8270EBB;
	Tue,  8 Apr 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Bs680thB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649F26FDBF;
	Tue,  8 Apr 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115678; cv=pass; b=qQiDE+3HSAbnCgOJUcd3Tia6InK4+HR91HChnvINBnyv+vjgx4KGdGetcXT5Lw33RiEek/6cIAOy2VFrDubJqI3F6Zs5csP+T0I4PIr+ayhgxpYhfXEwHTkGJLDWYq0V260UnKv4jPfxZlGTP3ZucRnFjJ8e6Sj+wTP3eQxtDQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115678; c=relaxed/simple;
	bh=8arC02Zg3aiuvhHloYcAXMYwMEfT1l734zclkX4UqJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6tlNUZBlWNvX7XuFJpqtlgfHLu5MhgUN6O89mdd2Y49nwFS/4UwjRJ5Iyz+9+nM2NHl1sI6Hv9d297bpBmxVgh1O+74mapoFHP1s877iyOObUe3Ppac453S6WXLiAKYN8dHqVkEJb5nMAOl8a9U5u1W774FloQoDSY7V8885TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Bs680thB; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115644; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PY6jqx5U52ScXIsY3auaVyv+7BWtneLk+q+9GKPWY6BEnRgBNgaHZmKD46rtpH4MLuSKKiYrOMua7mVDBg8Gft13CY6D5sULB1TBSTJDy23EH1brAO5+Hd8P7EryRrJiUNBiRUFbUKSzhe8dTNeztX77V3HbQ/9kYEFFCbi09dM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115644; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IrAxZJsnxWxfAC9Jv06K5PYc5+7SUvrOzwTo3QstjzU=; 
	b=nzVQX0p72ZUzHw2X4OJ/Fncx8XXDkV6WJb8VKjrH77GYNrqVUisSuuuR8H6PhjUPOpKjXeqXsce2lBVXYZPpOnE+7EDMyO7S5xVv6wy1LhH8NmmwsKmk4jDUv8QaF6rnJjMjgWtTzH1JSX39SyKOM/WhU8A/3taFjj7jfh3e3NI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115643;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=IrAxZJsnxWxfAC9Jv06K5PYc5+7SUvrOzwTo3QstjzU=;
	b=Bs680thBXUWdArgr3e/KhpgbwenfAAS1hWynNwYix7L9P4znPoPxyx/XRNCQace3
	11zdxpImK9xlqRWM8fBMQiGS/E5GOimzTpBg17unVyKkN4TmCrrM0iAGyfD4F/UNnrC
	pPeW66Um1egfgNGg4jTeLWP5xvzK5ov8fkyS6J8c=
Received: by mx.zohomail.com with SMTPS id 1744115643038191.0894648996681;
	Tue, 8 Apr 2025 05:34:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 14:32:17 +0200
Subject: [PATCH 5/7] pwm: Add rockchip PWMv4 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-rk3576-pwm-v1-5-a49286c2ca8e@collabora.com>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
In-Reply-To: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Rockchip RK3576 brings with it a new PWM IP, in downstream code
referred to as "v4". This new IP is different enough from the previous
Rockchip IP that I felt it necessary to add a new driver for it, instead
of shoehorning it in the old one.

Add this new driver, based on the PWM core's waveform APIs. Its platform
device is registered by the parent mfpwm driver, from which it also
receives a little platform data struct, so that mfpwm can guarantee that
all the platform device drivers spread across different subsystems for
this specific hardware IP do not interfere with each other.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS                   |   1 +
 drivers/pwm/Kconfig           |  13 ++
 drivers/pwm/Makefile          |   1 +
 drivers/pwm/pwm-rockchip-v4.c | 336 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 351 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6a9347be1e7889089e1d9e655cb23c2d8399b40..3ddd245fd4ad8d9ed2e762910a7a1f6436f93e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20891,6 +20891,7 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/pwm/pwm-rockchip-v4.c
 F:	drivers/soc/rockchip/mfpwm.c
 F:	include/soc/rockchip/mfpwm.h
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7edcc61138e4a5bf7e98906953ece4..242039f62ab091cea337bf27ef310bcf696b6ed0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -540,6 +540,19 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_ROCKCHIP_V4
+	tristate "Rockchip PWM v4 support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on ROCKCHIP_MFPWM
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWM controller found on
+	  later Rockchip SoCs such as the RK3576.
+
+	  Uses the Rockchip Multi-function PWM controller driver infrastructure
+	  to guarantee fearlessly concurrent operation with other functions of
+	  the same device implemented by drivers in other subsystems.
+
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
 	depends on RZ_MTU3
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 539e0def3f82fcb866ab83a0346a15f7efdd7127..b5aca7ff58ac83f844581df526624617025291de 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_ROCKCHIP_V4)	+= pwm-rockchip-v4.o
 obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
new file mode 100644
index 0000000000000000000000000000000000000000..980b27454ef9b930bef0496ca528533cf419fa0e
--- /dev/null
+++ b/drivers/pwm/pwm-rockchip-v4.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *
+ * A Pulse-Width-Modulation (PWM) generator driver for the generators found in
+ * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". Uses
+ * the MFPWM infrastructure to guarantee exclusive use over the device without
+ * other functions of the device from different drivers interfering with its
+ * operation while it's active.
+ *
+ * Authors:
+ *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <soc/rockchip/mfpwm.h>
+
+struct rockchip_pwm_v4 {
+	struct rockchip_mfpwm_func *pwmf;
+	struct pwm_chip chip;
+};
+
+struct rockchip_pwm_v4_wf {
+	u32 period;
+	u32 duty;
+	u32 offset;
+	u8 enable;
+};
+
+static inline struct rockchip_pwm_v4 *to_rockchip_pwm_v4(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+/**
+ * rockchip_pwm_v4_round_single - convert a PWM parameter to hardware
+ * @rate: clock rate of the PWM clock, as per clk_get_rate
+ * @in_val: parameter in nanoseconds to convert
+ * @out_val: pointer to location where converted result should be stored.
+ *
+ * If @out_val is %NULL, no calculation is performed.
+ *
+ * Return:
+ * * %0          - Success
+ * * %-EOVERFLOW - Result too large for target type
+ */
+static int rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val,
+					u32 *out_val)
+{
+	u64 tmp;
+
+	if (!out_val)
+		return 0;
+
+	tmp = mult_frac(rate, in_val, NSEC_PER_SEC);
+	if (tmp > U32_MAX)
+		return -EOVERFLOW;
+
+	*out_val = tmp;
+
+	return 0;
+}
+
+/**
+ * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
+ * @rate: PWM clock rate to do the calculations at
+ * @duty: PWM duty cycle in nanoseconds
+ * @period: PWM period in nanoseconds
+ * @offset: PWM offset in nanoseconds
+ * @out_duty: pointer to where the rounded duty value should be stored
+ *            if NULL, don't calculate or store it
+ * @out_period: pointer to where the rounded period value should be stored
+ *              if NULL, don't calculate or store it
+ * @out_offset: pointer to where the rounded offset value should be stored
+ *              if NULL, don't calculate or store it
+ *
+ * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
+ * native rounded representation in number of cycles at clock rate @rate. If an
+ * out_ parameter is a NULL pointer, the corresponding parameter will not be
+ * calculated or stored. Should an overflow error occur for any of the
+ * parameters, assume the data at all the out_ locations is invalid and may not
+ * even have been touched at all.
+ *
+ * Return:
+ * * %0          - Success
+ * * %-EOVERFLOW - One of the results is too large for the PWM hardware
+ */
+static int rockchip_pwm_v4_round_params(unsigned long rate, u64 duty,
+					u64 period, u64 offset, u32 *out_duty,
+					u32 *out_period, u32 *out_offset)
+{
+	int ret;
+
+	ret = rockchip_pwm_v4_round_single(rate, duty, out_duty);
+	if (ret)
+		return ret;
+
+	ret = rockchip_pwm_v4_round_single(rate, period, out_period);
+	if (ret)
+		return ret;
+
+	ret = rockchip_pwm_v4_round_single(rate, offset, out_offset);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_pwm_v4_round_wf_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
+{
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+	struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	unsigned long rate;
+	int ret = 0;
+
+	/* We do not want chosen_clk to change out from under us here */
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	rate = mfpwm_clk_get_rate(pc->pwmf->parent);
+
+	ret = rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
+					   wf->period_length_ns,
+					   wf->duty_offset_ns, &wfhw->duty,
+					   &wfhw->period, &wfhw->offset);
+
+	if (wf->period_length_ns > 0)
+		wfhw->enable = PWMV4_EN_BOTH_MASK;
+	else
+		wfhw->enable = 0;
+
+	dev_dbg(&chip->dev, "tohw: duty = %u, period = %u, offset = %u, rate %lu\n",
+		wfhw->duty, wfhw->period, wfhw->offset, rate);
+
+	mfpwm_release(pc->pwmf);
+	return ret;
+}
+
+static int rockchip_pwm_v4_round_wf_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	unsigned long rate;
+	int ret = 0;
+
+	/* We do not want chosen_clk to change out from under us here */
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	rate = mfpwm_clk_get_rate(pc->pwmf->parent);
+
+	/* Let's avoid a cool division-by-zero if the clock's busted. */
+	if (!rate) {
+		ret = -EINVAL;
+		goto out_mfpwm_release;
+	}
+
+	wf->duty_length_ns = mult_frac(wfhw->duty, NSEC_PER_SEC, rate);
+
+	if (pwmv4_is_enabled(wfhw->enable))
+		wf->period_length_ns = mult_frac(wfhw->period, NSEC_PER_SEC,
+						 rate);
+	else
+		wf->period_length_ns = 0;
+
+	wf->duty_offset_ns = mult_frac(wfhw->offset, NSEC_PER_SEC, rate);
+
+	dev_dbg(&chip->dev, "fromhw: duty = %llu, period = %llu, offset = %llu\n",
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
+out_mfpwm_release:
+	mfpwm_release(pc->pwmf);
+	return ret;
+}
+
+static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+	struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	int ret = 0;
+
+
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	wfhw->period = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
+	wfhw->duty = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
+	wfhw->offset = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
+	wfhw->enable = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE) & PWMV4_EN_BOTH_MASK;
+
+	mfpwm_release(pc->pwmf);
+
+	return 0;
+}
+
+static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct pwm_device *pwm,
+				    const void *_wfhw)
+{
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	bool was_enabled = false;
+	int ret = 0;
+
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	was_enabled = pwmv4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
+						      PWMV4_REG_ENABLE));
+
+	/*
+	 * "But Nicolas", you ask with valid concerns, "why would you enable the
+	 * PWM before setting all the parameter registers?"
+	 *
+	 * Excellent question, Mr. Reader M. Strawman! The RK3576 TRM Part 1
+	 * Section 34.6.3 specifies that this is the intended order of writes.
+	 * Doing the PWM_EN and PWM_CLK_EN writes after the params but before
+	 * the CTRL_UPDATE_EN, or even after the CTRL_UPDATE_EN, results in
+	 * erratic behaviour where repeated turning on and off of the PWM may
+	 * not turn it off under all circumstances. This is also why we don't
+	 * use relaxed writes; it's not worth the footgun.
+	 */
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+			REG_UPDATE_WE(wfhw->enable, 0, 1));
+
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
+
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS);
+
+	/* Commit new configuration to hardware output. */
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+			PWMV4_CTRL_UPDATE_EN(1));
+
+	if (pwmv4_is_enabled(wfhw->enable)) {
+		if (!was_enabled) {
+			dev_dbg(&chip->dev, "enabling PWM output\n");
+			ret = mfpwm_pwmclk_enable(pc->pwmf);
+			if (ret)
+				goto err_mfpwm_release;
+
+			/*
+			 * Output should be on now, acquire device to guarantee
+			 * exclusion with other device functions while it's on.
+			 */
+			ret = mfpwm_acquire(pc->pwmf);
+			if (ret)
+				goto err_mfpwm_release;
+		}
+	} else if (was_enabled) {
+		dev_dbg(&chip->dev, "disabling PWM output\n");
+		mfpwm_pwmclk_disable(pc->pwmf);
+		/* Output is off now, extra release to balance extra acquire */
+		mfpwm_release(pc->pwmf);
+	}
+
+err_mfpwm_release:
+	mfpwm_release(pc->pwmf);
+
+	return ret;
+}
+
+/* We state the PWM chip is atomic, so none of these functions should sleep. */
+static const struct pwm_ops rockchip_pwm_v4_ops = {
+	.sizeof_wfhw = sizeof(struct rockchip_pwm_v4_wf),
+	.round_waveform_tohw = rockchip_pwm_v4_round_wf_tohw,
+	.round_waveform_fromhw = rockchip_pwm_v4_round_wf_fromhw,
+	.read_waveform = rockchip_pwm_v4_read_wf,
+	.write_waveform = rockchip_pwm_v4_write_wf,
+};
+
+static int rockchip_pwm_v4_probe(struct platform_device *pdev)
+{
+	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
+	struct rockchip_pwm_v4 *pc;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pc = to_rockchip_pwm_v4(chip);
+	pc->pwmf = pwmf;
+
+	platform_set_drvdata(pdev, pc);
+
+	chip->ops = &rockchip_pwm_v4_ops;
+	chip->atomic = true;
+
+	ret = pwmchip_add(chip);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static void rockchip_pwm_v4_remove(struct platform_device *pdev)
+{
+	struct rockchip_pwm_v4 *pc = platform_get_drvdata(pdev);
+
+	mfpwm_remove_func(pc->pwmf);
+}
+
+static const struct platform_device_id rockchip_pwm_v4_ids[] = {
+	{ .name = "pwm-rockchip-v4", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rockchip_pwm_v4_ids);
+
+static struct platform_driver rockchip_pwm_v4_driver = {
+	.probe = rockchip_pwm_v4_probe,
+	.remove = rockchip_pwm_v4_remove,
+	.driver = {
+		.name = "pwm-rockchip-v4",
+	},
+	.id_table = rockchip_pwm_v4_ids,
+};
+module_platform_driver(rockchip_pwm_v4_driver);
+
+MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
+MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("ROCKCHIP_MFPWM");

-- 
2.49.0



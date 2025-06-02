Return-Path: <linux-pwm+bounces-6224-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0177ACB984
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5C4178B4C
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5F229B13;
	Mon,  2 Jun 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QzNozrQc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55B225A47;
	Mon,  2 Jun 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881244; cv=pass; b=LHikTDEvTAi5Y3J/h9oOtNokP2/K9Mf2+QNBnin841iWubsu+vX4RlmlNr332j1AeJXi1Ac5XL9wagfeiCmerLcd1P7XR2fymLWFZJMscnuVP5i/iuTS0GyaXUa7/8FYFhzhMFWB3RNBSkHk/RPy/ZosRyiRjrD3OmtPIdyAdvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881244; c=relaxed/simple;
	bh=U4wDpSFDbrzm7OqrAeryFQ9ob28dE2PHpOtLCXUXKlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbT+fi+rQ+JSjIDvxhgqkH/312kNkjN9/X9DPvktfKCKzLEX5VZsq91q3QBkp2jIC7O5q1IiO9mXIu7MAvCX8teL4/Rka10OZPwpzGajofLj4NGKNJHqc7FFMVaW+ZmGif0P2rmlsKixqpY7frWZ1IZZVg3hDPTAu/F10iNSO5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=QzNozrQc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748881210; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G6T0p2jDHJReVNNbbwnK7DVGNm2ZuIogFNfln3mUQHWbe6eG2+3fDWsPj9mXsrdj7d4erifrvl+U9AdKgfoHLrwZ4ZagdCx33wo6QO6hYCVkmFQlgsKVbFt1d8NHmMYhRKfbZutAiKUHTreQYrFIziXJod5J7yXkxHe3PHXjAcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748881210; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JQE8+UUe2ZYnyEepFbx8v4Nmdf6XOz4R07wEwqI14eM=; 
	b=XKMeF9vu0QBipKEg4RmiG6hkQVYyiYWQoA7S+YpFDvMoWzaBIyD4Ce0YAiJYhqaPlAdWVDeEAJg6t3/Xz2SYkJbPSp+/x3lfYeBlC4NOEpBOCPp4PdBy7rKCCLjZ8TuqfZhi7BF5Xw9wUyNeQnwjZZcFVzkiIEyGy3h8jVmttig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748881210;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=JQE8+UUe2ZYnyEepFbx8v4Nmdf6XOz4R07wEwqI14eM=;
	b=QzNozrQcLsrnSFqyINI80jNhWX0+r3dZlJ9kIpCq6RAl9osSA1S8yOb/Tme3AcPN
	/TJeqM+g/q59nH4IL2K6yCslbT5Cm/Z7Fy11Mv4SGaUFS6atM/VhYE92nIBkw0SJvfx
	+hLcgmoJmc9G6OZRVvMyTizEBEsMcvLfUnxE+DHY=
Received: by mx.zohomail.com with SMTPS id 1748881208796587.1675568317672;
	Mon, 2 Jun 2025 09:20:08 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 02 Jun 2025 18:19:16 +0200
Subject: [PATCH v2 5/7] pwm: Add rockchip PWMv4 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-rk3576-pwm-v2-5-a6434b0ce60c@collabora.com>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
In-Reply-To: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
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
 drivers/pwm/pwm-rockchip-v4.c | 372 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 387 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39177b52be34d48967075b4f5983365725e9c055..0014af1cbd3a7729a04bfdd0b0ed50e9df425693 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21424,6 +21424,7 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/pwm/pwm-rockchip-v4.c
 F:	drivers/soc/rockchip/mfpwm.c
 F:	include/soc/rockchip/mfpwm.h
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d9bcd1e8413eaed1602d6686873e263767c58f5f..903138128bca910276fe16efc28f55d05657e385 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -586,6 +586,19 @@ config PWM_ROCKCHIP
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
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 96160f4257fcb0e0951581af0090615c0edf5260..c03083de5dbf38d68caee6b7e089ddaa235b538b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_ROCKCHIP_V4)	+= pwm-rockchip-v4.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
new file mode 100644
index 0000000000000000000000000000000000000000..9af71e79c2c7e006e805604fb66b4448ab5ecbc4
--- /dev/null
+++ b/drivers/pwm/pwm-rockchip-v4.c
@@ -0,0 +1,372 @@
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
+ *
+ * Limitations:
+ * - When the output is disabled, it will end abruptly without letting the
+ *   current period complete.
+ *   TODO: This can be fixed in the driver in the future by having the enable-
+ *         to-disable transition switch to oneshot mode with one repetition,
+ *         and then disable the pwmclk and release mfpwm when the oneshot
+ *         complete interrupt fires.
+ * - When the output is disabled, the pin will remain driven to whatever state
+ *   it last had.
+ * - Adjustments to the duty cycle will only take effect during the next period.
+ * - Adjustments to the period length will only take effect during the next
+ *   period.
+ */
+
+#include <linux/math64.h>
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
+ * Return:
+ * * %0          - Success
+ * * %-EOVERFLOW - Result too large for target type
+ */
+static int rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val,
+					u32 *out_val)
+{
+	u64 tmp;
+
+	tmp = mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);
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
+ * @out_period: pointer to where the rounded period value should be stored
+ * @out_offset: pointer to where the rounded offset value should be stored
+ *
+ * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
+ * native rounded representation in number of cycles at clock rate @rate. Should
+ * any of the input parameters be out of range for the hardware, the
+ * corresponding output parameter is the maximum permissible value for said
+ * parameter with considerations to the others.
+ */
+static void rockchip_pwm_v4_round_params(unsigned long rate, u64 duty,
+					u64 period, u64 offset, u32 *out_duty,
+					u32 *out_period, u32 *out_offset)
+{
+	int ret;
+
+	ret = rockchip_pwm_v4_round_single(rate, period, out_period);
+	if (ret)
+		*out_period = U32_MAX;
+
+	ret = rockchip_pwm_v4_round_single(rate, duty, out_duty);
+	if (ret || *out_duty > *out_period)
+		*out_duty = *out_period;
+
+	ret = rockchip_pwm_v4_round_single(rate, offset, out_offset);
+	if (ret || *out_offset > (*out_period - *out_duty))
+		*out_offset = *out_period - *out_duty;
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
+	int ret;
+
+	/* We do not want chosen_clk to change out from under us here */
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(pc->pwmf->core);
+
+	rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
+				     wf->period_length_ns, wf->duty_offset_ns,
+				     &wfhw->duty, &wfhw->period, &wfhw->offset);
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
+	return 0;
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
+	rate = clk_get_rate(pc->pwmf->core);
+
+	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
+		if (!rate) {
+			ret = -EINVAL;
+			goto out_mfpwm_release;
+		}
+		wf->period_length_ns = mul_u64_u64_div_u64(wfhw->period, NSEC_PER_SEC, rate);
+		wf->duty_length_ns = mul_u64_u64_div_u64(wfhw->duty, NSEC_PER_SEC, rate);
+		wf->duty_offset_ns = mul_u64_u64_div_u64(wfhw->offset, NSEC_PER_SEC, rate);
+	} else {
+		wf->period_length_ns = 0;
+		wf->duty_length_ns = 0;
+		wf->duty_offset_ns = 0;
+	}
+
+	dev_dbg(&chip->dev, "fromhw: duty = %llu, period = %llu, offset = %llu, rate = %lu\n",
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns, rate);
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
+	was_enabled = rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
+								PWMV4_REG_ENABLE));
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
+			FIELD_PREP_HI16_WE(PWMV4_EN_BOTH_MASK, wfhw->enable));
+
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
+
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS);
+
+	/* Commit new configuration to hardware output. */
+	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+			PWMV4_CTRL_UPDATE_EN);
+
+	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
+		if (!was_enabled) {
+			dev_dbg(&chip->dev, "enabling PWM output\n");
+			ret = clk_enable(pc->pwmf->core);
+			if (ret)
+				goto err_mfpwm_release;
+			ret = clk_rate_exclusive_get(pc->pwmf->core);
+			if (ret) {
+				clk_disable(pc->pwmf->core);
+				goto err_mfpwm_release;
+			}
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
+		clk_rate_exclusive_put(pc->pwmf->core);
+		clk_disable(pc->pwmf->core);
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
+static const struct pwm_ops rockchip_pwm_v4_ops = {
+	.sizeof_wfhw = sizeof(struct rockchip_pwm_v4_wf),
+	.round_waveform_tohw = rockchip_pwm_v4_round_wf_tohw,
+	.round_waveform_fromhw = rockchip_pwm_v4_round_wf_fromhw,
+	.read_waveform = rockchip_pwm_v4_read_wf,
+	.write_waveform = rockchip_pwm_v4_write_wf,
+};
+
+static bool rockchip_pwm_v4_on_and_continuous(struct rockchip_pwm_v4 *pc)
+{
+	bool en;
+	u32 val;
+
+	en = rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
+						       PWMV4_REG_ENABLE));
+	val = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_CTRL);
+
+	return en && ((val & PWMV4_MODE_MASK) == PWMV4_MODE_CONT);
+}
+
+static int rockchip_pwm_v4_probe(struct platform_device *pdev)
+{
+	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
+	struct rockchip_pwm_v4 *pc;
+	struct pwm_chip *chip;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pc = to_rockchip_pwm_v4(chip);
+	pc->pwmf = pwmf;
+
+	ret = mfpwm_acquire(pwmf);
+	if (ret == -EBUSY)
+		dev_warn(dev, "pwm hardware already in use, can't check initial state\n");
+	else if (ret < 0)
+		return dev_err_probe(dev, ret, "couldn't acquire mfpwm in probe\n");
+
+	if (!rockchip_pwm_v4_on_and_continuous(pc))
+		mfpwm_release(pwmf);
+	else {
+		dev_dbg(dev, "pwm was already on at probe time\n");
+		ret = clk_enable(pwmf->core);
+		if (ret)
+			return dev_err_probe(dev, ret, "enabling pwm clock failed\n");
+		ret = clk_rate_exclusive_get(pc->pwmf->core);
+		if (ret) {
+			clk_disable(pwmf->core);
+			return dev_err_probe(dev, ret, "protecting pwm clock failed\n");
+		}
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->ops = &rockchip_pwm_v4_ops;
+
+	ret = pwmchip_add(chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static void rockchip_pwm_v4_remove(struct platform_device *pdev)
+{
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+
+	mfpwm_remove_func(pc->pwmf);
+
+	pwmchip_remove(chip);
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



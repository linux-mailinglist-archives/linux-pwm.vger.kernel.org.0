Return-Path: <linux-pwm+bounces-7499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1FBC0F97B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419E242169B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC2A317704;
	Mon, 27 Oct 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="I/gPFy/6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF53176ED;
	Mon, 27 Oct 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585282; cv=pass; b=Spvgn0YEBnbAeg5pya4Sp359nR4grhdtRPrRoGNic5T2IATJSRxczG8SUw6Qv4yvSkMre2PHMdsGO1aERgpT8lPPagAgfDK/NugTxCWTdtJDzcSk6SFxhIPWxOSg/cdCKCY3L+o1eUFWL9CQrwdkAvWZORiFaFZKySw5UXrMsJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585282; c=relaxed/simple;
	bh=PFhlVi8LhCU4b7Lto2h4SBuaW+IvZK+s6RzSim/2D/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksWhBOHaf/4Jny6VkkxwmaOdtUJ+ebnU4yPrzNgGjL7zFlf41hgn39lpubaYcUkkslK07hnaSQ8SQw0VhT2WSpND4zRsmIRJ/D3/JxuIut2gzqGlva3FlbaKDr9LrcHT1ufG8ppAA/7q2TI7MhivNJSPi7jxvqPI9dsl2oDKFjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=I/gPFy/6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Aq+pwO21myOfwzDZrAXFA5IQcKT1CrD4xNE4MXeXu1KSfLAVxu/ihjLZOz478AKuf2FZV10tQrfIWaylCPfgS9nK1KdmzpnuIDwDvR7FleOG93mmpQlsbH3eZXjE6F1LsyNPeMEwIs1eJ1YmHE3rPPeBzs+fk7r+K5cVV2Aps3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2D1kUd2uDKO2TIKsH+hL3dY2umEnQqrp35ZApho/dag=; 
	b=E6A839B9A9xi5ciwvcbFjQifmoO55h37CbaLsy3qK0XKN525C3TEn3VtUGn308EOPcgjcyt40u7Zd7fXZeP/ZwHXEG6vMyt8Nc1GS7wHJf3MIyZi5fb+2NQLhtw6Zt4PhJEX3/kO7Tfd18BmDZqW/B4Ewp7ja5TM+q/RVmnkSUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585253;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=2D1kUd2uDKO2TIKsH+hL3dY2umEnQqrp35ZApho/dag=;
	b=I/gPFy/672lwPTh68vydpeaCVCdKr4GgmcwaHnGHXsPXByXcPQvjC4E4vqN9ZOt5
	fijyXY6JP5la/OYjJ/aW5rgbl3PnUBv0I+en9NvBlMnRue2tAWOLR5tyb6XcWnD1sDc
	PBR5/uDTuW8WBTw/xJQH4K/cx5LQ4dmax6fuivWc=
Received: by mx.zohomail.com with SMTPS id 1761585251562196.01283614677175;
	Mon, 27 Oct 2025 10:14:11 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 27 Oct 2025 18:11:58 +0100
Subject: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
In-Reply-To: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

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
 drivers/pwm/pwm-rockchip-v4.c | 353 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 368 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f3235ba825e..2079c2d51d5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22372,6 +22372,7 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/pwm/pwm-rockchip-v4.c
 F:	drivers/soc/rockchip/mfpwm.c
 F:	include/soc/rockchip/mfpwm.h
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c2fd3f4b62d9..b852a7b2a29d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -615,6 +615,19 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_ROCKCHIP_V4
+	tristate "Rockchip PWM v4 support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on MFD_ROCKCHIP_MFPWM
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
index dfa8b4966ee1..fe0d16558d99 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_ROCKCHIP_V4)	+= pwm-rockchip-v4.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
new file mode 100644
index 000000000000..7afa83f12b6a
--- /dev/null
+++ b/drivers/pwm/pwm-rockchip-v4.c
@@ -0,0 +1,353 @@
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
+ * Technical Reference Manual: Chapter 31 of the RK3506 TRM Part 1, a SoC which
+ * uses the same PWM hardware and has a publicly available TRM.
+ * https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf
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
+ * - offset should be between 0 and (period - duty)
+ */
+
+#include <linux/math64.h>
+#include <linux/mfd/rockchip-mfpwm.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
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
+ *
+ * Returns the rounded value, saturating at U32_MAX if too large
+ */
+static u32 rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val)
+{
+	u64 tmp;
+
+	tmp = mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+
+	return (u32)tmp;
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
+	*out_period = rockchip_pwm_v4_round_single(rate, period);
+
+	*out_duty = rockchip_pwm_v4_round_single(rate, duty);
+
+	/* As per TRM, PWM_OFFSET: "The value ranges from 0 to (period-duty)" */
+	*out_offset = rockchip_pwm_v4_round_single(rate, offset);
+	if (*out_offset > (*out_period - *out_duty))
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
+	dev_dbg(&chip->dev,
+		"tohw: duty %llu -> %u, period %llu -> %u, offset %llu -> %u, rate %lu\n",
+		wf->duty_length_ns, wfhw->duty, wf->period_length_ns,
+		wfhw->period, wf->duty_offset_ns, wfhw->offset, rate);
+
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
+
+	rate = clk_get_rate(pc->pwmf->core);
+
+	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
+		if (!rate)
+			return -EINVAL;
+
+		wf->period_length_ns = (u64)wfhw->period * NSEC_PER_SEC / rate;
+		wf->duty_length_ns = (u64)wfhw->duty * NSEC_PER_SEC / rate;
+		wf->duty_offset_ns = (u64)wfhw->offset * NSEC_PER_SEC / rate;
+	} else {
+		wf->period_length_ns = 0;
+		wf->duty_length_ns = 0;
+		wf->duty_offset_ns = 0;
+	}
+
+	dev_dbg(&chip->dev,
+		"fromhw: duty %u -> %llu, period %u -> %llu, offset %u -> %llu, rate %lu\n",
+		wfhw->duty, wf->duty_length_ns, wfhw->period,
+		wf->period_length_ns, wfhw->offset, wf->duty_offset_ns, rate);
+
+	return 0;
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
+			FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK, wfhw->enable));
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
+			dev_dbg(&chip->dev, "Enabling PWM output\n");
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
+		dev_dbg(&chip->dev, "Disabling PWM output\n");
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
+	/*
+	 * For referencing the PWM in the DT to work, we need the parent MFD
+	 * device's OF node. Code shamelessly adapted from `drivers/pci/of.c`'s
+	 * pci_set_of_node(), which does this for bus reasons.
+	 */
+	dev->parent->of_node_reused = true;
+	device_set_node(dev,
+			of_fwnode_handle(no_free_ptr(dev->parent->of_node)));
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
+		dev_warn(dev, "PWM hardware already in use, can't check initial state\n");
+	else if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't acquire mfpwm in probe\n");
+
+	if (!rockchip_pwm_v4_on_and_continuous(pc))
+		mfpwm_release(pwmf);
+	else {
+		dev_dbg(dev, "PWM was already on at probe time\n");
+		ret = clk_enable(pwmf->core);
+		if (ret)
+			return dev_err_probe(dev, ret, "Enabling pwm clock failed\n");
+		ret = clk_rate_exclusive_get(pc->pwmf->core);
+		if (ret) {
+			clk_disable(pwmf->core);
+			return dev_err_probe(dev, ret, "Protecting pwm clock failed\n");
+		}
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->ops = &rockchip_pwm_v4_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
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
+MODULE_ALIAS("platform:pwm-rockchip-v4");

-- 
2.51.1



Return-Path: <linux-pwm+bounces-8649-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGiyKdFB5mlutgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8649-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:10:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A242DDE6
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4649A35A6F13
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E23D3494;
	Mon, 20 Apr 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cVSN9QHy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5B3D3305;
	Mon, 20 Apr 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692209; cv=pass; b=udE9qnOrDTZt/mtnBbS3qcxTow4mcNWW8gDbXeduDsKByCchwKxf7Ge/xIE8lC/kKpwJHrMBeom/7h6RI2c0pjsNGQ/jIfi8B9VQrQXuE+vkBHFeIv/WOHR7ZmB798GpR7FbTNkotjuVkWuE73lhRXup3xLGh+GdGszy7LrZ9CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692209; c=relaxed/simple;
	bh=2rHgoiYTnNrmBACuB/plpJJ3e3OvRFpmVwn1atGzMjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IddSkGas8W1QTwLQQc+55aN7bQNm7QkfLAY6RsgEauOvO7HmXQLDAysppsBNyXDAo5k4SF3WLcLR9A6wUvB85n7JibNtkFiaIRwmvY3aoe9XN3SpSG3medxF9OmGmrEeg0LfScave1twf5BmGR2G2I6ELrvF6MoJ4mqi9L+b/BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cVSN9QHy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692174; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d99VOWcJzTktq2yr1f1JVn929dugXet/qcoUCx1tIiMo9LpC7xgJy9ibWmlD1HIPaDV2a14kLpMLa3KFh6DXegqdk88K4G4pIdkvmezf+p5PflyF4npKrCkKvNKnuu7sVwf99QzD0ks7ulh7u/VLFQIvw7rPN2PkutjQs4B73ZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692174; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=978hIvIDO1JQcPsSm9qwEOC+l0xe4bOMy67Ouu23DCU=; 
	b=Hpx/mIvCo6XVR/e9/ugaQ4s2EiZWiK9yByKj2CKcd31n1wnNpZxvkIdxE6TbDucb3LdiRE1+XGq0FOdTRYP8zq1ZVkI0BE50S0Fl8vbqm6PcSpMlYA7s2r9NH9B6dLf//ZQuSRaOHsK6HfJJSi9B0soB9ieXshjPjcrQcWsVWwQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692174;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=978hIvIDO1JQcPsSm9qwEOC+l0xe4bOMy67Ouu23DCU=;
	b=cVSN9QHy2FLNUnE1Csd/PWmjLlGgE+J+3t4vDNU6AsFSuk+muWW0VBLfhiU4phcf
	KPwxj59eGPhyt9BhJdzp668EVz9rXGx9KRIXtWFTPxDGk+E/GKUfjI0n3AWcFNmUzDy
	5Bm1pJXS/qFRfsaZca03yYOXR6JiTwg1FsE0ETSI=
Received: by mx.zohomail.com with SMTPS id 1776692172247435.7285667818933;
	Mon, 20 Apr 2026 06:36:12 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:35:21 +0200
Subject: [PATCH v4 3/5] pwm: Add rockchip PWMv4 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v4-3-421738c7bf28@collabora.com>
References: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8649-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,infradead.org:email,rock-chips.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65A242DDE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 MAINTAINERS                            |   2 +
 drivers/counter/Kconfig                |  11 +
 drivers/counter/Makefile               |   1 +
 drivers/counter/rockchip-pwm-capture.c | 307 ++++++++++++++++++++++++++
 drivers/pwm/Kconfig                    |  11 +
 drivers/pwm/Makefile                   |   1 +
 drivers/pwm/pwm-rockchip-v4.c          | 383 +++++++++++++++++++++++++++++++++
 7 files changed, 716 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d52731242a33..3f72784dd5bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23178,7 +23178,9 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/counter/rockchip-pwm-capture.c
 F:	drivers/mfd/rockchip-mfpwm.c
+F:	drivers/pwm/pwm-rockchip-v4.c
 F:	include/linux/mfd/rockchip-mfpwm.h
 
 ROCKCHIP RK3568 RANDOM NUMBER GENERATOR SUPPORT
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe577..85adeb41aeed 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -90,6 +90,17 @@ config MICROCHIP_TCB_CAPTURE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microchip-tcb-capture.
 
+config ROCKCHIP_PWM_CAPTURE
+	tristate "Rockchip PWM Counter Capture driver"
+	depends on MFD_ROCKCHIP_MFPWM
+	help
+	  Generic counter framework driver for the multi-function PWM on
+	  Rockchip SoCs such as the RK3576.
+
+	  Uses the Rockchip Multi-function PWM controller driver infrastructure
+	  to guarantee exclusive operation with other functions of the same
+	  device implemented by drivers in other subsystems.
+
 config RZ_MTU3_CNT
 	tristate "Renesas RZ/G2L MTU3a counter driver"
 	depends on RZ_MTU3
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index fa3c1d08f706..2bfcfc2c584b 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
 obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
+obj-$(CONFIG_ROCKCHIP_PWM_CAPTURE)	+= rockchip-pwm-capture.o
diff --git a/drivers/counter/rockchip-pwm-capture.c b/drivers/counter/rockchip-pwm-capture.c
new file mode 100644
index 000000000000..09a92f2bc409
--- /dev/null
+++ b/drivers/counter/rockchip-pwm-capture.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *
+ * A counter driver for the Pulse-Width-Modulation (PWM) hardware found on
+ * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". It
+ * allows for measuring the high cycles and low cycles of a PWM signal through
+ * the generic counter framework, while guaranteeing exclusive use over the
+ * MFPWM device while the counter is enabled.
+ *
+ * Authors:
+ *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/counter.h>
+#include <linux/devm-helpers.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/rockchip-mfpwm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define RKPWMC_INT_MASK			(PWMV4_INT_LPC | PWMV4_INT_HPC)
+
+struct rockchip_pwm_capture {
+	struct rockchip_mfpwm_func *pwmf;
+	struct counter_device *counter;
+};
+
+static struct counter_signal rkpwmc_signals[] = {
+	{
+		.id = 0,
+		.name = "PWM Clock"
+	},
+};
+
+static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static struct counter_synapse rkpwmc_pwm_synapses[] = {
+	{
+		.actions_list = rkpwmc_hpc_lpc_actions,
+		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
+		.signal = &rkpwmc_signals[0]
+	},
+};
+
+static const enum counter_function rkpwmc_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
+};
+
+static inline bool rkpwmc_is_enabled(struct rockchip_mfpwm_func *pwmf)
+{
+	return mfpwm_get_mode(pwmf) == PWMV4_MODE_CAPTURE;
+}
+
+static bool rkpwmc_acquire_if_enabled(struct rockchip_pwm_capture *pc)
+{
+	int ret;
+
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret < 0)
+		return false;
+
+	if (rkpwmc_is_enabled(pc->pwmf))
+		return true;
+
+	mfpwm_release(pc->pwmf);
+
+	return false;
+}
+
+static int rkpwmc_enable_read(struct counter_device *counter,
+			       struct counter_count *count,
+			       u8 *enable)
+{
+	struct rockchip_pwm_capture *pc = counter_priv(counter);
+
+	*enable = rkpwmc_is_enabled(pc->pwmf);
+
+	return 0;
+}
+
+static int rkpwmc_enable_write(struct counter_device *counter,
+			       struct counter_count *count,
+			       u8 enable)
+{
+	struct rockchip_pwm_capture *pc = counter_priv(counter);
+	int ret;
+
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	if (!!enable != rkpwmc_is_enabled(pc->pwmf)) {
+		if (enable) {
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+					 PWMV4_EN(false));
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL,
+					 PWMV4_CTRL_CAP_FLAGS);
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
+					 PWMV4_INT_LPC_W(true) |
+					 PWMV4_INT_HPC_W(true));
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+					 PWMV4_EN(true) | PWMV4_CLK_EN(true));
+
+			ret = clk_enable(pc->pwmf->core);
+			if (ret)
+				goto err_release;
+
+			ret = clk_rate_exclusive_get(pc->pwmf->core);
+			if (ret)
+				goto err_disable_pwm_clk;
+
+			ret = mfpwm_acquire(pc->pwmf);
+			if (ret)
+				goto err_unprotect_pwm_clk;
+		} else {
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
+					 PWMV4_INT_LPC_W(false) |
+					 PWMV4_INT_HPC_W(false));
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+					 PWMV4_EN(false) | PWMV4_CLK_EN(false));
+			clk_rate_exclusive_put(pc->pwmf->core);
+			clk_disable(pc->pwmf->core);
+			mfpwm_release(pc->pwmf);
+		}
+	}
+
+	mfpwm_release(pc->pwmf);
+
+	return 0;
+
+err_unprotect_pwm_clk:
+	clk_rate_exclusive_put(pc->pwmf->core);
+err_disable_pwm_clk:
+	clk_disable(pc->pwmf->core);
+err_release:
+	mfpwm_release(pc->pwmf);
+
+	return ret;
+}
+
+static struct counter_comp rkpwmc_ext[] = {
+	COUNTER_COMP_ENABLE(rkpwmc_enable_read, rkpwmc_enable_write),
+};
+
+enum rkpwmc_count_id {
+	COUNT_LPC = 0,
+	COUNT_HPC = 1,
+};
+
+static struct counter_count rkpwmc_counts[] = {
+	{
+		.id = COUNT_LPC,
+		.name = "Low Polarity Capture",
+		.functions_list = rkpwmc_functions,
+		.num_functions = ARRAY_SIZE(rkpwmc_functions),
+		.synapses = rkpwmc_pwm_synapses,
+		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
+		.ext = rkpwmc_ext,
+		.num_ext = ARRAY_SIZE(rkpwmc_ext),
+	},
+	{
+		.id = COUNT_HPC,
+		.name = "High Polarity Capture",
+		.functions_list = rkpwmc_functions,
+		.num_functions = ARRAY_SIZE(rkpwmc_functions),
+		.synapses = rkpwmc_pwm_synapses,
+		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
+		.ext = rkpwmc_ext,
+		.num_ext = ARRAY_SIZE(rkpwmc_ext),
+	},
+};
+
+static int rkpwmc_count_read(struct counter_device *counter,
+			     struct counter_count *count, u64 *value)
+{
+	struct rockchip_pwm_capture *pc = counter_priv(counter);
+
+	switch (count->id) {
+	case COUNT_LPC:
+		if (rkpwmc_acquire_if_enabled(pc)) {
+			*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_LPC);
+			mfpwm_release(pc->pwmf);
+		} else {
+			*value = 0;
+		}
+		return 0;
+	case COUNT_HPC:
+		if (rkpwmc_acquire_if_enabled(pc)) {
+			*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_HPC);
+			mfpwm_release(pc->pwmf);
+		} else {
+			*value = 0;
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct counter_ops rkpwmc_ops = {
+	.count_read = rkpwmc_count_read,
+};
+
+static irqreturn_t rkpwmc_irq_handler(int irq, void *data)
+{
+	struct rockchip_pwm_capture *pc = data;
+	u32 intsts;
+	u32 clr = 0;
+
+	intsts = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_INTSTS);
+
+	if (!(intsts & RKPWMC_INT_MASK))
+		return IRQ_NONE;
+
+	if (intsts & PWMV4_INT_LPC) {
+		clr |= PWMV4_INT_LPC;
+		counter_push_event(pc->counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+	}
+
+	if (intsts & PWMV4_INT_HPC) {
+		clr |= PWMV4_INT_HPC;
+		counter_push_event(pc->counter, COUNTER_EVENT_CHANGE_OF_STATE, 1);
+	}
+
+	if (clr)
+		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INTSTS, clr);
+
+	/* If other interrupt status bits are set, they're not for this driver */
+	if (intsts != clr)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int rockchip_pwm_capture_probe(struct platform_device *pdev)
+{
+	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
+	struct rockchip_pwm_capture *pc;
+	struct counter_device *counter;
+	int ret;
+
+	/* Set our (still unset) OF node to the parent MFD device's OF node */
+	pdev->dev.parent->of_node_reused = true;
+	device_set_node(&pdev->dev,
+			of_fwnode_handle(no_free_ptr(pdev->dev.parent->of_node)));
+
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*pc));
+	if (IS_ERR(counter))
+		return PTR_ERR(counter);
+
+	pc = counter_priv(counter);
+	pc->pwmf = pwmf;
+
+	platform_set_drvdata(pdev, pc);
+
+	/* If the counter is on at module probe, acquire it */
+	rkpwmc_acquire_if_enabled(pc);
+
+	counter->name = pdev->name;
+	counter->signals = rkpwmc_signals;
+	counter->num_signals = ARRAY_SIZE(rkpwmc_signals);
+	counter->ops = &rkpwmc_ops;
+	counter->counts = rkpwmc_counts;
+	counter->num_counts = ARRAY_SIZE(rkpwmc_counts);
+
+	pc->counter = counter;
+
+	ret = devm_counter_add(&pdev->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
+
+	ret = devm_request_irq(&pdev->dev, pwmf->irq, rkpwmc_irq_handler,
+			       IRQF_SHARED, pdev->name, pc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed requesting IRQ\n");
+
+	return 0;
+}
+
+static const struct platform_device_id rockchip_pwm_capture_id_table[] = {
+	{ .name = "rockchip-pwm-capture", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, rockchip_pwm_capture_id_table);
+
+static struct platform_driver rockchip_pwm_capture_driver = {
+	.probe = rockchip_pwm_capture_probe,
+	.id_table = rockchip_pwm_capture_id_table,
+	.driver = {
+		.name = "rockchip-pwm-capture",
+	},
+};
+module_platform_driver(rockchip_pwm_capture_driver);
+
+MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
+MODULE_DESCRIPTION("Rockchip PWM Counter Capture Driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("ROCKCHIP_MFPWM");
+MODULE_IMPORT_NS("COUNTER");
+MODULE_ALIAS("platform:rockchip-pwm-capture");
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..3fe7993bf12b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -625,6 +625,17 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_ROCKCHIP_V4
+	tristate "Rockchip PWM v4 support"
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
index 0dc0d2b69025..a234027dbbc6 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_ROCKCHIP_V4)	+= pwm-rockchip-v4.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
new file mode 100644
index 000000000000..b7de72c433c5
--- /dev/null
+++ b/drivers/pwm/pwm-rockchip-v4.c
@@ -0,0 +1,383 @@
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
+ * - The hardware supports both completing the currently running period
+ *   on disable (by switching to oneshot mode with a single repetition and
+ *   only disable when the complete irq fires), and abrupt disable (freeze).
+ *   Only the latter is implemented in the driver.
+ * - When the output is disabled, the pin will remain driven to whatever state
+ *   it last had.
+ * - Adjustments to the duty cycle will only take effect during the next period.
+ * - Adjustments to the period length will only take effect during the next
+ *   period.
+ * - The hardware only supports offsets in [0, period - duty_cycle]
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
+struct __packed rockchip_pwm_v4_wf {
+	u32 period;
+	u32 duty;
+	u32 offset;
+	unsigned long rate;
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
+ *        Assumed to be <= 1GHz for overflow considerations
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
+	return tmp;
+}
+
+/**
+ * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
+ * @rate: PWM clock rate to do the calculations at
+ * @wf: pointer to the generic &struct pwm_waveform input parameters
+ * @wfhw: pointer to the hardware-specific &struct rockchip_pwm_v4_wf output
+ *        parameters that the results will be stored in
+ *
+ * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
+ * native rounded representation in number of cycles at clock rate @rate. Should
+ * any of the input parameters be out of range for the hardware, the
+ * corresponding output parameter is the maximum permissible value for said
+ * parameter with considerations to the others.
+ */
+static void rockchip_pwm_v4_round_params(unsigned long rate,
+					 const struct pwm_waveform *wf,
+					 struct rockchip_pwm_v4_wf *wfhw)
+{
+	wfhw->period = rockchip_pwm_v4_round_single(rate, wf->period_length_ns);
+
+	wfhw->duty = rockchip_pwm_v4_round_single(rate, wf->duty_length_ns);
+
+	/* As per TRM, PWM_OFFSET: "The value ranges from 0 to (period-duty)" */
+	wfhw->offset = rockchip_pwm_v4_round_single(rate, wf->duty_offset_ns);
+	if (!wfhw->period) /* Don't underflow when pwm disabled */
+		wfhw->offset = 0;
+	else if (wfhw->offset > wfhw->period - wfhw->duty)
+		wfhw->offset = wfhw->period - wfhw->duty;
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
+	/*
+	 * It's unlikely this code path is ever taken, as current hardware does
+	 * not expose a clock that comes anywhere close to 1GHz. However, in
+	 * order to avoid even a theoretical overflow in parameter rounding,
+	 * error out if this ever happens to be the case.
+	 */
+	if (rate > NSEC_PER_SEC)
+		return -ERANGE;
+
+	rockchip_pwm_v4_round_params(rate, wf, wfhw);
+
+	if (wf->period_length_ns > 0)
+		wfhw->rate = rate;
+	else
+		wfhw->rate = 0;
+
+	dev_dbg(&chip->dev,
+		"tohw: pwm#%u: %lld/%lld [+%lld] @%lu -> DUTY: %08x, PERIOD: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+		rate, wfhw->duty, wfhw->period, wfhw->offset);
+
+	return 0;
+}
+
+static int rockchip_pwm_v4_round_wf_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	unsigned long rate = wfhw->rate;
+
+	if (rate) {
+		wf->period_length_ns = DIV_ROUND_UP((u64)wfhw->period * NSEC_PER_SEC, rate);
+		wf->duty_length_ns = DIV_ROUND_UP((u64)wfhw->duty * NSEC_PER_SEC, rate);
+		wf->duty_offset_ns = DIV_ROUND_UP((u64)wfhw->offset * NSEC_PER_SEC, rate);
+	} else {
+		wf->period_length_ns = 0;
+		wf->duty_length_ns = 0;
+		wf->duty_offset_ns = 0;
+	}
+
+	dev_dbg(&chip->dev,
+		"fromhw: pwm#%u: DUTY: %08x, PERIOD: %08x, OFFSET: %08x @%lu -> %lld/%lld [+%lld]\n",
+		pwm->hwpwm, wfhw->duty, wfhw->period, wfhw->offset, rate,
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
+	return 0;
+}
+
+static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
+	struct rockchip_pwm_v4_wf *wfhw = _wfhw;
+	unsigned long rate;
+	int ret;
+
+	ret = mfpwm_acquire(pc->pwmf);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(pc->pwmf->core);
+
+	wfhw->period = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
+	wfhw->duty = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
+	wfhw->offset = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
+	if (rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE)))
+		wfhw->rate = rate;
+	else
+		wfhw->rate = 0;
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
+	bool was_enabled;
+	int ret;
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
+	if (wfhw->rate)
+		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK,
+						PWMV4_EN_BOTH_MASK));
+	else
+		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK, 0));
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
+	if (wfhw->rate) {
+		if (!was_enabled) {
+			dev_dbg(&chip->dev, "Enabling PWM output\n");
+			ret = clk_enable(pc->pwmf->core);
+			if (ret)
+				goto err_mfpwm_release;
+			ret = clk_set_rate_exclusive(pc->pwmf->core, wfhw->rate);
+			if (ret) {
+				clk_disable(pc->pwmf->core);
+				goto err_mfpwm_release;
+			}
+
+			/*
+			 * Output should be on now, acquire device to guarantee
+			 * exclusion with other device functions while it's on.
+			 *
+			 * It's highly unlikely that this fails, as mfpwm has
+			 * already been acquired before, and this is just a
+			 * usage counter increase. Not worth the added
+			 * complexity of clearing the PWMV4_REG_ENABLE again,
+			 * especially considering the CTRL_UPDATE_EN behaviour.
+			 */
+			ret = mfpwm_acquire(pc->pwmf);
+			if (ret) {
+				clk_rate_exclusive_put(pc->pwmf->core);
+				clk_disable(pc->pwmf->core);
+				goto err_mfpwm_release;
+			}
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
+	 * device's OF node.
+	 */
+	dev->of_node_reused = true;
+	device_set_node(dev, of_fwnode_handle(dev->parent->of_node));
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pc = to_rockchip_pwm_v4(chip);
+	pc->pwmf = pwmf;
+
+	ret = mfpwm_acquire(pwmf);
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't acquire mfpwm in probe\n");
+
+	if (!rockchip_pwm_v4_on_and_continuous(pc))
+		mfpwm_release(pwmf);
+	else {
+		dev_dbg(dev, "PWM was already on at probe time\n");
+		ret = clk_enable(pwmf->core);
+		if (ret) {
+			dev_err_probe(dev, ret, "Enabling pwm clock failed\n");
+			goto err_mfpwm_release;
+		}
+		ret = clk_rate_exclusive_get(pc->pwmf->core);
+		if (ret) {
+			dev_err_probe(dev, ret, "Protecting pwm clock failed\n");
+			goto err_clk_disable;
+		}
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->ops = &rockchip_pwm_v4_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+		if (rockchip_pwm_v4_on_and_continuous(pc))
+			goto err_rate_put;
+
+		return ret;
+	}
+
+	return 0;
+
+err_rate_put:
+	clk_rate_exclusive_put(pwmf->core);
+err_clk_disable:
+	clk_disable(pwmf->core);
+err_mfpwm_release:
+	mfpwm_release(pwmf);
+
+	return ret;
+}
+
+static const struct platform_device_id rockchip_pwm_v4_ids[] = {
+	{ .name = "rockchip-pwm-v4", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rockchip_pwm_v4_ids);
+
+static struct platform_driver rockchip_pwm_v4_driver = {
+	.probe = rockchip_pwm_v4_probe,
+	.driver = {
+		.name = "rockchip-pwm-v4",
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
2.53.0



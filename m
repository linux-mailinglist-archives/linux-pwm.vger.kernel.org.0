Return-Path: <linux-pwm+bounces-8657-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPTkL0tD5ml/twEAu9opvQ
	(envelope-from <linux-pwm+bounces-8657-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:16:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03342DFC4
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A066632A4A50
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AE31F98C;
	Mon, 20 Apr 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="OEmi/Xag"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF63195F0;
	Mon, 20 Apr 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693255; cv=pass; b=LPOsovowL8CxqzBpI3rTqUXBTqKrvx6H8ja8Gj7w0plNhfBKkPQLg/HJ4EEtkVLlNY38I7SgR3sK/+GiMH9mQXDgGw2tC4K+ehJhAFsSNkflCkIzf2CncYaaMDLXuzJYPYP/q09E0awcU1jRw9kS7tYFGB+ronKukTwL5ftHqCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693255; c=relaxed/simple;
	bh=DTwNUvQt4xdk7TbrZY5i0cQ67zmU5T0pWGFM0RmqOrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1XwVVfovbZWWqQ+rKaKQbkcXPgjiuLrH91Fv8DZqkGmNz5/aZZdd2TIJ6L1V5s2/Me5Uqz/gHIF1aHPKRtt8Hsv0we9FYa08XegY+ez2stx0LdH78hvQOaSiaIJX8Qp6BiRIc+XWkSJARbgFKt/oR6Xgctz0GKj1CxOJqXflNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=OEmi/Xag; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776693224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MiMILsuE5C9jBS0ighSf0wHMpSv+qZ5D6+SDnPLlalHcU4FkOAMVVW40pS8cl0ByzQSL7d4O/C+WgHyh8JAp/9s2xrwH6x/uAERB71VzPBUlf53KKF8fe+l3fDUQvEklTe55xRyscmSLx+PlP5MElyUxHUR3bIHjYLeozKW4nXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776693224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nsutsVj0iUbQZMCAjd1hvnunqn5qD6BVdq6dMYUC5IA=; 
	b=F56OApG/YY6EYMTt54naRwjDeaudyy21JwoxLD86i7Bqb95HYHlwGVpVnxU+uhk7gXhSvhJfn0V5jNuOYs/L4w7wSAnn04EVPStBiMMNrk+BIq6DGWD28nuAwijHte39G4pCc1gxFRvjdVHaZ6BYzubJQ5RPYWQfJQjEV2Lrvyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776693224;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nsutsVj0iUbQZMCAjd1hvnunqn5qD6BVdq6dMYUC5IA=;
	b=OEmi/Xagen/DSaYql+XoPlBjOyxZTPIjcAM9Nyf288bh04wP80biAu3WGqaeCYxp
	MzSc26pnEqUInXxJzqHmEVEKSMxXD95R00LexuPcz+DHlZ6J/1W5b2gkueprUCdoSPR
	idoyKKEt6bTe+BMjgkM1DTCxzzOb8yB6AtqDcoBs=
Received: by mx.zohomail.com with SMTPS id 1776693222111979.3501881109034;
	Mon, 20 Apr 2026 06:53:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:52:41 +0200
Subject: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8657-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: CB03342DFC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
PWM capture functionality.

Add a basic driver for this that works to expose HPC/LPC counts and
state change events to userspace through the counter framework. It's
quite basic, but works well enough to demonstrate the device function
exclusion stuff that mfpwm does, in order to eventually support all the
functions of this device in drivers within their appropriate subsystems,
without them interfering with each other.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS                            |   1 +
 drivers/counter/Kconfig                |  11 ++
 drivers/counter/Makefile               |   1 +
 drivers/counter/rockchip-pwm-capture.c | 307 +++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68bb9ee07a47..3f72784dd5bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23178,6 +23178,7 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/counter/rockchip-pwm-capture.c
 F:	drivers/mfd/rockchip-mfpwm.c
 F:	drivers/pwm/pwm-rockchip-v4.c
 F:	include/linux/mfd/rockchip-mfpwm.h
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

-- 
2.53.0



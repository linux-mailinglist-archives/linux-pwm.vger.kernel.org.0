Return-Path: <linux-pwm+bounces-7498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7DCC0F96F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD3F42612A
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62213168FA;
	Mon, 27 Oct 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KQk5vLOc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07B315D32;
	Mon, 27 Oct 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585275; cv=pass; b=RMwvDAOtxbpNngy4+M4zPZaJ7r7lL+YpAE4NJisIN6g5qzptXz0LdWWTyEBzc7NLJ+34vNRfWWDeEY0YYCd37BA1noZ8Vz42a2MCZ3aiejzzMWekPpoP5LJCw2WZqj3dK2lrm5Ljc8JpZDygJfDglYCurthbZnSiZxjyl4uhD3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585275; c=relaxed/simple;
	bh=WkjpIaqOVm27hyM4GjElAXAgqb8FWaod5zZ5duuezec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyulwBVdmz+ayjUqXCNg0oINbbeK1rgpk6WRRo4vUiJwQ7W/8lySzOBR+9KRBR++vAKLBCNG4A+tXqmqQu+1BH0217mLLI2IES8UynXQLLvmyKrC86IzHmpSomZaIHH/6sqjnKb0OyUxXQrTPyjf1CEYoDSFmig3GTvrI7LQbhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KQk5vLOc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585257; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D9iklI4wmWVXRCBdcbEKZqp8UagSHiUd1C0ddQt64HSh+OxUvRgpdzAQ7eFq7YR4xaBeSfP6in1AwmeyO/wP1TGR+YwkasyJKgmVeF0ZeZFSns/5z1msz0bT39KuW/Sm6XPMxmO5GwQz9a8oPVByTperW3v7rSch32CFV0/4PHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585257; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BkZC/UH30pgFjHHpxrxGEL/0mUOglLr4vaPq6NDjtYU=; 
	b=JD0YTCUD12zeVcq/gGjPqFnkxykAA0F7tswBkQA81MP8cBO/legZuhMtDW2kHuQmJkUAEGRYLtVfNil5Eer61RmgCtFVHfszPyDfBlkvwDc+ow74mel9hxM7Z+KEe1Luxw//zL5iDt4aF98E8gg5T3VbDV1+cCbReVC5H35xUo0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585257;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=BkZC/UH30pgFjHHpxrxGEL/0mUOglLr4vaPq6NDjtYU=;
	b=KQk5vLOcRzEiNV7eI1kYRi3l4MQVzVVZ7N9rk6hMBS1CJscEf5MZZzCU1m5DL7Nb
	TAEkZWNu7NSAxCjAcZZdkYqb7q17hy4GrAsp3Dg16rOL9pKFXMH4hWqTJBgc2T2eNMa
	ONNurOajfcqlhDrXTS/KbfD3Afmj4ekkx/7b5+tw=
Received: by mx.zohomail.com with SMTPS id 1761585255797123.46488322325456;
	Mon, 27 Oct 2025 10:14:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 27 Oct 2025 18:11:59 +0100
Subject: [PATCH v3 4/5] counter: Add rockchip-pwm-capture driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
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
 drivers/counter/Kconfig                |  13 ++
 drivers/counter/Makefile               |   1 +
 drivers/counter/rockchip-pwm-capture.c | 306 +++++++++++++++++++++++++++++++++
 4 files changed, 321 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2079c2d51d5c..17d625ef76d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22372,6 +22372,7 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/counter/rockchip-pwm-capture.c
 F:	drivers/pwm/pwm-rockchip-v4.c
 F:	drivers/soc/rockchip/mfpwm.c
 F:	include/soc/rockchip/mfpwm.h
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe577..12e823dd0ec7 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -90,6 +90,19 @@ config MICROCHIP_TCB_CAPTURE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microchip-tcb-capture.
 
+config ROCKCHIP_PWM_CAPTURE
+	tristate "Rockchip PWM Counter Capture driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on MFD_ROCKCHIP_MFPWM
+	depends on HAS_IOMEM
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
index 000000000000..63e1286303f9
--- /dev/null
+++ b/drivers/counter/rockchip-pwm-capture.c
@@ -0,0 +1,306 @@
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
+	bool is_enabled;
+	spinlock_t enable_lock;
+};
+
+/*
+ * Channel 0 receives a state changed notification whenever the LPC interrupt
+ * fires.
+ *
+ * Channel 1 receives a state changed notification whenever the HPC interrupt
+ * fires.
+ */
+static struct counter_signal rkpwmc_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 0"
+	},
+	{
+		.id = 1,
+		.name = "Channel 1"
+	},
+};
+
+static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+
+};
+
+static struct counter_synapse rkpwmc_pwm_synapses[] = {
+	{
+		.actions_list = rkpwmc_hpc_lpc_actions,
+		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
+		.signal = &rkpwmc_signals[0]
+	},
+	{
+		.actions_list = rkpwmc_hpc_lpc_actions,
+		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
+		.signal = &rkpwmc_signals[1]
+	},
+};
+
+static const enum counter_function rkpwmc_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
+};
+
+static int rkpwmc_enable_read(struct counter_device *counter,
+			       struct counter_count *count,
+			       u8 *enable)
+{
+	struct rockchip_pwm_capture *pc = counter_priv(counter);
+
+	guard(spinlock)(&pc->enable_lock);
+
+	*enable = pc->is_enabled;
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
+	guard(spinlock)(&pc->enable_lock);
+
+	if (!!enable != pc->is_enabled) {
+		ret = mfpwm_acquire(pc->pwmf);
+		if (ret)
+			return ret;
+
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
+
+			pc->is_enabled = true;
+		} else {
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_INT_EN,
+					 PWMV4_INT_LPC_W(false) |
+					 PWMV4_INT_HPC_W(false));
+			mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
+					 PWMV4_EN(false) | PWMV4_CLK_EN(false));
+			clk_rate_exclusive_put(pc->pwmf->core);
+			clk_disable(pc->pwmf->core);
+			pc->is_enabled = false;
+			mfpwm_release(pc->pwmf);
+		}
+
+		mfpwm_release(pc->pwmf);
+	}
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
+		.name = "PWM core clock cycles during which the signal was low",
+		.functions_list = rkpwmc_functions,
+		.num_functions = ARRAY_SIZE(rkpwmc_functions),
+		.synapses = rkpwmc_pwm_synapses,
+		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
+		.ext = rkpwmc_ext,
+		.num_ext = ARRAY_SIZE(rkpwmc_ext),
+	},
+	{
+		.id = COUNT_HPC,
+		.name = "PWM core clock cycles during which the signal was high",
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
+	guard(spinlock)(&pc->enable_lock);
+
+	if (!pc->is_enabled) {
+		*value = 0;
+		return 0;
+	}
+
+	switch (count->id) {
+	case COUNT_LPC:
+		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_LPC);
+		return 0;
+	case COUNT_HPC:
+		*value = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_HPC);
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
+	spin_lock_init(&pc->enable_lock);
+
+	platform_set_drvdata(pdev, pc);
+
+	ret = devm_request_irq(&pdev->dev, pwmf->irq, rkpwmc_irq_handler,
+			       IRQF_SHARED, pdev->name, pc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed requesting IRQ\n");
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
2.51.1



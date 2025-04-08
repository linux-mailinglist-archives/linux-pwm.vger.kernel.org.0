Return-Path: <linux-pwm+bounces-5381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937FA80869
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC5D3A3C13
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A1270EA8;
	Tue,  8 Apr 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="apOpePAI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A22686BC;
	Tue,  8 Apr 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115675; cv=pass; b=HAJlHjbjbiMHL5UkxkeUeUu7nzZ2/14x0JNUXzvEN1OOE4fC83jhwdAVBlnFfm31guw0OcMlwyb0Ei5/exjYHemx8L09TIIOysklkoCJrP6Wf1Mwp+F4J70NnXuJjOuvYVMuODWBBoYNA9n1yREROcaLfyz2ddSb+6WG9VkF+SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115675; c=relaxed/simple;
	bh=6YzZYX0DdAV0Nj/HLFdGUnHVLZjGtxOdSs2qZbaKoKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8kyOHeAbBuAFjPfTE4l1H1LFPrnURYGYBd09rBK48W94hQHDlvnr3sC165+M0eDKb1SZ3sQyeftFqZ3Yt5TF7HLRxs7EbjXzLt7F4HS3iDUs2NHx3+Vo8Jul6wzQ2iLxnb9SWZNPiI8Zg+ifQyxYNzSi8/NwH3h41k1E5l7+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=apOpePAI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jXL/sWHn7kKWZz2UojIYi/yr5UIzAQta2RCUpD2WNgSmq1t8k+fhvaiTcFyAv05MSok4Bu/UOzAvbROaEaOpCaMLyPDFNp2uQo63pcNAB7JjZSeurG/GTiOz613aPYYwaRbRYAwzdvCZwGAZURW4y0H/r+RtgxikmBNXqVrIHBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VwSY8ghfWMjZqpRRdjMskZPPFCrzGQDBj31m2UR+JRo=; 
	b=PHp7OQTaUQQmXzKDtpRRzoFiITRFeSCrskatYB7O96F3u+pIYF/7ZfkaBTxc77o1RkMBcVCQG4UUVAkBcRYiOwf7bXP6RbkUE6z4Tbw0z55l9gcKmn4TW/eXglLuM1vFqXeSZkJ/0fVqJleT6zpFJ9VfFQVLpcGAFxfgHWCcEtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115639;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=VwSY8ghfWMjZqpRRdjMskZPPFCrzGQDBj31m2UR+JRo=;
	b=apOpePAIgaPdiUzsbFPlMG1gREWKqFEGsIf1/g9OzGaVBBUX234GsJaEQ7srVGu9
	we0/x2hLtD5p6kCnijO8m0nbK+Z4/g4BmbFE+zCdCJYwhxD3mhblrDZY3COMbEFGOZf
	s4zIpKadQdJBy7eeY4jGhv2nR6FmcZ7stHMDBsuo=
Received: by mx.zohomail.com with SMTPS id 174411563799076.20317501450359;
	Tue, 8 Apr 2025 05:33:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 14:32:16 +0200
Subject: [PATCH 4/7] soc: rockchip: add mfpwm driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
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

With the Rockchip RK3576, the PWM IP used by Rockchip has changed
substantially. Looking at both the downstream pwm-rockchip driver as
well as the mainline pwm-rockchip driver made it clear that with all its
additional features and its differences from previous IP revisions, it
is best supported in a new driver.

This brings us to the question as to what such a new driver should be.
To me, it soon became clear that it should actually be several new
drivers, most prominently when Uwe Kleine-König let me know that I
should not implement the pwm subsystem's capture callback, but instead
write a counter driver for this functionality.

Combined with the other as-of-yet unimplemented functionality of this
new IP, it became apparent that it needs to be spread across several
subsystems.

For this reason, we add a new platform bus based driver, called mfpwm
(short for "Multi-function PWM"). This "parent" driver makes sure that
only one device function driver is using the device at a time, and is in
charge of registering the platform bus devices for the individual device
functions offered by the device.

An acquire/release pattern is used to guarantee that device function
drivers don't step on each other's toes.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS                   |   2 +
 drivers/soc/rockchip/Kconfig  |  13 +
 drivers/soc/rockchip/Makefile |   1 +
 drivers/soc/rockchip/mfpwm.c  | 608 ++++++++++++++++++++++++++++++++++++++++++
 include/soc/rockchip/mfpwm.h  | 505 +++++++++++++++++++++++++++++++++++
 5 files changed, 1129 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 407179d2a90dd49800f2bb5770a1280c5afebb5a..e6a9347be1e7889089e1d9e655cb23c2d8399b40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20891,6 +20891,8 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/soc/rockchip/mfpwm.c
+F:	include/soc/rockchip/mfpwm.h
 
 ROCKCHIP RK3568 RANDOM NUMBER GENERATOR SUPPORT
 M:	Daniel Golle <daniel@makrotopia.org>
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 785f60c6f3ad1a09f517e69a69726a8178bed168..4e1e4926c514a5a2c4d4caf8cf9809a098badc7d 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -30,4 +30,17 @@ config ROCKCHIP_DTPM
 	  on this platform. That will create all the power capping capable
 	  devices.
 
+config ROCKCHIP_MFPWM
+	tristate "Rockchip multi-function PWM controller"
+	depends on OF
+	depends on HAS_IOMEM
+	help
+	  Some Rockchip SoCs, such as the RK3576, use a PWM controller that has
+	  several different functions, such as generating PWM waveforms but also
+	  counting waveforms.
+
+	  This driver manages the overall device, and selects between different
+	  functionalities at runtime as needed, with drivers for them
+	  implemented in their respective subsystems.
+
 endif
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 23d414433c8c58557effc214337ec8e6ff17a461..ba12dbd01ac794910d9407c268e89071cd2b3139 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
 obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
+obj-$(CONFIG_ROCKCHIP_MFPWM) += mfpwm.o
diff --git a/drivers/soc/rockchip/mfpwm.c b/drivers/soc/rockchip/mfpwm.c
new file mode 100644
index 0000000000000000000000000000000000000000..9331c530f0581573e2b74f62a6622b8625c5b2c5
--- /dev/null
+++ b/drivers/soc/rockchip/mfpwm.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *
+ * A driver to manage all the different functionalities exposed by Rockchip's
+ * PWMv4 hardware.
+ *
+ * This driver is chiefly focused on guaranteeing non-concurrent operation
+ * between the different device functions, as well as setting the clocks.
+ * It registers the device function platform devices, e.g. PWM output or
+ * PWM capture.
+ *
+ * Authors:
+ *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <soc/rockchip/mfpwm.h>
+
+/**
+ * struct rockchip_mfpwm - private mfpwm driver instance state struct
+ * @pdev: pointer to this instance's &struct platform_device
+ * @base: pointer to the memory mapped registers of this device
+ * @pwm_clk: pointer to the PLL clock the PWM signal may be derived from
+ * @osc_clk: pointer to the fixed crystal the PWM signal may be derived from
+ * @chosen_clk: is one of either @pwm_clk or @osc_clk, depending on choice.
+ *              May only be swapped out while holding @state_lock.
+ * @pclk: pointer to the APB bus clock needed for mmio register access
+ * @pwm_dev: pointer to the &struct platform_device of the pwm output driver
+ * @counter_dev: pointer to the &struct platform_device of the counter driver
+ * @active_func: pointer to the currently active device function, or %NULL if no
+ *              device function is currently actively using any of the shared
+ *              resources. May only be checked/modified with @state_lock held.
+ * @acquire_cnt: number of times @active_func has currently mfpwm_acquire()'d
+ *               it. Must only be checked or modified while holding @state_lock.
+ * @pwmclk_enable_cnt: number of times @active_func has enabled the pwmclk sans
+ *                     disabling it. Must only be checked or modified while
+ *                     holding @state_lock. Only exists to fix a splat on mfpwm
+ *                     driver remove.
+ * @state_lock: this lock is held while either the active device function, the
+ *              enable register, or the chosen clock is being changed.
+ * @irq: the IRQ number of this device
+ */
+struct rockchip_mfpwm {
+	struct platform_device *pdev;
+	void __iomem *base;
+	struct clk *pwm_clk;
+	struct clk *osc_clk;
+	struct clk *chosen_clk;
+	struct clk *pclk;
+	struct platform_device *pwm_dev;
+	struct platform_device *counter_dev;
+	struct rockchip_mfpwm_func *active_func;
+	unsigned int acquire_cnt;
+	unsigned int pwmclk_enable_cnt;
+	spinlock_t state_lock;
+	int irq;
+};
+
+static atomic_t subdev_id = ATOMIC_INIT(0);
+
+static inline struct rockchip_mfpwm *to_rockchip_mfpwm(struct platform_device *pdev)
+{
+	return platform_get_drvdata(pdev);
+}
+
+unsigned long mfpwm_clk_get_rate(struct rockchip_mfpwm *mfpwm)
+{
+	if (!mfpwm || !mfpwm->chosen_clk)
+		return 0;
+
+	return clk_get_rate(mfpwm->chosen_clk);
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_clk_get_rate, "ROCKCHIP_MFPWM");
+
+static int mfpwm_check_pwmf(const struct rockchip_mfpwm_func *pwmf,
+			    const char *fname)
+{
+	if (IS_ERR_OR_NULL(pwmf)) {
+		WARN(1, "called %s with an erroneous handle, no effect\n",
+		     fname);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(pwmf->parent)) {
+		WARN(1, "called %s with an erroneous mfpwm_func parent, no effect\n",
+		     fname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+__attribute__((nonnull))
+static bool mfpwm_pwmf_is_active_pwmf(const struct rockchip_mfpwm_func *pwmf)
+{
+	if (pwmf->parent->active_func) {
+		if (pwmf->parent->active_func->id == pwmf->id)
+			return true;
+	}
+
+	return false;
+}
+
+int mfpwm_pwmclk_enable(struct rockchip_mfpwm_func *pwmf)
+{
+	unsigned long flags;
+	int ret;
+
+	ret = mfpwm_check_pwmf(pwmf, "mfpwm_pwmclk_enable");
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&pwmf->parent->state_lock, flags);
+	if (mfpwm_pwmf_is_active_pwmf(pwmf)) {
+		ret = clk_enable(pwmf->parent->chosen_clk);
+		pwmf->parent->pwmclk_enable_cnt++;
+	} else {
+		ret = -EBUSY;
+	}
+
+	spin_unlock_irqrestore(&pwmf->parent->state_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_pwmclk_enable, "ROCKCHIP_MFPWM");
+
+void mfpwm_pwmclk_disable(struct rockchip_mfpwm_func *pwmf)
+{
+	unsigned long flags;
+
+	if (mfpwm_check_pwmf(pwmf, "mfpwm_pwmclk_enable"))
+		return;
+
+	spin_lock_irqsave(&pwmf->parent->state_lock, flags);
+	if (mfpwm_pwmf_is_active_pwmf(pwmf)) {
+		clk_disable(pwmf->parent->chosen_clk);
+		pwmf->parent->pwmclk_enable_cnt--;
+	}
+	spin_unlock_irqrestore(&pwmf->parent->state_lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_pwmclk_disable, "ROCKCHIP_MFPWM");
+
+__attribute__((nonnull))
+static int mfpwm_do_acquire(struct rockchip_mfpwm_func *pwmf)
+{
+	struct rockchip_mfpwm *mfpwm = pwmf->parent;
+	unsigned int cnt;
+
+	if (mfpwm->active_func && pwmf->id != mfpwm->active_func->id)
+		return -EBUSY;
+
+	if (!mfpwm->active_func)
+		mfpwm->active_func = pwmf;
+
+	if (!check_add_overflow(mfpwm->acquire_cnt, 1, &cnt)) {
+		mfpwm->acquire_cnt = cnt;
+	} else {
+		WARN(1, "prevented acquire counter overflow in %s\n", __func__);
+		return -EOVERFLOW;
+	}
+
+	dev_dbg(&mfpwm->pdev->dev, "%d acquired mfpwm, acquires now at %u\n",
+		pwmf->id, mfpwm->acquire_cnt);
+
+	return clk_enable(mfpwm->pclk);
+}
+
+int mfpwm_acquire(struct rockchip_mfpwm_func *pwmf)
+{
+	struct rockchip_mfpwm *mfpwm;
+	unsigned long flags;
+	int ret = 0;
+
+	ret = mfpwm_check_pwmf(pwmf, "mfpwm_acquire");
+	if (ret)
+		return ret;
+
+	mfpwm = pwmf->parent;
+	dev_dbg(&mfpwm->pdev->dev, "%d is attempting to acquire\n", pwmf->id);
+
+	if (!spin_trylock_irqsave(&mfpwm->state_lock, flags))
+		return -EBUSY;
+
+	ret = mfpwm_do_acquire(pwmf);
+
+	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_acquire, "ROCKCHIP_MFPWM");
+
+__attribute__((nonnull))
+static void mfpwm_do_release(const struct rockchip_mfpwm_func *pwmf)
+{
+	struct rockchip_mfpwm *mfpwm = pwmf->parent;
+
+	if (!mfpwm->active_func)
+		return;
+
+	if (mfpwm->active_func->id != pwmf->id)
+		return;
+
+	/*
+	 * No need to check_sub_overflow here, !mfpwm->active_func above catches
+	 * this type of problem already.
+	 */
+	mfpwm->acquire_cnt--;
+
+	if (!mfpwm->acquire_cnt)
+		mfpwm->active_func = NULL;
+
+	clk_disable(mfpwm->pclk);
+}
+
+void mfpwm_release(const struct rockchip_mfpwm_func *pwmf)
+{
+	struct rockchip_mfpwm *mfpwm;
+	unsigned long flags;
+
+	if (mfpwm_check_pwmf(pwmf, "mfpwm_release"))
+		return;
+
+	mfpwm = pwmf->parent;
+
+	spin_lock_irqsave(&mfpwm->state_lock, flags);
+	mfpwm_do_release(pwmf);
+	dev_dbg(&mfpwm->pdev->dev, "%d released mfpwm, acquires now at %u\n",
+		pwmf->id, mfpwm->acquire_cnt);
+	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_release, "ROCKCHIP_MFPWM");
+
+void mfpwm_remove_func(struct rockchip_mfpwm_func *pwmf)
+{
+	struct rockchip_mfpwm *mfpwm;
+	unsigned long flags;
+
+	if (mfpwm_check_pwmf(pwmf, "mfpwm_remove_func"))
+		return;
+
+	mfpwm = pwmf->parent;
+	spin_lock_irqsave(&mfpwm->state_lock, flags);
+
+	if (mfpwm_pwmf_is_active_pwmf(pwmf)) {
+		dev_dbg(&mfpwm->pdev->dev, "removing active function %d\n",
+			pwmf->id);
+
+		while (mfpwm->acquire_cnt > 0)
+			mfpwm_do_release(pwmf);
+		for (; mfpwm->pwmclk_enable_cnt > 0; mfpwm->pwmclk_enable_cnt--)
+			clk_disable(mfpwm->chosen_clk);
+
+		mfpwm_reg_write(mfpwm->base, PWMV4_REG_ENABLE,
+				PWMV4_EN(false) | PWMV4_CLK_EN(false));
+	}
+
+	if (mfpwm->pwm_dev && mfpwm->pwm_dev->id == pwmf->id) {
+		dev_dbg(&mfpwm->pdev->dev, "clearing pwm_dev pointer\n");
+		mfpwm->pwm_dev = NULL;
+	} else if (mfpwm->counter_dev && mfpwm->counter_dev->id == pwmf->id) {
+		dev_dbg(&mfpwm->pdev->dev, "clearing counter_dev pointer\n");
+		mfpwm->counter_dev = NULL;
+	} else {
+		WARN(1, "trying to remove an unknown mfpwm device function");
+	}
+
+	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(mfpwm_remove_func, "ROCKCHIP_MFPWM");
+
+/**
+ * mfpwm_register_subdev - register a single mfpwm_func
+ * @mfpwm: pointer to the parent &struct rockchip_mfpwm
+ * @target: pointer to where the &struct platform_device pointer should be
+ *          stored, usually a member of @mfpwm
+ * @name: sub-device name string
+ *
+ * Allocate a single &struct mfpwm_func, fill its members with appropriate data,
+ * and register a new platform device, saving its pointer to @target. The
+ * allocation is devres tracked, so will be automatically freed on mfpwm remove.
+ *
+ * Returns: 0 on success, negative errno on error
+ */
+static int mfpwm_register_subdev(struct rockchip_mfpwm *mfpwm,
+				 struct platform_device **target,
+				 const char *name)
+{
+	struct rockchip_mfpwm_func *func;
+	struct platform_device *child;
+
+	func = devm_kzalloc(&mfpwm->pdev->dev, sizeof(*func), GFP_KERNEL);
+	if (IS_ERR(func))
+		return PTR_ERR(func);
+	func->irq = mfpwm->irq;
+	func->parent = mfpwm;
+	func->id = atomic_inc_return(&subdev_id);
+	func->base = mfpwm->base;
+	child = platform_device_register_data(&mfpwm->pdev->dev, name, func->id,
+					      func, sizeof(*func));
+
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+
+	*target = child;
+
+	return 0;
+}
+
+static int mfpwm_register_subdevs(struct rockchip_mfpwm *mfpwm)
+{
+	int ret;
+
+	ret = mfpwm_register_subdev(mfpwm, &mfpwm->pwm_dev, "pwm-rockchip-v4");
+	if (ret)
+		return ret;
+
+	ret = mfpwm_register_subdev(mfpwm, &mfpwm->counter_dev,
+				    "rockchip-pwm-capture");
+	if (ret)
+		goto err_unreg_pwm_dev;
+
+	return 0;
+
+err_unreg_pwm_dev:
+	platform_device_unregister(mfpwm->pwm_dev);
+
+	return ret;
+}
+
+/**
+ * mfpwm_get_clk_src - read the currently selected clock source
+ * @mfpwm: pointer to the driver's private &struct rockchip_mfpwm instance
+ *
+ * Read the device register to extract the currently selected clock source,
+ * and return it.
+ *
+ * Returns:
+ * * the numeric clock source ID on success, 0 <= id <= 2
+ * * negative errno on error
+ */
+static int mfpwm_get_clk_src(struct rockchip_mfpwm *mfpwm)
+{
+	u32 val;
+
+	clk_enable(mfpwm->pclk);
+	val = mfpwm_reg_read(mfpwm->base, PWMV4_REG_CLK_CTRL);
+	clk_disable(mfpwm->pclk);
+
+	return (val & PWMV4_CLK_SRC_MASK) >> PWMV4_CLK_SRC_SHIFT;
+}
+
+static int mfpwm_choose_clk(struct rockchip_mfpwm *mfpwm)
+{
+	int ret;
+
+	ret = mfpwm_get_clk_src(mfpwm);
+	if (ret < 0) {
+		dev_err(&mfpwm->pdev->dev, "couldn't get current clock source: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+	if (ret == PWMV4_CLK_SRC_CRYSTAL) {
+		if (mfpwm->osc_clk) {
+			mfpwm->chosen_clk = mfpwm->osc_clk;
+		} else {
+			dev_warn(&mfpwm->pdev->dev, "initial state wanted 'osc' as clock source, but it's unavailable. Defaulting to 'pwm'.\n");
+			mfpwm->chosen_clk = mfpwm->pwm_clk;
+		}
+	} else {
+		mfpwm->chosen_clk = mfpwm->pwm_clk;
+	}
+
+	return clk_rate_exclusive_get(mfpwm->chosen_clk);
+}
+
+/**
+ * mfpwm_switch_clk_src - switch between PWM clock sources
+ * @mfpwm: pointer to &struct rockchip_mfpwm driver data
+ * @clk_src: one of either %PWMV4_CLK_SRC_CRYSTAL or %PWMV4_CLK_SRC_PLL
+ *
+ * Switch between clock sources, ``_exclusive_put``ing the old rate,
+ * ``clk_rate_exclusive_get``ing the new one, writing the registers and
+ * swapping out the &struct_rockchip_mfpwm->chosen_clk.
+ *
+ * Returns:
+ * * %0        - Success
+ * * %-EINVAL  - A wrong @clk_src was given or it is unavailable
+ * * %-EBUSY   - Device is currently in use, try again later
+ */
+__attribute__((nonnull))
+static int mfpwm_switch_clk_src(struct rockchip_mfpwm *mfpwm,
+					  unsigned int clk_src)
+{
+	struct clk *prev;
+	int ret = 0;
+
+	scoped_cond_guard(spinlock_try, return -EBUSY, &mfpwm->state_lock) {
+		/* Don't fiddle with any of this stuff if the PWM is on */
+		if (mfpwm->active_func)
+			return -EBUSY;
+
+		prev = mfpwm->chosen_clk;
+		ret = mfpwm_get_clk_src(mfpwm);
+		if (ret < 0)
+			return ret;
+		if (ret == clk_src)
+			return 0;
+
+		switch (clk_src) {
+		case PWMV4_CLK_SRC_PLL:
+			mfpwm->chosen_clk = mfpwm->pwm_clk;
+			break;
+		case PWMV4_CLK_SRC_CRYSTAL:
+			if (!mfpwm->osc_clk)
+				return -EINVAL;
+			mfpwm->chosen_clk = mfpwm->osc_clk;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		clk_enable(mfpwm->pclk);
+
+		mfpwm_reg_write(mfpwm->base, PWMV4_REG_CLK_CTRL,
+				PWMV4_CLK_SRC(clk_src));
+		clk_rate_exclusive_get(mfpwm->chosen_clk);
+		if (prev)
+			clk_rate_exclusive_put(prev);
+
+		clk_disable(mfpwm->pclk);
+	}
+
+	return ret;
+}
+
+static ssize_t chosen_clock_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
+	unsigned long clk_src = 0;
+
+	/*
+	 * Why the weird indirection here? I have the suspicion that if we
+	 * emitted to sysfs with the lock still held, then a nefarious program
+	 * could hog the lock by somehow forcing a full buffer condition and
+	 * then refusing to read from it. Don't know whether that's feasible
+	 * to achieve in reality, but I don't want to find out the hard way
+	 * either.
+	 */
+	scoped_guard(spinlock, &mfpwm->state_lock) {
+		if (mfpwm->chosen_clk == mfpwm->pwm_clk)
+			clk_src = PWMV4_CLK_SRC_PLL;
+		else if (mfpwm->osc_clk && mfpwm->chosen_clk == mfpwm->osc_clk)
+			clk_src = PWMV4_CLK_SRC_CRYSTAL;
+		else
+			return -ENODEV;
+	}
+
+	if (clk_src == PWMV4_CLK_SRC_PLL)
+		return sysfs_emit(buf, "pll\n");
+	else if (clk_src == PWMV4_CLK_SRC_CRYSTAL)
+		return sysfs_emit(buf, "crystal\n");
+
+	return -ENODEV;
+}
+
+static ssize_t chosen_clock_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
+	int ret;
+
+	if (sysfs_streq(buf, "pll")) {
+		ret = mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_PLL);
+		if (ret)
+			return ret;
+		return count;
+	} else if (sysfs_streq(buf, "crystal")) {
+		ret = mfpwm_switch_clk_src(mfpwm, PWMV4_CLK_SRC_CRYSTAL);
+		if (ret)
+			return ret;
+		return count;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static DEVICE_ATTR_RW(chosen_clock);
+
+static ssize_t available_clocks_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct rockchip_mfpwm *mfpwm = dev_get_drvdata(dev);
+	ssize_t size = 0;
+
+	size += sysfs_emit_at(buf, size, "pll\n");
+	if (mfpwm->osc_clk)
+		size += sysfs_emit_at(buf, size, "crystal\n");
+
+	return size;
+}
+
+static DEVICE_ATTR_RO(available_clocks);
+
+static struct attribute *mfpwm_attrs[] = {
+	&dev_attr_available_clocks.attr,
+	&dev_attr_chosen_clock.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(mfpwm);
+
+static int rockchip_mfpwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_mfpwm *mfpwm;
+	int ret = 0;
+
+	mfpwm = devm_kzalloc(&pdev->dev, sizeof(*mfpwm), GFP_KERNEL);
+	if (IS_ERR(mfpwm))
+		return PTR_ERR(mfpwm);
+
+	mfpwm->pdev = pdev;
+
+	spin_lock_init(&mfpwm->state_lock);
+
+	mfpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mfpwm->base))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->base),
+				     "failed to ioremap address\n");
+
+	mfpwm->pclk = devm_clk_get_prepared(dev, "pclk");
+	if (IS_ERR(mfpwm->pclk))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->pclk),
+				     "couldn't get and prepare 'pclk' clock\n");
+
+	mfpwm->irq = platform_get_irq(pdev, 0);
+	if (mfpwm->irq < 0)
+		return dev_err_probe(dev, mfpwm->irq, "couldn't get irq 0\n");
+
+	mfpwm->pwm_clk = devm_clk_get_prepared(dev, "pwm");
+	if (IS_ERR(mfpwm->pwm_clk))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->pwm_clk),
+				     "couldn't get and prepare 'pwm' clock\n");
+
+	mfpwm->osc_clk = devm_clk_get_optional_prepared(dev, "osc");
+	if (IS_ERR(mfpwm->osc_clk))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->osc_clk),
+				     "couldn't get and prepare 'osc' clock\n");
+
+	ret = mfpwm_choose_clk(mfpwm);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, mfpwm);
+
+	ret = mfpwm_register_subdevs(mfpwm);
+	if (ret) {
+		dev_err(dev, "failed to register sub-devices: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	return ret;
+}
+
+static void rockchip_mfpwm_remove(struct platform_device *pdev)
+{
+	struct rockchip_mfpwm *mfpwm = to_rockchip_mfpwm(pdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mfpwm->state_lock, flags);
+
+	if (mfpwm->chosen_clk)
+		clk_rate_exclusive_put(mfpwm->chosen_clk);
+
+	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
+}
+
+static const struct of_device_id rockchip_mfpwm_of_match[] = {
+	{
+		.compatible = "rockchip,rk3576-pwm",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rockchip_mfpwm_of_match);
+
+static struct platform_driver rockchip_mfpwm_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = rockchip_mfpwm_of_match,
+		.dev_groups = mfpwm_groups,
+	},
+	.probe = rockchip_mfpwm_probe,
+	.remove = rockchip_mfpwm_remove,
+};
+module_platform_driver(rockchip_mfpwm_driver);
+
+MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
+MODULE_DESCRIPTION("Rockchip MFPWM Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/rockchip/mfpwm.h b/include/soc/rockchip/mfpwm.h
new file mode 100644
index 0000000000000000000000000000000000000000..345f13f438b57159a15cb2e0ae250800fb96ed43
--- /dev/null
+++ b/include/soc/rockchip/mfpwm.h
@@ -0,0 +1,505 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *
+ * Common header file for all the Rockchip Multi-function PWM controller
+ * drivers that are spread across subsystems.
+ *
+ * Authors:
+ *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+ */
+
+#ifndef __SOC_ROCKCHIP_MFPWM_H__
+#define __SOC_ROCKCHIP_MFPWM_H__
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <soc/rockchip/utils.h>
+
+struct rockchip_mfpwm;
+
+/**
+ * struct rockchip_mfpwm_func - struct representing a single function driver
+ *
+ * @id: unique id for this function driver instance
+ * @base: pointer to start of MMIO registers
+ * @parent: a pointer to the parent mfpwm struct
+ * @irq: the shared IRQ gotten from the parent mfpwm device
+ */
+struct rockchip_mfpwm_func {
+	int id;
+	void __iomem *base;
+	struct rockchip_mfpwm *parent;
+	int irq;
+};
+
+/*
+ * PWMV4 Register Definitions
+ * --------------------------
+ *
+ * Attributes:
+ *  RW  - Read-Write
+ *  RO  - Read-Only
+ *  WO  - Write-Only
+ *  W1T - Write high, Self-clearing
+ *  W1C - Write high to clear interrupt
+ *
+ * Bit ranges to be understood with Verilog-like semantics,
+ * e.g. [03:00] is 4 bits: 0, 1, 2 and 3.
+ *
+ * All registers must be accessed with 32-bit width accesses only
+ */
+
+#define PWMV4_REG_VERSION		0x000
+/*
+ * VERSION Register Description
+ * [31:24] RO  | Hardware Major Version
+ * [23:16] RO  | Hardware Minor Version			docArrive
+ * [15:15] RO  | Reserved
+ * [14:14] RO  | Hardware supports biphasic counters
+ * [13:13] RO  | Hardware supports filters
+ * [12:12] RO  | Hardware supports waveform generation
+ * [11:11] RO  | Hardware supports counter
+ * [10:10] RO  | Hardware supports frequency metering
+ * [09:09] RO  | Hardware supports power key functionality
+ * [08:08] RO  | Hardware supports infrared transmissions
+ * [07:04] RO  | Channel index of this instance
+ * [03:00] RO  | Number of channels the base instance supports
+ */
+static inline __pure u32 pwmv4_ver_chn_num(u32 val)
+{
+	return (val & GENMASK(3, 0));
+}
+
+static inline __pure u32 pwmv4_ver_chn_idx(u32 val)
+{
+	return (val & GENMASK(7, 4)) >> 4;
+}
+
+static inline __pure u32 pwmv4_ver_major(u32 val)
+{
+	return (val & GENMASK(31, 24)) >> 24;
+}
+
+static inline __pure u32 pwmv4_ver_minor(u32 val)
+{
+	return (val & GENMASK(23, 16)) >> 16;
+}
+
+#define PWMV4_REG_ENABLE		0x004
+/*
+ * ENABLE Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:06] RO  | Reserved
+ * [05:05] RW  | PWM Channel Counter Read Enable, 1 = enabled
+ */
+#define PWMV4_CHN_CNT_RD_EN(v)		REG_UPDATE_BIT_WE((v), 5)
+/*
+ * [04:04] W1T | PWM Globally Joined Control Enable
+ *               1 = this PWM channel will be enabled by a global pwm enable
+ *               bit instead of the PWM Enable bit.
+ */
+#define PWMV4_GLOBAL_CTRL_EN(v)		REG_UPDATE_BIT_WE((v), 4)
+/*
+ * [03:03] RW  | Force Clock Enable
+ *               0 = disabled, if the PWM channel is inactive then so is the
+ *               clock prescale module
+ */
+#define PWMV4_FORCE_CLK_EN(v)		REG_UPDATE_BIT_WE((v), 3)
+/*
+ * [02:02] W1T | PWM Control Update Enable
+ *               1 = enabled, commits modifications of _CTRL, _PERIOD, _DUTY and
+ *               _OFFSET registers once 1 is written to it
+ */
+#define PWMV4_CTRL_UPDATE_EN(v)		REG_UPDATE_BIT_WE((v), 2)
+#define PWMV4_CTRL_UPDATE_EN_MASK	BIT(2)
+/*
+ * [01:01] RW  | PWM Enable, 1 = enabled
+ *               If in one-shot mode, clears after end of operation
+ */
+#define PWMV4_EN(v)			REG_UPDATE_BIT_WE((v), 1)
+#define PWMV4_EN_MASK			BIT(1)
+/*
+ * [00:00] RW  | PWM Clock Enable, 1 = enabled
+ *               If in one-shot mode, clears after end of operation
+ */
+#define PWMV4_CLK_EN(v)			REG_UPDATE_BIT_WE((v), 0)
+#define PWMV4_CLK_EN_MASK		BIT(0)
+#define PWMV4_EN_BOTH_MASK		(PWMV4_EN_MASK | PWMV4_CLK_EN_MASK)
+static inline __pure bool pwmv4_is_enabled(unsigned int val)
+{
+	return (val & PWMV4_EN_BOTH_MASK);
+}
+
+#define PWMV4_REG_CLK_CTRL		0x008
+/*
+ * CLK_CTRL Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:15] RW  | Clock Global Selection
+ *               0 = current channel scale clock
+ *               1 = global channel scale clock
+ */
+#define PWMV4_CLK_GLOBAL(v)		REG_UPDATE_BIT_WE((v), 15)
+/*
+ * [14:13] RW  | Clock Source Selection
+ *               0 = Clock from PLL, frequency can be configured
+ *               1 = Clock from crystal oscillator, frequency is fixed
+ *               2 = Clock from RC oscillator, frequency is fixed
+ *               3 = Reserved
+ *               NOTE: This reg is of questionable usefulness on RK3576, as it
+ *                     just muxes between 100m_50m_24m and 24m directly. The
+ *                     only use-case I can come up with is if you must use 100m
+ *                     or 50m PWM on one channel but absolutely require to use
+ *                     the lower rate 24m clock on another channel on the same
+ *                     chip, which doesn't seem like a realistic use case. I
+ *                     suspect that's why downstream doesn't use it.
+ */
+#define PWMV4_CLK_SRC_PLL		0x0U
+#define PWMV4_CLK_SRC_CRYSTAL		0x1U
+#define PWMV4_CLK_SRC_RC		0x2U
+#define PWMV4_CLK_SRC(v)		REG_UPDATE_WE((v), 13, 14)
+#define PWMV4_CLK_SRC_SHIFT		13
+#define PWMV4_CLK_SRC_MASK		GENMASK(14, 13)
+/*
+ * [12:04] RW  | Scale Factor to apply to pre-scaled clock
+ *               1 <= v <= 256, v means clock divided by 2*v
+ */
+#define PWMV4_CLK_SCALE_F(v)		REG_UPDATE_WE((v), 4, 12)
+/*
+ * [03:03] RO  | Reserved
+ * [02:00] RW  | Prescale Factor
+ *               v here means the input clock is divided by pow(2, v)
+ */
+#define PWMV4_CLK_PRESCALE_F(v)		REG_UPDATE_WE((v), 0, 2)
+
+#define PWMV4_REG_CTRL			0x00C
+/*
+ * CTRL Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:09] RO  | Reserved
+ * [08:06] RW  | PWM Input Channel Selection
+ *               By default, the channel selects its own input, but writing v
+ *               here selects PWM input from channel v instead.
+ */
+#define PWMV4_CTRL_IN_SEL(v)		REG_UPDATE_WE((v), 6, 8)
+/* [05:05] RW  | Aligned Mode, 0 = Valid, 1 = Invalid */
+#define PWMV4_CTRL_UNALIGNED(v)		REG_UPDATE_BIT_WE((v), 5)
+/* [04:04] RW  | Output Mode, 0 = Left Aligned, 1 = Centre Aligned */
+#define PWMV4_LEFT_ALIGNED		0x0U
+#define PWMV4_CENTRE_ALIGNED		0x1U
+#define PWMV4_CTRL_OUT_MODE(v)		REG_UPDATE_BIT_WE((v), 4)
+/*
+ * [03:03] RW  | Inactive Polarity for when the channel is either disabled or
+ *               has completed outputting the entire waveform in one-shot mode.
+ *               0 = Negative, 1 = Positive
+ */
+#define PWMV4_POLARITY_N		0x0U
+#define PWMV4_POLARITY_P		0x1U
+#define PWMV4_INACTIVE_POL(v)		REG_UPDATE_BIT_WE((v), 3)
+/*
+ * [02:02] RW  | Duty Cycle Polarity to use at the start of the waveform.
+ *               0 = Negative, 1 = Positive
+ */
+#define PWMV4_DUTY_POL(v)		REG_UPDATE_BIT_WE((v), 2)
+#define PWMV4_DUTY_POL_MASK		BIT(2)
+#define PWMV4_DUTY_POL_SHIFT		2
+/*
+ * [01:00] RW  | PWM Mode
+ *               0 = One-shot mode, PWM generates waveform RPT times
+ *               1 = Continuous mode
+ *               2 = Capture mode, PWM measures cycles of input waveform
+ *               3 = Reserved
+ */
+#define PWMV4_MODE_ONESHOT		0x0U
+#define PWMV4_MODE_CONT			0x1U
+#define PWMV4_MODE_CAPTURE		0x2U
+#define PWMV4_MODE(v)			REG_UPDATE_WE((v), 0, 1)
+#define PWMV4_CTRL_COM_FLAGS	(PWMV4_INACTIVE_POL(PWMV4_POLARITY_N) | \
+				 PWMV4_DUTY_POL(PWMV4_POLARITY_P) | \
+				 PWMV4_CTRL_OUT_MODE(PWMV4_LEFT_ALIGNED) | \
+				 PWMV4_CTRL_UNALIGNED(true))
+#define PWMV4_CTRL_CONT_FLAGS	(PWMV4_MODE(PWMV4_MODE_CONT) | \
+				 PWMV4_CTRL_COM_FLAGS)
+#define PWMV4_CTRL_CAP_FLAGS	(PWMV4_MODE(PWMV4_MODE_CAPTURE) | \
+				 PWMV4_CTRL_COM_FLAGS)
+
+#define PWMV4_REG_PERIOD		0x010
+/*
+ * PERIOD Register Description
+ * [31:00] RW  | Period of the output waveform
+ *               Constraints: should be even if CTRL_OUT_MODE is CENTRE_ALIGNED
+ */
+
+#define PWMV4_REG_DUTY			0x014
+/*
+ * DUTY Register Description
+ * [31:00] RW  | Duty cycle of the output waveform
+ *               Constraints: should be even if CTRL_OUT_MODE is CENTRE_ALIGNED
+ */
+
+#define PWMV4_REG_OFFSET		0x018
+/*
+ * OFFSET Register Description
+ * [31:00] RW  | Offset of the output waveform, based on the PWM clock
+ *               Constraints: 0 <= v <= (PERIOD - DUTY)
+ */
+
+#define PWMV4_REG_RPT			0x01C
+/*
+ * RPT Register Description
+ * [31:16] RW  | Second dimensional of the effective number of waveform
+ *               repetitions. Increases by one every first dimensional times.
+ *               Value `n` means `n + 1` repetitions. The final number of
+ *               repetitions of the waveform in one-shot mode is:
+ *               `(first_dimensional + 1) * (second_dimensional + 1)`
+ * [15:00] RW  | First dimensional of the effective number of waveform
+ *               repetitions. Value `n` means `n + 1` repetitions.
+ */
+
+#define PWMV4_REG_FILTER_CTRL		0x020
+/*
+ * FILTER_CTRL Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:10] RO  | Reserved
+ * [09:04] RW  | Filter window number
+ * [03:01] RO  | Reserved
+ * [00:00] RW  | Filter Enable, 0 = disabled, 1 = enabled
+ */
+
+#define PWMV4_REG_CNT			0x024
+/*
+ * CNT Register Description
+ * [31:00] RO  | Current value of the PWM Channel 0 counter in pwm clock cycles,
+ *               0 <= v <= 2^32-1
+ */
+
+#define PWMV4_REG_ENABLE_DELAY		0x028
+/*
+ * ENABLE_DELAY Register Description
+ * [31:16] RO  | Reserved
+ * [15:00] RW  | PWM enable delay, in an unknown unit but probably cycles
+ */
+
+#define PWMV4_REG_HPC			0x02C
+/*
+ * HPC Register Description
+ * [31:00] RW  | Number of effective high polarity cycles of the input waveform
+ *               in capture mode. Based on the PWM clock. 0 <= v <= 2^32-1
+ */
+
+#define PWMV4_REG_LPC			0x030
+/*
+ * LPC Register Description
+ * [31:00] RW  | Number of effective low polarity cycles of the input waveform
+ *               in capture mode. Based on the PWM clock. 0 <= v <= 2^32-1
+ */
+
+#define PWMV4_REG_BIPHASIC_CNT_CTRL0	0x040
+/*
+ * BIPHASIC_CNT_CTRL0 Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:10] RO  | Reserved
+ * [09:09] RW  | Biphasic Counter Phase Edge Selection for mode 0,
+ *               0 = rising edge (posedge), 1 = falling edge (negedge)
+ * [08:08] RW  | Biphasic Counter Clock force enable, 1 = force enable
+ * [07:07] W1T | Synchronous Enable
+ * [06:06] W1T | Mode Switch
+ *               0 = Normal Mode, 1 = Switch timer clock and measured clock
+ *               Constraints: "Biphasic Counter Mode" must be 0 if this is 1
+ * [05:03] RW  | Biphasic Counter Mode
+ *               0x0 = Mode 0, 0x1 = Mode 1, 0x2 = Mode 2, 0x3 = Mode 3,
+ *               0x4 = Mode 4, 0x5 = Reserved
+ * [02:02] RW  | Biphasic Counter Clock Selection
+ *               0 = clock is from PLL and frequency can be configured
+ *               1 = clock is from crystal oscillator and frequency is fixed
+ * [01:01] RW  | Biphasic Counter Continuous Mode
+ * [00:00] W1T | Biphasic Counter Enable
+ */
+
+#define PWMV4_REG_BIPHASIC_CNT_CTRL1	0x044
+/*
+ * BIPHASIC_CNT_CTRL1 Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:11] RO  | Reserved
+ * [10:04] RW  | Biphasic Counter Filter Window Number
+ * [03:01] RO  | Reserved
+ * [00:00] RW  | Biphasic Counter Filter Enable
+ */
+
+#define PWMV4_REG_BIPHASIC_CNT_TIMER	0x048
+/*
+ * BIPHASIC_CNT_TIMER Register Description
+ * [31:00] RW  | Biphasic Counter Timer Value, in number of biphasic counter
+ *               timer clock cycles
+ */
+
+#define PWMV4_REG_BIPHASIC_CNT_RES	0x04C
+/*
+ * BIPHASIC_CNT_RES Register Description
+ * [31:00] RO  | Biphasic Counter Result Value
+ *               Constraints: Can only be read after INTSTS[9] is asserted
+ */
+
+#define PWMV4_REG_BIPHASIC_CNT_RES_S	0x050
+/*
+ * BIPHASIC_CNT_RES_S Register Description
+ * [31:00] RO  | Biphasic Counter Result Value with synchronised processing
+ *               Can be read in real-time if BIPHASIC_CNT_CTRL0[7] was set to 1
+ */
+
+#define PWMV4_REG_INTSTS		0x070
+/*
+ * INTSTS Register Description
+ * [31:10] RO  | Reserved
+ * [09:09] W1C | Biphasic Counter Interrupt Status, 1 = interrupt asserted
+ * [08:08] W1C | Waveform Middle Interrupt Status, 1 = interrupt asserted
+ * [07:07] W1C | Waveform Max Interrupt Status, 1 = interrupt asserted
+ * [06:06] W1C | IR Transmission End Interrupt Status, 1 = interrupt asserted
+ * [05:05] W1C | Power Key Match Interrupt Status, 1 = interrupt asserted
+ * [04:04] W1C | Frequency Meter Interrupt Status, 1 = interrupt asserted
+ * [03:03] W1C | Reload Interrupt Status, 1 = interrupt asserted
+ * [02:02] W1C | Oneshot End Interrupt Status, 1 = interrupt asserted
+ * [01:01] W1C | HPC Capture Interrupt Status, 1 = interrupt asserted
+ * [00:00] W1C | LPC Capture Interrupt Status, 1 = interrupt asserted
+ */
+#define PWMV4_INT_LPC			BIT(0)
+#define PWMV4_INT_HPC			BIT(1)
+#define PWMV4_INT_LPC_W(v)		REG_UPDATE_BIT_WE(((v) ? 1 : 0), 0)
+#define PWMV4_INT_HPC_W(v)		REG_UPDATE_BIT_WE(((v) ? 1 : 0), 1)
+
+#define PWMV4_REG_INT_EN		0x074
+/*
+ * INT_EN Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:10] RO  | Reserved
+ * [09:09] RW  | Biphasic Counter Interrupt Enable, 1 = enabled
+ * [08:08] W1C | Waveform Middle Interrupt Enable, 1 = enabled
+ * [07:07] W1C | Waveform Max Interrupt Enable, 1 = enabled
+ * [06:06] W1C | IR Transmission End Interrupt Enable, 1 = enabled
+ * [05:05] W1C | Power Key Match Interrupt Enable, 1 = enabled
+ * [04:04] W1C | Frequency Meter Interrupt Enable, 1 = enabled
+ * [03:03] W1C | Reload Interrupt Enable, 1 = enabled
+ * [02:02] W1C | Oneshot End Interrupt Enable, 1 = enabled
+ * [01:01] W1C | HPC Capture Interrupt Enable, 1 = enabled
+ * [00:00] W1C | LPC Capture Interrupt Enable, 1 = enabled
+ */
+
+#define PWMV4_REG_INT_MASK		0x078
+/*
+ * INT_MASK Register Description
+ * [31:16] WO  | Write Enable Mask for the lower half of the register
+ *               Set bit `n` here to 1 if you wish to modify bit `n >> 16` in
+ *               the same write operation
+ * [15:10] RO  | Reserved
+ * [09:09] RW  | Biphasic Counter Interrupt Masked, 1 = masked
+ * [08:08] W1C | Waveform Middle Interrupt Masked, 1 = masked
+ * [07:07] W1C | Waveform Max Interrupt Masked, 1 = masked
+ * [06:06] W1C | IR Transmission End Interrupt Masked, 1 = masked
+ * [05:05] W1C | Power Key Match Interrupt Masked, 1 = masked
+ * [04:04] W1C | Frequency Meter Interrupt Masked, 1 = masked
+ * [03:03] W1C | Reload Interrupt Masked, 1 = masked
+ * [02:02] W1C | Oneshot End Interrupt Masked, 1 = masked
+ * [01:01] W1C | HPC Capture Interrupt Masked, 1 = masked
+ * [00:00] W1C | LPC Capture Interrupt Masked, 1 = masked
+ */
+
+inline u32 mfpwm_reg_read(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
+inline void mfpwm_reg_write(void __iomem *base, u32 reg, u32 val)
+{
+	writel(val, base + reg);
+}
+
+/**
+ * mfpwm_clk_get_rate - get the currently used clock's rate, in Hz
+ * @mfpwm: pointer to the &struct rockchip_mfpwm instance
+ *
+ * Returns: %0 on error, clock rate in Hz on success
+ */
+unsigned long mfpwm_clk_get_rate(struct rockchip_mfpwm *mfpwm);
+
+/**
+ * mfpwm_acquire - try becoming the active mfpwm function device
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * mfpwm device "function" drivers must call this function before doing anything
+ * that either modifies or relies on the parent device's state, such as clocks,
+ * enabling/disabling outputs, modifying shared regs etc.
+ *
+ * The return statues should always be checked.
+ *
+ * All mfpwm_acquire() calls must be balanced with corresponding mfpwm_release()
+ * calls once the device is no longer making changes that affect other devices,
+ * or stops producing user-visible effects that depend on the current device
+ * state being kept as-is. (e.g. after the PWM output signal is stopped)
+ *
+ * The same device function may mfpwm_acquire() multiple times while it already
+ * is active, i.e. it is re-entrant, though it needs to balance this with the
+ * same number of mfpwm_release() calls.
+ *
+ * Context: This function does not sleep.
+ *
+ * Return:
+ * * %0                 - success
+ * * %-EBUSY            - a different device function is active
+ * * %-EOVERFLOW        - the acquire counter is at its maximum
+ */
+int __must_check mfpwm_acquire(struct rockchip_mfpwm_func *pwmf);
+
+/**
+ * mfpwm_release - drop usage of active mfpwm device function by 1
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * This is the balancing call to mfpwm_acquire(). If no users of the device
+ * function remain, set the mfpwm device to have no active device function,
+ * allowing other device functions to claim it.
+ */
+void mfpwm_release(const struct rockchip_mfpwm_func *pwmf);
+
+/**
+ * mfpwm_pwmclk_enable - enable the pwm clock the signal and timing is based on
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * Context: must be the active device function to call this
+ *
+ * Returns: 0 on success, negative errno on error.
+ */
+int mfpwm_pwmclk_enable(struct rockchip_mfpwm_func *pwmf);
+
+/**
+ * mfpwm_pwmclk_disable - disable the pwm clock the signal and timing is based on
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * Context: must be the active device function to call this
+ */
+void mfpwm_pwmclk_disable(struct rockchip_mfpwm_func *pwmf);
+
+/**
+ * mfpwm_remove_func - remove a device function driver from the mfpwm
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * If the device function driver described by @pwmf is the currently active
+ * device function, then it'll have its mfpwm_acquires and its pwmclk_enables
+ * balanced and be removed as the active device function driver.
+ */
+void mfpwm_remove_func(struct rockchip_mfpwm_func *pwmf);
+
+#endif /* __SOC_ROCKCHIP_MFPWM_H__ */

-- 
2.49.0



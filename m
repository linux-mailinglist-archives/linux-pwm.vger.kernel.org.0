Return-Path: <linux-pwm+bounces-7497-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1EC0F96C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730D2425AB8
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199A316190;
	Mon, 27 Oct 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HtXtJx9q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1464315D2A;
	Mon, 27 Oct 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585275; cv=pass; b=Osmsi8IKWug0EB4NW0ykwVdy3UxlW4MYn2AzHCPKa9jhP13PQfBPYsG2ICDrDQ/oItLCvzNR9zXA3aBqGfxE9H2yveZO22dx+bbZ0/BqCkja8eHLOVk4116fzUAYkL9wGDI7QwwJ34CwXDwx4viY6eKJ8asO8E5t6OMuPSQfHXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585275; c=relaxed/simple;
	bh=7rRPEjuwdg7Pv8NZfTlPDMpm6mMbwG5C8ojSid9v0Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ay4Q1VeyB1KccXaw+w2YxHzblWa/FfzOnGy83xM+6/YruHktflqBKOddw2Z8RSdrFkl4qLMpmzyZwi8bAr0f80qls0CAPnbkv6cKYpz1U8q0ovKUNQCU6WFkx41i3MyAICWvk0jvGVBZyoeIzqcLI2+dJEeoza7bi32vgQph520=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HtXtJx9q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Va+pTORXouUNecI4uLcKNqPIggPvSOK8/R9dxkhA8xLd1nB1vGGEoyGbNWOI5nQy6Rk9X+ABnWD95dDr1+AOtvWI8ZSJiPu8nCj1Pz23PTQTZfNAflphreG29NU6vHlomo1uytiXjaO9IGTwsGSjeIMSLyTAlgDvpkXmARMby3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585249; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NarRBoylhbPGxx+N1aPGbGQI8yC1tomNn2/zhbcMBUI=; 
	b=iXxc8GzSrlGrUHnAgiToWcONQ12ZHoSeWnVh6bPXYVKx39fJHdehwBS5rNvEbVaqN2Fav1fbiZ3SDluMhqEuNUanvs97mbQF5QDo7/ppmc/Usm3MjmubLNRWHdg9pYBY91hLCRbaPQvBGqYBoNRz09EFPWjr+gjjN/bLw2VShYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585249;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NarRBoylhbPGxx+N1aPGbGQI8yC1tomNn2/zhbcMBUI=;
	b=HtXtJx9qtO8su+JVKYTGu8Cu5L+Hxlm3+78nVLUetEzumArFJoGy8R7sUOj6RqmV
	C+Xg0LoKUlA6WRxYdPF4TQDz/8EolfUwQsYebDXZXZRhMZVxGcq0xwPckrqyZtyK0SO
	vgOH07ebunIsf3gb32PW6hH2GJYVkuoR9VbLEOxU=
Received: by mx.zohomail.com with SMTPS id 1761585247322138.72995644389403;
	Mon, 27 Oct 2025 10:14:07 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 27 Oct 2025 18:11:57 +0100
Subject: [PATCH v3 2/5] mfd: Add Rockchip mfpwm driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-rk3576-pwm-v3-2-654a5cb1e3f8@collabora.com>
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

For this reason, we add a new MFD core driver, called mfpwm (short for
"Multi-function PWM"). This "parent" driver makes sure that only one
device function driver is using the device at a time, and is in charge
of registering the MFD cell devices for the individual device functions
offered by the device.

An acquire/release pattern is used to guarantee that device function
drivers don't step on each other's toes.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS                        |   2 +
 drivers/mfd/Kconfig                |  15 ++
 drivers/mfd/Makefile               |   1 +
 drivers/mfd/rockchip-mfpwm.c       | 340 +++++++++++++++++++++++++++
 include/linux/mfd/rockchip-mfpwm.h | 454 +++++++++++++++++++++++++++++++++++++
 5 files changed, 812 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baecabab35a2..8f3235ba825e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22372,6 +22372,8 @@ L:	linux-rockchip@lists.infradead.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+F:	drivers/soc/rockchip/mfpwm.c
+F:	include/soc/rockchip/mfpwm.h
 
 ROCKCHIP RK3568 RANDOM NUMBER GENERATOR SUPPORT
 M:	Daniel Golle <daniel@makrotopia.org>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index dbeac6825a10..8b3a3160fbdf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1367,6 +1367,21 @@ config MFD_RC5T583
 	  Additional drivers must be enabled in order to use the
 	  different functionality of the device.
 
+config MFD_ROCKCHIP_MFPWM
+	tristate "Rockchip multi-function PWM controller"
+	depends on OF
+	depends on HAS_IOMEM
+	depends on COMMON_CLK
+	select MFD_CORE
+	help
+	  Some Rockchip SoCs, such as the RK3576, use a PWM controller that has
+	  several different functions, such as generating PWM waveforms but also
+	  counting waveforms.
+
+	  This driver manages the overall device, and selects between different
+	  functionalities at runtime as needed. Drivers for them are implemented
+	  in their respective subsystems.
+
 config MFD_RK8XX
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e75e8045c28a..ebadbaea9e4a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -231,6 +231,7 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
+obj-$(CONFIG_MFD_ROCKCHIP_MFPWM)	+= rockchip-mfpwm.o
 obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
 obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
diff --git a/drivers/mfd/rockchip-mfpwm.c b/drivers/mfd/rockchip-mfpwm.c
new file mode 100644
index 000000000000..08c2d8da41b7
--- /dev/null
+++ b/drivers/mfd/rockchip-mfpwm.c
@@ -0,0 +1,340 @@
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
+#include <linux/array_size.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/rockchip-mfpwm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/**
+ * struct rockchip_mfpwm - private mfpwm driver instance state struct
+ * @pdev: pointer to this instance's &struct platform_device
+ * @base: pointer to the memory mapped registers of this device
+ * @pwm_clk: pointer to the PLL clock the PWM signal may be derived from
+ * @osc_clk: pointer to the fixed crystal the PWM signal may be derived from
+ * @rc_clk: pointer to the RC oscillator the PWM signal may be derived from
+ * @chosen_clk: a clk-mux of pwm_clk, osc_clk and rc_clk
+ * @pclk: pointer to the APB bus clock needed for mmio register access
+ * @active_func: pointer to the currently active device function, or %NULL if no
+ *               device function is currently actively using any of the shared
+ *               resources. May only be checked/modified with @state_lock held.
+ * @acquire_cnt: number of times @active_func has currently mfpwm_acquire()'d
+ *               it. Must only be checked or modified while holding @state_lock.
+ * @state_lock: this lock is held while either the active device function, the
+ *              enable register, or the chosen clock is being changed.
+ * @irq: the IRQ number of this device
+ */
+struct rockchip_mfpwm {
+	struct platform_device *pdev;
+	void __iomem *base;
+	struct clk *pwm_clk;
+	struct clk *osc_clk;
+	struct clk *rc_clk;
+	struct clk *chosen_clk;
+	struct clk *pclk;
+	struct rockchip_mfpwm_func *active_func;
+	unsigned int acquire_cnt;
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
+static int mfpwm_check_pwmf(const struct rockchip_mfpwm_func *pwmf,
+			    const char *fname)
+{
+	struct device *dev = &pwmf->parent->pdev->dev;
+
+	if (IS_ERR_OR_NULL(pwmf)) {
+		dev_warn(dev, "called %s with an erroneous handle, no effect\n",
+			 fname);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(pwmf->parent)) {
+		dev_warn(dev, "called %s with an erroneous mfpwm_func parent, no effect\n",
+			 fname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
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
+		dev_warn(&mfpwm->pdev->dev, "prevented acquire counter overflow in %s\n",
+			 __func__);
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
+/**
+ * mfpwm_register_subdev - register a single mfpwm_func
+ * @mfpwm: pointer to the parent &struct rockchip_mfpwm
+ * @name: sub-device name string
+ *
+ * Allocate a single &struct mfpwm_func, fill its members with appropriate data,
+ * and register a new mfd cell.
+ *
+ * Returns: 0 on success, negative errno on error
+ */
+static int mfpwm_register_subdev(struct rockchip_mfpwm *mfpwm,
+				 const char *name)
+{
+	struct rockchip_mfpwm_func *func;
+	struct mfd_cell cell = {};
+
+	func = devm_kzalloc(&mfpwm->pdev->dev, sizeof(*func), GFP_KERNEL);
+	if (IS_ERR(func))
+		return PTR_ERR(func);
+	func->irq = mfpwm->irq;
+	func->parent = mfpwm;
+	func->id = atomic_inc_return(&subdev_id);
+	func->base = mfpwm->base;
+	func->core = mfpwm->chosen_clk;
+	cell.name = name;
+	cell.platform_data = func;
+	cell.pdata_size = sizeof(*func);
+	// cell.ignore_resource_conflicts = true;
+	// cell.resources = mfpwm->pdev->resource;
+	// cell.num_resources = mfpwm->pdev->num_resources;
+
+	return devm_mfd_add_devices(&mfpwm->pdev->dev, func->id, &cell, 1, NULL,
+				    0, NULL);
+}
+
+static int mfpwm_register_subdevs(struct rockchip_mfpwm *mfpwm)
+{
+	int ret;
+
+	ret = mfpwm_register_subdev(mfpwm, "pwm-rockchip-v4");
+	if (ret)
+		return ret;
+
+	ret = mfpwm_register_subdev(mfpwm, "rockchip-pwm-capture");
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_mfpwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_mfpwm *mfpwm;
+	char *clk_mux_name;
+	const char *mux_p_names[3];
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
+	mfpwm->osc_clk = devm_clk_get_prepared(dev, "osc");
+	if (IS_ERR(mfpwm->osc_clk))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->osc_clk),
+				     "couldn't get and prepare 'osc' clock\n");
+
+	mfpwm->rc_clk = devm_clk_get_prepared(dev, "rc");
+	if (IS_ERR(mfpwm->rc_clk))
+		return dev_err_probe(dev, PTR_ERR(mfpwm->rc_clk),
+				     "couldn't get and prepare 'rc' clock\n");
+
+	clk_mux_name = devm_kasprintf(dev, GFP_KERNEL, "%s_chosen", dev_name(dev));
+	if (!clk_mux_name)
+		return -ENOMEM;
+
+	mux_p_names[0] = __clk_get_name(mfpwm->pwm_clk);
+	mux_p_names[1] = __clk_get_name(mfpwm->osc_clk);
+	mux_p_names[2] = __clk_get_name(mfpwm->rc_clk);
+	mfpwm->chosen_clk = clk_register_mux(dev, clk_mux_name, mux_p_names,
+					     ARRAY_SIZE(mux_p_names),
+					     CLK_SET_RATE_PARENT,
+					     mfpwm->base + PWMV4_REG_CLK_CTRL,
+					     PWMV4_CLK_SRC_SHIFT, PWMV4_CLK_SRC_WIDTH,
+					     CLK_MUX_HIWORD_MASK, NULL);
+	ret = clk_prepare(mfpwm->chosen_clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare PWM clock mux: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
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
+	if (mfpwm->chosen_clk) {
+		clk_unprepare(mfpwm->chosen_clk);
+		clk_unregister_mux(mfpwm->chosen_clk);
+	}
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
+	},
+	.probe = rockchip_mfpwm_probe,
+	.remove = rockchip_mfpwm_remove,
+};
+module_platform_driver(rockchip_mfpwm_driver);
+
+MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
+MODULE_DESCRIPTION("Rockchip MFPWM Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rockchip-mfpwm.h b/include/linux/mfd/rockchip-mfpwm.h
new file mode 100644
index 000000000000..78d9c3396f7e
--- /dev/null
+++ b/include/linux/mfd/rockchip-mfpwm.h
@@ -0,0 +1,454 @@
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
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/hw_bitfield.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
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
+ * @core: a pointer to the clk mux that drives this channel's PWM
+ */
+struct rockchip_mfpwm_func {
+	int id;
+	void __iomem *base;
+	struct rockchip_mfpwm *parent;
+	int irq;
+	struct clk *core;
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
+ * [23:16] RO  | Hardware Minor Version
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
+#define PWMV4_CHN_CNT_RD_EN(v)		FIELD_PREP_WM16(BIT(5), (v))
+/*
+ * [04:04] W1T | PWM Globally Joined Control Enable
+ *               1 = this PWM channel will be enabled by a global pwm enable
+ *               bit instead of the PWM Enable bit.
+ */
+#define PWMV4_GLOBAL_CTRL_EN(v)		FIELD_PREP_WM16(BIT(4), (v))
+/*
+ * [03:03] RW  | Force Clock Enable
+ *               0 = disabled, if the PWM channel is inactive then so is the
+ *               clock prescale module
+ */
+#define PWMV4_FORCE_CLK_EN(v)		FIELD_PREP_WM16(BIT(3), (v))
+/*
+ * [02:02] W1T | PWM Control Update Enable
+ *               1 = enabled, commits modifications of _CTRL, _PERIOD, _DUTY and
+ *               _OFFSET registers once 1 is written to it
+ */
+#define PWMV4_CTRL_UPDATE_EN		FIELD_PREP_WM16_CONST(BIT(2), 1)
+/*
+ * [01:01] RW  | PWM Enable, 1 = enabled
+ *               If in one-shot mode, clears after end of operation
+ */
+#define PWMV4_EN_MASK			BIT(1)
+#define PWMV4_EN(v)			FIELD_PREP_WM16(PWMV4_EN_MASK, \
+							((v) ? 1 : 0))
+/*
+ * [00:00] RW  | PWM Clock Enable, 1 = enabled
+ *               If in one-shot mode, clears after end of operation
+ */
+#define PWMV4_CLK_EN_MASK		BIT(0)
+#define PWMV4_CLK_EN(v)			FIELD_PREP_WM16(PWMV4_CLK_EN_MASK, \
+							((v) ? 1 : 0))
+#define PWMV4_EN_BOTH_MASK		(PWMV4_EN_MASK | PWMV4_CLK_EN_MASK)
+static inline __pure bool rockchip_pwm_v4_is_enabled(unsigned int val)
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
+#define PWMV4_CLK_GLOBAL(v)		FIELD_PREP_WM16(BIT(15), (v))
+/*
+ * [14:13] RW  | Clock Source Selection
+ *               0 = Clock from PLL, frequency can be configured
+ *               1 = Clock from crystal oscillator, frequency is fixed
+ *               2 = Clock from RC oscillator, frequency is fixed
+ *               3 = Reserved
+ *               NOTE: The purpose for this clock-mux-outside-CRU construct is
+ *                     to let the SoC go into a sleep state with the PWM
+ *                     hardware still having a clock signal for IR input, which
+ *                     can then wake up the SoC.
+ */
+#define PWMV4_CLK_SRC_PLL		0x0U
+#define PWMV4_CLK_SRC_CRYSTAL		0x1U
+#define PWMV4_CLK_SRC_RC		0x2U
+#define PWMV4_CLK_SRC_SHIFT		13
+#define PWMV4_CLK_SRC_WIDTH		2
+/*
+ * [12:04] RW  | Scale Factor to apply to pre-scaled clock
+ *               1 <= v <= 256, v means clock divided by 2*v
+ */
+#define PWMV4_CLK_SCALE_F(v)		FIELD_PREP_WM16(GENMASK(12, 4), (v))
+/*
+ * [03:03] RO  | Reserved
+ * [02:00] RW  | Prescale Factor
+ *               v here means the input clock is divided by pow(2, v)
+ */
+#define PWMV4_CLK_PRESCALE_F(v)		FIELD_PREP_WM16(GENMASK(2, 0), (v))
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
+#define PWMV4_CTRL_IN_SEL(v)		FIELD_PREP_WM16(GENMASK(8, 6), (v))
+/* [05:05] RW  | Aligned Mode, 0 = Valid, 1 = Invalid */
+#define PWMV4_CTRL_UNALIGNED(v)		FIELD_PREP_WM16(BIT(5), (v))
+/* [04:04] RW  | Output Mode, 0 = Left Aligned, 1 = Centre Aligned */
+#define PWMV4_LEFT_ALIGNED		0x0U
+#define PWMV4_CENTRE_ALIGNED		0x1U
+#define PWMV4_CTRL_OUT_MODE(v)		FIELD_PREP_WM16(BIT(4), (v))
+/*
+ * [03:03] RW  | Inactive Polarity for when the channel is either disabled or
+ *               has completed outputting the entire waveform in one-shot mode.
+ *               0 = Negative, 1 = Positive
+ */
+#define PWMV4_POLARITY_N		0x0U
+#define PWMV4_POLARITY_P		0x1U
+#define PWMV4_INACTIVE_POL(v)		FIELD_PREP_WM16(BIT(3), (v))
+/*
+ * [02:02] RW  | Duty Cycle Polarity to use at the start of the waveform.
+ *               0 = Negative, 1 = Positive
+ */
+#define PWMV4_DUTY_POL_SHIFT		2
+#define PWMV4_DUTY_POL_MASK		BIT(PWMV4_DUTY_POL_SHIFT)
+#define PWMV4_DUTY_POL(v)		FIELD_PREP_WM16(PWMV4_DUTY_POL_MASK, \
+							(v))
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
+#define PWMV4_MODE_MASK			GENMASK(1, 0)
+#define PWMV4_MODE(v)			FIELD_PREP_WM16(PWMV4_MODE_MASK, (v))
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
+#define PWMV4_INT_LPC_W(v)		FIELD_PREP_WM16(PWMV4_INT_LPC, \
+							((v) ? 1 : 0))
+#define PWMV4_INT_HPC_W(v)		FIELD_PREP_WM16(PWMV4_INT_HPC, \
+							((v) ? 1 : 0))
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
+static inline u32 mfpwm_reg_read(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
+static inline void mfpwm_reg_write(void __iomem *base, u32 reg, u32 val)
+{
+	writel(val, base + reg);
+}
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
+extern int __must_check mfpwm_acquire(struct rockchip_mfpwm_func *pwmf);
+
+/**
+ * mfpwm_release - drop usage of active mfpwm device function by 1
+ * @pwmf: pointer to the calling driver instance's &struct rockchip_mfpwm_func
+ *
+ * This is the balancing call to mfpwm_acquire(). If no users of the device
+ * function remain, set the mfpwm device to have no active device function,
+ * allowing other device functions to claim it.
+ */
+extern void mfpwm_release(const struct rockchip_mfpwm_func *pwmf);
+
+#endif /* __SOC_ROCKCHIP_MFPWM_H__ */

-- 
2.51.1



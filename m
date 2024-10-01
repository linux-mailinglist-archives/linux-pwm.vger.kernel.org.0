Return-Path: <linux-pwm+bounces-3419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E303E98C471
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5199EB221A1
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E201CBEA6;
	Tue,  1 Oct 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQpZ0agO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979071B5336;
	Tue,  1 Oct 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803815; cv=none; b=V1syLJoGeov8nDOYRvfrlTFuIR8Yc6gx2J15AFAeqRTJTdjGBGX6AY41YuHZ/sDZPsDLXXqUz3Zmd9FH6Sznd1hvZSs5hNwCoRQfLY+a02U094N5zVPOtk3uqNizdWPauWTtMts+FLjP3bUADuAomWzcRrzt8zPuEn8UxEKJDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803815; c=relaxed/simple;
	bh=yoKJWk9Jn019pIaaHdwuMgnjCdikmtxOvwtZDp+9ezQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyONmFoTGPDZmKwExl3PkLPmda6nafKIGlGAevnO5WjFRK2BMGv4jqR3gGF2d8x3PDMdxyahoLTE86tgT5B8FX+/sHLzShignq9aZi2wCYTbWbIxvS66pDkSYicLUCuOeBp/iVFmvk6VZo0CDZMXznaDLcHWAKLFkU9IiTEHCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQpZ0agO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21393C4CEC7;
	Tue,  1 Oct 2024 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727803815;
	bh=yoKJWk9Jn019pIaaHdwuMgnjCdikmtxOvwtZDp+9ezQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQpZ0agO/Jkd+bo4j8O1BVpHpAOsrZ/8PdfVqJmnXaq+mobmn7rOXazrihorJDNlD
	 NfK7njERCt/6Yh/dkYi/5X26B6pTD4TpEc3+BX7n73ai7AxzJMEqDMAC1RzaT2F6R1
	 hXQaEOZ3QA80ugc5IEolRSGqYCVC7f5qPoQuwzkU1UQ5BlNH8oMCKUpiTeJVUCYXvA
	 cTRnsG6UMtf+dP+3Ix762DSTS98PBS9nj/EuLRNHqisZ3TiRG1JFPwJVdv5NKE1tG7
	 2Bf2b+taJN0bpZELVEOkiBQk20PZdyc0zFFunwqZkEfi7RogJnBuLqPX00SwZ49Too
	 qMOwbgd+/LSqA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Oct 2024 19:29:32 +0200
Subject: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
In-Reply-To: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.1

From: Christian Marangi <ansuelsmth@gmail.com>

Support for Airoha EN7581 Multi Function Device that
expose PINCTRL functionality and PWM functionality.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mfd/Kconfig                   |  8 ++++
 drivers/mfd/Makefile                  |  2 +
 drivers/mfd/airoha-en7581-gpio-mfd.c  | 72 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/airoha-en7581-mfd.h |  9 +++++
 4 files changed, 91 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f9325bcce1b9..eca221351ab7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -32,6 +32,14 @@ config MFD_ADP5585
 	  the core APIs _only_, you have to select individual components like
 	  the GPIO and PWM functions under the corresponding menus.
 
+config MFD_AIROHA_EN7581
+	bool "Airoha EN7581 Multi Function Device"
+	depends on (ARCH_AIROHA || COMPILE_TEST) && OF
+	select MFD_CORE
+	help
+	  Support for Airoha EN7581 Multi Function Device that
+	  expose PINCTRL functionality and PWM functionality.
+
 config MFD_ALTERA_A10SR
 	bool "Altera Arria10 DevKit System Resource chip"
 	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=y && OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2a9f91e81af8..be8448e81a5b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -257,6 +257,8 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
 
+obj-$(CONFIG_MFD_AIROHA_EN7581)	+= airoha-en7581-gpio-mfd.o
+
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
diff --git a/drivers/mfd/airoha-en7581-gpio-mfd.c b/drivers/mfd/airoha-en7581-gpio-mfd.c
new file mode 100644
index 000000000000..88407ce5747e
--- /dev/null
+++ b/drivers/mfd/airoha-en7581-gpio-mfd.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD driver for Airoha EN7581
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/mfd/airoha-en7581-mfd.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+
+static struct resource airoha_mfd_pinctrl_intr[] = {
+	{
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static const struct mfd_cell airoha_mfd_devs[] = {
+	{
+		.name = "pinctrl-airoha",
+		.resources = airoha_mfd_pinctrl_intr,
+		.num_resources = ARRAY_SIZE(airoha_mfd_pinctrl_intr),
+	}, {
+		.name = "pwm-airoha",
+	},
+};
+
+static int airoha_mfd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_mfd *mfd;
+	int irq;
+
+	mfd = devm_kzalloc(dev, sizeof(*mfd), GFP_KERNEL);
+	if (!mfd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mfd);
+
+	mfd->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mfd->base))
+		return PTR_ERR(mfd->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	airoha_mfd_pinctrl_intr[0].start = irq;
+	airoha_mfd_pinctrl_intr[0].end = irq;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, airoha_mfd_devs,
+				    ARRAY_SIZE(airoha_mfd_devs), NULL, 0,
+				    NULL);
+}
+
+static const struct of_device_id airoha_mfd_of_match[] = {
+	{ .compatible = "airoha,en7581-gpio-sysctl" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_mfd_of_match);
+
+static struct platform_driver airoha_mfd_driver = {
+	.probe = airoha_mfd_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = airoha_mfd_of_match,
+	},
+};
+module_platform_driver(airoha_mfd_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha EN7581 MFD");
diff --git a/include/linux/mfd/airoha-en7581-mfd.h b/include/linux/mfd/airoha-en7581-mfd.h
new file mode 100644
index 000000000000..25e73952a777
--- /dev/null
+++ b/include/linux/mfd/airoha-en7581-mfd.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_
+#define _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_
+
+struct airoha_mfd {
+	void __iomem *base;
+};
+
+#endif  /* _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_ */

-- 
2.46.2



Return-Path: <linux-pwm+bounces-3068-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D44967232
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BF728379A
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA801BDDB;
	Sat, 31 Aug 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM9ZcI4a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8712E78;
	Sat, 31 Aug 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114524; cv=none; b=GwIXgcc4ilWeTa5KP4DvnHEhUxvXgMA4n/8cGLIWRDHe8qim/DUw2DFM79STZ4z4xNF8iPRUeMXvtLCu9UtKibyGUJ3QL4+f7IBmko3m0jeC3g0lXQ49y65/MYdb759hTIbq39hTCJV7UJ4h/yb7hfkbATQtmAeASDPMX45MaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114524; c=relaxed/simple;
	bh=/6uBpfrB/F12iCmrrtq2Zl6JyMgmBNI04LH3ctsg3dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mip+7J1SSQNj5P1HLBLmcdaJTCajK5JMgObMcxSUez8IO193cUdI6l7H4z4khTUwFlTTuJkfKWb/eVyGuhAFRhJIKmY6VpiVz02NCKv8OJ0qbaNgRBfrtHNGh76LqB20a18/KGYp7TwCsF+t2hetWtx+lwugicucQL/Yg5wB2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM9ZcI4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9CBC4CEC0;
	Sat, 31 Aug 2024 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725114524;
	bh=/6uBpfrB/F12iCmrrtq2Zl6JyMgmBNI04LH3ctsg3dM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PM9ZcI4aJI3nLutDqYC0SQhm490LufbtMsWiSggY+B9y60xCOImghu3hpY0Rf7RYR
	 wxg1Gh9hWkRP+xkWie72KwZvsiZLIuoD1j6fXzrqs+9iNN5wESeTvClMBE2LnEY3Om
	 La4WQi5WiBJUPnN1ddty5YI0wEhl0hnO8s7DDC05j+X6xJtb4rxOySEHY6g3S4Zq5M
	 qL/DgZGUKLkUsFfBteUjpgS7STxgtnfitY2TdjUBIkl2oM+xF5JDOPF+w75s6ojzjD
	 bKj9PIKDkKdjc4v5zY+kZWBtIdlJ4pzN0amnzUiACUbhYkxX9rxKH9whwkEOP3slCo
	 SlChzmfLsFs1Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 31 Aug 2024 16:27:48 +0200
Subject: [PATCH v3 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-en7581-pinctrl-v3-3-98eebfb4da66@kernel.org>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
In-Reply-To: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
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
index bc8be2e593b6..c690378066ac 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -20,6 +20,14 @@ config MFD_CS5535
 	  This is the core driver for CS5535/CS5536 MFD functions.  This is
 	  necessary for using the board's GPIO and MFGPT functionality.
 
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
index 02b651cd7535..075dbff618e0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -256,6 +256,8 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
 
+obj-$(CONFIG_MFD_AIROHA_EN7581)	+= airoha-en7581-gpio-mfd.o
+
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
diff --git a/drivers/mfd/airoha-en7581-gpio-mfd.c b/drivers/mfd/airoha-en7581-gpio-mfd.c
new file mode 100644
index 000000000000..7888c175f6c5
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
+		.name = "airoha-pwm",
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
2.46.0



Return-Path: <linux-pwm+bounces-3200-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC084975B14
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594021F23B04
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FF1BA890;
	Wed, 11 Sep 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZB6o2yt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D617DFFC;
	Wed, 11 Sep 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084274; cv=none; b=kiGKVQAwtGhwrO+XaTg+kKMbx5JpjRJN1OA/qsuMFtBGancUpBf++luXFRiBxGdFZzuiqus8Soq9FNfiCcwQOiRkVX9JBDA6F7R3fVNUQwA+An8vATtFVgMfjeZe+kx/YlEtWQOtTVd+KIAvZO4j/JkGCk4jFh3rhvsBOFTW4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084274; c=relaxed/simple;
	bh=uTnLq6mgxfCu8fXAVFjIpMyL+iKn9WrfpqJ11Eh10D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nF9n8NkekGLI9H252iy0Rp63mCFzLcaLWxma3FFgZivBpoI7N0pYDA2P24CTLvtweAOFtZ9LGVAc+0KhA+K7xFEwCjtf/W9yHbKOylcmaHBO1vXPvvSfV4BLf4edb3qpAeLFQDwUEywWB6m9Y1UdtYo8Tw/U5hbIzVrPpErl/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZB6o2yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136ECC4CEC0;
	Wed, 11 Sep 2024 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726084273;
	bh=uTnLq6mgxfCu8fXAVFjIpMyL+iKn9WrfpqJ11Eh10D8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZB6o2yt9BdHmyd2DmWN8VywY0+/Sxx7J5YnpwuxdLzii6EJEfEmQ0AkBlYdFEU9Z
	 gCZiz7/BqhnqhuJ63Zx36IBhr69cvE4kdPiOOSZuYftLIPVb36D96c5kZXsH06YhO6
	 RRVzL24sknQR1eBJg2g1hK+pwcAwx1MSBOkM8KHbsODyyHnldPJgJL5CZ9qx69d2DH
	 PbQko1rWaN4t82Jy2/khNeH17HLMvezLOb2IW5VMQGz7clx0xifzkJSKzVX0MpS3La
	 BMZ5pUMcjQQZ+I9PXCgF1pGWhdFKBt0sgp3gfVs8TEFSfPPAVZKauPhPJugv0ouSUO
	 +b9mteTVdy2uw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 11 Sep 2024 21:50:03 +0200
Subject: [PATCH v4 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-en7581-pinctrl-v4-3-60ac93d760bb@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
In-Reply-To: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
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
2.46.0



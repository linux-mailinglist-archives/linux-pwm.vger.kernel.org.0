Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161AB5F5C8D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 00:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJEWNf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJEWM7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 18:12:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E483207
        for <linux-pwm@vger.kernel.org>; Wed,  5 Oct 2022 15:12:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so27714289wrq.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Oct 2022 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bZarqMDc/6hKea1bOExuvbbOHo7DHkLG1khhfpxmIGM=;
        b=igTVBe0Ph4Rd6sj6mhho1+l3Bd/ZU1wL9WrNVesnexi49y62F/Dv9aOLUXM+q1M/fP
         Mqmb4IucG1r197RdHWv51nfY8EOAUbhNjhFszTXZVOD4zBRbJkcPAYeYv410eReuEKjE
         6XXW86OXgY3DgMDxwhEAEEbu0aSAE9GTNazXSyeHJkTPSSstc2yx2+ELUqgardL0rRzd
         irvrzxQQ6lbkxfLG+TkpdCsdF/T8ERN0K/o/BMVmwZ9Isygqo/u8Z7e8EOem8ADsUowf
         uuYhS3warTcovaKfqZbBlHrxWMs8qMDt8+ZHyEePdi8beOlKO+E2Kw+msj3kT8bgjK28
         WS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bZarqMDc/6hKea1bOExuvbbOHo7DHkLG1khhfpxmIGM=;
        b=C1jsH1UkJtxoFqKvieXl5nQCx7Z4pYUeg9J8qd2WbijG7I1Wfzm+fqfJ3o8DEGpo5p
         tNXG8h6ItuvW/hnAddJgQ51/72ZSX+Qpi2osOcSt9SuJgp1kD0FplagBknei+twgSQJ1
         dOusK7gMsSeHmCIRqN/UJVwpSAERzY2CdANIaAORNmLVGWHvl65eN+UFsllv/2goqBqf
         lTu6q7Yi3KMiInLo9YkRgpepkG2VW73xLI84eskNOpHsW2PKk2UgGS4aYNZtMXOa327v
         ngvFqsZcP1OqwHFsQ3P+WgdY60Nbj7VUnh/JC+KI9YPwnSbg/UJxt+U8UYAWAa9PPUvL
         XX0A==
X-Gm-Message-State: ACrzQf09ahxkgw3h3xJPTw0cKZoeGLTQyCafzgmrnj8AvtQ7EQaKKQIu
        gT7fNQjadOWHB4P6Q0ComphDAoDr67oNljdlrdgP0l/M+4XK1uTiaToLy/rIwN9GU4PBxXSAggR
        8xmjDWlJlhBjK3dEuLY+K2Ruz0OamuLLPTSn0iXp+kE/K4kvSNtL/XpiXjHQ8/k0vdK2rlAHxLV
        w=
X-Google-Smtp-Source: AMsMyM6HCqEIW4cRzauq58hqXRLMk2QWD2yd1ZOMi7+VYokOGU6k+TxUTI9GXIIVENK0BDlFL5tHvQ==
X-Received: by 2002:adf:fa05:0:b0:22e:362a:ce57 with SMTP id m5-20020adffa05000000b0022e362ace57mr1071884wrr.96.1665007974856;
        Wed, 05 Oct 2022 15:12:54 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:54 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v5 08/10] pwm: dwc: add of/platform support
Date:   Wed,  5 Oct 2022 23:12:40 +0100
Message-Id: <20221005221242.470734-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005221242.470734-1-ben.dooks@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v5:
 - fix missing " in kconfig
 - remove .remove method, devm already sorts this.
 - merge pwm-number code
 - split the of code out of the core
 - get bus clock
v4:
 - moved the compile test code earlier
 - fixed review comments
  - used NS_PER_SEC
  - use devm_clk_get_enabled
  - ensure we get the bus clock
v3:
 - changed compatible name

fixup add pwm/Kconfig
---
 drivers/pwm/Kconfig      |  9 +++++
 drivers/pwm/Makefile     |  1 +
 drivers/pwm/pwm-dwc-of.c | 76 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a9f1c554db2b..c734f58a8bfc 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -192,6 +192,15 @@ config PWM_DWC_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc-pci.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)"
+	depends on PWM_DWC && OF
+	help
+	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-of.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a70d36623129..d1fd1641f077 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
 obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
new file mode 100644
index 000000000000..c5b4351cc7b0
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver OF
+ *
+ * Copyright (C) 2022 SiFive, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+
+#include "pwm-dwc.h"
+
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	struct clk *bus;
+	u32 nr_pwm;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
+		if (nr_pwm > DWC_TIMERS_TOTAL)
+			dev_err(dev, "too many PWMs (%d) specified, capping at %d\n",
+				nr_pwm, dwc->chip.npwm);
+		else
+			dwc->chip.npwm = nr_pwm;
+	}
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return PTR_ERR(dwc->base);
+
+	bus = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(bus))
+		return dev_err_probe(dev, PTR_ERR(bus),
+				     "failed to get clock\n");
+
+	dwc->clk = devm_clk_get_enabled(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
+	return devm_pwmchip_add(dev, &dwc->chip);
+}
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,dw-apb-timers-pwm2" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name		= "dwc-pwm",
+		.of_match_table  = dwc_pwm_dt_ids,
+	},
+	.probe	= dwc_pwm_plat_probe,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm-of");
+MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
-- 
2.35.1


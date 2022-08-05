Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6B58AE74
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiHEQuv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbiHEQut (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995B24F13
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso1955977wmc.1
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=abkM+9KtvZpTOSZDEcAMxsi7Tb1bi4vBUsbcV6Kxc+A=;
        b=DjmHorn+ak8GjoAPOPJZROmCy0kQQK+Rq2G/ghg8hH8Gi3lv+zgKjeL8Yj+sNj04kj
         x1R+nbj+0Or0zlYhR0JnFT73q10UL2Pjua2QSPHykMnijkHA8ny9HrBQ2faHC9H1Bu6f
         8LDjoeIHHAb0iuaMxXSsMUY9fZ+42rNop1pN4f1YxZm85r2IRahQNRNZBhjIrtv1ZwhU
         l1TFFRXI6bWzhhm+fsmpQnyODpWLsoIB+EPemWoO57sEzowT/v/fPpA8VaTHOy4d+VVR
         iz5VGyvCJbVIKyqYkY6mk6lAAuJ9cYuNVr4IpwvkOt+WzcNIn/SFe/dF7SL0rhYxYmYe
         qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=abkM+9KtvZpTOSZDEcAMxsi7Tb1bi4vBUsbcV6Kxc+A=;
        b=xLRnptfson2iK7AaIPiu+vqW+hpVptCyB2TD0T9Ekn8flUNsYSSnl4bwnchwmmWljD
         EMFo7SRLW1p6cp6RTypUmxeOIeL+xHn0bMmlBDhNDVNzbFmWhcQPj4BXVu2eWB34eJBZ
         HzFyTUYHAOaVOlKGIxTaPgJBi+23eacOZ0nY64oW4U0acekmdNeMbudLgH0hgU+I8W6H
         3iawk+zUzpiBTX4b64NnA3KtrWNcqa/nUULBb90TXiNbJgfP27L1XuOThAu2N0JUfDcT
         tnZXAPfg5CIqpcTUzocJAOqwxxI8KAXHaIqTduSnYQxgRQ22Tbkvsp2BHJp2nrj/tVQD
         fhgw==
X-Gm-Message-State: ACgBeo0TdB2a91QkopGg7pbSu4xNFPbcW62oz5ewo8B7CIjTxeJbu1fP
        9eE4GsXDQi/dQBQq9dMwR9CXzgUjmtIGve+G
X-Google-Smtp-Source: AA6agR5aodnlQ2aQYtYpMQXhKA97cR1+SaHXLKATLOWAS3x0Td/WHVHEo/uV5VPO+PuIOU7TsAFy2A==
X-Received: by 2002:a1c:2585:0:b0:3a5:2163:f33b with SMTP id l127-20020a1c2585000000b003a52163f33bmr2070277wml.189.1659718246682;
        Fri, 05 Aug 2022 09:50:46 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:46 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 4/8] pwm: dwc: add of/platform support
Date:   Fri,  5 Aug 2022 17:50:29 +0100
Message-Id: <20220805165033.140958-5-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v3:
 - changed compatible name
---
 drivers/pwm/Kconfig   |  5 ++--
 drivers/pwm/pwm-dwc.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..b8717877a524 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -176,9 +176,10 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI
+	depends on PCI || OF
 	help
-	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
+	  PWM driver for Synopsys DWC PWM Controller attached to either a
+	  PCI or platform bus.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 61f11e0a9319..d5f2df6fee62 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
@@ -319,6 +320,58 @@ static struct pci_driver dwc_pwm_driver = {
 
 module_pci_driver(dwc_pwm_driver);
 
+#ifdef CONFIG_OF
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	int ret;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return dev_err_probe(dev, PTR_ERR(dwc->base),
+				     "failed to map IO\n");
+
+	ret = pwmchip_add(&dwc->chip);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc_pwm_plat_remove(struct platform_device *pdev)
+{
+	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&dwc->chip);
+	return 0;
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
+	.remove	= dwc_pwm_plat_remove,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm");
+#endif /* CONFIG_OF */
+
+
 MODULE_AUTHOR("Felipe Balbi (Intel)");
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
 MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
-- 
2.35.1


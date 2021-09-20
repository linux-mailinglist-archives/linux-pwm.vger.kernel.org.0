Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE05412C8C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351783AbhIUCpj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhIUCDC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B732AC140910;
        Mon, 20 Sep 2021 11:12:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so68772583lfu.2;
        Mon, 20 Sep 2021 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIcT7jD3PqmkaPXwCgv6FGE++Qsz6I3+CRXDdvNGkZc=;
        b=I9R7QFLq2vtNTn9WgjY8skE0wHZb5ww3olMCdJCrBIxZ7/srNlDV5s0g7He18WQna0
         bM92SnpR/cJwPrJ1dAdO7u3Dnbv2LNzsIzHoFpUudWe+D6F7dYj+r9V9VCC2JKFQ+8De
         iGtDc9JWN4OyLJawpvQzPlEnuSGbpTJoUaD2h7zXBTyv9bV7FI/G4y9BHTTWbmtPumdX
         S1ef9l3vrftK/Y27iW0zmqFkp8UFEaAMe2qtdYnYu32dXOhQGN+gjbM1BnLbZF6Kh8tj
         yB1ECHF1gLuCSdJljDcULPzOwUycIDuhh38RTxWDv9J1ei4vqd1EMg4MdKGC95pAD79Q
         vWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIcT7jD3PqmkaPXwCgv6FGE++Qsz6I3+CRXDdvNGkZc=;
        b=BdRHX7HdGA64TYjGC+C9NkIey8Ogee+hKj3+jVZTvUSXoFhOUt+Pfxmbj4vlUtkk04
         kexmmtCnKB4kbrVCPZamohf0T4ui/scn8XihDc0MHIsEGX/NvAk0EKv2Cv2xR4pQVw7R
         kBZoidqCNYhTkVS+aNC6yACSAJ6DsmwA/5NCjbQSJ1Y2u7cwfFwxGyMV0XYiVQBObERx
         +wgGdfVlHXDl3ZvCLj867ky1nWKNTnNjDlg0/zK/UYmg/XtdMi9L7/mSWaCFaDS1bCMS
         El9jFsI+oNWgs/Od3A9pUJ30JZ5ouFQVsHGjNjQXe1M1oJ861HCQ+tnpG9T10NqFfEk4
         F+RA==
X-Gm-Message-State: AOAM5332jlhFyzWqrgp1HVCqYZQlRZq+3i5StLErjvnbSEoGK7gpydIb
        D0+RSSxgOYY65tV5TRFfcbU=
X-Google-Smtp-Source: ABdhPJycOGjUanMbCSnP//tSaeiwk9oVfouwCzt9Yl6vG5bBY8rTzXF4YPUcHeV+xk8YvLMZVTT8dQ==
X-Received: by 2002:a2e:5306:: with SMTP id h6mr22597038ljb.271.1632161539271;
        Mon, 20 Sep 2021 11:12:19 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 16/35] usb: chipidea: tegra: Add runtime PM and OPP support
Date:   Mon, 20 Sep 2021 21:11:26 +0300
Message-Id: <20210920181145.19543-17-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Tegra USB controller belongs to the core power domain and we're going
to enable GENPD support for the core domain. Now USB controller must be
resumed using runtime PM API in order to initialize the USB power state.
We already support runtime PM for the CI device, but CI's PM is separated
from the RPM managed by tegra-usb driver. Add runtime PM and OPP support
to the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 53 ++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 60361141ac04..3142ef7ebe42 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <linux/usb.h>
@@ -15,6 +16,8 @@
 #include <linux/usb/of.h>
 #include <linux/usb/phy.h>
 
+#include <soc/tegra/common.h>
+
 #include "../host/ehci.h"
 
 #include "ci.h"
@@ -278,6 +281,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (!usb)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, usb);
+
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
 		dev_err(&pdev->dev, "failed to match OF data\n");
@@ -296,11 +301,17 @@ static int tegra_usb_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(usb->clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", err);
+	err = devm_pm_runtime_enable(&pdev->dev);
+	if (err)
+		return err;
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
 		return err;
-	}
 
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
@@ -320,8 +331,6 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_power_off;
 
-	platform_set_drvdata(pdev, usb);
-
 	/* setup and register ChipIdea HDRC device */
 	usb->soc = soc;
 	usb->data.name = "tegra-usb";
@@ -350,7 +359,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 phy_shutdown:
 	usb_phy_shutdown(usb->phy);
 fail_power_off:
-	clk_disable_unprepare(usb->clk);
+	pm_runtime_put(&pdev->dev);
+
 	return err;
 }
 
@@ -360,15 +370,44 @@ static int tegra_usb_remove(struct platform_device *pdev)
 
 	ci_hdrc_remove_device(usb->dev);
 	usb_phy_shutdown(usb->phy);
+	pm_runtime_put(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_resume(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(usb->clk);
+	if (err < 0) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_suspend(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(usb->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_usb_pm = {
+	SET_RUNTIME_PM_OPS(tegra_usb_runtime_suspend, tegra_usb_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver tegra_usb_driver = {
 	.driver = {
 		.name = "tegra-usb",
 		.of_match_table = tegra_usb_of_match,
+		.pm = &tegra_usb_pm,
 	},
 	.probe = tegra_usb_probe,
 	.remove = tegra_usb_remove,
-- 
2.32.0


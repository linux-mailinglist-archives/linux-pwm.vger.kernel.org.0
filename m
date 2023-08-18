Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4B780856
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359129AbjHRJbE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359192AbjHRJat (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 05:30:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B93AA6;
        Fri, 18 Aug 2023 02:30:42 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRxPq0hvVzVkYK;
        Fri, 18 Aug 2023 17:28:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:30:38 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <andy@kernel.org>,
        <j-keerthy@ti.com>, <vz@mleia.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <grygorii.strashko@ti.com>,
        <ssantosh@kernel.org>, <khilman@kernel.org>,
        <shubhrajyoti.datta@amd.com>, <srinivas.neeli@amd.com>,
        <michal.simek@amd.com>
CC:     <lizetao1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH -next 10/11] gpio: xilinx: Use helper function devm_clk_get_optional_enabled()
Date:   Fri, 18 Aug 2023 17:30:17 +0800
Message-ID: <20230818093018.1051434-11-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818093018.1051434-1-lizetao1@huawei.com>
References: <20230818093018.1051434-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
prepared and enabled clocks"), devm_clk_get_optional() and
clk_prepare_enable() can now be replaced by
devm_clk_get_optional_enabled() when the driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover,
it is no longer necessary to unprepare and disable the clocks explicitly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/gpio/gpio-xilinx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index a16945e8319e..4e4da07bf8a2 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -334,12 +334,9 @@ static int __maybe_unused xgpio_suspend(struct device *dev)
  */
 static int xgpio_remove(struct platform_device *pdev)
 {
-	struct xgpio_instance *gpio = platform_get_drvdata(pdev);
-
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(gpio->clk);
 
 	return 0;
 }
@@ -647,15 +644,11 @@ static int xgpio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->regs);
 	}
 
-	chip->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	chip->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	if (IS_ERR(chip->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk), "input clock not found.\n");
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
+				     "input clock not found or failed to prepare clk\n");
 
-	status = clk_prepare_enable(chip->clk);
-	if (status < 0) {
-		dev_err(&pdev->dev, "Failed to prepare clk\n");
-		return status;
-	}
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -702,7 +695,6 @@ static int xgpio_probe(struct platform_device *pdev)
 err_pm_put:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-	clk_disable_unprepare(chip->clk);
 	return status;
 }
 
-- 
2.34.1


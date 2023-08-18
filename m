Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6E780868
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359169AbjHRJbL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359189AbjHRJas (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 05:30:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B36C3AA2;
        Fri, 18 Aug 2023 02:30:42 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxQj2Jnxz1GF9p;
        Fri, 18 Aug 2023 17:29:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:30:39 +0800
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
Subject: [PATCH -next 11/11] gpio: zynq: Use helper function devm_clk_get_enabled()
Date:   Fri, 18 Aug 2023 17:30:18 +0800
Message-ID: <20230818093018.1051434-12-lizetao1@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
can now be replaced by devm_clk_get_enabled() when the driver enables
(and possibly prepares) the clocks for the whole lifetime of the device.
Moreover, it is no longer necessary to unprepare and disable the clocks
explicitly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/gpio/gpio-zynq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0a7264aabe48..98cb38c95837 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -918,15 +918,10 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->ngpio = gpio->p_data->ngpio;
 
 	/* Retrieve GPIO clock */
-	gpio->clk = devm_clk_get(&pdev->dev, NULL);
+	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(gpio->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->clk), "input clock not found.\n");
-
-	ret = clk_prepare_enable(gpio->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable clock.\n");
-		return ret;
-	}
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->clk),
+				     "input clock not found or unable to enable clock.\n");
 
 	spin_lock_init(&gpio->dirlock);
 
@@ -977,7 +972,6 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 err_pm_dis:
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(gpio->clk);
 
 	return ret;
 }
@@ -997,7 +991,6 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(&pdev->dev, "pm_runtime_get_sync() Failed\n");
 	gpiochip_remove(&gpio->chip);
-	clk_disable_unprepare(gpio->clk);
 	device_set_wakeup_capable(&pdev->dev, 0);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
2.34.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7B780863
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359152AbjHRJbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359142AbjHRJal (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 05:30:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCD3ABE;
        Fri, 18 Aug 2023 02:30:37 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRxNl6JhJzFqld;
        Fri, 18 Aug 2023 17:27:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:30:34 +0800
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
Subject: [PATCH -next 03/11] gpio: ftgpio010: Use helper function devm_clk_get_enabled()
Date:   Fri, 18 Aug 2023 17:30:10 +0800
Message-ID: <20230818093018.1051434-4-lizetao1@huawei.com>
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
 drivers/gpio/gpio-ftgpio010.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 5ce59dcf02e3..51724adf237a 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -253,18 +253,13 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	g->clk = devm_clk_get(dev, NULL);
-	if (!IS_ERR(g->clk)) {
-		ret = clk_prepare_enable(g->clk);
-		if (ret)
-			return ret;
-	} else if (PTR_ERR(g->clk) == -EPROBE_DEFER) {
+	g->clk = devm_clk_get_enabled(dev, NULL);
+	if (PTR_ERR_OR_ZERO(g->clk) == -EPROBE_DEFER)
 		/*
 		 * Percolate deferrals, for anything else,
 		 * just live without the clocking.
 		 */
 		return PTR_ERR(g->clk);
-	}
 
 	ret = bgpio_init(&g->gc, dev, 4,
 			 g->base + GPIO_DATA_IN,
@@ -275,7 +270,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 			 0);
 	if (ret) {
 		dev_err(dev, "unable to init generic GPIO\n");
-		goto dis_clk;
+		return ret;
 	}
 	g->gc.label = dev_name(dev);
 	g->gc.base = -1;
@@ -293,10 +288,9 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
 				     GFP_KERNEL);
-	if (!girq->parents) {
-		ret = -ENOMEM;
-		goto dis_clk;
-	}
+	if (!girq->parents)
+		return -ENOMEM;
+
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = irq;
@@ -311,25 +305,16 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 
 	ret = devm_gpiochip_add_data(dev, &g->gc, g);
 	if (ret)
-		goto dis_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, g);
 	dev_info(dev, "FTGPIO010 @%p registered\n", g->base);
 
 	return 0;
-
-dis_clk:
-	clk_disable_unprepare(g->clk);
-
-	return ret;
 }
 
 static int ftgpio_gpio_remove(struct platform_device *pdev)
 {
-	struct ftgpio_gpio *g = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(g->clk);
-
 	return 0;
 }
 
-- 
2.34.1


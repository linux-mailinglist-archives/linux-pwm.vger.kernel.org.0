Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE51780867
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359147AbjHRJbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359133AbjHRJal (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 05:30:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718333AAC;
        Fri, 18 Aug 2023 02:30:37 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxQc0sgZz1GF9c;
        Fri, 18 Aug 2023 17:29:12 +0800 (CST)
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
Subject: [PATCH -next 02/11] gpio: davinci: Use helper function devm_clk_get_enabled()
Date:   Fri, 18 Aug 2023 17:30:09 +0800
Message-ID: <20230818093018.1051434-3-lizetao1@huawei.com>
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
 drivers/gpio/gpio-davinci.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 8db5717bdabe..23b5ae8cf2aa 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -477,7 +477,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 {
 	unsigned	gpio, bank;
 	int		irq;
-	int		ret;
 	struct clk	*clk;
 	u32		binten = 0;
 	unsigned	ngpio;
@@ -502,21 +501,16 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 	ngpio = pdata->ngpio;
 
-	clk = devm_clk_get(dev, "gpio");
+	clk = devm_clk_get_enabled(dev, "gpio");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Error %ld getting gpio clock\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	if (!pdata->gpio_unbanked) {
 		irq = devm_irq_alloc_descs(dev, -1, 0, ngpio, 0);
 		if (irq < 0) {
 			dev_err(dev, "Couldn't allocate IRQ numbers\n");
-			clk_disable_unprepare(clk);
 			return irq;
 		}
 
@@ -525,7 +519,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 							chips);
 		if (!irq_domain) {
 			dev_err(dev, "Couldn't register an IRQ domain\n");
-			clk_disable_unprepare(clk);
 			return -ENODEV;
 		}
 	}
@@ -594,10 +587,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 				       sizeof(struct
 					      davinci_gpio_irq_data),
 					      GFP_KERNEL);
-		if (!irqdata) {
-			clk_disable_unprepare(clk);
+		if (!irqdata)
 			return -ENOMEM;
-		}
 
 		irqdata->regs = g;
 		irqdata->bank_num = bank;
-- 
2.34.1


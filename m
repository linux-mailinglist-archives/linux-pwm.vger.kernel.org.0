Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2D7771C3
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Aug 2023 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHJHno (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Aug 2023 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHJHni (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Aug 2023 03:43:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D41703
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 00:43:36 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLzP63WNjzqSnC;
        Thu, 10 Aug 2023 15:40:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 15:43:33 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <claudiu.beznea@tuxon.dev>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] pwm: omap-dmtimer: Remove redundant of_match_ptr()
Date:   Thu, 10 Aug 2023 15:42:58 +0800
Message-ID: <20230810074258.2390629-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810074258.2390629-1-ruanjinjie@huawei.com>
References: <20230810074258.2390629-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 4889fbd8a431..94faa4650686 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -466,7 +466,7 @@ MODULE_DEVICE_TABLE(of, pwm_omap_dmtimer_of_match);
 static struct platform_driver pwm_omap_dmtimer_driver = {
 	.driver = {
 		.name = "omap-dmtimer-pwm",
-		.of_match_table = of_match_ptr(pwm_omap_dmtimer_of_match),
+		.of_match_table = pwm_omap_dmtimer_of_match,
 	},
 	.probe = pwm_omap_dmtimer_probe,
 	.remove_new = pwm_omap_dmtimer_remove,
-- 
2.34.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7E6A9FA8
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjCCSzR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCCSzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF051DB9F
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-0006Cj-9M; Fri, 03 Mar 2023 19:55:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001cTw-Ir; Fri, 03 Mar 2023 19:54:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001uk5-Lh; Fri, 03 Mar 2023 19:54:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 08/30] pwm: clk: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:23 +0100
Message-Id: <20230303185445.2112695-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mQjeNXEw/kmtDjvuoJVgwDlpGIlepU37hvnuMeDUXig=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwOf7J8f6qOvXJmQTm481q3+T2JG/qn9bQvL0vgtMmR XinpOjSTkZjFgZGLgZZMUWWuiItsQkSa/7blSzhhhnEygQyhYGLUwButBH7/5qNnyK5a/5tyjqs k1P71KpD4uOyled6/d8Jx8zS1jywtWUy929LXiZVGe9jwvPfMPyxONwicvvBXuH8sP08r85arnE w1t+vcn2rUHi7/NfeC4pKor8aDs3+m81X+8lHJfu1o6DYifMr80wylTVEfVNy+5rUlkjP511ewh W6i6PpxPd1U/NKcr2a/uU0m7nxtLgX59588cBAq07a/iLvq+US/WyTNM9c7Xctl567gqdq9aPHP +c7h2zn3HrkoD7HvIASjU/6a8or3zBFlmgz9R4UWBcnZaYwzf+sWT2H9KEtUtHp0zIlWbS1VQ23 vQnlCRcvtKgu3LrdiiXI6/4XVu91T5yfd/0IuM75IAwA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index c2a503d684a7..f1da99881adf 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -112,7 +112,7 @@ static int pwm_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_clk_remove(struct platform_device *pdev)
+static void pwm_clk_remove(struct platform_device *pdev)
 {
 	struct pwm_clk_chip *pcchip = platform_get_drvdata(pdev);
 
@@ -122,8 +122,6 @@ static int pwm_clk_remove(struct platform_device *pdev)
 		clk_disable(pcchip->clk);
 
 	clk_unprepare(pcchip->clk);
-
-	return 0;
 }
 
 static const struct of_device_id pwm_clk_dt_ids[] = {
@@ -138,7 +136,7 @@ static struct platform_driver pwm_clk_driver = {
 		.of_match_table = pwm_clk_dt_ids,
 	},
 	.probe = pwm_clk_probe,
-	.remove = pwm_clk_remove,
+	.remove_new = pwm_clk_remove,
 };
 module_platform_driver(pwm_clk_driver);
 
-- 
2.39.1


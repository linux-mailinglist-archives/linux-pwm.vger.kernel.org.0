Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF456A9FC5
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCCSze (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCCSzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD01F48D
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYc-0006Ut-0F; Fri, 03 Mar 2023 19:55:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-001cVb-Sa; Fri, 03 Mar 2023 19:55:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001ukn-76; Fri, 03 Mar 2023 19:55:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 20/30] pwm: sifive: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:35 +0100
Message-Id: <20230303185445.2112695-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qMafb/hg7zFL02UFPEZV5gEG/vwYDPL5U0C7Ndq8GYw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJHsO7KnsALZ/5vaBUA+pXb5ayVMdj/m7kLY d/YanFOSx2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCRwAKCRDB/BR4rcrs CU77B/9hdSMSFrKcMQw1LLDMm/Gvonnt6aLpyqaNJ3xz/Mj5q+af9TlcBIrHQlsA/lSKSf1A19j s1TkrM6/60gi1ZGeXqbe4wXel+u9YZGizM/4rF2gkxnHSknoV27JCv6RrYiAdkanv+xqYqYI9wV 1KJghKXYKvaVBBhYatJ7A9ej5hUln0gHow3bzpBNDIFdp4ZrxPzuSFyGptsv4OmdNJrHLA2a7kN pSnmWu60RBFLi4m9oc1W8RDzk1w6pd37vLwR4M5Uh+a/CQY4W3Ux/WJrQK/DS40vj4WkA9oOgil 1xtSg+enYsEFQ7DUWffooVu0bcuLUJfVOHVSsFdV9n585p5+
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
 drivers/pwm/pwm-sifive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 393a4b97fc19..5b0574f635f6 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -313,7 +313,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pwm_sifive_remove(struct platform_device *dev)
+static void pwm_sifive_remove(struct platform_device *dev)
 {
 	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
 	struct pwm_device *pwm;
@@ -329,8 +329,6 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	}
 
 	clk_unprepare(ddata->clk);
-
-	return 0;
 }
 
 static const struct of_device_id pwm_sifive_of_match[] = {
@@ -341,7 +339,7 @@ MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
 
 static struct platform_driver pwm_sifive_driver = {
 	.probe = pwm_sifive_probe,
-	.remove = pwm_sifive_remove,
+	.remove_new = pwm_sifive_remove,
 	.driver = {
 		.name = "pwm-sifive",
 		.of_match_table = pwm_sifive_of_match,
-- 
2.39.1


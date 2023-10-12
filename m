Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C117C72B5
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379586AbjJLQbH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379597AbjJLQa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66DCA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-0004v6-Dh; Thu, 12 Oct 2023 18:30:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-001C6z-0q; Thu, 12 Oct 2023 18:30:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-00F5Nv-O3; Thu, 12 Oct 2023 18:30:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 027/109] pwm: sifive: Make use of parent device pointer in driver data
Date:   Thu, 12 Oct 2023 18:28:55 +0200
Message-ID: <20231012162827.1002444-138-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u3/GZck+TfxYkqVskYKK5Hl5pXENpjr66q9uG7q6QQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7M8bGGBOtNOOXEf49rdZ11E1YvueSejX0yQ fJibnKEiIKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgezAAKCRCPgPtYfRL+ TtE0B/9KTVwiSqXEp07MsgdIzpjvLa0Cgv3HmqWs6naP/C13N17P+UmkLVF4FN46HdP2LmVjtjg 35PFu9Oc304vvKNlSwxfdnLzHKzueFH6hZgRpA0qNu2/bnICMH+JJJPt8/lT2cqGuyE3kSYvGIX rDgERXyRdFkP9uEus4vHFR/h516spm15Y9fYcej1whKy0RmEkqxhSmC4cB8DE41CKXXJCrputXT yXPNICUAPB/Zh/j98CFN4p4iu/ZKk97zKFuSiAzdPNL7duFHxI3YMjxyO+NcvsUSgxG3mq10PWf dmSZG1qZFpxJ9flAaNbgDsw1NJZkh2a3GXdiSGnFzTtXLoTj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 089e50bdbbf0..c830845e0e52 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -42,6 +42,7 @@
 
 struct pwm_sifive_ddata {
 	struct pwm_chip	chip;
+	struct device *parent;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
@@ -185,7 +186,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!enabled) {
 		ret = clk_enable(ddata->clk);
 		if (ret) {
-			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			dev_err(ddata->parent, "Enable clk failed\n");
 			return ret;
 		}
 	}
@@ -234,7 +235,9 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	if (!ddata)
 		return -ENOMEM;
 
+	ddata->parent = dev;
 	mutex_init(&ddata->lock);
+
 	chip = &ddata->chip;
 	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-- 
2.42.0


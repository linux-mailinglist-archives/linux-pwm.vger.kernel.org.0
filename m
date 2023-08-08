Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2550774415
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjHHSPC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjHHSOh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7751DD26
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0007lg-MP; Tue, 08 Aug 2023 19:20:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0022Ag-2M; Tue, 08 Aug 2023 19:20:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-00BTGW-0D; Tue, 08 Aug 2023 19:20:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 098/101] pwm: vt8500: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:28 +0200
Message-Id: <20230808171931.944154-99-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bVqVeYJNSYPTr4V327ecw1VPEB5+nnNKqOIy4x7c9ZM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkfz17wTrXTQqQcK9GtS+tj1VSH2kDAw6RtY ptyv/om1VaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5HwAKCRCPgPtYfRL+ TpcyCACtqZT6Ibno+xQ5oD0NeH9VGKzZ4Voc1FhDGpC18emjyIT2z6KKnUamGHpy6LVz15JU8rN 51iHVh5sZmAvt6SEsof5udTS/TGmnFWVHRGI/CXii2nX+W669hbBdgFBu5owfy2s0ucCAjWRTh+ P+ExRGPmHHU/CzL4+8fRl5QtmuaQMBWlCyAI7FXNzueYEo2aAWbIIrKKiNQxAfPmcmhhWclCG6G vxmUq/+ur/r5s36et8Dnm8QQJWrVR8VPvv8ggrBoOPGIfOzOuOiraK6aHl099LdA/h+LgUpr3Kt MtEAw4FfJ4F5DaZOLAvy7ZkwXRR1Mm6VGZca/h2wqtiBJWQ1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 41d9f1a0f74f..634dac40594f 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -45,6 +45,7 @@
 #define STATUS_ALL_UPDATE	0x0F
 
 struct vt8500_chip {
+	struct device *parent;
 	void __iomem *base;
 	struct clk *clk;
 };
@@ -80,7 +81,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(vt8500->parent, "failed to enable clock\n");
 		return err;
 	}
 
@@ -139,7 +140,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(vt8500->parent, "failed to enable clock\n");
 		return err;
 	}
 
@@ -257,6 +258,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &vt8500_pwm_ops;
 
+	vt8500->parent = &pdev->dev;
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(vt8500->clk), "clock source not specified\n");
-- 
2.40.1


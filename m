Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7919F77440A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHHSOs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjHHSOT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3CF1DD12
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-0007aS-MV; Tue, 08 Aug 2023 19:20:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00229I-LJ; Tue, 08 Aug 2023 19:19:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00BTFO-Hf; Tue, 08 Aug 2023 19:19:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 081/101] pwm: mediatek: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:11 +0200
Message-Id: <20230808171931.944154-82-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GdbwnyZw8jvMT56F3GdwH183QhXxipFtnYQ2CFceOTE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkMXG+FM9EgwF+io2QwMY8I//rq9tExlCjHU rvK6fHz5jaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5DAAKCRCPgPtYfRL+ TsRCB/9dko59Uc/+/Rhq9fXKz2xzWFikyjLR1UPTLMMkGvI9BltzCZ46V7ofyS2fjfJ+gYyWiiq GySHPTkb7rKCBJlB1fIoUTKQiXqYFOgZGQnsRBcQM2j3yvmRagK7pBEcT3Ql+llI1bU8YkGpeFn 113dof1zOShd+oYfDOs6SoEoqultFdD1idYCOEJwARzGLfolRHbXzUa8XsnOB6tz5BKP/y3VElZ 8uzpuuHVZNOsqL1wgBKau0l/6gYYw9GxX/sRGBkp1Xic5m6FZ8QN4DyJRdAz0RqSXqRVm+ma0mI rTXB336Pn++ocoWldKi72vfS0EXaL1rLJg39B9CLYkT4tP2l
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
 drivers/pwm/pwm-mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 68cdeeb1ecf2..11e345474e1a 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -51,6 +51,7 @@ struct pwm_mediatek_of_data {
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
+	struct device *parent;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
@@ -149,7 +150,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
 		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
+		dev_err(pc->parent, "period of %d ns not supported\n", period_ns);
 		return -EINVAL;
 	}
 
@@ -246,6 +247,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	pc = to_pwm_mediatek_chip(chip);
 
 	pc->soc = soc;
+	pc->parent = &pdev->dev;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
-- 
2.40.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30FC7748BF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjHHTiM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjHHThw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:37:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91EF77981
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0007js-Jd; Tue, 08 Aug 2023 19:20:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0022AF-RN; Tue, 08 Aug 2023 19:20:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00BTG9-Vi; Tue, 08 Aug 2023 19:20:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 093/101] pwm: sun4i: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:23 +0200
Message-Id: <20230808171931.944154-94-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ek3sFOZAwni3SnI0mopSOU15KiNRbgv5sY0ytzn59IU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkZMQ8XElO1Jk5wk6OtCr+1vVaItSKmRNtIZ NLwedVZPD2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5GQAKCRCPgPtYfRL+ TuBLB/41v8yIjtQzqBRpapgUv0Tr0pZuoBwVIyq10QEAcJhvPyHnN0+e5avoDUI4JgjoplBLJj1 3ZxOG//gKygTgDgw/0cbNKk1ijaEqMJ0wYhcggVasuhQDiDZVCGHMLqDTuuTHEZSYEfGsegrrnP 723rWA8LipQXnwq0KN3FQz/txCd51LwPpwLe4xRSucRpaE9tq6XQ9atH+kvlz/samH8IxTJDUu4 h+IF4LZWygk2wgROI4vb+rbDQ7gXE4F3Kg8WlLEN3hpsY2FdUXjC8ONcOrUM3EdaZ2hDyyQMG9P dOkliEzF4pHWgyz/oOWzghsmp5Izmn8OtMSTlDPKVUy+lYwM
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
 drivers/pwm/pwm-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 4251807e496b..f2e85484f397 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -81,6 +81,7 @@ struct sun4i_pwm_data {
 };
 
 struct sun4i_pwm_chip {
+	struct device *parent;
 	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -244,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
+			dev_err(sun4i_pwm->parent, "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
@@ -252,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
-		dev_err(chip->dev, "period exceeds the maximum value\n");
+		dev_err(sun4i_pwm->parent, "period exceeds the maximum value\n");
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
@@ -397,6 +398,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	sun4ichip = to_sun4i_pwm_chip(chip);
 
+	sun4ichip->parent = &pdev->dev;
 	sun4ichip->data = data;
 	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sun4ichip->base))
-- 
2.40.1


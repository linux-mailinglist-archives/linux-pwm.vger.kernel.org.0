Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100BE7C72BE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379007AbjJLQbM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379554AbjJLQbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B35C6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-0004wG-AC; Thu, 12 Oct 2023 18:30:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-001C7F-Tv; Thu, 12 Oct 2023 18:30:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-00F5OB-Kv; Thu, 12 Oct 2023 18:30:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 031/109] pwm: sun4i: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:59 +0200
Message-ID: <20231012162827.1002444-142-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HIZLcG7Ck3uCiidtWYoYqHxm8CIohmV/VYBLbN2MIts=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7QyiiNmFtagV2g0fYhFlWynZouKX4MBIGgM sZcuTgldECJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge0AAKCRCPgPtYfRL+ TriYCACox0Z0wFAzhVFpuFQcSB/DtH8pQsoPsrokCJiXjwRL1gAQmVmDiTjroPY6otyUvuxaWVX gZNbQH4tRQmabx7yZTWsunmPqqvy7HBfqnD7GWHEWxCOVWuxrpLcaiNqqwDFMOyQmZgVEyL+RxZ YESl2J/3HO5FoOAWZMXn/BkZjEOroWtrstW/6bOGvUQ7wqjO1OfinR87kvOabNC/6pvyvz3belO 6b2H8nyHaP87H8/l6LMqUn3pg2k9lCc7J8D7vlJR8Ae7c+JTIzn/Ag4kTebI2ujm1Z7kInhF11C cW9ki1MiHu2O8VQCPTJ6HgaYhIoyYnBPdR4lK8D4AQbtIhQk
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
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1a439025540d..44edf1ce5739 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -245,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
+			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
@@ -253,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
-		dev_err(chip->dev, "period exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
-- 
2.42.0


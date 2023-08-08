Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64677774BC2
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHHUyu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjHHUyi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:54:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFDD1DD1C
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007fX-Av; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229b-Eu; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00BTFk-Oq; Tue, 08 Aug 2023 19:19:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 087/101] pwm: rcar: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:17 +0200
Message-Id: <20230808171931.944154-88-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OVuDdvGzckJg4dzK3pZhK4/b+garzidd8CLxsRqOUKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkShTbB1WQRJWeMBVM1CJE2oUumSXoKCKh9X 4HYmzqwM0iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5EgAKCRCPgPtYfRL+ TuHdB/oDWQKKIy9b1FA2lZ0V/SMeRP30+GryYeNSc5k/HXaWrqii23YGL19PD0mJTJEgFVXc2EQ zgEOZ3CqW5677UU9K++ESkSz3y8Pwhjg3tzTEQ3cJlfxKsYepR9eq0QXOWHuhnydtyZ8QR/+gWk EqucZsYjJIVPFltzTJrmu12Rejt7R+xE9Lp2AQ+E4sEambjk9Fdi7wRGk83V+DsRH+EYsk7vLaa Sky1BKdTZFLTozjlSdmSs//n6IpaXoWSRhv8fZSQMWmHHbGyS2kVaI5rOaaZrn5n2FGpWdKEEdU p7Azs5qpgIn6y7OuhZM8x9eT2IbgTN3VxLhgUdQqMqLhzyx+
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
 drivers/pwm/pwm-rcar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 5bb7b579705d..ecbe7d2a26d7 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -38,6 +38,7 @@
 #define  RCAR_PWMCNT_PH0_SHIFT	0
 
 struct rcar_pwm_chip {
+	struct device *parent;
 	void __iomem *base;
 	struct clk *clk;
 };
@@ -131,12 +132,14 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	return pm_runtime_get_sync(chip->dev);
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	return pm_runtime_get_sync(rp->parent);
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pm_runtime_put(chip->dev);
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	pm_runtime_put(rp->parent);
 }
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
-- 
2.40.1


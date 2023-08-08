Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7777440F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjHHSOx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjHHSOZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FD75874
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007fx-Bj; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229h-IB; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00BTFo-V7; Tue, 08 Aug 2023 19:19:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 088/101] pwm: rz-mtu3: Make use of parent device pointer in driver data
Date:   Tue,  8 Aug 2023 19:19:18 +0200
Message-Id: <20230808171931.944154-89-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=61f3C7cGtZUleth5O8MMntZDhhhsheUf2Tw0n8JCMyE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkT6rT3QiPfIeKdWLL8hJ8kOZdHKUlliWdfu XNyiYadoK+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5EwAKCRCPgPtYfRL+ TownCAC5kSYASY5iw0SD9wvl+jJxbpq3SWw/gbu2xsGKdho3DKPkhqkAPlpBTS+PYiPePGUnlNU j/jC8/h733ZiuSCHIJ1iZu5kBFIVVUPUFUwBnKyRdEde6di//9eWon0lzkCy0xd/kpOewZ23/rg dIzvmjSzpFo95KHPX2mwByR66sYMx9nSL66O4TwQ7E+FP92iJs09bsUpsnBrJSAhARsDUGCLd2D sVQ17KAnT1RW8VaiecubCna3maS2i+mOtafDXp0nvkygBmxe+7WOH3xQH9ZugjNqqYJRggic1+3 WakTearqyaKOtz7BjobsvGvd0xkeU+a3OGHKi/WxWFyjh22g
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
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rz-mtu3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index ff396e2de7ab..2dedeaa35de8 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -274,7 +274,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(chip->dev);
+	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->parent);
 	if (rc)
 		return rc;
 
@@ -307,7 +307,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->polarity = PWM_POLARITY_NORMAL;
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(rz_mtu3_pwm->parent);
 
 	return 0;
 }
@@ -362,7 +362,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!pwm->state.enabled) {
 		int rc;
 
-		rc = pm_runtime_resume_and_get(chip->dev);
+		rc = pm_runtime_resume_and_get(rz_mtu3_pwm->parent);
 		if (rc)
 			return rc;
 	}
@@ -399,7 +399,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* If the PWM is not enabled, turn the clock off again to save power. */
 	if (!pwm->state.enabled)
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(rz_mtu3_pwm->parent);
 
 	return 0;
 }
-- 
2.40.1


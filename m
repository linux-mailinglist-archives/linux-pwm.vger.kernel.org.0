Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A207B37B8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI2QTa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B191B1
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-0007om-VP; Fri, 29 Sep 2023 18:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-009r5k-IX; Fri, 29 Sep 2023 18:19:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-00616D-9Q; Fri, 29 Sep 2023 18:19:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/11] pwm: sprd: Provide a helper to cast a chip to driver data
Date:   Fri, 29 Sep 2023 18:19:14 +0200
Message-Id: <20230929161918.2410424-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QzZu0O2af8KQHmP9vYKVunWSqJwJmEPf3DZXyXoM3EY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj8NtSLbMovzU7ZiuZcxTl6cHwtU8zKkne4b 7iMm2yv6CiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4/AAKCRCPgPtYfRL+ Tgv3B/9A9VbxOzqT/3bFokLMr9uExpomj2LVQDSn/e/1H5xJMTy7OLth7sDaElhrCTrXGn0FwwF Prern1eHMv79+ojj1P7aHhsV2yGXoJRJ7U8ikeLHReVnWplFGKoS5sFjm+jXK2AS3Czf7J+Pfwr FhSW93+y6IGBfLC7ukDNAles6u525TGYOiRl4misVf/+OBLADlT/Jc+gw+LiCj/8syMHiJKV11I YQJfPm9u+VOAgjfmRN6FI/wUfOtNxQWrp+NAigDoXOYyQkt6Yvlf+yS8T0qXPsM/ynFYH04WvAE OQQsM7xxNJtnyaJoAb6xEDXhRZXFUrFeoATzzmuL3VulmbAj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Similar to most other PWM drivers provide a static inline function to
calculate driver data from a given pwmchip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 1499c8c1fe37..a3020bf164c8 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -40,6 +40,11 @@ struct sprd_pwm_chip {
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
+static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sprd_pwm_chip, chip);
+}
+
 /*
  * The list of clocks required by PWM channels, and each channel has 2 clocks:
  * enable clock and pwm clock.
@@ -69,8 +74,7 @@ static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
 static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			      struct pwm_state *state)
 {
-	struct sprd_pwm_chip *spc =
-		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chip *spc = sprd_pwm_from_chip(chip);
 	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
 	u32 val, duty, prescale;
 	u64 tmp;
@@ -162,8 +166,7 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
-	struct sprd_pwm_chip *spc =
-		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chip *spc = sprd_pwm_from_chip(chip);
 	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
 	struct pwm_state *cstate = &pwm->state;
 	int ret;
-- 
2.40.1


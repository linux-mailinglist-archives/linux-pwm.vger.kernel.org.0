Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDA774BAD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjHHUxV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjHHUxJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:53:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C47586E
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-0007YF-Ih; Tue, 08 Aug 2023 19:20:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-002299-61; Tue, 08 Aug 2023 19:19:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00BTFF-2K; Tue, 08 Aug 2023 19:19:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 079/101] pwm: lpc18xx-sct: Make use of parent device pointer in driver data
Date:   Tue,  8 Aug 2023 19:19:09 +0200
Message-Id: <20230808171931.944154-80-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=R8pfWHDx+7HjUjdHzMk8A6xK/kSiVCDBqiBaMzLoUHQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkJVwyLOAANAPeiorNefg9Zc17WRsutlIRzT lxn3ImPKyeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5CQAKCRCPgPtYfRL+ Tu+eB/0T499oVskshtm54PUz04gMk+EEhm/YT4gX8+p2WAXb/VR6/Jf4e4gOGIZcEdVIsLj12sc 4srYxnEFdZb4uBn7RyaAK5B8ms9vmGe51ZnupXBJSorPDJhupIA5J6P2FMWQwx4YosR7NcZ+izb STyFROtdhV5cKTnICXNDcEIUzp8/C57qxiZ5AZzbC748liA2iRnWw0dCT74z4nZLErbh5iLfAmz x/ugbWVAzKjRG5XvVu1AaBeDb8+Yc0TXCBIEQcob4Szstt0eGOGTF4w+FQzs795l2azRnExOC/n e1aryGauSiyIwG0KmPUBCtQp0TcDFgkqVWJwhpq1wnx/WG7Q
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
 drivers/pwm/pwm-lpc18xx-sct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 49eabd9c1e36..cb7e230b1b36 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -197,7 +197,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < lpc18xx_pwm->min_period_ns ||
 	    period_ns > lpc18xx_pwm->max_period_ns) {
-		dev_err(chip->dev, "period %d not in range\n", period_ns);
+		dev_err(lpc18xx_pwm->dev, "period %d not in range\n", period_ns);
 		return -ERANGE;
 	}
 
@@ -213,7 +213,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (requested_events > 2 && lpc18xx_pwm->period_ns != period_ns &&
 	    lpc18xx_pwm->period_ns) {
-		dev_err(chip->dev, "conflicting period requested for PWM %u\n",
+		dev_err(lpc18xx_pwm->dev, "conflicting period requested for PWM %u\n",
 			pwm->hwpwm);
 		mutex_unlock(&lpc18xx_pwm->period_lock);
 		return -EBUSY;
-- 
2.40.1


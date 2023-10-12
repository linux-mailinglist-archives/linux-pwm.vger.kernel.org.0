Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6327C72AC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379614AbjJLQbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379578AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F915E0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-0004ml-EM; Thu, 12 Oct 2023 18:30:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-001C68-Ii; Thu, 12 Oct 2023 18:30:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-00F5Mz-9X; Thu, 12 Oct 2023 18:30:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 014/109] pwm: imx27: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:42 +0200
Message-ID: <20231012162827.1002444-125-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=21gVfHE440/T65WsIsIoIm1SwOOZ2P7hANAjmVXXXN4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB686gTTw90h3M7Rqg1A713CSQCBlXMywiMYj 0IQDu0QENyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgevAAKCRCPgPtYfRL+ TsvmB/9Pdre/BWqtlENbUoY8DjOORBThN2fb7ODUVbJA3F9iasL+BDlPH6LmCCm0HketkOlO0So xxkyfAb5jsz0WPzLB4CsaMY+uW5rLBauxCJ5yF2j9ymuCKYcp8S1KGTJ8ZAh082L6TPMYeX2TS6 iGf+q6GyQImR9smcHFB3R870gromCD17VtuJYHs0wsE5YWB1DTsyDyFRCJTNqWhWKeEIgXUjkjo ETy/UW3CbeDgX8ZIVkJPoA2x/QcGLGdYiXxUrQwulIc8kw11enOl+SCOLRC9VuyQve5XnmwAylr bvXbsvLT2V0WmBw1nZDYsZmnTTAfJ+2c04tXQ7EiqzflyZQo
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
 drivers/pwm/pwm-imx27.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..5d796453519a 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -145,7 +145,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_INVERSED;
 		break;
 	default:
-		dev_warn(chip->dev, "can't set polarity, output disconnected");
+		dev_warn(pwmchip_parent(chip), "can't set polarity, output disconnected");
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
@@ -177,7 +177,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int wait_count = 0;
 	u32 cr;
 
@@ -196,7 +196,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 				     struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int period_ms;
 	int fifoav;
 	u32 sr;
-- 
2.42.0


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC137C72B6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379626AbjJLQbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379594AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF2BD3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-0004qZ-On; Thu, 12 Oct 2023 18:30:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-001C6h-67; Thu, 12 Oct 2023 18:30:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-00F5Ne-T5; Thu, 12 Oct 2023 18:30:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 023/109] pwm: raspberrypi-poe: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:51 +0200
Message-ID: <20231012162827.1002444-134-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7SoKIM/xkEZFVaeBKg/shON3CQblDARA/8PcLYb/Wys=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7HrtSJAq3YDbLZ9rjZpMgWhsDnYEPZPUm7P 98hGQ65KjuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgexwAKCRCPgPtYfRL+ TgP2B/9CMYwEpJdJ5lXRVzDLqMgFgKcPeaCNESFFXv46fxQ123DHH5zAjECvwhaPACT53w6wLmO VjA9h4Dy5TIjwWo4S1e4u6m66OaFAYRYojvrsKdMSv0rhW5lq/N/UgRmsuJEEAPeE9w623RbyRb yJ4PdsASuSsiJLRqrGXii+6ILMvNNH+Rze39AUAQkjchx4zvXk4axe9JKbpzh7b7vcgQ3VDyI8/ 79M6vADhs5+CjNDt17z5+kdfAVV9l3xveEFV3fIaDOvfMx8rwA7IWJ1i45/P5AcqB7KWQgwGXRg L7Qpbd8mU9wm5hbW2JikpdYsS/a2zh+uBSdKFUg/nqkApL0h
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
 drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 1ad814fdec6b..f10e8a624c51 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -122,7 +122,7 @@ static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   duty_cycle);
 	if (ret) {
-		dev_err(chip->dev, "Failed to set duty cycle: %pe\n",
+		dev_err(pwmchip_parent(chip), "Failed to set duty cycle: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.42.0


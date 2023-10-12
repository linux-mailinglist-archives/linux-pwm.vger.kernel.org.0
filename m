Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF61D7C72A2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379579AbjJLQa6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379548AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6190D3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-0004gP-Dm; Thu, 12 Oct 2023 18:30:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-001C5Y-18; Thu, 12 Oct 2023 18:30:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-00F5MP-OO; Thu, 12 Oct 2023 18:30:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 005/109] pwm: atmel-tcb: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:33 +0200
Message-ID: <20231012162827.1002444-116-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Nnxs2Z+6TjrCDsOZJBnYwY/uH1KcfJKA3Q2e5YZ2rak=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6xBpOsuCLOAu6jKEXdke3uZEV5UN2b02+Qn +7L96JdPWuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgesQAKCRCPgPtYfRL+ TsIWB/9Uz5ilKOz8oZGLjrvjzCvIJfpKcyq4RFZbPEbNlqSMjz3v+DhhYsIyOHA8cKBkc9/v29R PMiq/QyhbDYHcZzRxXG6tOdf66Q8C/ubdjsuaY4Hqw0TXInrB04t7kh/ZdsGecagLDEo470Bwil ZgwBfvtw/Jsgbi88hblyVx8SZ32t93VF62Jh6i7uS1xmHJTqk+ZBuytQlj36Vye6KyPspWitMfH muXnWy3/H9+aBiTzdQ8FRpctJY1/D1hRL8pbOzhCBH+jvYkiLtpJhPQuWgOE5Uzyukn+qHeK9Pb Uyzfw+wCvZUx4XR+Mef/jzSvQk6drCWJpmOHOlHJoH8Dy3lU
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
 drivers/pwm/pwm-atmel-tcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 98b33c016c3c..9d335773c2fc 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -327,7 +327,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if ((atcbpwm && atcbpwm->duty > 0 &&
 			atcbpwm->duty != atcbpwm->period) &&
 		(atcbpwm->div != i || atcbpwm->period != period)) {
-		dev_err(chip->dev,
+		dev_err(pwmchip_parent(chip),
 			"failed to configure period_ns: PWM group already configured with a different value\n");
 		return -EINVAL;
 	}
-- 
2.42.0


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122937C72B9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379598AbjJLQbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbjJLQa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4815D6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-0004r9-1p; Thu, 12 Oct 2023 18:30:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-001C6q-Jl; Thu, 12 Oct 2023 18:30:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-00F5Nm-Am; Thu, 12 Oct 2023 18:30:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 025/109] pwm: rz-mtu3: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:53 +0200
Message-ID: <20231012162827.1002444-136-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RXUL+Bul1j2UW9auOAT9GLPfTlq3Ul9LsGuF3oz8Iec=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7JDFiRAfaUzSpbn1O5zVXCcbk9UK/awexG7 hzl25yYy3eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgeyQAKCRCPgPtYfRL+ Tm+YB/9S2XbiX9DtzBXhBIKx83PW/m24e/49yPy5KcTsUHvhqACybAMjtjv+FINmo0meKJsq8TW rvqneSEqb9W8kiyLgZeD8UMdf8ylRLmH+AdBsp3/s43Tf6u7ES9mot/ZYYoT7jnxDZGrVVWvosg PkD4Z5YGEW/77QLQzbF4+jfydAcKS85hNcXBRM/CJM1ZLat4+uDnw36rZYuptXTRJeRB/FyW8JE DnUBeCFC7vPqVBz6+xNnUuxa5CkxeWmofVnXXaXbVjWE9JbaT/6TSAg8SqoKdThC7zcektj1nnY 2/gQ9zRt0zTPSNv39ejbBab/GB3dO+S95hVg71qw40lSELdJ
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
 drivers/pwm/pwm-rz-mtu3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index bdda315b3bd3..45d075560a21 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -274,7 +274,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(chip->dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (rc)
 		return rc;
 
@@ -307,7 +307,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->polarity = PWM_POLARITY_NORMAL;
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -362,7 +362,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!pwm->state.enabled) {
 		int rc;
 
-		rc = pm_runtime_resume_and_get(chip->dev);
+		rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (rc)
 			return rc;
 	}
@@ -399,7 +399,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* If the PWM is not enabled, turn the clock off again to save power. */
 	if (!pwm->state.enabled)
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
-- 
2.42.0


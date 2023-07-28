Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E789D766FED
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjG1O6f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjG1O6f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 10:58:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FCC268B
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 07:58:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvI-00030P-Oy; Fri, 28 Jul 2023 16:58:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvI-002jOH-3v; Fri, 28 Jul 2023 16:58:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvH-008WkT-Ib; Fri, 28 Jul 2023 16:58:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: Drop unused member "pwm" from struct pwm_device
Date:   Fri, 28 Jul 2023 16:58:24 +0200
Message-Id: <20230728145824.616687-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vHLArjMMSRIb90ot50mGOO0fTywEWEiu8B3i2grlvCM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkw9eL7qf3jBzwdxUtpziPucVjFR2xWMS01TS4p 4vmVIb+ieKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMPXiwAKCRCPgPtYfRL+ TvkZB/9XTMNTeSCM5J9Peism41+zVSdcLw8V5beIuN+rif26O8kXZfZtPacqPwv+VuSEzYEjlgw K/eOR9coE1hAjv6LwB/HoCJXFkTD8Y13/6cwGS8oU9lRtwbcN7sdSGHaFmXdt0avd4tCrOP5+Cy p+mzD/R+WG4pir8h6kQN8HVCrHqK6s3gStM3Z91H70W8Q5deYmpvJCHZjYaujSBodHBxgKSp/uM icz/PrBI6XqPbSIG3lcmZcQEMp32cURuvkGz98JpNWcOhvzL9pv2ktwbyVU4ySIk1XmuMIAXZ67 qXKI7bBeCZ5/rf6QvueoMUQtnbZ2VUyu9zVsDs5pRNmesS91
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This member is only assigned to and never read. So drop it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 1 -
 include/linux/pwm.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..f5d0ec7ed962 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -291,7 +291,6 @@ int pwmchip_add(struct pwm_chip *chip)
 		pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
-		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 04ae1d9073a7..46e181a8e4f2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -80,7 +80,6 @@ struct pwm_device {
 	const char *label;
 	unsigned long flags;
 	unsigned int hwpwm;
-	unsigned int pwm;
 	struct pwm_chip *chip;
 	void *chip_data;
 
-- 
2.39.2


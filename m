Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF37EAEBC
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjKNLUe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 06:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjKNLUd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 06:20:33 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D980187
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 03:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-0002ur-Rk; Tue, 14 Nov 2023 12:20:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-008yr1-Dy; Tue, 14 Nov 2023 12:20:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-001JwF-52; Tue, 14 Nov 2023 12:20:28 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/3] pwm: Drop unused member "pwm" from struct pwm_device
Date:   Tue, 14 Nov 2023 12:20:11 +0100
Message-ID: <20231114112009.340168-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
References: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x6SZWVUOGwiklxXnyRg4jbkPkQKr4hgAyuSJOpvUTl8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlU1fq8htP+wjebUBrMjFnGVjywogTj61ONMSde OYrLQ47eYSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVNX6gAKCRCPgPtYfRL+ TgWjB/0bn8TehUGyZDJ49djeBhVemwZJR8+aCd2l5Tz2CivOFiATCrlsqNYlnrBECtX+2xEvbWa 0/Q965MQUnh/EBa9HlBor7s/ldzFbfQHscBpGRBCTEcIQdMAy1OjCBfJsoND8/XGgslXpPseitC uswGNrRf+PeOXmFIfkWUlopL60rKThVBLhNyla0XdeyD9qLFNeEzm12yqZafRZdC6FUnTlwPRvt J2zjrU9S7LUGZ3Hfm56yTOC6bFt1WLOOSLKpdaKq730I9TZv31s5WP9r7K+A+nNBuAczpq7/cdW ozmaWaWyP6t4wxoXs6nOB28WHvsa12nMAGIQ/bUwdKeL/F2R
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
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
index 29078486534d..24bb796d15f6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -265,7 +265,6 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
-		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cda3597b84f2..8cadf9ee8d26 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -79,7 +79,6 @@ struct pwm_device {
 	const char *label;
 	unsigned long flags;
 	unsigned int hwpwm;
-	unsigned int pwm;
 	struct pwm_chip *chip;
 
 	struct pwm_args args;
-- 
2.42.0


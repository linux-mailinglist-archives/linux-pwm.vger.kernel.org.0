Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498A4FB601
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiDKIdz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiDKIdy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 04:33:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494FB36B43
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 01:31:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndpSK-000541-9r; Mon, 11 Apr 2022 10:31:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndpSJ-002LsK-TZ; Mon, 11 Apr 2022 10:31:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndpSH-002YpK-Pp; Mon, 11 Apr 2022 10:31:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: [PATCH] staging: greybus: Drop assignment to struct pwm_chip::base
Date:   Mon, 11 Apr 2022 10:31:18 +0200
Message-Id: <20220411083118.200663-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; h=from:subject; bh=ER/N+DeBOO1Y9RYHSt+mjXMVVEZi8R68GqVf6f45IVE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiU+dSHXk+NBtIcvbw/KEdUTwpCfO/NCaMAnvUfQno iCURsYGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlPnUgAKCRDB/BR4rcrsCSrnB/ 96fl9Nz18OTqBGzJeS0O5PANuWobux9q5FllMui2XbKDNOpOZBPPFU5Yt5mm26LSXrOEaEp4sL6a5k VYq29MzRnBSs/lZpA9t2R8IlGkhAQVzaxQCpmVq9fugujlO0e4qES5nKDNO05edn9xhKYcLM4aFu/a wpqFI87bLcuu68JNZrHN3ffP3JdiuM2gXkTynocViZ+RMfZgy4p7YiQzLjFXkssiblweqPUT98CfZd /BbfSCdcOoKLCv4r6+l2aCo25CLgP+HBIZ51+SNoKubJnzpi+hHxlf3tq2f3rGp1RjRcVcum1r+ZYp MOvtwf1BT1mWW/IG/pxDqvsNROM+Sf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
dynamically") the value held in base isn't used any more in the PWM
framework. All PMWs get assigned a dynamic ID, so the assignment is
redundant and can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index ad20ec24031e..3fda172239d2 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -297,7 +297,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 
 	pwm->dev = &gbphy_dev->dev;
 	pwm->ops = &gb_pwm_ops;
-	pwm->base = -1;			/* Allocate base dynamically */
 	pwm->npwm = pwmc->pwm_max + 1;
 
 	ret = pwmchip_add(pwm);

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1


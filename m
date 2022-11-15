Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12246296F6
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiKOLP1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 06:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKOLO6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 06:14:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FED13CD8
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 03:14:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt8-0006Wk-OJ; Tue, 15 Nov 2022 12:13:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt7-004Qgf-5G; Tue, 15 Nov 2022 12:13:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt7-00GmRf-1T; Tue, 15 Nov 2022 12:13:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/5] pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where applicable
Date:   Tue, 15 Nov 2022 12:13:45 +0100
Message-Id: <20221115111347.3705732-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TEbD2h2Vq8pTTxObIcAZ7hCkTiJkkXYXc6ZjNyh/tyo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjc3RdLeZo58dBqCla/GiFAPBcBizdbDyAWXrTSStA UcgIyo2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3N0XQAKCRDB/BR4rcrsCZaoB/ 96X9T0yyCztKLVKapyr78Lcy1JCbJrMha7aLnlDobBtu3FWLHdAxvpM8aYh1TkNWzNXAhK7USth9CX ePKGhJL92VnCPjErEyk5xYeH/10FjXjVFZViDjRu0LlN28PqDT8Ur+EKbotgpWiO4gdmQcMyhC3qte lZIUJZ+ZtJQjqN+Et33/h4uSCtP+Ku85I35cSTvqWWtVICDknJ0+OxZoU4b6Uz1DVnqrMSHJHBRun+ BLASkE8LxP4uo4REmJbN5oTinSavaeWr8YmiMveKO5390A84D7ILwcms1OVcZMzZUOfjmNlFVWMa3a AGWrjFArSAanwvG/f9QDnqyzC7ckFd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Found using coccinelle and the following semantic patch:

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, bits)
+ regmap_set_bits(map, reg, bits)

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, 0)
+ regmap_clear_bits(map, reg, bits)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 54bd95a5cab0..7246176fce06 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -47,8 +47,8 @@ static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 	int ret;
 
 	if (!duty_scale)
-		return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-					  IQS620_PWR_SETTINGS_PWM_OUT, 0);
+		return regmap_clear_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT);
 
 	ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 			   duty_scale - 1);
-- 
2.38.1


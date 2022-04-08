Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E354F994E
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiDHPYz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiDHPYx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:24:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D7108753
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:22:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRi-0000Ji-Ai; Fri, 08 Apr 2022 17:22:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRi-001pMG-Br; Fri, 08 Apr 2022 17:22:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRg-001zWv-50; Fri, 08 Apr 2022 17:22:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Milo Kim <milo.kim@ti.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: lp3943: fix duty calculation in case period was clamped
Date:   Fri,  8 Apr 2022 17:22:38 +0200
Message-Id: <20220408152239.164462-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=j2XNwdJGyRj+lANNaZ+2vXhlc5sOAAGxZsaIBzKmhRQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiUFM3speKoxe0sxAgFMmo93xGAA3MH9O4+gk9MeDe zgnkqEuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlBTNwAKCRDB/BR4rcrsCaCPB/ 9n4rpXj2XExvbxhuxya85DN2kXayevrvD9SUrxK5Anr1ImYZb3wUcdWGKEIH/BtB9gHMKXAF7uzH+/ DhIXmeX7MuvI4TCuT6FZH3KdoTubm7kYuX+3qyt0ZvTvD/I86m1lwPi08ORo5MRLKKzqSCtL073kb+ 2JrLC1rBZUB0YRZ68QPcllAD3AbwrQh8SbToj5QIGGFXRF9/6cjnQNCDnPO0RBiXHe1vr2jcL/yFEy v5xJbi7tdTJuUliKRlyEOIZ6gpWY5mmHF8uoKdwyx5bIBHyoWB3Gcq37R9fPyoK0RRxD83WftGGaxy swtB2cLBEM+Qw0t7CZql0w056+ocrc
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

The hardware only supports periods <= 1.6 ms and if a bigger period is
requested it is clamped to 1.6 ms. In this case duty_cycle might be bigger
than 1.6 ms and then the duty cycle register is written with a value
bigger than LP3943_MAX_DUTY. So clamp duty_cycle accordingly.

Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index ea17d446a627..2bd04ecb508c 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -125,6 +125,7 @@ static int lp3943_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
+	duty_ns = min(duty_ns, period_ns);
 	val = (u8)(duty_ns * LP3943_MAX_DUTY / period_ns);
 
 	return lp3943_write_byte(lp3943, reg_duty, val);

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1


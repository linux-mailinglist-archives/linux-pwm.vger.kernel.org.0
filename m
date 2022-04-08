Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E24F997B
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiDHPba (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiDHPb2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:31:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C1911984A
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:29:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqY2-000114-9Z; Fri, 08 Apr 2022 17:29:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqY2-001pMh-Dj; Fri, 08 Apr 2022 17:29:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqY0-001zXw-4g; Fri, 08 Apr 2022 17:29:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: atmel-tcp: Make atmel_tcb_divisors static
Date:   Fri,  8 Apr 2022 17:29:10 +0200
Message-Id: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; h=from:subject; bh=2u+T9Ia9KXdlTujpv/Tyn+RH3FPE1wel/5FNMC6y3k0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiUFTDVIIrAeevAfs8D1kFWnsgDBePNjkEUS3rLwKf pK3K3naJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlBUwwAKCRDB/BR4rcrsCbhdB/ 43mkR3myd7/PNjsdIZB0A0/WCEGammpLmCA3yiy7u7NwbhnJ13jytieyKKLrN6EqcCeT1LsZdo6jbw BIW10fampGDUER1OzeRfkCrdd6BSDAjs3Yzd2QBqRrUtZkTZrq4U1t7F2keWSlWUE14zHX2hsO63T+ DcXL/4EBFx7eja/s8p/0brNn34RHY8dDf+4h89kTtAJEC+UI/Wa+12N6JTBjCCFKJiAWx5jN49ialx icydNH1SVoWtejcfJT+VySmlMRIDZxQnhi4kK7TxbuoqvuSk9R5M6KSfUmrkmrxLJL8u2JqJQy64Rk WrGwMPyWPCpKNxsCzzKOjUsWkjvVKa
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

The array atmel_tcb_divisors is not supposed to be used outside of the
driver, so make it static.

This fixes a sparse warning:

	drivers/pwm/pwm-atmel-tcb.c:64:10: warning: symbol 'atmel_tcb_divisors' was not declared. Should it be static?

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 36f7ea381838..9869d3eb8355 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -61,7 +61,7 @@ struct atmel_tcb_pwm_chip {
 	struct atmel_tcb_channel bkup;
 };
 
-const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
+static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
 
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 {

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1


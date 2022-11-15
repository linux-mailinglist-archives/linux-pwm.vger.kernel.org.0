Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618E462A3D2
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKOVPh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 16:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiKOVPg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 16:15:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BFB1D0F5
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 13:15:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HJ-0005Bt-5a; Tue, 15 Nov 2022 22:15:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HH-004WcP-Ih; Tue, 15 Nov 2022 22:15:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HH-00Guk8-Rj; Tue, 15 Nov 2022 22:15:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/4] pwm: Mark free pwm IDs as used in alloc_pwms()
Date:   Tue, 15 Nov 2022 22:15:14 +0100
Message-Id: <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=67Sh+CadgT81I090cww7WtAFSMpXxuv7y697vqIUN84=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdAFcha5RDK/Csdijh+RXlJ5/rD0qN+RkV7pgiJNr qNhACfCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3QBXAAKCRDB/BR4rcrsCZwnCA Cc3xvqmi1E8ngVJ7uaHyqdaIhQavFIq9IkQ/T5DOyTwekg8BE8gScSt2W0Ws5YAKMA1P+5k1InVhd0 jCjGtwIMYC3sVBsAUELVBJf/8vsXkBDdmu7TzWkzflxXdfKDMMvOc/kK+FZibS+DK1aDJkeVMATqr6 zEiZFNvX2pup/pRpOWIpBgq7oN6fwSOEla2qYzTLlkMopabsqHZIH3f1VrHfvfCrTuXLsz9aZqFZ10 g8vbQ34H2YuV/I1wRr5HZ5cNfo+CQ6gCdn8wReig2RVVlE7fxZ6Z84Rbpo5nvzbqsakC+Dlr/AsnUD fFShg/hirsxNmggqkl8DPrqoFLxcsi
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

alloc_pwms() only identified a free range of IDs and this range was marked
as used only later by pwmchip_add(). Instead let alloc_pwms() already do
the marking (which makes the function actually allocating the range and so
justifies the function name). This way access to the allocated_pwms
bitfield is limited to two functions only.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2338119a09d8..b43b24bd3c9f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -51,6 +51,8 @@ static int alloc_pwms(unsigned int count)
 	if (start + count > MAX_PWMS)
 		return -ENOSPC;
 
+	bitmap_set(allocated_pwms, start, count);
+
 	return start;
 }
 
@@ -297,8 +299,6 @@ int pwmchip_add(struct pwm_chip *chip)
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
-	bitmap_set(allocated_pwms, chip->base, chip->npwm);
-
 	INIT_LIST_HEAD(&chip->list);
 	list_add(&chip->list, &pwm_chips);
 
-- 
2.38.1


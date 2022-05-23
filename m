Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26740531BF9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiEWSDK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbiEWSAo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 14:00:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053866AF7
        for <linux-pwm@vger.kernel.org>; Mon, 23 May 2022 10:46:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7I-0005Yq-CB; Mon, 23 May 2022 19:45:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7J-0047dA-0C; Mon, 23 May 2022 19:45:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7G-00BeVf-Ec; Mon, 23 May 2022 19:45:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: Drop unused forward declaration from pwm.h
Date:   Mon, 23 May 2022 19:45:01 +0200
Message-Id: <20220523174502.987113-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=523; h=from:subject; bh=xOoHYb+PJiofNuDq+LFXotli2SK19LANagvkbUfFUz8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBii8gWDQ+ghZgwgJClOP8ImAETeCozrPPRfBkYFhJL O7AOSgaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYovIFgAKCRDB/BR4rcrsCcbFB/ 0T7TD4pCL1kMgc2dgind27+r1Vh0oTQP0zumG1n/1urebErFEJxoDy2KnT9QR2gsvQi2UEYdXGCVxp 3pUvscvH6cuv3IIz8StFBCDpwUPoxzOzzn6/22d5/3Ct8nb8BMPWDsVZKuHopHWG/2y5efDKVUp+wA vFYNffMoCs0gza8CTWb/NxZTPpRZ1AzuOK/2zo/4O9eCrUJXtFLfsDnVrNTYb23Kd8mPwrbugz7NjU 5B/Vy3QwY8Y0SvkVFkKohduJbqGOVcY8UvN9RdDwXPD4rq9xNWZITj0EYkCgtH8Ig4aI6waT7otYwy PMQ0Jda2o6urbqlOmV6pi6R7l6b+3h
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

The declaration was necessary until commit cc2d22477779 ("pwm: Drop
per-chip dbg_show callback").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2aa6de03d7f2..219db73956d1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -6,8 +6,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 
-struct seq_file;
-
 struct pwm_chip;
 
 /**
-- 
2.35.1


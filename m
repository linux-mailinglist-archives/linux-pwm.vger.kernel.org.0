Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161853193D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiEWSDL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiEWSAo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 14:00:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B5D13F24
        for <linux-pwm@vger.kernel.org>; Mon, 23 May 2022 10:46:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7I-0005Yl-Am; Mon, 23 May 2022 19:45:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7I-0047d7-Bm; Mon, 23 May 2022 19:45:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7G-00BeVc-8c; Mon, 23 May 2022 19:45:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/3] pwm: Reorder header file to get rid of struct pwm_capture forward declaration
Date:   Mon, 23 May 2022 19:45:00 +0200
Message-Id: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; h=from:subject; bh=llYdaL7QerVLFCzf8K3IGY2hGij7Vffb7kbTAtyga6A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBii8gSAUNd+82nbEW8OaJzU8p8NecBq5ytxaHMrMmr Mxrset2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYovIEgAKCRDB/BR4rcrsCYZCB/ 4+JwhRzXBSYo0xVD8AwETzPGhPxquU5n2ws7Exblen1HvavidglegbOPh7eKYfirRwpovTq2K5e9+H zHBAfYxbRjy0bv8nx9glGl0QAEEaobZ8cf98ETkeaXAHYENOp/zx8v/QWWA4YA7yyPArZJHYZO7lQC tMgQ6x1dYIDm/V150qU0KeA/fmwquwEfGael63AlfVtHRvF9KnEKRt7BpOWFwFCJlZFq29FB+yyRMt MLZYM9I2YfTBvwAJuWjIxHDvCrHg2eOWu//aajeJ/KnYDiIUTOOTXIda7nX0asdvb2A/iCdrOyGIg5 QS19NJVN5gSmC3g4bnG07sacG3cu/b
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

There is no cyclic dependency, so by reordering the forward declaration
can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9771a0761a40..2aa6de03d7f2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -6,7 +6,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 
-struct pwm_capture;
 struct seq_file;
 
 struct pwm_chip;
@@ -251,6 +250,16 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
 	return 0;
 }
 
+/**
+ * struct pwm_capture - PWM capture data
+ * @period: period of the PWM signal (in nanoseconds)
+ * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
+ */
+struct pwm_capture {
+	unsigned int period;
+	unsigned int duty_cycle;
+};
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
@@ -312,16 +321,6 @@ struct pwm_chip {
 	struct pwm_device *pwms;
 };
 
-/**
- * struct pwm_capture - PWM capture data
- * @period: period of the PWM signal (in nanoseconds)
- * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
- */
-struct pwm_capture {
-	unsigned int period;
-	unsigned int duty_cycle;
-};
-
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 struct pwm_device *pwm_request(int pwm_id, const char *label);

base-commit: 3d593b6e80ad2c911b5645af28d83eabb96e7c1b
-- 
2.35.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8760CE6B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Oct 2022 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiJYOI2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiJYOHw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 10:07:52 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944B635A
        for <linux-pwm@vger.kernel.org>; Tue, 25 Oct 2022 07:04:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:9dd:efb4:9ae5:d7b4])
        by xavier.telenet-ops.be with bizsmtp
        id cE4R2800Z1HY1Pb01E4RNh; Tue, 25 Oct 2022 16:04:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1onKXZ-001R24-CU; Tue, 25 Oct 2022 16:04:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1onKXY-00ERaZ-Ty; Tue, 25 Oct 2022 16:04:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pwm: Move pwm_capture() dummy to restore order
Date:   Tue, 25 Oct 2022 16:04:23 +0200
Message-Id: <08a02c91eec1874ffd3ad7b8388ec7219686204c.1666706633.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Move the dummy pwm_capture(), to make the declaration order of all
dummies to match the declaration order of the real functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/pwm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index bba492eea96c5552..991ecfe1a85d3a98 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -440,13 +440,6 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 	return -EINVAL;
 }
 
-static inline int pwm_capture(struct pwm_device *pwm,
-			      struct pwm_capture *result,
-			      unsigned long timeout)
-{
-	return -EINVAL;
-}
-
 static inline int pwm_enable(struct pwm_device *pwm)
 {
 	might_sleep();
@@ -458,6 +451,13 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	might_sleep();
 }
 
+static inline int pwm_capture(struct pwm_device *pwm,
+			      struct pwm_capture *result,
+			      unsigned long timeout)
+{
+	return -EINVAL;
+}
+
 static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
 {
 	return -EINVAL;
-- 
2.25.1


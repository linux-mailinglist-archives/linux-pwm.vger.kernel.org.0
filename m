Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10A79B2B5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Sep 2023 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjIKVT6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Sep 2023 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbjIKPpJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Sep 2023 11:45:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1FFB
        for <linux-pwm@vger.kernel.org>; Mon, 11 Sep 2023 08:45:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfj5x-0002KO-At; Mon, 11 Sep 2023 17:45:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfj5w-005aEl-D3; Mon, 11 Sep 2023 17:45:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qfj5v-000jCM-83; Mon, 11 Sep 2023 17:44:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        Jens Gehrlein <J.Gehrlein@eckelmann.de>, kernel@pengutronix.de
Subject: [PATCH] pwm: Adapt sysfs API documentation to reality
Date:   Mon, 11 Sep 2023 17:44:54 +0200
Message-Id: <20230911154454.675057-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4A5sSRv+6RINWk6kAEpHjJYkO36CLeG9ZhKErZmmhQg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk/zX1Vs0bXvaqXoNMwDGbIcBj3f5EhZQvBTEuO s/tpKU24g6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZP819QAKCRCPgPtYfRL+ Trb4CACushLrnjlng1M3Ky7EHWpfvK6OfpIYpsFGdGE0eElUoesiWJufbn27KMuggNCX5x88nRi /yIl4IB9VRonJbc52jT4UpG5t+bCUwdgb6ccw/r8m7BixRJOEGJ0TCG/vG0ltOVsXh7YQiu4uhN Pgaf8zNZUTfdZIapCCxbrHxaF0U8ij+aLf9oHPVs7SE5hZh3Q/Y3Hy0/NZ23Y6AffVSoJlRLAL/ yXronRLJfJxntz0TaBYsG3jmSarzNFEo8ca0Oe8Ht7q0VdIorI76YqLejVs9+68QKj5eu2VUMeI Jm6CO9LtOkSLsSQTl3fg0bAZ3S5hBnAZkhc3nzOsDK30jo6r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most low-level PWM drivers support duty_cycle == period, and so does the
sysfs API. Also polarity can be changed for enabled PWMs since commit
39100ceea79f ("pwm: Switch to the atomic API").

Reported-by: Jens Gehrlein <J.Gehrlein@eckelmann.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/pwm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 3fdc95f7a1d1..bb264490a87a 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -111,13 +111,13 @@ channel that was exported. The following properties will then be available:
 
   duty_cycle
     The active time of the PWM signal (read/write).
-    Value is in nanoseconds and must be less than the period.
+    Value is in nanoseconds and must be less than or equal to the period.
 
   polarity
     Changes the polarity of the PWM signal (read/write).
     Writes to this property only work if the PWM chip supports changing
-    the polarity. The polarity can only be changed if the PWM is not
-    enabled. Value is the string "normal" or "inversed".
+    the polarity.
+    Value is the string "normal" or "inversed".
 
   enable
     Enable/disable the PWM signal (read/write).

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1


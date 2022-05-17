Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B552A5A0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiEQPGd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349769AbiEQPGL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 11:06:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B9DE8A
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2022 08:06:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqym0-0005Aw-5K; Tue, 17 May 2022 17:06:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqym0-002tPa-1s; Tue, 17 May 2022 17:06:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqylx-00AK5q-Rw; Tue, 17 May 2022 17:06:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Document that the pinstate of a disabled PWM isn't reliable
Date:   Tue, 17 May 2022 17:05:55 +0200
Message-Id: <20220517150555.404363-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; h=from:subject; bh=XBwdT22YnR7TCc2WW7TU0sQbzIQeU3Jsp4vO8EQXik8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBig7nQBIFAuJbUwTfxKrgM8RA2dxoA8X+RlSqOM757 segCu3qJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoO50AAKCRDB/BR4rcrsCSKkCA CGFVg6sFkdwp0Pm4ctSm//rsXHcGTBqsyTarTthi1cajvSrFJckop/gNIzKT5oQ2/KtJFInqqUw16D /4yyFRBp0yjORNnuwwZxl3/DkyOnPTZdoseAmCcadx2+QfmoGT0gbO3KzKDmiNaOJ6I/hh4cdgWr8o MThzXCVejKJIq98yRLR3/h+yuf+6RA7M2QfSgDMhVY8Jo1HkEIYyUpSUCjC7O5fek7dTht/ni6Z6Xx qlVLGuNg8FdwK4NUQJs6ixSrP99YO2qvqlQa8Piy5QJ3lq4WlVNXIaxO0VkGQULj59jgvJNHQrTHgR +MuSNgbOl0IPXgFEZTv5gksdSGG/p8
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

Some (most?) drivers emit the inactive state when the PWM is disabled.
However there are exceptions, so document that a consumer better doesn't
depend on this behaviour.

Some known exceptions:

  - imx27 emits 0 independent of the configured polarity
  - mxs just drives the output to the last emitted state.
  - iqs620a makes the output tristated on disable, so an external
    pull-down would be required.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/pwm.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index ccb06e485756..fd26c3d895b6 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -49,6 +49,12 @@ After being requested, a PWM has to be configured using::
 
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
+
+As a consumer, don't rely on the output's state for a disabled PWM. If it's
+easily possible, drivers are supposed to emit the inactive state, but some
+drivers cannot. If you rely on getting the inactive state, use .duty_cycle=0,
+.enabled=true.
+
 There is also a usage_power setting: If set, the PWM driver is only required to
 maintain the power output but has more freedom regarding signal form.
 If supported by the driver, the signal can be optimized, for example to improve
-- 
2.35.1


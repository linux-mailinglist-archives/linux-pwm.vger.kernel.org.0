Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C507C7664F4
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjG1HNn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjG1HN1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:13:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA123A97
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:13:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHeo-0001X9-6u; Fri, 28 Jul 2023 09:13:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHen-002eiY-91; Fri, 28 Jul 2023 09:13:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPHem-008RTU-9y; Fri, 28 Jul 2023 09:13:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Drop unused #include <linux/radix-tree.h>
Date:   Fri, 28 Jul 2023 09:12:59 +0200
Message-Id: <20230728071259.590902-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0mXPKqhPEkjrjJqV24sm5Ecf7/Uz2FUbCUkTiy3P2ZI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpTDWVXZxbO+eRusL7l4JWvbDJEq089bbZi1ZLPUX8cFX Lt963FyJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT+bWR/X/gvQonOdWws/LG 28X7DObrJrKUvDopYcWm3tn66NWF9BsKM4Kqdl3iPmXg7d7ZuE3jQHHt9oCVc3JOMtRaunzu0uh +I57+XmfdLZvHAon9Ep/qj8yS+P6vpY9XS038hulRq9KW5t+Nx13MeaVOnGjlXp6tp6MTYvuvYk dURto2tY+BE1+G82Rp32o3ebrkaWh6qvzahMVBk9La45OS1zzo2LrH4sYLUXHukzNCXLO3WMysj bYM2VDtVLVbdceWp/LnRQ7Fv01UFTNNd1wpsO2IXevZ7R4WJt7mS29lJLE8iM3VlVNIufsom/NH 3htWy/ebHefs7/2/Z3NI61r/ayveObVfWmggsls1+vdfAA==
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

core.c doens't use any of the symbols provided by linux/radix-tree.h
and compiles just fine without this include. So drop the #include.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..5b0794858ad4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -9,7 +9,6 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pwm.h>
-#include <linux/radix-tree.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/err.h>

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2


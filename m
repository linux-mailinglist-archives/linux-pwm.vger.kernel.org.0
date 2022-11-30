Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99063D938
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiK3PWJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiK3PWH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0407E422
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuO-0000BM-53; Wed, 30 Nov 2022 16:22:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-001Le9-5q; Wed, 30 Nov 2022 16:21:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Vr8-SZ; Wed, 30 Nov 2022 16:21:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org
Subject: [PATCH v2 10/11] pwm: sprd: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:47 +0100
Message-Id: <20221130152148.2769768-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=po5Jf2sbUy5TRP//519Gve5YpMjZVRA7VAjgr2Lxx68=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3UC9LtBh1xiE8aolWbqnBXElQg62zXpKCuP4wy6 /fPT21SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d1AgAKCRDB/BR4rcrsCdYQCA CgfDPoRQBDf9U5NjoJzyMRsSsMFU6oFaoquTVDoqfZmow6t8yJkLFxWZaiIE7xz+yjuQAIaRgnHRtg 0eJdiWy4J0rr6+RwDEtzmoN57w0H/I7SJfetFm/RoDdmkBr0RVjPwBFacZUrzk99Qz8oU/gWBT9bib DXlm3cNvMJoOqZhutTLtGndCsF/efW5jkK6g2fEcN2BsWSIQ8aecK8OXUduVuaOqQeTOspU5Z4CYfP 8XBJhImmFhoBstg3WcCstvDYuu766Ky0ex1dXCVZmJJdrKCtju0EoHtitHbkLn4qW+y1k3x36s9lvU dVzQ8jsj7qBr4uJttcSr/mdjuD8b1Q
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

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index bda8bc5af976..d866ce345f97 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -83,7 +83,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret) {
 		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
 			pwm->hwpwm);
-		return 0;
+		return ret;
 	}
 
 	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
-- 
2.38.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8E754402
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjGNU4j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjGNU4h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796235AD
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-00085L-Jq; Fri, 14 Jul 2023 22:56:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-00EQSp-RS; Fri, 14 Jul 2023 22:56:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-004u4B-5d; Fri, 14 Jul 2023 22:56:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 08/10] pwm: sifive: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:21 +0200
Message-Id: <20230714205623.2496590-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BMcjYLEWzp9vBXgIDVtaex6uUybr0ko5zvax6INeS/o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZvFVQpNLyF8V35ZOAn7byJn1uVCEuAf/T5B 54N5woKG8SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2bwAKCRCPgPtYfRL+ Tru1CACJbPDN3Zvz+IYCuXCeHQ0g65/VEBd5eI0R/h+CuONNXq3grLikeU+90uMgd5eEGXRaaG3 AKbdyCehV06XJ5mx1bkJIfkVKJDxYMWE3peRsW4c8Lc3x4fnC7ZSkMtdYxYIbvyeDoCC+tFW8N5 5EOG+nISZSHntHn2I6wG3KVW19XmoX4rfCu5IIoKSXm9xat9Q5lqMp0Wy2sIKb8Mh9wt/gdybJU KmveczWY1cnAobiilup+tGg9/nIiFZlP1owK+xkVzkQKkA6JQmLJCv3UmE64U4yl4+29daJh9uQ tTs6ypw/5FeeXee5Y6ElXI1p5xnrBznPK9SRsx9qDkSWd8fw
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

Most variables holding a pointer to a pwm_chip are called "chip" which
is also the usual name in most other pwm drivers. Rename the single
variable that have a different name to be called "chip", too, for
consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index ae49d67ab2b1..25b9b7d9476a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -51,9 +51,9 @@ struct pwm_sifive_ddata {
 };
 
 static inline
-struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
+struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
 {
-	return container_of(c, struct pwm_sifive_ddata, chip);
+	return container_of(chip, struct pwm_sifive_ddata, chip);
 }
 
 static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.39.2


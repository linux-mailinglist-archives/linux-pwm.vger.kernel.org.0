Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD878754405
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjGNU4l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjGNU4i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0DD35B0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-00084Q-Hq; Fri, 14 Jul 2023 22:56:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq4-00EQSZ-U9; Fri, 14 Jul 2023 22:56:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq3-004u3s-DY; Fri, 14 Jul 2023 22:56:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/10] pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:16 +0200
Message-Id: <20230714205623.2496590-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vNzqNzEXA2F3TBtUEKGliHAnJzBhO4w1+O0GP4Fg6O4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZpOSuRH5oVwZmKM4xJCZLoaGIAOLLhX5MdM Kz6GKrly9GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2aQAKCRCPgPtYfRL+ TvX8B/9Zv9mbeoU6enDG44MdfVTxgtHId2qN+Yw5xdLLhGUurYL9krgAOhYHo/6jcadGr1retBE vztQJVjmw1H09aX7wSp7ft8ycsUGH19IaXO6vteGsKcixMOPHgB8ADiJwjkmlDy87iWE2t94/6E 4f+Lb9RQWZ2pcReYWAgkp2eGTFoxFCw9CwmrN+c20MBkqo0ua9UhwyAPINelQN+nm+G4xQzVPm6 ywpK6hn/XEenyWr1SW4iDTthI+VXiScOR73kLWMJVXk1urew/cSgOv+do39nzeQQhlcD2oXYDLn fnFkHUEg2mKefwMHJfFKYfDbL4Ns5iS0B9bUIkGQEUITtmCx
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
 drivers/pwm/pwm-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 4fa6e249e4cf..e5b00cc9f7a7 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -61,9 +61,9 @@ struct kona_pwmc {
 	struct clk *clk;
 };
 
-static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
+static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *chip)
 {
-	return container_of(_chip, struct kona_pwmc, chip);
+	return container_of(chip, struct kona_pwmc, chip);
 }
 
 /*
-- 
2.39.2


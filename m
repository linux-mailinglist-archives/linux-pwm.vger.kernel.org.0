Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879677583E6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 19:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGRRxZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRRxX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 13:53:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD0DC
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 10:53:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLosz-0006eJ-1g; Tue, 18 Jul 2023 19:53:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLosy-000QI1-4m; Tue, 18 Jul 2023 19:53:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLosx-005uI4-A3; Tue, 18 Jul 2023 19:53:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] pwm: ntxec: Use device_set_of_node_from_dev()
Date:   Tue, 18 Jul 2023 19:53:10 +0200
Message-Id: <20230718175310.3946687-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SE8Pq1QJCCHDEq5LmoYzqUC09tfjQ/mn7OOwOBpjyjA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttGC0rHqGyfikhkKtIQ43NwxP17YvS8nuLUwo td61Wq9J2SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbRggAKCRCPgPtYfRL+ Tv4YB/4qPafBX+fj0X07yIlufg4PH6vQEybuzfW0kzFbvOzkbH9hQQnfJ11kB11LAoS/8Y3kzJ4 A1L0nawH06tfqjeO+Af7HbaNpHDxbwK2cqFdIuBD39AIDJSDXXQrGvb340466MGZtfNEuDCsM10 IAUtdt4dVRCmIFC13jP4uM3riM3+oV7KWILKgbFiiOqp2OzANEnOAUAsF22B/QHKrQVaKjRf+fG fAUm7F4d8fssIwWv7I59LIPjD0rZ098Qo89UMB5OzoYI1YjFeuAPhgLpnEA1Y57yCIEjX9PxgSW GWx7xQHmYscISDhPyQaW6db8mGdeLgoA8rFtmYqQ0bmNFept
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

Compared to overwriting pdev->dev.of_node directly, this takes care of
reference counting. It also prevents that the parent device matches this
driver. See commit 9b22c17a3cc5 ("of: Check 'of_node_reused' flag on
of_match_device()") for further details.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ntxec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
index ab63b081df53..7ff5a33c17f3 100644
--- a/drivers/pwm/pwm-ntxec.c
+++ b/drivers/pwm/pwm-ntxec.c
@@ -141,7 +141,7 @@ static int ntxec_pwm_probe(struct platform_device *pdev)
 	struct ntxec_pwm *priv;
 	struct pwm_chip *chip;
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2


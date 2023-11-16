Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756C37EDC4C
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 08:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjKPHuZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 02:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHuY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 02:50:24 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC4120;
        Wed, 15 Nov 2023 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1700121020; x=1731657020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kjXlzMKI4SAh9l1+GsCDYTAjNE/uMze9MZXtOyCmaPM=;
  b=HQLNp6OiqIDewTqK16FrYbVgOkqNFAEBumH+BqcJr1hkkkJT1NNZlale
   7WFR3OvkYqRlvvW4t/R51TP2JX0Yn+vF3eQTlujw1iODESKjt0GNlj8sP
   DmVMVTRU7Gm3ijhPWu+xv7ppBJzjgET9ujCishDMf+UFIMZ41y59fMyQo
   OeTP4aahmFCBuAtBAqhxQUhHyXUOi5EfM/WUAmW0z0nT6vn/mQrFgzN7C
   QeeFdpyUEwjYcF8IoquNEBSYaGP8Ho6fDnWLZyYecA093UWQv6ij1bjlX
   asqXehEZH535cJaaf/S0KgFioL6XsN1z+CWN6LLTjbpJ4p7Rfc68xKBd/
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,307,1694728800"; 
   d="scan'208";a="34010892"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Nov 2023 08:50:18 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 30CB928007F;
        Thu, 16 Nov 2023 08:50:18 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 1/1] backlight: pwm_bl: Use dev_err_probe
Date:   Thu, 16 Nov 2023 08:50:17 +0100
Message-Id: <20231116075017.939926-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let dev_err_probe handle the -EPROBE_DEFER case and also add an entry to
/sys/kernel/debug/devices_deferred when deferred.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/video/backlight/pwm_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 289bd9ce4d36d..3825c2b67c53b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -509,8 +509,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
 		ret = PTR_ERR(pb->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "unable to request PWM\n");
+		dev_err_probe(&pdev->dev, ret, "unable to request PWM\n");
 		goto err_alloc;
 	}
 
-- 
2.34.1


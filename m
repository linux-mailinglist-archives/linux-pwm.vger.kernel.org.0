Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637C8403400
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Sep 2021 08:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbhIHGDO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Sep 2021 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhIHGDN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Sep 2021 02:03:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA967C061575;
        Tue,  7 Sep 2021 23:02:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so1432015pgh.8;
        Tue, 07 Sep 2021 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSiMQk56/574e6Ytth3NtxR5oOiJlmv6sEDHdEKTFyo=;
        b=IgFLsu6o3wNCcCeMn42KktR94q8Yrri9lzDt01z9KHdDvDiU10Ya3yR2pCoG0MSQhN
         OH/DJNSXtyVu4jx7LnsUlm/ddTOC2HqB3geYKh5YTgY/dXZQ3A2Ix9FzOq51cA5FC5bY
         8tgDiW6syjddzGrsXmw9ZyfYsbuOd9LhslnKHMNNu4qGH33sKGjZcUhfX9a3pKXtTKQy
         peY6CgnmlO2RJc6y2dF7efejCgv1ml/rXyvca1QfPVV7ypspJ8ItzwQ/v1/Z0Mw9Z+8E
         YvksFqjFR4VX6jiux6VYxYWwbM9PXk4yEVG12aCzXSg7zh7v0KeM7iLA6yjZ8YTEHRco
         oz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSiMQk56/574e6Ytth3NtxR5oOiJlmv6sEDHdEKTFyo=;
        b=QQAgY0P8FWgJu/Cuc5SXFZfy5Jitdr0ayAlw2OjWyeW1tREJ3mRLbbCUXPLNlqTd5f
         2jRThANO0Gi1hHPeNXWNXO3lS5Zd8SkMvTMeX//IaO3XPxnEA9jzXVItHPUH0ZuwNq41
         r7ZKhjjkKR9kDSKk+kRM+J3y4fu4ntiQ4CVx7ifJy0rIIrc6r0cH1Og6SSQnRwAReqwn
         ahLFsYrGnmQdL959tkYrrMSp9XKj7TCB8IJkP1f8PH2we3HGUWU8R0yUx6GbqsEQJLiw
         B5tbiQmyDfWru9uLOvRxcKDb1rIVYToHTiMntE5CRL5C4X2yU9FVwC4jQ8vsStg4mhv/
         1TqQ==
X-Gm-Message-State: AOAM530LkvOrwQ6o6/Vl3rcW2boUA/eJtZOw3jAiqx6d8kyprrqB93aE
        brgis+3dMMG7j31JAKA2JlI=
X-Google-Smtp-Source: ABdhPJxxdD9YVqtlGJqLn3N06MsfBTPT8u9dPdxrf57YIyUwN9QPAc6f+LFz2S6ih/9X2X7CvODp2A==
X-Received: by 2002:a62:e302:0:b0:3f2:628b:3103 with SMTP id g2-20020a62e302000000b003f2628b3103mr2006006pfh.39.1631080926218;
        Tue, 07 Sep 2021 23:02:06 -0700 (PDT)
Received: from localhost.localdomain ([124.126.19.250])
        by smtp.gmail.com with ESMTPSA id a10sm962969pfg.20.2021.09.07.23.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:02:05 -0700 (PDT)
From:   zhaoxiao <long870912@gmail.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <long870912@gmail.com>
Subject: [PATCH] pwm: ab8500: Don't check the return code of pwmchip_remove()
Date:   Wed,  8 Sep 2021 14:02:00 +0800
Message-Id: <20210908060200.7876-1-long870912@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_remove() returns always 0. Don't use the value to make it
possible to eventually change the function to return void. Also the
driver core ignores the return value of ab8500_pwm_remove()
and considers the device removed anyhow. So returning early results
in a resource leak.

Signed-off-by: zhaoxiao <long870912@gmail.com>
---
 drivers/pwm/pwm-ab8500.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index e2a26d9da25b..51132a076f7f 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -113,11 +113,8 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 static int ab8500_pwm_remove(struct platform_device *pdev)
 {
 	struct ab8500_pwm_chip *ab8500 = platform_get_drvdata(pdev);
-	int err;
 
-	err = pwmchip_remove(&ab8500->chip);
-	if (err < 0)
-		return err;
+	pwmchip_remove(&ab8500->chip);
 
 	dev_dbg(&pdev->dev, "pwm driver removed\n");
 
-- 
2.20.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620EF4027A5
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Sep 2021 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbhIGLQh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Sep 2021 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbhIGLQg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Sep 2021 07:16:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03489C061575;
        Tue,  7 Sep 2021 04:15:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k11so81224pll.2;
        Tue, 07 Sep 2021 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+vtDM7N1inDWNRtsVWvYj/AupNMjks6EQe94H48eVc=;
        b=Kyfxu5HI8vnXUTSjiCDuY9veVBodyGT5tnyhaITlJTOMUqLE3P01SdL5IGe9x/fUa9
         s8dYydvcAcJRMlCFDLfQkpnUo3JzDWOs3z9dQ4ulnw4BQbD/BnHaPXdHb5TLRvGjLgoJ
         t4dPmcKJLzOf7WO/LPuDbS/8LYLWLiVxeMaduG5i1WZqsIxnmx3KtiULU2jc7h4XeY7P
         5b4D+0ovVVTEV+cthKqlQlAdbXmuadmNI6DoKcV+9OPnXdE0/3cZyykEzMw43VYzLrQm
         gNFsz8mtM0wvcb3amGtrfQD241QRLRGH1XiQbhcY4SfC3t0GN96jUbbHBIG/x65msx10
         wcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+vtDM7N1inDWNRtsVWvYj/AupNMjks6EQe94H48eVc=;
        b=MrFlmD4JtxqkKm/79cH8geOa6NcnpQd56v+goFqmfKoRsCs4pYquKKuOkWGukCL8ho
         adne4AVileHOtBH6UoLK3sbnHdMy8ll3NF2rc9LOXBX6ja3OJtk6BtH8Fy+/4Y2/qn06
         47P4wgaTJuHHqX/7zQtw9DJxfrT8CPSL2TEzqmaFfab4M/CEYVUpVHzKxen4SMHmYw5I
         SnM1nHylRATJp/liwMsYj4jpJKBXe0yYP7+FQJ78vNnohLNDcx9UW7cxFs8q7eS8XB0Q
         FAKG1tVgU36Bo9IKGcjnzzl6ntyOyeKKvjgYomUme6Jn0EZzxgLEuvKz2pUk0YW2636K
         XiyQ==
X-Gm-Message-State: AOAM5327UIMgcJhYHHMxI8SUK0DmnkuBqQr14WcPW6d2hbAeeYm/tsyX
        ftIcdHjFI4hs7ac/tH5gRdI=
X-Google-Smtp-Source: ABdhPJxiHJqW1MKSP18+tK3uTQHHGX7r1fOPKTXekMh9uclXRUeb07/sVtBUfRG+jYbF3ZSbYUQvbA==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr14291652plq.73.1631013330477;
        Tue, 07 Sep 2021 04:15:30 -0700 (PDT)
Received: from localhost.localdomain ([124.126.19.250])
        by smtp.gmail.com with ESMTPSA id u17sm10357123pfh.184.2021.09.07.04.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:15:30 -0700 (PDT)
From:   zhaoxiao <long870912@gmail.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <long870912@gmail.com>
Subject: [PATCH] pwm: twl: Simplify using devm_pwmchip_add()
Date:   Tue,  7 Sep 2021 19:15:18 +0800
Message-Id: <20210907111518.15914-1-long870912@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_pwmchip_add() we can drop pwmchip_remove() from the device
remove callback. The latter can then go away, too and as this is the
only user of platform_get_drvdata(), the respective call to
platform_set_drvdata() can go, too.

Signed-off-by: zhaoxiao <long870912@gmail.com>
---
 drivers/pwm/pwm-twl-led.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 6c8df5f4e87d..1b4494581274 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -294,22 +294,13 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 
 	mutex_init(&twl->mutex);
 
-	ret = pwmchip_add(&twl->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &twl->chip);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, twl);
-
 	return 0;
 }
 
-static int twl_pwmled_remove(struct platform_device *pdev)
-{
-	struct twl_pwmled_chip *twl = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&twl->chip);
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id twl_pwmled_of_match[] = {
 	{ .compatible = "ti,twl4030-pwmled" },
@@ -325,7 +316,6 @@ static struct platform_driver twl_pwmled_driver = {
 		.of_match_table = of_match_ptr(twl_pwmled_of_match),
 	},
 	.probe = twl_pwmled_probe,
-	.remove = twl_pwmled_remove,
 };
 module_platform_driver(twl_pwmled_driver);
 
-- 
2.20.1


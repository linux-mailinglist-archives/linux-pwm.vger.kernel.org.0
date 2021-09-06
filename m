Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D534018DB
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Sep 2021 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbhIFJbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Sep 2021 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbhIFJbn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Sep 2021 05:31:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F0C061575;
        Mon,  6 Sep 2021 02:30:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso3910621pjh.5;
        Mon, 06 Sep 2021 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjYsgygAO0K1MY/VaooktkjgOc7TVHV/8M0HRrCiZ9o=;
        b=qGINo34jZzIe3ddUptsVSMZTPVfMpDQa1T8GU5Glzxf42LqmDQSCiE1Ye4gnSDc94t
         ogCHzB4Zscgg4yFKCw3lPWc8Y1DYPUqxHdrFr305xiZ12lRT6zfluwzMh2EmJxWU4ES8
         pcIbs5/INz69t6bya7yW0utgUuJb4+iPi0Dv0BuzleYHE0+FggejvABCB0rKRPDsrBPC
         cRtq/zpXdXoKoRZIgIs2pmPJ0/ah6+nziSy8aVuM/Het6txCcqG7ieD80KTBZQ33D/kD
         hgOkLK7+zsHEqsB6wsWYj2ZQIBhsiP98Pn/OTvOLWugtd7qsMj91vQnyg48yy/SKkYVh
         9jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjYsgygAO0K1MY/VaooktkjgOc7TVHV/8M0HRrCiZ9o=;
        b=CNVreI4W9jvAuchfyYFJG9Q345X8RZNADfZhL89Agz99oB13ecWm46O6q+TrihkeZh
         AnYDDKPC62QdqtVycZ3McGamkZtSkEQW21y5U/gJ+TZq+dJoXRLbYRN6abQr/n9+G55q
         dZMmg9DSgQAOrfWn1aj5fiBY+GLV9PWtESuZMVSfH1c39cd1mDQbTrzPZRPv0Io00Gxn
         P8jnJGIQTHG4RKrfXqONP++vH4vI6+e5URcaiw5jJLRnaS9nOndSVCXXfipIDmZ7/X19
         XcASGe3cUD4ft0Mp3uHuaM7mnJZxozT6bJ1/wyKOBxHuTlx65WFU06YjAcnrucJW2Zkh
         us5w==
X-Gm-Message-State: AOAM5300wLy0KuRPx1fwPWimgCOArvAeQEIprW39DBHw7GwfVAyq9Sog
        J+aM8Wo67svvkyrv2qk3rdPkNsoTxGm/KRip
X-Google-Smtp-Source: ABdhPJzSSp2bZxsFmV+MsX0O5bZuK0Ac9nFgFzjLb0XwxaxzfvF8a8BFu+DEkTbeABmkkcQoOW6euw==
X-Received: by 2002:a17:90b:a48:: with SMTP id gw8mr13148112pjb.145.1630920637596;
        Mon, 06 Sep 2021 02:30:37 -0700 (PDT)
Received: from localhost.localdomain ([111.207.172.18])
        by smtp.gmail.com with ESMTPSA id p30sm6989361pfh.116.2021.09.06.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:30:37 -0700 (PDT)
From:   zhaoxiao <long870912@gmail.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhaoxiao <long870912@gmail.com>
Subject: [PATCH] pwm: mediatek: Simplify using devm_pwmchip_add()
Date:   Mon,  6 Sep 2021 17:30:30 +0800
Message-Id: <20210906093030.459-1-long870912@gmail.com>
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
 drivers/pwm/pwm-mediatek.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b4a31060bcd7..0d4dd80e9f07 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -253,13 +253,11 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, pc);
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &pwm_mediatek_ops;
 	pc->chip.npwm = pc->soc->num_pwms;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
@@ -268,13 +266,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_mediatek_remove(struct platform_device *pdev)
-{
-	struct pwm_mediatek_chip *pc = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pc->chip);
-}
-
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
@@ -335,7 +326,6 @@ static struct platform_driver pwm_mediatek_driver = {
 		.of_match_table = pwm_mediatek_of_match,
 	},
 	.probe = pwm_mediatek_probe,
-	.remove = pwm_mediatek_remove,
 };
 module_platform_driver(pwm_mediatek_driver);
 
-- 
2.20.1


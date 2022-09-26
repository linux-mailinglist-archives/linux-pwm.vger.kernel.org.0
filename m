Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED175EAB35
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiIZPfv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiIZPdu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 11:33:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F64286817;
        Mon, 26 Sep 2022 07:21:03 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MblF60X2yzWh38;
        Mon, 26 Sep 2022 22:16:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:21:01 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:21:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fbdev@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee@kernel.org>, <daniel.thompson@linaro.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next resend] backlight: pwm_bl: Switch to use dev_err_probe() helper
Date:   Mon, 26 Sep 2022 22:27:50 +0800
Message-ID: <20220926142750.2298337-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Resend for adding SoB.
---
 drivers/video/backlight/pwm_bl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index c0523a0269ee..ae858e3bd38f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -513,9 +513,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ERR(pb->pwm)) {
-		ret = PTR_ERR(pb->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "unable to request PWM\n");
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pb->pwm),
+				    "unable to request PWM\n");
 		goto err_alloc;
 	}
 
-- 
2.25.1


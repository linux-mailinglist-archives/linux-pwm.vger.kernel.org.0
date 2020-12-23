Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB112E1F37
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLWQEF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:04:05 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:47972 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgLWQEE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:04:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 8DDE4C0CDA;
        Wed, 23 Dec 2020 16:03:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x5UeQ1o4yb_0; Wed, 23 Dec 2020 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 01B6FC0CAA;
        Wed, 23 Dec 2020 16:03:00 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 5/7] pwm: rockchip: rockchip_pwm_probe(): Remove unneeded goto target
Date:   Wed, 23 Dec 2020 11:01:07 -0500
Message-Id: <0637b8ebea49b30e5e675385225d59d028077421.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Eliminate the remaining goto target in rockchip_pwm_probe() by moving the
code that follows it to the point where it is invoked.

The target no longer serves any purpose as the error-handling portions of
this function no longer share any recovery steps.

Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index d904a5d24885..80f5e69d9b8a 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -336,7 +336,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
-		goto err_clk;
+		clk_disable_unprepare(pc->clk);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
@@ -372,11 +373,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(pc->clk);
-
-	return ret;
 }
 
 static int rockchip_pwm_remove(struct platform_device *pdev)
-- 
2.29.2


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2478C2E1F1D
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgLWQCl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:02:41 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:33932 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLWQCk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:02:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3A073C0E07;
        Wed, 23 Dec 2020 16:01:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s5WhSR3WjPd2; Wed, 23 Dec 2020 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4E5C4C0E1D;
        Wed, 23 Dec 2020 16:01:36 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 1/7] pwm: rockchip: Enable APB clock during register access while probing
Date:   Wed, 23 Dec 2020 11:01:03 -0500
Message-Id: <49ceda3def13f6186073745e99d7315c974bfa81.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
probing") modified rockchip_pwm_probe() to access a PWM device's registers
directly to check whether or not the device is running, but did not also
change the function to first enable the device's APB clock to be certain
the device can respond. This risks hanging the kernel on systems with PWM
devices that use more than a single clock.

Avoid this by enabling the device's APB clock before accessing its
registers (and disabling the clock when register access is complete).

Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while probing")
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Suggested-by: Trent Piepho <tpiepho@gmail.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 77c23a2c6d71..d2058138ce1e 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -332,9 +332,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare(pc->pclk);
+	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
+		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
 		goto err_clk;
 	}
 
@@ -364,10 +364,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if ((ctrl & enable_conf) != enable_conf)
 		clk_disable(pc->clk);
 
+	clk_disable(pc->pclk);
+
 	return 0;
 
 err_pclk:
-	clk_unprepare(pc->pclk);
+	clk_disable_unprepare(pc->pclk);
 err_clk:
 	clk_disable_unprepare(pc->clk);
 
-- 
2.29.2


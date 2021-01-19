Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02B72FBC2D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392097AbhASQOH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:14:07 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:39462 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392051AbhASQNh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:13:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 7EF8025084;
        Tue, 19 Jan 2021 16:12:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BN3w_MxS4KIj; Tue, 19 Jan 2021 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6029A2502E;
        Tue, 19 Jan 2021 16:12:36 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 1/5] pwm: rockchip: Enable APB clock during register access while probing
Date:   Tue, 19 Jan 2021 11:12:05 -0500
Message-Id: <b16d8d5794235c469934c65a810ee00121be2acf.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610976129.git.simon@simonsouth.net>
References: <cover.1610976129.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
probing") modified rockchip_pwm_probe() to access a PWM device's registers
directly to check whether or not the device is enabled, but did not also
change the function so it first enables the device's APB clock to be
certain the device can respond. This risks hanging the kernel on systems
with PWM devices that use more than a single clock.

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
index 389a5e140412..e6929bc73968 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -330,9 +330,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare(pc->pclk);
+	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
+		dev_err(&pdev->dev, "Can't prepare enable APB clk: %d\n", ret);
 		goto err_clk;
 	}
 
@@ -362,10 +362,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
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
2.30.0


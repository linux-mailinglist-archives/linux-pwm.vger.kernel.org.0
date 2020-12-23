Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28572E1F2B
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgLWQD1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:03:27 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:39704 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgLWQDX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:03:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id BDB6BC0D92;
        Wed, 23 Dec 2020 16:02:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UnY-35FmZUnb; Wed, 23 Dec 2020 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id AE71FC0CAA;
        Wed, 23 Dec 2020 16:02:20 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 3/7] pwm: rockchip: Replace "bus clk" with "PWM clk"
Date:   Wed, 23 Dec 2020 11:01:05 -0500
Message-Id: <1c2f85dafab03d6f5cdbcac37e7288de8f90e6d8.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Clarify the Rockchip PWM driver's error messages by referring to the clock
that operates a PWM device as the "PWM" clock, rather than the "bus"
clock (which is especially misleading in the case of devices that also use
a separate clock for bus access).

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 0c940c7508ea..3b1aa5daafff 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -309,7 +309,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pc->clk))
 			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
-					     "Can't get bus clk\n");
+					     "Can't get PWM clk\n");
 	}
 
 	count = of_count_phandle_with_args(pdev->dev.of_node,
@@ -328,7 +328,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(pc->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
+		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.29.2


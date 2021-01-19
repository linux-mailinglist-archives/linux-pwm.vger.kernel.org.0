Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC72FBC2F
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbhASQOU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:14:20 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:47094 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391433AbhASQON (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:14:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id EC4E52507D;
        Tue, 19 Jan 2021 16:13:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1rJEfYNot2xH; Tue, 19 Jan 2021 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id DD9AB2502E;
        Tue, 19 Jan 2021 16:13:12 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 3/5] pwm: rockchip: Replace "bus clk" with "PWM clk"
Date:   Tue, 19 Jan 2021 11:12:07 -0500
Message-Id: <546993443c425dbd4ca1131f4caecbcd25bafb36.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610976129.git.simon@simonsouth.net>
References: <cover.1610976129.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Clarify the Rockchip PWM driver's error messages by referring to the clock
that operates a PWM device as the "PWM" clock, matching its name in the
device tree, rather than the "bus" clock (which is especially misleading in
the case of devices that also use a separate clock for bus access).

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 90f969f9f5e2..b5bab427b5de 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -307,7 +307,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pc->clk))
 			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
-					     "Can't get bus clk\n");
+					     "Can't get PWM clk\n");
 	}
 
 	count = of_count_phandle_with_args(pdev->dev.of_node,
@@ -326,7 +326,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(pc->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
+		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.30.0


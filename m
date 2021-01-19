Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6182FBC32
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbhASQOd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:14:33 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:43752 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392090AbhASQNy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:13:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id A25C624FE5;
        Tue, 19 Jan 2021 16:13:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8UKaFe7EHaky; Tue, 19 Jan 2021 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B14F32502E;
        Tue, 19 Jan 2021 16:12:54 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 2/5] pwm: rockchip: rockchip_pwm_probe(): Remove superfluous clk_unprepare()
Date:   Tue, 19 Jan 2021 11:12:06 -0500
Message-Id: <3c4fa376546368a04d1f35e2c79379cdffce32c2.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610976129.git.simon@simonsouth.net>
References: <cover.1610976129.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If rockchip_pwm_probe() fails to register a PWM device it calls
clk_unprepare() for the device's PWM clock, without having first disabled
the clock and before jumping to an error handler that also unprepares
it. This is likely to produce warnings from the kernel about the clock
being unprepared when it is still enabled, and then being unprepared when
it has already been unprepared.

Prevent these warnings by removing this unnecessary call to
clk_unprepare().

Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PWMs")
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index e6929bc73968..90f969f9f5e2 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -351,7 +351,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-		clk_unprepare(pc->clk);
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		goto err_pclk;
 	}
-- 
2.30.0


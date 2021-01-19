Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1472FBC34
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392147AbhASQO5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:14:57 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:52118 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392132AbhASQOu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:14:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 707412508A;
        Tue, 19 Jan 2021 16:14:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XzNuQnkCdiqe; Tue, 19 Jan 2021 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4D8CD25085;
        Tue, 19 Jan 2021 16:13:48 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 5/5] pwm: rockchip: Enable clock before calling clk_get_rate()
Date:   Tue, 19 Jan 2021 11:12:09 -0500
Message-Id: <4924f18fea9b028cab92ad4e79d957f5cb336b9c.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610976129.git.simon@simonsouth.net>
References: <cover.1610976129.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The documentation for clk_get_rate() in include/linux/clk.h states the
function's result is valid only for a clock source that has been
enabled. However, the Rockchip PWM driver uses this function in two places
to query the rate of a clock without first ensuring it is enabled.

Fix this by modifying rockchip_pwm_get_state() and rockchip_pwm_apply() so
they enable a device's PWM clock before querying its rate (in the latter
case, the querying is actually done in rockchip_pwm_config()) and disable
the clock again before returning.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 228147e9bc6e..6ad7d0a50aed 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -72,6 +72,10 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	if (ret)
 		return;
 
+	ret = clk_enable(pc->clk);
+	if (ret)
+		return;
+
 	clk_rate = clk_get_rate(pc->clk);
 
 	tmp = readl_relaxed(pc->base + pc->data->regs.period);
@@ -90,6 +94,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->polarity = PWM_POLARITY_NORMAL;
 
+	clk_disable(pc->clk);
 	clk_disable(pc->pclk);
 }
 
@@ -189,6 +194,10 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		return ret;
 
+	ret = clk_enable(pc->clk);
+	if (ret)
+		return ret;
+
 	pwm_get_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
@@ -208,6 +217,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 out:
+	clk_disable(pc->clk);
 	clk_disable(pc->pclk);
 
 	return ret;
-- 
2.30.0


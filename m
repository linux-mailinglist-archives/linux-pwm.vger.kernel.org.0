Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700312E1F3C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgLWQEu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:04:50 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:54118 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgLWQEu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:04:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C7D8BBF51F;
        Wed, 23 Dec 2020 16:04:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q_OXOl_ia-w1; Wed, 23 Dec 2020 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 18B43C0E47;
        Wed, 23 Dec 2020 16:03:45 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 7/7] pwm: rockchip: Enable clock before calling clk_get_rate()
Date:   Wed, 23 Dec 2020 11:01:09 -0500
Message-Id: <58dc19f81bbf531d2921c6fb0018a5cc37dc9794.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
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
index 02da7370db70..44425eeb4e81 100644
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
2.29.2


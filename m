Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537869BE92
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfHXPhi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:38 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45448 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPhi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:38 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9A62777EAEA; Sat, 24 Aug 2019 17:37:36 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 4/6] pwm: sun4i: Don't update the state for the caller of pwm_apply_state()
Date:   Sat, 24 Aug 2019 17:37:05 +0200
Message-Id: <20190824153707.13746-5-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824153707.13746-1-uwe@kleine-koenig.org>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The pwm-sun4i driver is one of only three PWM drivers which updates the
state for the caller of pwm_apply_state(). This might have surprising
results if the caller reuses the values expecting them to still
represent the same state.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index de78c824bbfd..39007a7c0d83 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -192,12 +192,6 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	*dty = div;
 	*prsclr = prescaler;
 
-	div = (u64)pval * NSEC_PER_SEC * *prd;
-	state->period = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
-
-	div = (u64)pval * NSEC_PER_SEC * *dty;
-	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(div, clk_rate);
-
 	return 0;
 }
 
-- 
2.20.1


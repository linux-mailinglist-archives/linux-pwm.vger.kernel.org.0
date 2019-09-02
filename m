Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C694A5990
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfIBOks (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 10:40:48 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56066 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbfIBOkr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 10:40:47 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 007B0792C0D; Mon,  2 Sep 2019 16:40:45 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] pwm: rockchip: set polarity unconditionally in .get_state()
Date:   Mon,  2 Sep 2019 16:39:41 +0200
Message-Id: <20190902143941.10631-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Don't rely on *state being zero initialized and PWM_POLARITY_NORMAL
being zero. So always assign .polarity.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-rockchip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 51b96cb7dd25..8eb2db59741d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -90,10 +90,10 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 		state->enabled = ((val & enable_conf) == enable_conf) ?
 				 true : false;
 
-	if (pc->data->supports_polarity) {
-		if (!(val & PWM_DUTY_POSITIVE))
-			state->polarity = PWM_POLARITY_INVERSED;
-	}
+	if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
 
 	clk_disable(pc->pclk);
 }
-- 
2.23.0


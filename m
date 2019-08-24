Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC69BE91
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfHXPhg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:36 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45438 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPhg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:36 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 1371477EAE8; Sat, 24 Aug 2019 17:37:35 +0200 (CEST)
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
Subject: [PATCH v3 3/6] pwm: rockchip: Don't update the state for the caller of pwm_apply_state()
Date:   Sat, 24 Aug 2019 17:37:04 +0200
Message-Id: <20190824153707.13746-4-uwe@kleine-koenig.org>
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

The pwm-rockchip driver is one of only three PWM drivers which updates
the state for the caller of pwm_apply_state(). This might have
surprising results if the caller reuses the values expecting them to
still represent the same state.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 51b96cb7dd25..cc502c8d7e9c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -212,12 +212,6 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			goto out;
 	}
 
-	/*
-	 * Update the state with the real hardware, which can differ a bit
-	 * because of period/duty_cycle approximation.
-	 */
-	rockchip_pwm_get_state(chip, pwm, state);
-
 out:
 	clk_disable(pc->pclk);
 
-- 
2.20.1


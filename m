Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342E09BE96
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfHXPhm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:42 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45472 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPhl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:41 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 7D21D77EAEC; Sat, 24 Aug 2019 17:37:40 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the caller of pwm_apply_state()
Date:   Sat, 24 Aug 2019 17:37:06 +0200
Message-Id: <20190824153707.13746-6-uwe@kleine-koenig.org>
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

The pwm-fsl-ftm driver is one of only three PWM drivers which updates
the state for the caller of pwm_apply_state(). This might have
surprising results if the caller reuses the values expecting them to
still represent the same state.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 9d31a217111d..3c9738617ceb 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -292,10 +292,6 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 
 	regmap_update_bits(fpc->regmap, FTM_POL, BIT(pwm->hwpwm), reg_polarity);
 
-	newstate->period = fsl_pwm_ticks_to_ns(fpc,
-					       fpc->period.mod_period + 1);
-	newstate->duty_cycle = fsl_pwm_ticks_to_ns(fpc, duty);
-
 	ftm_set_write_protection(fpc);
 
 	return 0;
-- 
2.20.1


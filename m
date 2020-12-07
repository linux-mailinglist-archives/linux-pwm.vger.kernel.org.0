Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDB2D126B
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 14:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgLGNqr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 08:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGNqq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 08:46:46 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592BFC0613D0
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 05:46:06 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id CA4ADA9D7D0; Mon,  7 Dec 2020 14:45:58 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: atmel-hlcdc: Use pwmchip_add() instead of pwmchip_add_with_polarity()
Date:   Mon,  7 Dec 2020 14:45:55 +0100
Message-Id: <20201207134556.25217-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207134556.25217-1-uwe@kleine-koenig.org>
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The only side effect of this change is that pwm->state.polarity is
initialized to PWM_POLARITY_NORMAL instead of PWM_POLARITY_INVERSED.
However all other members of pwm->state are uninitialized and consumers
are expected to provide the right polarity (either by setting it explicitly
or by using a helper like pwm_init_state() that overwrites .polarity
anyhow with a value independent of the initial value).

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index dcbc0489dfd4..4551aa2c484c 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -270,7 +270,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
 
-	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add(&chip->chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
-- 
2.29.2


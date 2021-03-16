Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1297133DEF9
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Mar 2021 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCPUiz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Mar 2021 16:38:55 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:53548 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhCPUiZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Mar 2021 16:38:25 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 2B2A7B3384C; Tue, 16 Mar 2021 21:38:19 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] input: misc: max8997: Switch to pwm_apply()
Date:   Tue, 16 Mar 2021 21:38:13 +0100
Message-Id: <20210316203813.48999-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

max8997_haptic_enable() is the only caller of
max8997_haptic_set_duty_cycle(). For the non-external case the PWM is
already enabled in max8997_haptic_set_duty_cycle(), so this can be done
for the external case, too, and so the pwm_enable() call can be folded into
max8997_haptic_set_duty_cycle()'s call to pwm_apply_state().

With max8997_haptic_set_duty_cycle() now using pwm_init_state() the call to
pwm_apply_args() can be dropped.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/input/misc/max8997_haptic.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 20ff087b8a44..c86966ea0f16 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -58,8 +58,12 @@ static int max8997_haptic_set_duty_cycle(struct max8997_haptic *chip)
 	int ret = 0;
 
 	if (chip->mode == MAX8997_EXTERNAL_MODE) {
-		unsigned int duty = chip->pwm_period * chip->level / 100;
-		ret = pwm_config(chip->pwm, duty, chip->pwm_period);
+		struct pwm_state state;
+		pwm_init_state(chip->pwm, &state);
+		state.enabled = true;
+		state.period = chip->pwm_period;
+		pwm_set_relative_duty_cycle(&state, chip->level, 100);
+		ret = pwm_apply_state(chip->pwm, &state);
 	} else {
 		int i;
 		u8 duty_index = 0;
@@ -173,14 +177,6 @@ static void max8997_haptic_enable(struct max8997_haptic *chip)
 			goto out;
 		}
 		max8997_haptic_configure(chip);
-		if (chip->mode == MAX8997_EXTERNAL_MODE) {
-			error = pwm_enable(chip->pwm);
-			if (error) {
-				dev_err(chip->dev, "Failed to enable PWM\n");
-				regulator_disable(chip->regulator);
-				goto out;
-			}
-		}
 		chip->enabled = true;
 	}
 
@@ -293,11 +289,6 @@ static int max8997_haptic_probe(struct platform_device *pdev)
 			goto err_free_mem;
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(chip->pwm);
 		break;
 
 	default:
-- 
2.30.1


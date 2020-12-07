Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6E2D126C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLGNql (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 08:46:41 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:57390 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGNql (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 08:46:41 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 0BF9CA9D7D2; Mon,  7 Dec 2020 14:45:59 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH v2 3/3] pwm: Drop function pwmchip_add_with_polarity()
Date:   Mon,  7 Dec 2020 14:45:56 +0100
Message-Id: <20201207134556.25217-4-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207134556.25217-1-uwe@kleine-koenig.org>
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else. All
other users of pwmchip_add_with_polarity() are gone. So drop
pwmchip_add_with_polarity() and move the code instead to pwmchip_add().

The initial assignment to pwm->state.polarity is dropped. In every correct
usage of the PWM API this value is overwritten later anyhow.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/core.c  | 25 +++----------------------
 include/linux/pwm.h |  2 --
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f16f5365d3c..78611487d887 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -260,18 +260,15 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 }
 
 /**
- * pwmchip_add_with_polarity() - register a new PWM chip
+ * pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
- * @polarity: initial polarity of PWM channels
  *
  * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used. The initial polarity for all channels is specified by the
- * @polarity parameter.
+ * will be used.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity)
+int pwmchip_add(struct pwm_chip *chip)
 {
 	struct pwm_device *pwm;
 	unsigned int i;
@@ -303,7 +300,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
-		pwm->state.polarity = polarity;
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -326,21 +322,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwmchip_add_with_polarity);
-
-/**
- * pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- *
- * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used. The initial polarity for all channels is normal.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwmchip_add(struct pwm_chip *chip)
-{
-	return pwmchip_add_with_polarity(chip, PWM_POLARITY_NORMAL);
-}
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
 /**
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..8f4eefd129aa 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -392,8 +392,6 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
-int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-- 
2.29.2


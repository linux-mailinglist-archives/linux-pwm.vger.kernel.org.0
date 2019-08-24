Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C969BE90
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHXPhc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:32 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45416 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPhc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:32 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id D642777EAE6; Sat, 24 Aug 2019 17:37:30 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/6] pwm: let pwm_get_state() return the last implemented state
Date:   Sat, 24 Aug 2019 17:37:03 +0200
Message-Id: <20190824153707.13746-3-uwe@kleine-koenig.org>
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

When pwm_apply_state() is called the lowlevel driver usually has to
apply some rounding because the hardware doesn't support nanosecond
resolution. So let pwm_get_state() return the actually implemented state
instead of the last applied one if possible.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 72347ca4a647..92333b89bf02 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -473,7 +473,14 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 		if (err)
 			return err;
 
-		pwm->state = *state;
+		/*
+		 * .apply might have to round some values in *state, if possible
+		 * read the actually implemented value back.
+		 */
+		if (chip->ops->get_state)
+			chip->ops->get_state(chip, pwm, &pwm->state);
+		else
+			pwm->state = *state;
 	} else {
 		/*
 		 * FIXME: restore the initial state in case of error.
-- 
2.20.1


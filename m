Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1068F1A5298
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Apr 2020 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDKPfb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Apr 2020 11:35:31 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:50427 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDKPfb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Apr 2020 11:35:31 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d41 with ME
        id RTbV220010scBcy03TbVS0; Sat, 11 Apr 2020 17:35:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 17:35:30 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] pwm: Add missing '\n' in log messages
Date:   Sat, 11 Apr 2020 17:35:28 +0200
Message-Id: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..bca04965bfe6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
 		dev_warn(chip->dev,
-			 "requested disabled, but yielded enabled with duty > 0");
+			 "requested disabled, but yielded enabled with duty > 0\n");
 
 	/* reapply the state that the driver reported being configured. */
 	err = chip->ops->apply(chip, pwm, &s1);
-- 
2.20.1


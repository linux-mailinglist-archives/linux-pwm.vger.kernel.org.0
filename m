Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE63DEA3B
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfJUK6n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:58:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJUK6e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:58:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so3609679wrs.9
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGCIBmW/Cb8USuy1i53TIbLdFLqD0xjnRbjcRmVWcp8=;
        b=bWy6amsZ4Lr7kyk5yk1vWb6AIn081dpVGpAK0n8WiVZPwisGDPAEZZ878bTX6VP/pi
         AlCM8QqDt7rE5Ae28DHG81R5hSQcmQgwr/HmhKL1Zul9LeZtXCv/bYqJTggI8+SKMbwf
         pRN3Fzq6o71L2TWvabGnUNLEvJxhpsbE/zRosbcsBmyhtaAWgNsNXXyCgb+touffqclw
         +akClaB2fVI1bbY/Hjte4qXmInLiJtMbigCyJkCed4kqGZitBT2MBVHMQRIakWeUqdqg
         Almnuzry4ecHpB28844CfJDZMA2i15xHkpOs78sYvyKZ5s8did3VWLtWekeYF6qKfcRi
         vcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGCIBmW/Cb8USuy1i53TIbLdFLqD0xjnRbjcRmVWcp8=;
        b=P8etwrxu7FqNWyaeJ6BgIa/p4gaUsYZVCM4WkXUc6jUmaCf2qF4U/1pl9jKVH0dbIu
         nt05Lm4gi4QeTkTSuyBSh3kbfZ0I63/CuReo7/2CJd+y5ZHHceLMjUggR636vxbYIItO
         QqmkVWcucxC37YCe2e/0z3S7Ljsl3F6xVpazAh+29RJjVo5wOb+po9VjgIVf5x6PN87v
         Zxt0XNv4jKYxgORJB1TDaWECvDEcaCoiN1o65dGH011CbiDcJlAFMlCBCLxLkFiU4xgy
         bdulVAkC/+OVFW0nQFM5bXjFtoV0xwiUipLVsxOI7WAEKHAr3xVW4fZF2YnSEXGEUrVh
         Uyfg==
X-Gm-Message-State: APjAAAWVeAwtbwFPvTxA//qxy0a7gzWrGhTQG6P9BopW/iM6FjMwLaBi
        e21J8e49b5J0H3/83eLA6D2A9v4d
X-Google-Smtp-Source: APXvYqzU2/i9teOkKcrXQ4rHgv11qn+3CQG0sgdwOEPkNM7aJZDLjZqWrFwsuBT5qY3xTRRQJLa04g==
X-Received: by 2002:a5d:5690:: with SMTP id f16mr8484858wrv.380.1571655512561;
        Mon, 21 Oct 2019 03:58:32 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id i5sm12945933wmd.21.2019.10.21.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] Revert "pwm: Let pwm_get_state() return the last implemented state"
Date:   Mon, 21 Oct 2019 12:58:30 +0200
Message-Id: <20191021105830.1357795-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
the last implemented state") causes backlight failures on a number of
boards. The reason is that some of the drivers do not write the full
state through to the hardware registers, which means that ->get_state()
subsequently does not return the correct state. Consumers which rely on
pwm_get_state() returning the current state will therefore get confused
and subsequently try to program a bad state.

Before this change can be made, existing drivers need to be more
carefully audited and fixed to behave as the framework expects. Until
then, keep the original behaviour of returning the software state that
was applied rather than reading the state back from hardware.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6ad51aa60c03..f877e77d9184 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -472,14 +472,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		if (err)
 			return err;
 
-		/*
-		 * .apply might have to round some values in *state, if possible
-		 * read the actually implemented value back.
-		 */
-		if (chip->ops->get_state)
-			chip->ops->get_state(chip, pwm, &pwm->state);
-		else
-			pwm->state = *state;
+		pwm->state = *state;
 	} else {
 		/*
 		 * FIXME: restore the initial state in case of error.
-- 
2.23.0


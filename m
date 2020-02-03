Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5CE151205
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2020 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBCVnK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Feb 2020 16:43:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34441 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBCVnK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Feb 2020 16:43:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so8286789pfc.1;
        Mon, 03 Feb 2020 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4utvhxtA7zvr4Iu+DFpm/vNXzWR8TFP5LHSqSIJBCWo=;
        b=AjF/en/PwCT4W2EHQ5+3AviOlyIo9uYNWYWol1vasV9sf8IdjnbhX0VVoyzxvrEf/D
         GFZdJygPyQAUvAfYJcknUmlv/ZtEEyBxTFc9ZsL0fnmwF2hX+u7HoCsDurh8jvMg1FWI
         ZWHACVb5FbOXuB2KNwYM0j5X+9+pI30sBWK2io4DQOsjatvjLtJ3k8LvU5jD6h+0bApj
         nji7QoFrpIa/EfyS9aE1H8PnCdnd46+Bv/wWa0lI/yY3MRhmscM5HAz8FUe4N0GHhpMf
         AblamewqllV4aFJNX9rqC38Bfrua5qSGpBXfEvK4rxqB8uDXrzrhq3DbRWcLI4ZsALte
         Lfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4utvhxtA7zvr4Iu+DFpm/vNXzWR8TFP5LHSqSIJBCWo=;
        b=kaYy9bn6CiQJOQv9VcSKd6kZQoVT9NL3NbS85qC2V8bRe/69zKYV5SV6I7SMfcKJA/
         X4JDPrs5idQaw0W+jtGWtXrkcTnD6ZQUV2syvh0qr04N3q13CxKgaq2IYh+geFUa40nH
         INHMv6ED2YVf+Yj27ZQJE65TRmF5aCfp/pmsFYsrDv12N9RBT9wfBtpvuCSE/vx3r2tI
         2UUVHjcj9J0+jeDJNf/UNGBlJ75z6J4jXdIhqb3+eUZyK1SkQgPhKuv58CbyTaFSNvtU
         CASOdC/6X6NFSYmqzphxoTdMoP/P+a5zPl+EfASS4QihMdd7Dtc7Sj7UqyoTXI+eN6up
         W8qA==
X-Gm-Message-State: APjAAAUEZSn4dHuHz2AAVFyZHTcrPXGsLfnPs50ux/Pw1Mjg2LQPAPUk
        nSjGth1wSFk6dLPRC2andZlYyNzo
X-Google-Smtp-Source: APXvYqzqvmjhjyfBbCiXK6ubgSKYGKoWsiXrEE1FSXHo7/8RTwhszxSZmlrQQ8mbNKUBQU48ZmIo+A==
X-Received: by 2002:a63:6c82:: with SMTP id h124mr27098458pgc.328.1580766189626;
        Mon, 03 Feb 2020 13:43:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c26sm2947558pfj.8.2020.02.03.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:43:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bart Tanghe <bart.tanghe@thomasmore.be>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH] pwm: bcm2835: Dynamically allocate base
Date:   Mon,  3 Feb 2020 13:35:35 -0800
Message-Id: <20200203213536.32226-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The newer 2711 and 7211 chips have two PWM controllers and failure to
dynamically allocate the PWM base would prevent the second PWM
controller instance being probed for succeeding with an -EEXIST error
from alloc_pwms().

Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pwm/pwm-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 91e24f01b54e..d78f86f8e462 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -166,6 +166,7 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.base = -1;
 	pc->chip.npwm = 2;
 	pc->chip.of_xlate = of_pwm_xlate_with_flags;
 	pc->chip.of_pwm_n_cells = 3;
-- 
2.17.1


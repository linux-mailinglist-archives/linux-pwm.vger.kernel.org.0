Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA410565C6
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFZJkU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 05:40:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJkU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 05:40:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so1886075wru.10
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dDT8eg0qQglLJffVR+CUM2VadBQyF4Yx180CNIOPmc8=;
        b=lRhqjR7DOi8Dumkb1IfZoURBu+6nr9675WtzdFyf0H+eI1adKt9WbqmTda+qzBzYIb
         f6tvrEdSX8caYRQ9FUOrBjEHZpQFT963XK0CmZDPUL3O38tlRPw7GXxLvPS12xLRLh2d
         RTCO/tFUT9yNqVOq3iZJ+TpWGlUuUnlmqs5DMydgYy0gkUEEh+rKUapp38DNfgLElkEZ
         2f7xlz13GOfUkHR5BXST7zGOnnAiSCvzCIaX90rsAiI1OTrsyzHddRhMJ9mBY2oexrF9
         2rMy8+CXqhNwJnG5T2RG9rKtLpiwuwmIhn/Xj/PKifdiEKCgAKGJrKT57HkB/oxp7aOZ
         lfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dDT8eg0qQglLJffVR+CUM2VadBQyF4Yx180CNIOPmc8=;
        b=R9dD9NLbfm7xs6et/K0zCJP/6EdfDohx8hW//918fYdaR+1KymDiurCYpvp/XlqZyF
         8Ses/BR7q5WOhhZ9cKVUbsBkWksGsBv3PGeYi4TZ0FkSB/x6v8s2WX7cA0TF1GdJNy+f
         pEXDbjZwuZBE6l4G3poI4A9H0a6rMIHF95uEfKtjTG5eV0BJsWlcntNZmknTVf5itkaw
         wKkeOvDs7F6vU6PMVFvWXca9cayzikw/TiLOIPW7uxZ35zWDB/dtKcIINi0wqOpyTf7F
         sf0ToLW4e8F/31VpFsBlvMkhwDlH03y4U7WEVpn7W4/yL/3HfswG7iZRiTYUkZ0EUyQM
         a6Pw==
X-Gm-Message-State: APjAAAW0TiiyCVPxZj0wHQ8N+ZoGdFIjn4UPGxf2SHRwpkea7gwITFW/
        t0+GcklKUb4DB1e6u2W/moo=
X-Google-Smtp-Source: APXvYqxV5C6Sr/NCGyl80yLoFdGFxP3LBokpznqGWtXZcb6AuVW30B/MepdRASA9ugRQJGJZsJI3xg==
X-Received: by 2002:a5d:4086:: with SMTP id o6mr2937873wrp.185.1561542018018;
        Wed, 26 Jun 2019 02:40:18 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n5sm1184224wmi.21.2019.06.26.02.40.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 02:40:17 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH] pwm: fsl-ftm: Make sure to unlock mutex on failure
Date:   Wed, 26 Jun 2019 11:40:15 +0200
Message-Id: <20190626094015.16540-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Upon failure to enable clocks while trying to enable the PWM, make sure
to unlock the mutex that was taken to avoid a deadlock during subsequent
operations.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 6a4106c65cb4..efc226bda214 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -342,12 +342,12 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!oldstate->enabled) {
 		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
 		if (ret)
-			return ret;
+			goto end_mutex;
 
 		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 		if (ret) {
 			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
-			return ret;
+			goto end_mutex;
 		}
 
 		regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
-- 
2.21.0


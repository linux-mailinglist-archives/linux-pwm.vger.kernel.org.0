Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93941E9EE7
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFAHLx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHLw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 03:11:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1070C061A0E;
        Mon,  1 Jun 2020 00:11:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r2so8432273ila.4;
        Mon, 01 Jun 2020 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d2wjzu5hNjBN2lnlNJbakDYVSmEeQaYOmEfaX/yDMFc=;
        b=m/WEJHugJCTG/xEig0okL0reL6mjy1oztoHleupNk/tPGUEeHzXDx8zxLd1JSzUWYT
         LzePiPU6tBjB0vePm4fNQXoHI4NckA6HjK/m/mg1xO7X6ztL39PgnKhL6Nzhw7/zjC5l
         Immnx25barRzXWFkkL5KWJLjjtBRyTK1ADOObQSEivoGL5Q3YajlMn4AGxEUewLFCW+D
         C5ZHpRygttv/X4oQab2DVm/5Gnn5ZogEr/3lhZzXOYVQaPlbQ9RtTtNDK4wMy1+YRsiI
         Dzpzc+Ppvccub94Do7ttA0vYRd23QBFq14Vbc90/lOsYSHRMIiNb6NMh8P1N6VJ/4STC
         mzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d2wjzu5hNjBN2lnlNJbakDYVSmEeQaYOmEfaX/yDMFc=;
        b=DSx/1CctVtV+VTCgBBuNWcF1z/UT7WorCqthva6h38duqYJOPOtazDmPQqGQ0OTP1X
         Zf/jlcNpx3/ljxOCohxhF4sYhatNIKeDrGmpi6Slzm+u7J+TbVKUVF0tS7/uRVkHTNEY
         FKhkHQbWxEpj1GuRcg9XRXyPwIUUFu8eZbQ/au/8nscGCvsXSH4DKJYPoV2/VAWu1a1K
         Tzqhk7bqJrGsQkjHGjeIIxJjNJZJGRU98+mxpo7m/t49pRZD1OUBJXDXS4fwDqprAoo1
         eHlX1RA7RGrFwKoaKrwnF1bgaCpE8W3hf3ZY76DQHPSi6PPt92bbnkoC0En4U8ERy0Wv
         bXPA==
X-Gm-Message-State: AOAM5319ol26Ef3uiUc8Km9ExWSwG4LGxFNhS2JN7iEe2rriOpYYXaMK
        7rjevwu3ElPF8gcCKwCTjZ8=
X-Google-Smtp-Source: ABdhPJyCwgJytqUeyj8X/+cDcO+HQLzJ1l9BhFjpdwK/FGaM3IwMnpaG96lEeumn1BFl+g+VofVDNA==
X-Received: by 2002:a92:6411:: with SMTP id y17mr20187975ilb.161.1590995512033;
        Mon, 01 Jun 2020 00:11:52 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id p75sm9366454ilb.23.2020.06.01.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:11:51 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] pwm: img: call pm_runtime_put in pm_runtime_get_sync failed case
Date:   Mon,  1 Jun 2020 02:11:16 -0500
Message-Id: <20200601071116.69508-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Even in failed case of pm_runtime_get_sync, the usage_count
is incremented. In order to keep the usage_count with correct
value call appropriate put.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pwm/pwm-img.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fb..599a0f66a384 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -129,8 +129,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
 	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(chip->dev);
 		return ret;
+	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
@@ -331,8 +333,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
-- 
2.17.1


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312AC1ED8BA
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2020 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFCWk7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Jun 2020 18:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgFCWk6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 18:40:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC4C08C5C1
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 15:40:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so2656712pgm.0
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hfaVvEQXRU/NfnUqDeckNY3kMdmo4vte9DRkgTctMdo=;
        b=UdAJsijgBYMmdkz/7ucDwbwRbxZgfxsqQeUrLPgPU9MMs6qdFWwb5qCTrzjX7gF4dD
         ew8YtyGD6+F/DbF6a+ze43Yyx1EFIO+G/fGfLeqpxgvBiSmOC0rzFfJGgG6K86hksFpu
         2BEhkippRVb6I/7ddm/m7cFNBNjXhNC0KSnNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hfaVvEQXRU/NfnUqDeckNY3kMdmo4vte9DRkgTctMdo=;
        b=ZBv5+dQaqm2lvlnjkVnnCmitOuj7zXW4DQrXE3xTeJ09x59Xjn1AnldPrvk99WUFPM
         rP+TFim/agaasAl4dTavWTlZcFWVCe9TnBc/UFqVQlpJjHdL/yGyuKuRipbhiuhRIOI5
         o0UsbWutRQl3skUDlyl6v/xAHDeiv7JOw8w+wTLuQBi4WDlczLT/nNTnfhsc36+bKRKJ
         rBGCX5Ah5Z6X2wW+61UHmjDzdiFrL0Bnorpa1RyqX/OKt+wqnCZMn72xrzx7x+RQiNzg
         7MyYKaFSqcS3Gk54j94aphjcuPMcoa71K4yXx1GMO/RckWcZhJmOI97EmP3wG17D7T7V
         emZg==
X-Gm-Message-State: AOAM5328FKHPWDbKMc4+dmJ2fLOcJXks72Bxb2veEy4ksladD56VtcS6
        QpfcnRN3DDiMrqTV5+FnJ4dmoA==
X-Google-Smtp-Source: ABdhPJxySiM/Q8GchHlVngN81CEaDSJz0PjV6xqWSV7FrESFXDuOH11mdHLy95tXYyWivV5urxGGvw==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr1242439pfu.164.1591224057921;
        Wed, 03 Jun 2020 15:40:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm2204424pgn.58.2020.06.03.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 15:40:57 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:40:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <202006031539.4198EA6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The IS_ENABLED() use was missing the CONFIG_ prefix which would have
lead to skipping this code.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..6b3cbc0490c6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
 
-		if (IS_ENABLED(PWM_DEBUG))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
 
-- 
2.25.1


-- 
Kees Cook

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679D7453E3A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 03:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhKQCL5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Nov 2021 21:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhKQCL5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Nov 2021 21:11:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49DC061570;
        Tue, 16 Nov 2021 18:08:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq11so1004628pjb.3;
        Tue, 16 Nov 2021 18:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/UAMENAQZVjitbkP9kKOozR9MA0Bb9mgqzEAIZQPrE=;
        b=NwyKoqxQ47nrx7lSYUycTjmZXBLRbi85Oj1d6VB8S4B0rn8ntzv7HJ7eq5bTEljCuO
         U/bGOJUN5XUP/JKwmFXC7FbiqPsmRbyNMWAS6X7c5PI5hvmmvwxqYeUuEE1/sVOQdKpw
         T74yCTy6CQu70Bc/akQM90rMy0p7CtAm/GmzPj3Bx2TTpTdj+GwZtUUz8FmyoaTwKqsX
         YoJd47K9PoraSgEykMtGexu6Mt0jaTgixjLVMMaTmyDkQhuqFBFG3vIP5+FQ6+YivZXD
         JAM/DX9rgvRidnZnDHYuTuXwEdnFX7s2wBYYyjsce6r9FWUt74edZJEu6d9ImgP+gNur
         yeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/UAMENAQZVjitbkP9kKOozR9MA0Bb9mgqzEAIZQPrE=;
        b=U91u0hglwQLYhQnbNep5zWSn2Ow9qCF1CMPSofuQNm0gPN7Ykjmjkdv4Pw71Er9SdZ
         06RU962nttKCH8nMlRpE+A+a5re2loh03h9HjWON2dOxxKrxuLOXDkTBTivWIVxRtfIS
         NOV+dT3Sp/26EoS1DoqnmB4aQaAhma4YwJ0B5SgF7OCRR1Vs3+9DbreJtqqIEwzIhkN2
         1r0zceXEdsWSxtkKZe/DxTJ424/+nXtISKWVWzHGPdUWbVeSgvDeSEYJ8RPxosihyIK0
         U/iwPfphGdoe+emEcOtYNq7wFzw6LaxJ+ehtmWmD6aFh+DjB+410QnyWxXj/QE+IUo7I
         Z82Q==
X-Gm-Message-State: AOAM532GSzfqjEnaHflyjvFn8OANcIwgllne/sYyIVhI6BIueuARXz6C
        LqCA0S8IoM/6mmv/4nHdD3c=
X-Google-Smtp-Source: ABdhPJxKeop46ZbtcDdfEUpDFWioAKB7JT+ByabLMny9uhgR9P5F80UGxwnHhMRZdhxkhCAU+B67bg==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr4922243pjb.54.1637114939209;
        Tue, 16 Nov 2021 18:08:59 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o6sm3332087pfh.70.2021.11.16.18.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:08:58 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pwm: rcar: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 02:08:54 +0000
Message-Id: <20211117020854.159472-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. If the divisor is unsigned long, using
div64_ul can avoid truncation to 32-bit.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index b437192380e2..fb475c188e1e 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -111,7 +111,7 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 	u32 cyc, ph;
 
 	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
-	do_div(one_cycle, clk_rate);
+	div64_ul(one_cycle, clk_rate);
 
 	tmp = period_ns * 100ULL;
 	do_div(tmp, one_cycle);
-- 
2.25.1


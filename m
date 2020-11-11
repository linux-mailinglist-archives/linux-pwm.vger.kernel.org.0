Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3E2AF8C4
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKKTPC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKTPB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:15:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C624C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:15:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so3596492wrb.9
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkr0WLco4uBLugzGlKBSOKTZjoWTigiQkc3F7HbhM9Y=;
        b=PFBUUn4+teEAvKkqraC6L1xDpq8KlxQ9HpBZeG3LNPKtQ5+47HPLY9ID5BEw8+DLQO
         TogpZR2Vp1Mc1wHOVe4+aJPNg+4zqU3aubCdDM7tFsu/MczOnxB0i6a6OevKZmjt5Cmh
         qnDTqIh3o06AG9IkqowtwloixfFgSsEZngA4vHM2f2n9gchVghSqqjF1BOSipiymxgI9
         FfwUrAXl847tG1FpACNQCv2eYs+91lXn9FuRXZmydcO8FwG2I2mWyuu5p9wIuD46zeeX
         M3zQUZHW6zmygz6AbCdb8nnwZJrZy/zptC/fLSLeYAYan56Yh9fzWd2USMeqNzpeieP7
         OMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkr0WLco4uBLugzGlKBSOKTZjoWTigiQkc3F7HbhM9Y=;
        b=hveDqDiNqlEK2KoDvCQ13v2iW07RY39UNtTuXoxyxElpFrVeUoL1eAYpnedvu+m1pT
         nUu3AP+wJO36q7UGBaVWYielLPhs62yQpkZJFzzpzpVabeRUFbJ0bjANKCWnYq+CYro9
         uWwn23DrgerzG89c7R9MD+5Z3XMhdU0+Nj/QZ7B/Lw8QvQk6hzZIcqGni8dGOR8wLAe7
         tDQIwANOcGVfFcDxhtxiUMaHP30QbtJW6OHreWfLkMbXIcqCUS3af48p4eF1RF4xtV1B
         x5kU4Thlli8ElnkbjY9+AxGjLsaencvdmNzD1Oh8xvDCXkgeK0QmPzR6qwfC4kKlZ8lP
         FDFw==
X-Gm-Message-State: AOAM531D2l+PzYXevPS0qGPcPY/0VSi5ndSaSwmspRuZz+BnlafvAqy5
        f7j82irMD3yKfw6/RqeP+uQ=
X-Google-Smtp-Source: ABdhPJyofdT5oBECt+yKVRhyuYlURaKQEqJLCZhyOYeBg4vwHqGswbrZ2oMNW4e3JiEFhVcCw91PPg==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr25892680wrv.395.1605122099013;
        Wed, 11 Nov 2020 11:14:59 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s12sm3657459wmc.6.2020.11.11.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:14:58 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: sti: Remove unnecessary blank line
Date:   Wed, 11 Nov 2020 20:14:49 +0100
Message-Id: <20201111191449.409402-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111191449.409402-1-thierry.reding@gmail.com>
References: <20201111191449.409402-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A single blank line is enough to separate logical code blocks.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-sti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index c6c82724d327..ec667b31d7ec 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -505,7 +505,6 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (IS_ERR(pc->prescale_high))
 		return PTR_ERR(pc->prescale_high);
 
-
 	pc->pwm_out_en = devm_regmap_field_alloc(dev, pc->regmap,
 						 reg_fields[PWM_OUT_EN]);
 	if (IS_ERR(pc->pwm_out_en))
-- 
2.29.2


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1AD8EE9
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390722AbfJPLGL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:06:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfJPLGL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2417932wma.5
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/rXG7dZ6ZZm2mP84hlYfs8wnMTiZSfso3bXtqugNtM=;
        b=ZzbLdYezjTXkU16z7PUrdL0Iki0lJuPsOIg6IM3Dl9MbHhEr195j45uH3vk1Jy/Pv2
         3TdvYIqpWh7R8kLag6HdUPq8mJ0A2u8JMB+EZMjsVYJGIx3BVmrQDzaXezqYPw5xlagJ
         E6lTNiqmqhXQyAsebZuInXV0UtSg2VQpI/5e/zUC90I1/wophbCMz+iK9G7z7+UnpMxL
         4q0Jv93LqpRv5/KRX3/kDy9APIwpSxZk5fsgE5oIKfLPDFEffOUb25Dpw/dk3CxK4mav
         u+ZgIL8CXRs6qvA++RVB5pFqHOlqG4QMy7IqCGWVBxXC+0/ik3z5lIHjve2bITpr36gd
         KgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/rXG7dZ6ZZm2mP84hlYfs8wnMTiZSfso3bXtqugNtM=;
        b=S53D0uyThDFpC77KnhtBiivQrSdj3jn3CQtgUFx7cC76hwGxu7SL8pgSYKHu/yul0/
         ui3crRDlrIbVUhCw8Y8sFSkA9oAXpdNm/TtKWB6XMvVLewWdCBgn5tqOhRufZXVXOv4R
         WGyXLV8PvfwRe0td1dT2bqOMMeDpULpvhlkSMT6shcseGgbw4+JEOzULt4zL5mT5+2ch
         uS8Gw7IV+fWYYRVjzSflhjV3cMoT9ence7iYoeBxdwlc1LHPG5A8TkTGpmVafcGbKKr2
         6NEfOhIiC+oaRJ38SHdInmET6Pk0jE8UWc+gYKLtUGfDeI2kY1m8YfSepKR0aFB++zdP
         8FIQ==
X-Gm-Message-State: APjAAAUcpH+aC6hS8YwkvJQenE8jpTSftnv4qNGSolKxxO5fglUMLoB6
        CrdRC3bmxReKPQ0OPbJsCxykLsSH
X-Google-Smtp-Source: APXvYqyIhaULJipFFRhEx7tjW1pvft2xdpg6B8OsbW3XzBtoiKLm0pyDlO67J9MTKKuJ2vIPYZUyng==
X-Received: by 2002:a7b:c629:: with SMTP id p9mr2904875wmk.65.1571223968592;
        Wed, 16 Oct 2019 04:06:08 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id 3sm2251940wmo.22.2019.10.16.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:06:07 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: stm32: Pass breakinput instead of its values
Date:   Wed, 16 Oct 2019 13:06:00 +0200
Message-Id: <20191016110601.1765415-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of passing the individual values of the breakpoint, pass a
pointer to the breakpoint.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a5b323432d8c..db1d675b45fb 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -491,18 +491,18 @@ static const struct pwm_ops stm32pwm_ops = {
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
-				    int index, int level, int filter)
+				    const struct stm32_breakinput *bi)
 {
-	u32 shift = TIM_BDTR_BKF_SHIFT(index);
-	u32 bke = TIM_BDTR_BKE(index);
-	u32 bkp = TIM_BDTR_BKP(index);
-	u32 bkf = TIM_BDTR_BKF(index);
+	u32 shift = TIM_BDTR_BKF_SHIFT(bi->index);
+	u32 bke = TIM_BDTR_BKE(bi->index);
+	u32 bkp = TIM_BDTR_BKP(bi->index);
+	u32 bkf = TIM_BDTR_BKF(bi->index);
 	u32 mask = bkf | bkp | bke;
 	u32 bdtr;
 
-	bdtr = (filter & TIM_BDTR_BKF_MASK) << shift | bke;
+	bdtr = (bi->filter & TIM_BDTR_BKF_MASK) << shift | bke;
 
-	if (level)
+	if (bi->level)
 		bdtr |= bkp;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
@@ -518,10 +518,7 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
 	int ret;
 
 	for (i = 0; i < priv->num_breakinputs; i++) {
-		ret = stm32_pwm_set_breakinput(priv,
-					       priv->breakinputs[i].index,
-					       priv->breakinputs[i].level,
-					       priv->breakinputs[i].filter);
+		ret = stm32_pwm_set_breakinput(priv, &priv->breakinputs[i]);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.23.0


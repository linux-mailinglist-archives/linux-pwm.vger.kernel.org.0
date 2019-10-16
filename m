Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F38D89EE
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfJPHiy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:38:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHix (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so26745987wro.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vs2VhOLNsT887JCPUVtKi4tfgehtvhFhfAihWgRySOA=;
        b=J/H+JNJFGZ86uZXXPJhBXa1I71ICkk2UUVHbvTjx49l+WfrPGmkxPZRxXLl3Y56o2n
         VJiMkjD+CdapiMOiHw+9X2YdUNEkaZt2rK48ir86Djdy2fYjhYc3XTISAzk7FbP+Budi
         6kh+IiClSlo7uY2dOy1ndN3SbRZE+T80DVO5+IWKCVx7U9BrvzMPwPAZbiUumvi7WK9c
         9Vqm10d695eMxQllQ7xAIXNB0AZn9BDVouf3kb/z+4I1ohe1gsJ2bhvijPUeChxiJgra
         vefjdoiaCQS/MNHTCnXNF76XWZeu0Xz5Nj9W/G35AV+FohzNCxhIEkiGa6DIz6SB+E8x
         2lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vs2VhOLNsT887JCPUVtKi4tfgehtvhFhfAihWgRySOA=;
        b=n/Emg4bfSjwRH+9K07ya0c4PkR0IW3DkcmVtvWrHV4Sgglo6FHmlgd3mWTnLlWCjup
         xTgq9fOTFhoi+XJXv/A2s2/8BzhoC+n60A/hU8ZyykH2arxYn/5Lo6NGerbYvRsEFpY4
         aQk6kcOXGHFYgpXaRDW9Z86XX3qdKQluucZCJV+taz6m8F+LCG6DmGbHK2Fqd1xlRPl3
         bfsF5gTMlTaitxzkh5GCc82wlBhhuR8Ffa/iJ1FyIw/mMQK2aWeho3/FDwtrCgKMcAIZ
         POIWy9ReBxDDs2ySeMIcx0oyKpi2f8+vbenNlt6rapyCtxMX77beonNDMn2MSK5bSG8v
         iDgw==
X-Gm-Message-State: APjAAAV4G23Gh+zTp0nBreU8WJoyea/RUmhobi32CtkFuxhAbRZ2i1bO
        4NNLKEE8/MAlqWufhRr/neo=
X-Google-Smtp-Source: APXvYqyH6JAqFqSn0uCIuyUWDa0wzD3/iNtWnLk3e6jF+Vq/O7F6I8z9+hvNIocnpq2t2XtRYKgjRg==
X-Received: by 2002:adf:a141:: with SMTP id r1mr1409362wrr.122.1571211531605;
        Wed, 16 Oct 2019 00:38:51 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a7sm33787504wra.43.2019.10.16.00.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:38:50 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] pwm: stm32: Pass breakinput instead of its values
Date:   Wed, 16 Oct 2019 09:38:42 +0200
Message-Id: <20191016073842.1300297-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
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
 drivers/pwm/pwm-stm32.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 8f1f3371e1dd..9e500928c37d 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -491,11 +491,11 @@ static const struct pwm_ops stm32pwm_ops = {
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
-				    int index, int level, int filter)
+				    const struct stm32_breakinput *bi)
 {
 	u32 bke, bkp, shift, mask, bdtr;
 
-	if (index == 0) {
+	if (bi->index == 0) {
 		bke = TIM_BDTR_BKE;
 		bkp = TIM_BDTR_BKP;
 		shift = TIM_BDTR_BKF_SHIFT;
@@ -509,10 +509,10 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 
 	bdtr = bke;
 
-	if (level)
+	if (bi->level)
 		bdtr |= bkp;
 
-	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
+	bdtr |= (bi->filter & TIM_BDTR_BKF_MASK) << shift;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
 
@@ -527,10 +527,7 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
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


Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD0D89EA
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfJPHit (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:38:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so1683967wmh.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uddH2lljej5bAW7SiuL/aXQPJTgUCIZOjKs3w73ZX4=;
        b=lV01Pewhmw84HAtrAzdEQiNJTDunw9jVS/+jc63APUpqu13ihpxrQn2xBCiUvXWV/p
         anMcfv/7Uz8o7P7otBw/FHM2zn6KdmjDnl8rqC/K9mrjqjZcoX9QS9HZWyqjXKx2OqIZ
         st/DPrpCdV5hE2m+FLAppwcNkjyy611ZfCrE8WLl7tqwem69Rlw0b7LC43L3BW9f1xIz
         aLGL4JroKJynEfN91ndJkTHNSjT7qLptg667Jh/nauPiXbS6NDyIUdOZKUT5ngpsI8oA
         YYKEzmBVZOYuZETF62rjRhuCtHLtie3uaEDjtdqX/q35dRxAATdcRlxeiVleZoDfgGxL
         J5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uddH2lljej5bAW7SiuL/aXQPJTgUCIZOjKs3w73ZX4=;
        b=ZsqsqZeeXfpAmXMZ0Ze3V4b0j3hWWv8Aiw5hnHdm2pVIooRFsl8DdM2Y3o2jJXLsPS
         juY9Qb+0vs32mWOrpcA3CA1kXsdPLnEaURBPUdObKLrr7XjfbmmM0mJk98EmvBtQVKPB
         u540Kf6fbNR4zbRn9xNIpbTwCdkmexermU9X9wk3AxZz+fNWixSCJvDYf0eeL1pnHTEl
         NO2QLZ7gnVhPoGT4Chv60VkFWxZSoeqrmfqgT3Nvmd99T8g9cR+ahqKvXQfS+yS7d1fB
         svwvSTIcp/bh+/6v7K7/DD1M8YR0vNyrsqfyW4qV+S6lrY9BHDzILzzX49k3d3ayIDeN
         i9QQ==
X-Gm-Message-State: APjAAAXXpTGvqAFPOst2XjovJYOtIRLFiFmq79jFu3C0rO2X0C587ZJ8
        a1pIJnUs0fNo+lXzzLGZW4E=
X-Google-Smtp-Source: APXvYqxF26fdyeTdezi8eodlzFYf3me4vKpqMmBmaeO70mB4UM0qKK6WV9mMOXTKl0pRk3q9Y7KVUw==
X-Received: by 2002:a7b:c7c1:: with SMTP id z1mr1937014wmk.61.1571211526924;
        Wed, 16 Oct 2019 00:38:46 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n17sm23615263wrp.37.2019.10.16.00.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:38:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 1/3] pwm: stm32: Remove clutter from ternary operator
Date:   Wed, 16 Oct 2019 09:38:40 +0200
Message-Id: <20191016073842.1300297-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove usage of the ternary operator to assign values for register
fields. This removes clutter and improves readability.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 9430b4cd383f..b12fb11b7a55 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,11 +493,19 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
-	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
-	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
-				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
-	u32 bdtr = bke;
+	u32 bke, shift, mask, bdtr;
+
+	if (index == 0) {
+		bke = TIM_BDTR_BKE;
+		shift = TIM_BDTR_BKF_SHIFT;
+		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
+	} else {
+		bke = TIM_BDTR_BK2E;
+		shift = TIM_BDTR_BK2F_SHIFT;
+		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
+	}
+
+	bdtr = bke;
 
 	/*
 	 * The both bits could be set since only one will be wrote
-- 
2.23.0


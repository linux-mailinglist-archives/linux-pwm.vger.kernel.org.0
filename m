Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196C3C66DE
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 01:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhGLXWH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Jul 2021 19:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhGLXWH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Jul 2021 19:22:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634DC0613DD;
        Mon, 12 Jul 2021 16:19:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so30413630edt.13;
        Mon, 12 Jul 2021 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VBbhEWvbus7ziJpvb/XYH0OM683tiVzU4891qJ5jW4U=;
        b=lemSPLuV5IaA49HyZM/afkD+OgNcBUvIJauIxkInOvd4rnovqj3+gKZfSRrxj6fT2C
         1fMNmcNF52bK3nvqP1a0BTcDcKWOAb9x4uZBaHgv8gajItD/T1cQH+1Ux4JaSLNumzsC
         EuHqf0Kg5BSClTi60HMrLHy30v2msKCJ19bwDeypVU+IQ47DDaRNmuoDWvTGD9Vht5CT
         ZmKa5PeMIGz2+0RvavO6uIeSKDm71/BFljpMu9kwUGHR/Y/DxXmlYmzbpSQYJuk+7Mxi
         78a5MuBMHWqC3LSsNPPg0QBgSDQWUp2ejhH/zhIB1F+y1z6gXlMf/u4zhrQVj674LKFw
         lAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VBbhEWvbus7ziJpvb/XYH0OM683tiVzU4891qJ5jW4U=;
        b=Mndgknk0kGYv9Q05zAiQXAaNdFa+vTRbcjlmplTQH8srohpKEVbcjJ5hWvjRCMjlzI
         CqILdyB4qv3Y3wqhZGNQhRPjUak/MZ3vEc8ICLGux3nqk3idxMz1V6TJLkD2F8vEe8pH
         ghsrtrxqdYNX7C84/Bsd8h0HLKlb/K2hc2O97YcHIudFdmm563hBrFYYw4CjP8QcuLSm
         D+FpLczEdfP3i+qYfrdfG0nmdbTWK8OohfjzEPBF5ij2qFx+y8HSJ5r8dBLCZTjs7LdO
         +LV86aGyRSfKjc2z6c3IrROFUgTeb/JdMEX4upFW2zCYaCJxt3SFXUHaQsYVpUizs93/
         gShg==
X-Gm-Message-State: AOAM530p8UveW3GCEHC7iRVm94P700BTH6rNSddMZAgAh+r7VzbpfHsf
        ctWT9QoiYW7LihqGpGbWbw4=
X-Google-Smtp-Source: ABdhPJxaNoFn9O1IGfp71lScAWRvRQMBo74KvcqChM8BUYAhSFoXmB3BCa2ZOxHlKrWpZgeMLi/W3Q==
X-Received: by 2002:aa7:cfcf:: with SMTP id r15mr1594999edy.161.1626131956606;
        Mon, 12 Jul 2021 16:19:16 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id e24sm6983837ejx.100.2021.07.12.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:19:16 -0700 (PDT)
Date:   Tue, 13 Jul 2021 00:19:10 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     fabrice.gasnier@foss.st.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] divide by 3*sizeof(u32) when computing array_size
Message-ID: <20210712231910.GA1831270@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Divide by 3*sizeof(u32) when computing array_size, since stm32_breakinput
has 3 fields of type u32.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 794ca5b02968..fb21bc2b2dd6 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -544,7 +544,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 		return -EINVAL;
 
 	priv->num_breakinputs = nb;
-	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
+	array_size = nb * sizeof(struct stm32_breakinput) / (3 * sizeof(u32));
 	ret = of_property_read_u32_array(np, "st,breakinput",
 					 (u32 *)priv->breakinputs, array_size);
 	if (ret)
-- 
2.25.1


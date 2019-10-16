Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBBED89EC
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfJPHiw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:38:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHiw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so1664852wmp.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qhc0gHKOvdAh16HP2S+6KVMIuLQLQw2vk1l+n24RLFY=;
        b=FO2Bdpbr498r/+iBvA2fcNKBWaZbAgzADsEjuLL63RvLxVdHYhZOQZn+r/5yN3B+lw
         q1mIhoR7CsJ1McKpyu4/N+3Mw95i9lPYG01vB3NAM31mccHCkDkd58ChJ++14zyCfdgZ
         PSneLmUX5E5nB/pi6rqmGkc0gNtTiWWg41LloBnok/dbW4VYnfk5b+SAPbwYCJGwlRZ8
         1NKv3jzobaQkRLRsJASdw7h3nx1hy54oJYk9Igq67kxPmgRTvH1tS3ywt381Ur92dwD5
         1+7+cXRwmnLIUXLR1/fpGAneB2BuMis8w3+f42LswPf5hL6tUVbYJ43Xire2Z08Hnt7k
         Ohfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qhc0gHKOvdAh16HP2S+6KVMIuLQLQw2vk1l+n24RLFY=;
        b=H4igLg2T+I3yXRR8LkV5cRNQow4cMI+OgFv9KRzYS2m+wWeEJcfXyUtJk6UTgwLzIx
         k1IjfSxITH2FoX1M5otmCrZgpeCgSqLx6NIvNP420OdVf7KC/4Qryr7salyqE7Rd3qWT
         XBUpgXvkKUtr0rtKggilUE/5KgS5/0zXm7uWmAwOxcgDNQswUANPoDmz+qB/beUnsyU3
         jSfgeBTQ2LJE784EyEcHAVRTcqkdl7kjYppLKHx9rsdnahP/F42Lrt8Wa0ZyvTd00GmM
         l0AwDuM7C18KFnKbiG1c8PoOhdzZ9ZA6YmQTRQyMKnw6H7pda+dkN5tMDKl4dKXY6soB
         Ocjg==
X-Gm-Message-State: APjAAAUVE4TlZgGNWavz57SobScHvLg3nZ4xsqAnjWNsgDSseiXJJed0
        3T8/ajSziznjKyL+Y0DqjLQ=
X-Google-Smtp-Source: APXvYqyfV+joCmyfoqYK0Nr0uM7bRqfLO5DnuSQktYXhBjk1ZffcLKfLxHn5QihrJGuY1+h8CMR1og==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr2032462wmb.84.1571211529033;
        Wed, 16 Oct 2019 00:38:49 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id s10sm16419715wrr.5.2019.10.16.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:38:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
Date:   Wed, 16 Oct 2019 09:38:41 +0200
Message-Id: <20191016073842.1300297-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Both BKP bits are set in the BDTR register and the code relies on the
mask used during write to make sure only one of them is written. Since
this isn't immediately obvious, a comment is needed to explain it. The
same can be achieved by making explicit what happens, so add another
temporary variable that contains only the one bit that is actually ORed
into the register and get rid of the comment.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b12fb11b7a55..8f1f3371e1dd 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke, shift, mask, bdtr;
+	u32 bke, bkp, shift, mask, bdtr;
 
 	if (index == 0) {
 		bke = TIM_BDTR_BKE;
+		bkp = TIM_BDTR_BKP;
 		shift = TIM_BDTR_BKF_SHIFT;
 		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
 	} else {
 		bke = TIM_BDTR_BK2E;
+		bkp = TIM_BDTR_BK2P;
 		shift = TIM_BDTR_BK2F_SHIFT;
 		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
 	}
 
 	bdtr = bke;
 
-	/*
-	 * The both bits could be set since only one will be wrote
-	 * due to mask value.
-	 */
 	if (level)
-		bdtr |= TIM_BDTR_BKP | TIM_BDTR_BK2P;
+		bdtr |= bkp;
 
 	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
 
-- 
2.23.0


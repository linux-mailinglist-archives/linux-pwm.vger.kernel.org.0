Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD14384A9
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Oct 2021 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJWSXI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Oct 2021 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJWSXH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Oct 2021 14:23:07 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C23C061766
        for <linux-pwm@vger.kernel.org>; Sat, 23 Oct 2021 11:20:48 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id e5so6797501uam.11
        for <linux-pwm@vger.kernel.org>; Sat, 23 Oct 2021 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=LnwR1uAWKDgHHpgLi+Zphb6m+amdTcCgICOpeRfFVOA=;
        b=uyBDv6otKN1Ibzsyl86F6F6HrH5fI8ZJRERLa8+a5Z0zqTUTwrm0YOdET776KI8v+6
         HOns4XzLLC7p176sLhSEHgb5p9A0yalA1aPQlADATDPEtLgWMgTQuUPFknxSBBVSnRcj
         kH1Lia8SexULXam2JjNnJUkgkEnARVDMJa0yfmphhyZr716R0lQx1YSfpcYry8eRoc7w
         nvB7dnGbDmscCzxKG/PQEoEG/cNCMHkvvT6YIPmnetoo8xBDkIHtpwo8r2nXbL+Mf040
         PQIQ8J0sNzLw6bKSPHunZmR73dCj+mRj2eJDTaHPfNEjsczugKJyO3m+Km4LtPQpzwPE
         gDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=LnwR1uAWKDgHHpgLi+Zphb6m+amdTcCgICOpeRfFVOA=;
        b=cz2sci8i9t5+7RWnLOkWyqvlFKq7jGfne6EAhQRL2xjJr/sKNCr+Aa3hrTLkhLfn33
         LxBfY8dLp7aCLzSZtsQxL98aymV3lij5QXqDlvSDVmNcNVoeSDozA2XrroeYTJx2SEAe
         mEu7lY4hydOy0YO3Qr/K9RKwVGuNxuxu1fRMaUzh9Zl5cl7Sbs/9g9y92e6BBHtw7OHs
         56H3tz0yMPOIDKRkY1zmlghWz4SyZy47/CqKn3tWwt3CuiU6pi/yqIqn/WAr7uWHwjPT
         oIFG3qnxwLMVy8iXvkhkvxfDhPVSznX13zSiv6TnItmySlKmwgROlxTDC8w+WmuJtqrv
         7Q4w==
X-Gm-Message-State: AOAM530bjRst76AS9CFdDSjH7k3z6Fx+xP60hy6SxPqg08spLo80YIm4
        jbQ0gurZwjvfxFTeC2so/eKsLw==
X-Google-Smtp-Source: ABdhPJwMiab9PdGiUEvO6PeSSgiBKATBf4wU9zU+aI5Wka5wj+MyhnAkv5TprLrLulcJZ03KN5r/2w==
X-Received: by 2002:a05:6102:3589:: with SMTP id h9mr7096058vsu.47.1635013247056;
        Sat, 23 Oct 2021 11:20:47 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id t7sm6585389vko.7.2021.10.23.11.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 11:20:46 -0700 (PDT)
Date:   Sat, 23 Oct 2021 15:20:42 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <YXRSaMb2FV78+1tc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
replace it for the atomic PWM API.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2: Assign variables directly and simplify conditional statement
---
 drivers/media/rc/pwm-ir-tx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 4bc28d2c9cc9..ca943f168855 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -53,22 +53,21 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 {
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
-	int i, duty, period;
+	struct pwm_state state;
+	int i;
 	ktime_t edge;
 	long delta;
 
-	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
-	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
+	pwm_init_state(pwm, &state);
 
-	pwm_config(pwm, duty, period);
+	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
+	state.duty_cycle = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
 
 	edge = ktime_get();
 
 	for (i = 0; i < count; i++) {
-		if (i % 2) // space
-			pwm_disable(pwm);
-		else
-			pwm_enable(pwm);
+		state.enabled = !(i % 2);
+		pwm_apply_state(pwm, &state);
 
 		edge = ktime_add_us(edge, txbuf[i]);
 		delta = ktime_us_delta(edge, ktime_get());
@@ -76,7 +75,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 			usleep_range(delta, delta + 10);
 	}
 
-	pwm_disable(pwm);
+	state.enabled = false;
+	pwm_apply_state(pwm, &state);
 
 	return count;
 }
-- 
2.31.1


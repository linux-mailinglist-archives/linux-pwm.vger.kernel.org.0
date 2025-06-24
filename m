Return-Path: <linux-pwm+bounces-6517-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FBAE6E6E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C9165BF4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C811230BCB;
	Tue, 24 Jun 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xi2QL25n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71869293C6C
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789000; cv=none; b=iWF03mD2TeY6Ts+tv5nHQitS2CcXqLfxPOHelhgEvzRYZ1jURaU4kQMtsAphj69wisTZS+sKZWUWdOTs9CGMB1p9lJfg1yZx822ozCfd7zhbtkUGzLzjul8coCZAFd8a6kBKV3JoXiAN/Ccd81vq70fMCldu1stw5XmqCTAYASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789000; c=relaxed/simple;
	bh=E/uUePM7a46y0UkgtyPdkbBAs51qHEH/jq0OTlEoicI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRs6RbHoKm17V5pdYdZw1BjQR/1+ejGkfCQi9LsdTeMZz/GYeVaMu4Qibrz3uS2HGQuEQs+7mNU2ba8pSi6LzxquDB7EQN05EWgTlr7ZSJlogIdjAaV9dc+dsHKRZpaNk8fnvDL7hXMVnEmqYQoLCMaRB4SunWkWCTs3JNkW2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xi2QL25n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so9922387a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788995; x=1751393795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEjv4F6KSOcClNbcVqHshoCAEKi/vQAT9lN/7mgczII=;
        b=xi2QL25nOiEuO2g6UroJNZQjZhHpu5ZPormzH9OjpkiycmuS5ujj+FTLcxT7stFcgP
         sqbUeq+yw+yx1VZerhF+MvH9GKcInTaD0HfzQrS7zXMnzh8USTBJY8KEWSDvi4KwRzIa
         OH0ubnAWUhDEVca0HimzSou/d3FlJt0+I+0avuOoocgtBC8jvygUd3hyjBBzZ1APi4pi
         NbLjhySxwrwbR3MYQ4hG6aQGqQmPaUKAcPhGd3JjddW9lO/mOiiNIlpsGErbgAjeoq6T
         K00JIFU/g8do9krZFDp0byAUQOKJOZhmSB2HY++Iu4teKpX1mDCvU3/orT01teUN7FqF
         2yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788995; x=1751393795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEjv4F6KSOcClNbcVqHshoCAEKi/vQAT9lN/7mgczII=;
        b=UB+o7wuUxfkDWXalYMnqtotjUHQ7XY36IcHHffwnaNvSzMk7Tn0Tw4dPhtyNSagzZm
         psrqtBH4R2L0TgqMMHdSwqCDl0qXPJp6AGo+9JseShDGpNB8d/YbFXi2Yiv2+XDpthZo
         KSmkUD9RtUavlslUX6O5gR+Sqvzw06E7WHgOr43pqRwfSdM+kmf2ybZnl7S3SY0RblUV
         VR6mh4TWSnnbl45KAGFDZ45etD9IQEX3jXAxww8xAc/es5f2pvJ1ElD4enuTFg16sVf/
         7HKoByqujvRugHlwdLsInTpnaWWBl4/FNPQ1BorO/e4VcXgcSQqCSS6BK/CSmwK9YZVY
         n5/g==
X-Gm-Message-State: AOJu0YyN6kS57rNCSRnCdFB3HSG7Nm99mU5I2LpjpjQocd4fIqk77IuP
	+u6ih9HoyRLnoDpTGKszXXtiL8pUcFHEntT5v9ftVh8XpZfjiGa+YXoBq10q+tvsudNRlN4Rtqy
	VhQ2H
X-Gm-Gg: ASbGncstX0FwO737x6xKGdc6AFIF1jMebARoANvn15zvHZsReFEQBa1gNiU+dCFezjw
	hvJ7L7Q6XDHyhrUszhzXPABb96Etm4csXOqbQfFXXqG73W2eMVwYcT3SqBtzpw0TEGXffaHrkyd
	K4QgpEYgih5nvURYt7XOsSlz95aYLt3Pw8lhfacpFdXELcJ0UoCDmYN8b2C8k33BPdlDOiLjpwN
	ikj5mfUldL2oGcCr8IphLUvwsN845C7xFVo1i/C6HTZDjJzRA/cv8+zcpgVSgsTvh/Iv4k4VcI+
	Z7wyBv8ykjENDVfGB1qTsRWFhKgRnYJl/QR3i48G4EEnQ+D56hO9OaCMNU0GOZ25/2s=
X-Google-Smtp-Source: AGHT+IEBuy6MlT6u62EQdRkXXyLoqvydf3fc2sW2sY8y/XmffxoA6g93x7kLpzH/nKHARpOTaVXeag==
X-Received: by 2002:a05:6402:2787:b0:60c:4782:e4e1 with SMTP id 4fb4d7f45d1cf-60c4782e825mr471973a12.27.1750788994579;
        Tue, 24 Jun 2025 11:16:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c2f4682cfsm1357564a12.39.2025.06.24.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 7/8] pwm: sun4i: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:43 +0200
Message-ID:  <87b71c46b82b787959f0cea314d3010f16a50a29.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=E/uUePM7a46y0UkgtyPdkbBAs51qHEH/jq0OTlEoicI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWuthUg2J6w2ChMNVvit4yXPA5cDRrT0c/S8gW 4HHQIQNG0aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrYQAKCRCPgPtYfRL+ TjNGB/wO0hqOPlv69u2jHFp28EXbuBIuakfzbJR6Kdu2hu2gfU/7Osac8aAdtKXPA98M/zP3KSD zMVYhpn+mGKi2Io57AJuIcfNYVQSZUT3CqXf6QAQmeXAOFxCi0g1nE+wSUIsN9NJyIC6n7+65Xq O27FjJEQrrhrNDzXNvGfWJn5O2hk0Hyfi/t5aENoWcy6sg88u3sPAsgzdHvG9UYOQc/9yjEaR6m /jPX9EWcS7ZewwKR/tZf4MgxzQr7/Ov/S41lh31r7KMi09KVWOV18l1iT0dQ5+UaphXTk4jvKAT yip0E/lVsUngTPdTR+cONqYKBxPOz+Rw07St5K7dzBdJMRtn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core serializes calls to .apply(), so the driver lock doesn't
add any protection and can safely be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-sun4i.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e60dc7d6b591..6c5591ca868b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -21,7 +21,6 @@
 #include <linux/pwm.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/time.h>
 
 #define PWM_CTRL_REG		0x0
@@ -85,7 +84,6 @@ struct sun4i_pwm_chip {
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
-	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
 };
 
@@ -258,7 +256,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
-	spin_lock(&sun4ichip->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4ichip, PWM_CTRL_REG);
 
 	if (sun4ichip->data->has_direct_mod_clk_output) {
@@ -266,7 +263,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
 			/* We can skip other parameter */
 			sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
-			spin_unlock(&sun4ichip->ctrl_lock);
 			return 0;
 		}
 
@@ -297,8 +293,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
 
-	spin_unlock(&sun4ichip->ctrl_lock);
-
 	if (state->enabled)
 		return 0;
 
@@ -309,12 +303,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		usleep_range(delay_us, delay_us * 2);
 
-	spin_lock(&sun4ichip->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4ichip, PWM_CTRL_REG);
 	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
 	sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
-	spin_unlock(&sun4ichip->ctrl_lock);
 
 	clk_disable_unprepare(sun4ichip->clk);
 
@@ -456,8 +448,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &sun4i_pwm_ops;
 
-	spin_lock_init(&sun4ichip->ctrl_lock);
-
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-- 
2.49.0



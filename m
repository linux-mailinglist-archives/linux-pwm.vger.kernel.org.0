Return-Path: <linux-pwm+bounces-5780-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F7AA47C4
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD759C1809
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87760236421;
	Wed, 30 Apr 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hivxOt1J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E37237164
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007103; cv=none; b=ryRLbZzDtwahs/OWCGMcIWids7sSD7GKTci0rtuCpVnHoAeKE73g7k47XWxHiE5LXx1qAelBP8NV4gDhGDDRG3TmtPOmHEzN0uSdRNeyzTvKpW4OUO7XzorjPOCnFxnFAKpaCBv7OkWMQwvx+aa01U6IWwtqNcln/FyxffWU07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007103; c=relaxed/simple;
	bh=3eSx1C/GX8hyp6Ceh2NJJp3pJchNIsGHq2rT98Fdnqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saBxPQtLm2XM6D+CWWSZIp35YZXiR/CZUc6Kn5VOY6uSOWVAamwLfOal6zg2mA8HWy3BPF4lT6Kx7lOiiHMqWclBIzE3oVh+LstFh999zombkU0m/TmKoy2ykLH7P9okZarJougzNUG5HPV/kQ+E0TBT6Enn5Al5YW/6YWnx3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hivxOt1J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso55377485e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746007099; x=1746611899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7tY0nC24oyGSd/sL5Ai+/WNM2n2l6u/H1QH4845/ow=;
        b=hivxOt1JUnWWo54w/yEp7P5Sd6GFMlUZI6vyfKYxAvy9L1dYyvF9/TJ4jm0Ie3BLt4
         o5Aua1BUi6cU6+VBsKyhfu57Nwawqtt1/TptSw37DHxX13UhqSEsnJ67s87j+WKnq6gO
         +6bV9YHu8Za6TK4mjEI/KD3b/1/p3LbkRue5A8NHdAj/e2SBWdWocLZagCGMstn19LJR
         hpfBELUa4FQgBinpfYcL8f8StdhC7udDoOZPfDSG7Ky4KK1YzjwcrKn1Hi7tqvSZI1l3
         tFTjDkatVL5LhnD5uJ5o54niyTVHTngk8aYhxozmSPvH50nEA7Re5RWIJquC7nsjYLbg
         rdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746007099; x=1746611899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7tY0nC24oyGSd/sL5Ai+/WNM2n2l6u/H1QH4845/ow=;
        b=efKOPIq+cCfFlujjqhUtiE2vSFmyqSMBxe/reDV8L2aIiqAuzqW5/j+Xid4owVZBBd
         DvxmdVaqEDh50QBqibs4eesLVFeYQYIyQowJhEFDZ8D9UcioMCTSK7BEoqM8okf9+T/k
         X3dNZBRHKerqkDqp1D5tYAnq39ASfw0RNc+qn/xUxSPwtN6t+EpwLxc7IJvtHnrnF6xR
         KvFHuWBvnEdww6KYvAi2/BRkdEl9pVYVaw8onUqcUKRxVn+OKFCs4pl+LjrS8zXLKKOt
         +YjY2Fu1A4UcMP4+ms6QVlnxubdlGsiL44uGRRQuCK2XEwQY0tykzLOojPLgXnY2vVLT
         OMvA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAajxZpqdqjboNKE39O9LIzWUoTJUifYmtymuT85hLEI9iAiEGV5ewrWnnzZeF28Dv1o6jHJ0rbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6icGsreCfM9fa51zjvW+IMJjPRAAcJGhFKIVjB4dOyCF42Ejp
	pwwTlXfhm7xjR7ouq/UIBVjN9QL9zNsLvh3JLN7S7ZHIHAzlYxPIuhP7r7fwbI0=
X-Gm-Gg: ASbGncs4HNPgc573xs1045Fsg6MmSQMZiacv1BXjEvDGQn6OiOD468apDlwycqEsO4i
	2rQpAvOZcueMk769Qc7psGkNvCcxjcN1rk6sjFiAMESO6bQ5slU5+qUGUonNZv52qKE0Lh/iwtw
	1VDICq1Z86nfNJgYOfnL1eVqCR+bwkINKuAa+3p9MmUi3M/syfnrWZu+AHBqrktqX1z6qKaEu/N
	q+pu8nOwZRNGFlirPMQQH83fN5MR4wDQ31IUIV7tP1UwkFOsFOR2r/QdrJX7KJ72QhxJjEjFJUn
	b0krkANodVKZqjnpM9XZFV18yPwgs9Ge3eIf0s5XpfU0CaHFsUJ/pXlrFqaNh57Q52gqsTZpXDV
	Y36gMhY8=
X-Google-Smtp-Source: AGHT+IGmVTMNri5Sm8wcqpeF8VIVZrJ/Zu3eKJXhtydgdXvYik6fTjiDVeRubZGj+D7bbCVYLRosrQ==
X-Received: by 2002:a05:600c:1546:b0:43d:1b95:6d0e with SMTP id 5b1f17b1804b1-441b1f5bfeemr16819265e9.23.1746007099232;
        Wed, 30 Apr 2025 02:58:19 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2b972d6sm19343455e9.1.2025.04.30.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:58:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/4] clk: pwm: Convert to use pwm_apply_might_sleep()
Date: Wed, 30 Apr 2025 11:57:47 +0200
Message-ID:  <f194fad5ee8bdd3fda6159324524979729683653.1746006578.git.ukleinek@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=3eSx1C/GX8hyp6Ceh2NJJp3pJchNIsGHq2rT98Fdnqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEfQf/27S9h+HoK7cxoF/90bC0GRDe3ryXpqFk xQxVM3sJEKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBH0HwAKCRCPgPtYfRL+ TmQ3B/9Tmd33dF6R8m+knOn2zYUKu80d78lpu6Ojb4Muk3IbkC7sjIyqVVrOAy+6x3Hj6+FPAxn y53Yd+TZoZryiEEy/w0ChtbaE5VYAYx7tT3XPyw8yJOH0bgYZij+ujSrjhvHee+2Y3R+iBAjnnP G/ej/i+21MXkV1qQhRhdAuiowd/OVXZv8hKQWT14h2sw12EVAE7ja0NWfvId/02AuVA1KrwXSdz ts9kZAJWS4rDkbk+xNRxezmxXPihfoveGAeDP3avnRM88lbXf4qVWN5bz3DCFDUi4erHHlKPZ4V taELV252HV8pAtVVCqMZeS72ynZSPdReu8EXGOECK8Lxkzar
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pwm_config() is an old function that I'd like to remove. So convert this
driver to use pwm_apply_might_sleep().

There is a minor change in behaviour as the explicitly calculated
duty_cycle used an uprounding division while pwm_set_relative_duty_cycle()
rounds down. I don't expect that difference to matter in practice though.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/clk/clk-pwm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 429150bba8cf..f5e6fef3f4d5 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -14,6 +14,7 @@
 struct clk_pwm {
 	struct clk_hw hw;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 	u32 fixed_rate;
 };
 
@@ -26,7 +27,7 @@ static int clk_pwm_prepare(struct clk_hw *hw)
 {
 	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
 
-	return pwm_enable(clk_pwm->pwm);
+	return pwm_apply_might_sleep(clk_pwm->pwm, &clk_pwm->state);
 }
 
 static void clk_pwm_unprepare(struct clk_hw *hw)
@@ -106,15 +107,16 @@ static int clk_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(pwm);
-	ret = pwm_config(pwm, (pargs.period + 1) >> 1, pargs.period);
+	pwm_init_state(pwm, &clk_pwm->state);
+	pwm_set_relative_duty_cycle(&clk_pwm->state, 1, 2);
+
+	ret = pwm_apply_might_sleep(pwm, &clk_pwm->state);
 	if (ret < 0)
 		return ret;
 
+	/* set enabled only now to not enable output above */
+	clk_pwm->state.enabled = true;
+
 	clk_name = node->name;
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-- 
2.47.2



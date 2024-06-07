Return-Path: <linux-pwm+bounces-2371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A58FFE3F
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71F228204D
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611115B57F;
	Fri,  7 Jun 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WRYkQq3C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21215B128
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749892; cv=none; b=KxJddtKdSCf0Nf6rc8oY87KbTC7sUiqVnkLpfvTOUxul1mhDOFSR5xOJrLa/5HA2jWhErJdrXkSls1p/4xnHwT5SL1Y6bTCL3XfASVGmRTBgofNam+5iw7+poF4guLIKW/TCYZsLWdxyX4bFy+gv0P9emXo9khVuAzUwuBb/a9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749892; c=relaxed/simple;
	bh=wudYmHy3qCSrWLSreH+1TgxgneyUtA3ewiC9lXDQSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ple3pvvwQBTIhgJITD7mhIypDaOZrOXllyEMB500SVJ4QmjFji2Ol13Hf/3x2sYQEdT7jcygUcWas0s5hk8eKNSALE0ckate2TNyx5MY2OhmAiRfm8asFjU+AvD83xytjOWe0eqiS7m4yX/1JrO/dgn+9eaB1rrv1X/5WZ6FG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WRYkQq3C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4214fe0067fso17972435e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717749888; x=1718354688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FGL8cAEQ0O2enVmYyGVM2Jx+NaXP9rfnR5x0k/WELA=;
        b=WRYkQq3Cw2ZkjAGEjYa0qecOxF1FIZEIprx0xpD9syTdNHTT6U0e4F1Nrp6MwYcDml
         tyToYTqhZFpNt+r/f2aSfqHECjiQk30EzxcFBs9dUyaKfPG0LyU1v/lbAUm56qnyJEhD
         YuTsOwrWPwlNbpLoJFP0Oxkxaz3s0QEcZSc9VOH49FvSWfLTxV/tNCkF10eRVwkbQ4Wv
         yqJfTt585tX9K176GFcNEoS/Ofi7UKU3Ll/6B8gt9QFYrF4ccaQbGTzX/Z5MrxqPGpfF
         Bia1NmsdX/HH1mnY6B3VIg08gCLAdrCJJItVYSHVHBKoAaxVACj8kS1O1+lyiZ4oTzbb
         DeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749888; x=1718354688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FGL8cAEQ0O2enVmYyGVM2Jx+NaXP9rfnR5x0k/WELA=;
        b=LBzkBEMwcS2wmFznocyUYht7Fx0ddCtHgjy7bxb7oEvrYTXejCUV1+ynyqavV9yap0
         nMiehkbeGxhXWQkkAflA/sIyOY7/TpJDYd13sXcwrTZkX3rHy46rWQn8dQmwJjmNFl/S
         DZlgxR+4xpxqBPR7Ra/MQ8YlLiuT6XI4cDg2tENQ83SoPcp+5TlcAJSZaFBY+VeOfh1/
         /Ebgd6EfrHI7BcRAIkjisUVACiyjTSRanmtnuAjRWd0lEtkCPpifzen1nGgk+dIwJGt2
         BKE9qO4nvTGv7JihsAhXrnSfSPFRmMA991i7R9V/xmk8i3v8iaUT3TBDd9KPCtm4ejRn
         n4/w==
X-Forwarded-Encrypted: i=1; AJvYcCUqhb1JTOuU+QD8PWqLtQrjX+CTpQ0RUdBma5RMwHuBI07RZYTs/4PSJbkfCY+mHJu5/1WhhcYIBratpVW9U/81VHPSEEzFVNLL
X-Gm-Message-State: AOJu0Yy4Wec+NITOtJTLqyDdwYDYqu0W5gCITiL3TyGl0nIwZmTNtbqi
	unkFwk+B5q9uDEqrl6eUtlRGeFiFVwdytP4tyk5i56SNxY/Mt5yyhrJdrswXDGw=
X-Google-Smtp-Source: AGHT+IH/9XI6ce6wjpuBpjMC8y/GtYJRiFfAam5jHMBp7OViFavLuETNBz3U8/PfPmbAek4vxlG7yA==
X-Received: by 2002:a05:600c:450e:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-42164a3b0f0mr19195415e9.31.1717749887864;
        Fri, 07 Jun 2024 01:44:47 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7bfsm80098415e9.40.2024.06.07.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:44:47 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in .get_state()
Date: Fri,  7 Jun 2024 10:44:15 +0200
Message-ID: <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=wudYmHy3qCSrWLSreH+1TgxgneyUtA3ewiC9lXDQSKs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYshl2TygktlmNS6vtWgQA7+2Bnh2F7OPpd1Z2 OFVxplP1LiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmLIZQAKCRCPgPtYfRL+ TjbTCACR1DiLfufuRbJltZvAy1vOOWnfILZW6Txf383BpkW755Jry1cQfC4l0KE2mqgXI9FRLmk +YL7nbP+5arxci4Hq8p1PEv1B5C9BUP7z1Xq1mk0ZlpLbBm+jGk2D9gZR71WquJp1KJfonHDd0l mGksY7Bl6kwFNrhtqRdy+JuNMQLpb7yHspr+Afm08DNYqlL8ncrTPkN+X8yiuOs9z7ZsMbt8P+1 HoHxCaKPXTW1XBXckJzT6Bpt/FaiyedOk8g/cWakA2TSctd540/d3pfiQZj6X+vspclmmkde34s z/77KO/ajGmZUu9utoA/V8bGYdIurzFPY5AUGuuRXUVu4fNB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The get_state() callback is never called (in a visible way) after there
is a consumer for a pwm device. The core handles loosing the information
about duty_cycle just fine.

Simplify the driver accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-cros-ec.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 606ccfdaf4cc..ba4ee0b507b7 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,15 +25,6 @@
 struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;
 	bool use_pwm_type;
-	struct cros_ec_pwm *channel;
-};
-
-/**
- * struct cros_ec_pwm - per-PWM driver data
- * @duty_cycle: cached duty cycle
- */
-struct cros_ec_pwm {
-	u16 duty_cycle;
 };
 
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *chip)
@@ -135,7 +126,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	u16 duty_cycle;
 	int ret;
 
@@ -156,8 +146,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret < 0)
 		return ret;
 
-	channel->duty_cycle = state->duty_cycle;
-
 	return 0;
 }
 
@@ -165,7 +153,6 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				 struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	int ret;
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
@@ -175,23 +162,10 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->enabled = (ret > 0);
+	state->duty_cycle = ret;
 	state->period = EC_PWM_MAX_DUTY;
 	state->polarity = PWM_POLARITY_NORMAL;
 
-	/*
-	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
-	 * the cached duty cycle is not zero, used the cached duty cycle. This
-	 * ensures that the configured duty cycle is kept across a disable and
-	 * enable operation and avoids potentially confusing consumers.
-	 *
-	 * For the case of the initial hardware readout, channel->duty_cycle
-	 * will be 0 and the actual duty cycle read from the EC is used.
-	 */
-	if (ret == 0 && channel->duty_cycle > 0)
-		state->duty_cycle = channel->duty_cycle;
-	else
-		state->duty_cycle = ret;
-
 	return 0;
 }
 
@@ -291,11 +265,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
 
-	ec_pwm->channel = devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel),
-					GFP_KERNEL);
-	if (!ec_pwm->channel)
-		return -ENOMEM;
-
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
 
 	ret = devm_pwmchip_add(dev, chip);
-- 
2.43.0



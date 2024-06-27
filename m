Return-Path: <linux-pwm+bounces-2632-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B391B06E
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 22:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165191F22450
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2C19DF9F;
	Thu, 27 Jun 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EFuCFy3S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5219DF7B
	for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520318; cv=none; b=fro5yE6mg+FdTU7sTDIcx4e/YxEX2Iuq2Ezl5pLlI/cD8gWXNe93+t3Muu4kBqNY/MiqLqr0m2W5PnDbtcIBW7VacJiYjiZdqttuE9WpUmwCiMqKoxFF4fWd8r0c+CV9zrjTYv0PW38ADmqb/jM+K66jaqrTyVvSrCFMbxiJtNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520318; c=relaxed/simple;
	bh=zS03w1BFnn7nouEACpJyMYug2hjDYazbtdcAjRzizsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdD2F5Tp63CrREKu29BsJMuVK9ZnUBNhD1A/Y9nFCRm39bvtE+GwlpTmftGisNP2VXrXMmZ5GkmLMECSvTLUhlz7tf/r33BPP0/jsiJtfA6y3qGxIveNgkynFjZFzJf55NP1yQL/UOhr289JzMR5sfpoKz6fd1r0tuBKoc9tul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EFuCFy3S; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so630097766b.3
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719520314; x=1720125114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz2E6CJdcyAjb7OmY4xnSvszCXS8uIlteWhuDW6VaL0=;
        b=EFuCFy3S/2cIyo6EWabRpP8FUi7/evy4uiPOobkChiYv9F/8Rh5nWSSNhx06C0KUwJ
         LVeD+JXGIwpK+oB3wn4oCD74Pp29bBA/B0Goz04gM45poygESrF/N1Bh1sm/4Y6gr5HT
         JiYIWrr9Y4POXo4g0QXrhARUWXLsUxTxfQhYBaUV3jAJ6YGJAczI/2FJd3FqSowVOBBG
         IVqAl/VKx19FgEPSD+HumFVpodrRj2PFCZYmrysIKVEkAlDlJE9vML+op0zjczIj7T/v
         hLqTgqHjnSZ4NpIydPxtBFs5TKguV/oS7gvSeVquuleCpIpOA1Lk5A9Crd3GlbWkqTIi
         vL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520314; x=1720125114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz2E6CJdcyAjb7OmY4xnSvszCXS8uIlteWhuDW6VaL0=;
        b=SKNaaGFU1DvKASjLOE69CdBXfGi6yX3wgy+gUrKfF9XonuiOKJOkR13UL32gUMgbES
         iEFp9BOYAFZbefayWpXvfHei50QKEOuxT1+QPIhwXVJZcJJ1r42bTQKRXzlN10pMosXe
         prFD4wCnqpg7LIyGZIEryHjbW4kDcpk/BzhUjKlUshGKILFIDzJY+vsVEAlD8LoRPq+X
         bF0Gx9HiS99HhEDoNEb26XAuiq41TGAZ0ozMQU1DnANiQi/jC5Odc6mIhV/Blfh9g4QD
         aTUUnc2d12gQWIxgMAHE2bIqnuErUQKoXgqaRngiLJafxXIvmwJbYBJqP73SywTLBLyd
         M7xA==
X-Gm-Message-State: AOJu0Yz6LuCAaFsWvOvpc5M4FjZ/Jp5tHmSBezoLXYR8SlVq1ydMjEck
	0dZ+Y/LBwndLzYAAepEFfhgIg1t99aNljjfWE8fTZ0OuO6pKNYetO/tmiNmf/QN96fHdRBBgCYm
	VGE0=
X-Google-Smtp-Source: AGHT+IHUZcyfFAMeaB1y0c6JccsReE6XEoBQP1iJ/FGAkyhPYS3sBbAcjkEIJgzVbpzjFAhW2hNv6Q==
X-Received: by 2002:a17:907:3ad4:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a7245bad98emr800887666b.40.1719520314074;
        Thu, 27 Jun 2024 13:31:54 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06527csm8930266b.125.2024.06.27.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] pwm: Use guards for export->lock instead of explicity mutex_lock + mutex_unlock
Date: Thu, 27 Jun 2024 22:31:20 +0200
Message-ID:  <210010f2e579a92476462726e18e0135f6854909.1719520143.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
References: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zS03w1BFnn7nouEACpJyMYug2hjDYazbtdcAjRzizsI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfcwnCyOuSTTej1jUALVEyeaBc/U3v1dONzbEC aRKGqbbgGaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn3MJwAKCRCPgPtYfRL+ TtqJCACl4yK7PfH272yXIAnmsksjSJON2YgMao2mOQ8q5SIRmjGPhOJm2kmwCLM8F3ORrqHmOy9 py2C3KLcVXGL9OQJP9RHjzF3ZAKLexbp8GXLYWKkr2Ugq27EoiBjmeSrxhrCkeZzlJwHdI0HISd LzyC3zo+30UGOodBD+47UqdpT79Xl6d/TYF/o4R0ESvRUysfxSrt9/ZmCLV7/n84CzLd2V8uvPC lnPrkxNHvyFInoH4v3g18szK5kdljoOczUm60bo1OE3ipuHzW+aWj3WjiV+p+Vr/NfViQ/HOKXr eYNm14UpAG567sqBLfrxa/U9XsvNACK5hcPiilb5jzwYxsDy
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With the compiler caring for unlocking the mutex several functions can
be simplified. Benefit from that.

There is just one caller left for mutex_lock(&export->lock). The code
flow is too complicated there to convert it to the compiler assisted
variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 58e868b56530..a0b1aee373bf 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -503,11 +503,11 @@ static ssize_t period_store(struct device *pwm_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&export->lock);
+	guard(mutex)(&export->lock);
+
 	pwm_get_state(pwm, &state);
 	state.period = val;
 	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -538,11 +538,11 @@ static ssize_t duty_cycle_store(struct device *pwm_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&export->lock);
+	guard(mutex)(&export->lock);
+
 	pwm_get_state(pwm, &state);
 	state.duty_cycle = val;
 	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
@@ -572,7 +572,7 @@ static ssize_t enable_store(struct device *pwm_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&export->lock);
+	guard(mutex)(&export->lock);
 
 	pwm_get_state(pwm, &state);
 
@@ -584,14 +584,11 @@ static ssize_t enable_store(struct device *pwm_dev,
 		state.enabled = true;
 		break;
 	default:
-		ret = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
 	ret = pwm_apply_might_sleep(pwm, &state);
 
-unlock:
-	mutex_unlock(&export->lock);
 	return ret ? : size;
 }
 
@@ -635,11 +632,11 @@ static ssize_t polarity_store(struct device *pwm_dev,
 	else
 		return -EINVAL;
 
-	mutex_lock(&export->lock);
+	guard(mutex)(&export->lock);
+
 	pwm_get_state(pwm, &state);
 	state.polarity = polarity;
 	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
 
 	return ret ? : size;
 }
-- 
2.43.0



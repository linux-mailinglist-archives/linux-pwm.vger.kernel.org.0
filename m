Return-Path: <linux-pwm+bounces-2740-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9892B501
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E834D1C22AED
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A61FA3;
	Tue,  9 Jul 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="inCSN53x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232D13DB92
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jul 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520312; cv=none; b=n8HAclZVpOWZOZxJf3Ara+PD9iHR55DlewMmpeTstch9QcqZK4X90D/zlyeAYpE3EMjOv29nR8N19U6j89yNt80q35T2AAFn7XUtQXf0jOAnUzyEHv4XaenkqT1MH0R77fVg+zeWSP3RJEAbJZrsTdmAGwUGGNDS96FIFdR7vLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520312; c=relaxed/simple;
	bh=HRECQNJEoiWSJM96Y5TzsskbT2xf7RBPRMnhjuAtAsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv9iZXg5nmOaoIVbXfjdhldaHgMEeQwEfbr6QyRJrEGmLAF+w/0VVZkVwJWJcek89MDzLgNHeXwdXdy1J5gxKDB5aP4g53KfzstWVnR1zVMcNkEEbr5sHDpO4FlHkQziUv/gwJlnNipLYRMnDtZ6PfBUHQd+Drj36DzRmNbJXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=inCSN53x; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fd513f18bso500443266b.3
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720520308; x=1721125108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BOw9dsOWGZoOiBoP3N0sxoT3vbz+H/cGBx1h+V5mL8=;
        b=inCSN53xaefe3iEoIrAcN7CcDodOOOV8mzVmp3NeesunbO6fhY4P/fzpUKNN611h4U
         nTJGTHGVZXltbLpKWrvDLIRlXXXoF4Jd1Ih/LIs2Wag2UW5BzATmLfTIRKPoifQeO9vw
         6hmNK8LvkxGXsEKZXSAtI9KBarY80R9mxPMlG/M5DdDGJpBzr54KOJ0es/XtKiXUrFUG
         SIFnGWA5yWBCEzvrlG2JIzIb6b2mf9GuutMz0zrCR1wVjZVk87SF3DP0CvjQ/tNMM2fg
         DHQmV1CZRZbj09mXgPmEoCDZeKK2Yk24v7nEJAgybz16mGMAE+f+DWQwb7n6KtMxxsl6
         rOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520308; x=1721125108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BOw9dsOWGZoOiBoP3N0sxoT3vbz+H/cGBx1h+V5mL8=;
        b=IX5kjfChZsQUt0tZGp7eulNymorHjprI2jIKDs40bee9+Fr5WFC0nns6wnvIKIEHS8
         Gri48OPchzG24BZpKmphWB0eahgp7ReSZcQfdxtbcS1FWYleVyIEVjMhoBf4pGVAsx0v
         3hoQsrap8A1iTGWAeFKUaPQo2KvwNshKPqkEhrLHvvs0WJDo9sRoCqn3m+3HjvezIrGG
         TkNF4774vOIR7ojITIx8RgpQDEEPYGU3TOV1Kg+3lm3M0G4NeLmtvZGzbu9JwQP1WRcc
         jI8mcPyNMrLF8W1TIIDE1ych3XdSAre+7wSzmNAZL99S9PW9R2QV/kDUPEL0xckWmcnC
         9gYw==
X-Gm-Message-State: AOJu0YxXmBggiB8afSxbyu7PijpRXfodAtwWCZsXEEi2CGxG5pkcH7ml
	KnUSuv7K7oggDRFc2UolAf+/hXgS6jGjRRpKnDbzT/OVRYiGREAhl1r9OAxSnwg=
X-Google-Smtp-Source: AGHT+IGVVa5D8a6/0GBs6EWCyvWixTX/bOy31j64hArHSZ7WV+Fy/H469dRiEtMa86fDs5rPgvYElw==
X-Received: by 2002:a17:906:1388:b0:a72:428f:cd66 with SMTP id a640c23a62f3a-a780b705222mr124173666b.39.1720520308461;
        Tue, 09 Jul 2024 03:18:28 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a856251sm64827766b.185.2024.07.09.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:18:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pwm: atmel-tcb: Simplify checking the companion output
Date: Tue,  9 Jul 2024 12:18:06 +0200
Message-ID: <20240709101806.52394-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=HRECQNJEoiWSJM96Y5TzsskbT2xf7RBPRMnhjuAtAsE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrRevqSy5Kdeaf8YDzhvTgr8arve/sze15a/IuW5KyedO GS6JJapk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ8Fiy/6/L9c8+86cyPyBR RiPL93Z31+1DoSu4Xx2xqo6pCuoXydvdaMNx48LJg43LhFSv7Dhldv3dMa52BtmH64ocuILaLN5 pr5P3Pm0RXGlRmxTV1eOW02wcpKsUVO2ld7D21v+Ku6ZXtcIaoi9/+1k/5eaGxlJ1lkUHjPw8PG effBOxjnNTjrupfZh3qKLeqaUXW1KVDfrnKh1mSk2oL5/1ZAr/d+uNk5kzPJaYTr1ddutS+S8pV o1H1od39K7TirJknRKSJjnh3rZL0VtXNMbq6wZF3Ekqe8XJt3b/7/pk1XdO0Xc6ShmXbsvS/5pj Jr/vY7bA1E0rLtVP2fq6/q7JBE222DeH15i66AYFCX8DAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The two outputs provided by the supported hardware share some settings,
so access to the other PWM is required when one of them is configured.

Instead of an explicit if to deterimine the other PWM just use
hwpwm ^ 1. Further atcbpwm is never NULL, so drop the corresponding
check.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index aca11493239a..2feee3744b50 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -260,7 +260,8 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
-	struct atmel_tcb_pwm_device *atcbpwm = NULL;
+	/* companion PWM sharing register values period and div */
+	struct atmel_tcb_pwm_device *atcbpwm = &tcbpwmc->pwms[pwm->hwpwm ^ 1];
 	int i = 0;
 	int slowclk = 0;
 	unsigned period;
@@ -305,11 +306,6 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = div_u64(duty_ns, min);
 	period = div_u64(period_ns, min);
 
-	if (pwm->hwpwm == 0)
-		atcbpwm = &tcbpwmc->pwms[1];
-	else
-		atcbpwm = &tcbpwmc->pwms[0];
-
 	/*
 	 * PWM devices provided by the TCB driver are grouped by 2.
 	 * PWM devices in a given group must be configured with the
@@ -318,8 +314,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * We're checking the period value of the second PWM device
 	 * in this group before applying the new config.
 	 */
-	if ((atcbpwm && atcbpwm->duty > 0 &&
-			atcbpwm->duty != atcbpwm->period) &&
+	if ((atcbpwm->duty > 0 && atcbpwm->duty != atcbpwm->period) &&
 		(atcbpwm->div != i || atcbpwm->period != period)) {
 		dev_err(pwmchip_parent(chip),
 			"failed to configure period_ns: PWM group already configured with a different value\n");
-- 
2.43.0



Return-Path: <linux-pwm+bounces-6777-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E08AFD51B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2716F71D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72EF9E8;
	Tue,  8 Jul 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0p/LeI88"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41A19EED3
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995108; cv=none; b=E6odfWogLbm7tHmR+ChJpZzvMdxhgJ8zHSr68rf7t1MDtEGuD2yRGAmxcQkHs4N1RBjnQQEjhtAqqKUX7MdtLDkYMgq4XCIzVSfXzqwrraeeSvvdZE3D8rUaqcM11l9/95uQfWQRGC3WXArm3197RayDeFt9n6vOZh74RExak0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995108; c=relaxed/simple;
	bh=nV5WU9eTGJmkqDeV3h7DAn+akVBA0HdaJQu7k8lPdtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txcND0updhpBWKZ9gSH0GW8mE9tdV32ckaeRCxFmalntRuplV4y3LFqq98CMGTP464l6Va/JG6sFZSmITMSqFYtqQGIwTvGenjg4+oofRS3sSK/IIynM8bFbc546KI3BP1G9wjmT7JEzqLzPGpGq7DB0j45/TYwjilWnw+0QcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0p/LeI88; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade76b8356cso845736166b.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995104; x=1752599904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkFgeNoYfK+HxZTMIBp2hIo/HsHu9OatYytKnTqkhjQ=;
        b=0p/LeI88Eg9f1CEqDauFODHIukPkQLw1IhldjbIWkllHF3ZkO4QVvv8Ng5m6+xCn2l
         i4T4ZeTJM7Dba94KrlfIJMI/k8tr+8QSVMQ04MvnAFCtq3djEUo7g1wPu9qBI2gG37Cg
         U0ozXhHubHcG+Q3jbna+YRoi/Qe9cFx/jWvdAFQQ88UK1t55CSwgpj9ZmF7k+X0eZXEV
         fHKLhlR0uSuZw+Bi/xWEteu+tf/RYUVuQ6n+XxrFz52VO2oeGsRFbFCTyX5NHvDR/IvE
         u04tn/SbghnpLlV9fFQPoPD1WbV5wv35MwK1sxAJySAmH4MQbElURVA76yDQqDYE5tDN
         hSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995104; x=1752599904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkFgeNoYfK+HxZTMIBp2hIo/HsHu9OatYytKnTqkhjQ=;
        b=OK1qt6AxwWHDBO9uCW35Hcnjeb7Ur6VLtS1WXvoZ7j6R9r12EgummuN7nFO926vqhI
         4pOQ89c1KJsVltWZfbqqgfhB7oECJJfWkjBBBFSziL4emUl9Rvr233vkoR7iE82kvKvT
         f6V26EBtLa620ciueqI6mXSKIzCbuMZP2l8p9LONatLX2tfUcHT4La7ordwdcSUzV0pb
         WIP3Pax4oGMn+PZ8wdSGG5WTzHqlJJoAymKJpVYcLQ3Tu90/AyVJQXxo+Tf6Lm1xVX22
         YURNWzbJ1mqR6yFnE0WqAm1w/UZopQgKLz/GrLLEoIc92AurqwClk7QKIJBLfeFsw8sv
         7n3g==
X-Gm-Message-State: AOJu0YyoYvnMg4sVoqk8/FhD8ziit5U/SZjRbToXCqeuP87UN2MKuqcp
	Vh0Kwo0iKvsddPyppoJV8wTB+nEWJvK5tNkyc4jCY6JRnShVgDN61cm65DjX+KPCRNrL69q660G
	a4R3H
X-Gm-Gg: ASbGncvRL9UW09lhqAz6dB4jyGF4CS9Uz5NbKu+czc1z6CXtbCTpRzH3MD9pplPtpL9
	fyx3bMsWejQ/sIV6oSdeIFq2qhL/snpYZpkU9jyVzR59mAW4vUftz3kLlfz4198TtReHQFDsX6w
	dr02PbEy5KnJMLhdBdD1ziwQbzTMk7Wt5ns9O/UtK3j4ueduuofZItk6SB4GYb9AV0mJUO8TIpd
	HydtLbcirFma3/wS8RxS/8NeyuRo6MUH+eryb5i/NNuRGcNB4M1QPhMUI/C71gk7xepR/64zhb2
	crQw6cStXgEfMlks1hf/3eOeVp/RAAlF7xczDRZ8X1s6PNeKA/jvr9QOys31zzYg+r1mw9Mz31z
	zPTcxj4ag2s1ZxLoimIpJz92Mh+DA
X-Google-Smtp-Source: AGHT+IHOxdUertMa7C5f/SkaMBdQnzwRPrXfx9tZ+7AAHvjcKZi5/blhlkVsfIpB/gAFrv+xjFZOFg==
X-Received: by 2002:a17:907:9443:b0:ae0:ce59:5952 with SMTP id a640c23a62f3a-ae3fbeaee26mr1640744766b.60.1751995103618;
        Tue, 08 Jul 2025 10:18:23 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b0335fsm917275966b.129.2025.07.08.10.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:18:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] pwm: Disable PWM_DEBUG check for disabled states
Date: Tue,  8 Jul 2025 19:18:00 +0200
Message-ID:  <16d29212b09b66c286c1232b1ab0ec0f8d510aae.1751994988.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4138; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nV5WU9eTGJmkqDeV3h7DAn+akVBA0HdaJQu7k8lPdtM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLMuTkqZG7efia4yHDiqVjt6oBwJ5v5MIGy4 Xiz/Na0JMqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1SzAAKCRCPgPtYfRL+ ThARB/0Ue6QYvOHH3hZibRN745/6peuVSVnSqbvtMFG96uEBQl5vjgZFcwOsfFNOrkC82fYsmtz RLicgkpnA1e2E5t9hxCUUz+ZxTCNZGgBl2z2uzuy4RIip4d+R56RbyJj+TMEjtu1mqBudVC5VTl XkTF68AFrY2S27eZHNbxZh1ZYzW+WIKhQRSRjDOrp7FpBxpSlAZiHvzMnW2u5cnH2aaZCvSqvRY DiCxrWCQbNl3ruMNz4gPgLbD83Xxntt/2iXNi7X6MvZmPLG9apqbopezMse9aHg1duiB6bMpE7E UoHmgrmOKTd4Lb1DWsrVRg5jNxow3KPsUD2KZK1gynZEK9zw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a PWM is requested to be disabled, the result is unspecified, the only
intention is to save some power. So skip all checks in this case.

All but two checks already only triggered for states with .enabled = true.
The first resulted in some false positive diagnostics, the other checked
for a condition that depending on hardware might not be implementable.

Similar if the lowlevel driver disabled the hardware this might be a valid
reaction and with .enabled = false all other state parameters are
unreliable, so skip further tests in this case, too.

All later usages of .enabled can be assumed to yield true, and so several
if conditions can be simplified.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0d66376a83ec..d9d9badf7a8e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -496,6 +496,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	if (!chip->ops->get_state)
 		return;
 
+	/*
+	 * If a disabled PWM was requested the result is unspecified, so nothing
+	 * to check.
+	 */
+	if (!state->enabled)
+		return;
+
 	/*
 	 * *state was just applied. Read out the hardware state and do some
 	 * checks.
@@ -507,16 +514,23 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 		/* If that failed there isn't much to debug */
 		return;
 
+	/*
+	 * If the PWM was disabled that's maybe strange but there is nothing
+	 * that can be sensibly checked then. So return early.
+	 */
+	if (!s1.enabled)
+		return;
+
 	/*
 	 * The lowlevel driver either ignored .polarity (which is a bug) or as
 	 * best effort inverted .polarity and fixed .duty_cycle respectively.
 	 * Undo this inversion and fixup for further tests.
 	 */
-	if (s1.enabled && s1.polarity != state->polarity) {
+	if (s1.polarity != state->polarity) {
 		s2.polarity = state->polarity;
 		s2.duty_cycle = s1.period - s1.duty_cycle;
 		s2.period = s1.period;
-		s2.enabled = s1.enabled;
+		s2.enabled = true;
 	} else {
 		s2 = s1;
 	}
@@ -525,8 +539,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	    state->duty_cycle < state->period)
 		dev_warn(pwmchip_parent(chip), ".apply ignored .polarity\n");
 
-	if (state->enabled && s2.enabled &&
-	    last->polarity == state->polarity &&
+	if (last->polarity == state->polarity &&
 	    last->period > s2.period &&
 	    last->period <= state->period)
 		dev_warn(pwmchip_parent(chip),
@@ -537,13 +550,12 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	 * Rounding period up is fine only if duty_cycle is 0 then, because a
 	 * flat line doesn't have a characteristic period.
 	 */
-	if (state->enabled && s2.enabled && state->period < s2.period && s2.duty_cycle)
+	if (state->period < s2.period && s2.duty_cycle)
 		dev_warn(pwmchip_parent(chip),
 			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
 			 state->period, s2.period);
 
-	if (state->enabled &&
-	    last->polarity == state->polarity &&
+	if (last->polarity == state->polarity &&
 	    last->period == s2.period &&
 	    last->duty_cycle > s2.duty_cycle &&
 	    last->duty_cycle <= state->duty_cycle)
@@ -553,16 +565,12 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 			 s2.duty_cycle, s2.period,
 			 last->duty_cycle, last->period);
 
-	if (state->enabled && s2.enabled && state->duty_cycle < s2.duty_cycle)
+	if (state->duty_cycle < s2.duty_cycle)
 		dev_warn(pwmchip_parent(chip),
 			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period);
 
-	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
-		dev_warn(pwmchip_parent(chip),
-			 "requested disabled, but yielded enabled with duty > 0\n");
-
 	/* reapply the state that the driver reported being configured. */
 	err = chip->ops->apply(chip, pwm, &s1);
 	trace_pwm_apply(pwm, &s1, err);
-- 
2.49.0



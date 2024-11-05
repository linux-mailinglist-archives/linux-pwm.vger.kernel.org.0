Return-Path: <linux-pwm+bounces-4032-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55E9BD0BD
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3129DB245DD
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2024 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BD84E18;
	Tue,  5 Nov 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XcS/9osV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E4824BD
	for <linux-pwm@vger.kernel.org>; Tue,  5 Nov 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820938; cv=none; b=bDBqNv1v/ZELyBzZ1XEo3P0dpFh0GePvvNXZSRCpmhdRm3U+JkElEegSsnJzEeAzZJrD7AMlZxaRRxczXwzChrQjBWni1VhVYXLNRPiyMfMRgg4wKqoqbHms0WKuGKczgItb8QG9ONEtM1bbZ0uKUdaXv/yg6ONtC38j6WQ85r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820938; c=relaxed/simple;
	bh=otxDOdrBEwxCC0tw2zrB0zxfuikqUSqsu3ubEQkWoH0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZwrMtKy439mR2xCD4RClKgFf/QfIXd1nmjIW5nyTnYa5wvJ9jw6qXCQyUjGyXSaHeNw7H4/2E6SqzxMz8ULQ+WcwKhBEtTkFpItpxnpEcbK/wgYAr2ahVMyOvVJa/E0tVKxuXmAAwI6cFegMh0+3F8WLZ+Nn4eZHwwuE2zVLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XcS/9osV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1190433366b.1
        for <linux-pwm@vger.kernel.org>; Tue, 05 Nov 2024 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730820933; x=1731425733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFpnSzL4D9yFNB1r5RhblQ0VqANo2i16BYnRdPEQteI=;
        b=XcS/9osVK6+OU1Rz0qown1S1/5DKO1WlcYTP0guoEz8CInaT1CCx5vZLbopzq7oJkG
         ahJqJCCG73R5gq+26UOF4lWmpwz/sxTWE7d6vc9DP14nEbhvqZUnCtEo157yNNufkAv+
         PYPjBoticiFXgKL2pbSHwdfeFkzKvgTnyQOL23C3iCYu2B+92ImkmON41nNhy+DTqOV5
         bi4TfcSUs3RIPtXh0Ff+bxpDCsUgDLDSTW2CtEu0jnQ7Uy9riBYw4cMWO3SUu0Cxc7dr
         3AF3uMLMSTpzXlshY6lz2GzPi6cDRH1Oe3Jvkzx4SQWYiKAJoFUVnz7Zpu4JgMJ1tJ07
         VVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820933; x=1731425733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFpnSzL4D9yFNB1r5RhblQ0VqANo2i16BYnRdPEQteI=;
        b=ngRbXm2gEpFwEE+4hDxGjyz8EBpZGwd0lykbHPRtO/e0qqpwi1p5VDTXoLFiTDTIuF
         hv8owwMImlFimHkY5xbmdhZD9BnnRqtcwqoi9GuT5vrzVwvPR+4JtOt0zbV5RL1veBLG
         KVYEik3mhvMIpyPQTU1TUnR9wwHTKZ0TYY1IvlQsVLqtdvB8gie6xF8UOH3slrrpkR0T
         x3xwkYkiWsKF6jGPGsfDNn5QR3jnVUzSHUTflEE8iURjZCXw6WcgKnQifoZgZ/O/K3MI
         765iYoUu7m+bvHoYJEy4HTT3k2Rcxs7t0X54DaX9D3GEvjqQoty/oJOjY01l1U1euKPS
         idpQ==
X-Gm-Message-State: AOJu0YyswM1VUTwYhh4uYhdrzyp9vsaCr1cQj6rHalHZT977+tzjmRPc
	Qvp2sdDuxX7QDnr4lj8252VZChI4M5trYHOF+u5YsW34RZTJokS+IXyfLUfCSogx6J0MpCZMWLU
	/
X-Google-Smtp-Source: AGHT+IHLrXRzE6BvfNy/em7lJJJ8vdLkfHJuI2YRAURdbog7Clb4NWKdWA7Ym5J0UssVPu2KgPL3Mg==
X-Received: by 2002:a17:906:f592:b0:a9a:1ef0:837b with SMTP id a640c23a62f3a-a9e652fcac6mr1544676366b.10.1730820933161;
        Tue, 05 Nov 2024 07:35:33 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:28ed:f221:2ec3:ba2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cecedsm150297666b.128.2024.11.05.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:35:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH] pwm: Assume a disabled PWM to emit a constant inactive output
Date: Tue,  5 Nov 2024 16:35:22 +0100
Message-ID: <20241105153521.1001864-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=otxDOdrBEwxCC0tw2zrB0zxfuikqUSqsu3ubEQkWoH0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnKjs5/AUA4nhXG20bXuHd3NtbcntaTFa0qNTZo srYML3n5fiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZyo7OQAKCRCPgPtYfRL+ TpThB/44y7MAvsXu+6RZEtTYm5vQZFDT3yHPa1u9tLXmEKUvCqG2mqWxaYad2z+4HtOxAueb6Zk 3j/lIf0SkOj0Z9aXh4y4DGa7rm95ioiurowmGBcZYaUkhRNVyZTuz1949mAi4MaIfrYkBb/8cn2 6nhctuWzaKATuJCRdInW+k1TKoeBiw09JHQnyjstWx63E0KArOwOmSIPBThx+1KGGf5GaAiFxFI JEUUW2I149MWYmqcp9U2i6G4nYKYjkJC8ONCKsif3HhNa0kFxSzU+DD5eSBGWnXU1DoyWidpet5 W+QhaUHHXdkSxEZ5JSkSqo6gGrcJodQk94AddoiCRguqiMEW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Some PWM hardwares (e.g. MC33XS2410) cannot implement a zero duty cycle
but can instead disable the hardware which also results in a constant
inactive output.

There are some checks (enabled with CONFIG_PWM_DEBUG) to help
implementing a driver without violating the normal rounding rules. Make
them less strict to let above described hardware pass without warning.

Reported-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Link: https://lore.kernel.org/r/20241103205215.GA509903@debian
Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

in the context of discussing the implementation of an MC33XS2410 driver
Dimitri reported this (unjustified) warning. With this patch the
reported warning should go away when applying the optimisation I
suggested.

Best regards
Uwe

 drivers/pwm/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6e752e148b98..210368099a06 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -75,7 +75,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	    state->duty_cycle < state->period)
 		dev_warn(pwmchip_parent(chip), ".apply ignored .polarity\n");
 
-	if (state->enabled &&
+	if (state->enabled && s2.enabled &&
 	    last->polarity == state->polarity &&
 	    last->period > s2.period &&
 	    last->period <= state->period)
@@ -83,7 +83,11 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
 			 state->period, s2.period, last->period);
 
-	if (state->enabled && state->period < s2.period)
+	/*
+	 * Rounding period up is fine only if duty_cycle is 0 then, because a
+	 * flat line doesn't have a characteristic period.
+	 */
+	if (state->enabled && s2.enabled && state->period < s2.period && s2.duty_cycle)
 		dev_warn(pwmchip_parent(chip),
 			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
 			 state->period, s2.period);
@@ -99,7 +103,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 			 s2.duty_cycle, s2.period,
 			 last->duty_cycle, last->period);
 
-	if (state->enabled && state->duty_cycle < s2.duty_cycle)
+	if (state->enabled && s2.enabled && state->duty_cycle < s2.duty_cycle)
 		dev_warn(pwmchip_parent(chip),
 			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
 			 state->duty_cycle, state->period,

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2



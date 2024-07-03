Return-Path: <linux-pwm+bounces-2687-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF4925BEF
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6491C20BE6
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56284157E62;
	Wed,  3 Jul 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cNJxpkiG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE976E5ED
	for <linux-pwm@vger.kernel.org>; Wed,  3 Jul 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004428; cv=none; b=pt7bUsMvlxi+NOxp/enh1uK1rypfr0brxnAIFL6A2RIhbU6CWE/CuUW/5xANV7q3+HDHiYhwBsQGtksgIxGCz580eIsr75yyjYKnyGVVEJzankzYwZG+nOSiaVhGKuAMPHHMO7pf6nI2yTZ1lqpiTnFzo4x3465HDEcQ2UIAmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004428; c=relaxed/simple;
	bh=+HpQU6gozfMhxx/gK3ptpRjLMLOdhZfsXR4twlS01fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXx9GgqWTOP8Xhfgr1eLzt+h4P8ZIYg51ssnK9U6s6kOpM/nFmtX46Qq4GBLyyydLSSQQsQdntiS7gPTfPw0mFYJNYK8jDCmFFQLe+mYm0WYHEOoQeimBaI4p5O+snl5+NGNYBSkeCsfnmLVqCAoe7QRlhIqHvWLYeDR6SQotYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cNJxpkiG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-365663f51adso3178364f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jul 2024 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720004423; x=1720609223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtisqDMXNi+4gJuWXZy25aio20MDv0fW59jKl/DfJmI=;
        b=cNJxpkiGBlfjh27WJnC1WVlSglAMjXDrpyeN+oUUDn0pV2gTyd0imNd4mhyZLte7FG
         M4O1ol28u4hZD9nY9nGbSZ0F5daIiKCl7PVmC9IJOFOickidYK62egsGDMwJIes6qp5K
         2Z1aYOkM9hXBgZEaajRUHgA4rH1YoXlZPByrE7jkMSy6leo0PRSCvNuXlAI94sUi1LaL
         lUhTq148hIRcTjxNipv2SfXSWe90gCvOYBWit9lSfTnb4+Tp06Y217Wce83WqhtePBPF
         c7pq4DpkSElG2br6ITEmKneOn/5sMFJ3rpD19qF10a3VLsOXJ8PJgf6H3pKmg6+Aj78r
         p6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004423; x=1720609223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtisqDMXNi+4gJuWXZy25aio20MDv0fW59jKl/DfJmI=;
        b=WHaMwSYhWWQU4wF6rQZ9nIARbvB9XvE+3aD7VCRmCrTRfyeznHMy7tDao+6ozpDrH3
         qwZLZ2q09SPQpHhi98sTV2JQpPvBF1cSPZp0B6Ritr0JTAwCO3GzkEP7ywkH72oGGRuN
         ItC7dILNGdU+golRnpxVPO0WZTZhYj9f5QsOT3oAhXB3d5ehDws1emjbN1vKU5g6tB5L
         B4dBwRttfjtVVIEV4Lmp8Q04ZIRONnOjpxwTTG+EZzJIT6MtmqWAhJeiNt50Tiafyvxm
         K3jiyYjIkS8OPWLq80ijwWcNsARc95Fap56Gx7SXW/j/uQ6AXZgrLV2lYdhQ2gHY2aqR
         e+Yg==
X-Gm-Message-State: AOJu0YzGzEE92z8KbqThitE3xg3+ShFePH3tv51DCa+hHECunOIo7+Td
	1Ue6UkM+TV8e+WNYiHR0Qp5/yKdR3RTR9vufqO7Wb3zr1xvHRW7FvIpf2aER5D9DpNGTdk3Zjn+
	z
X-Google-Smtp-Source: AGHT+IGO43C86ulPQhwH3Aoxdh6WYDHyi8aYiyMUrl6XRbUbgoH04VEiYXx2FjA/4gS9pUkkEHf9aw==
X-Received: by 2002:adf:e6d1:0:b0:367:9387:e48f with SMTP id ffacd0b85a97d-3679387e567mr785575f8f.66.1720004423383;
        Wed, 03 Jul 2024 04:00:23 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36794e6863dsm1166471f8f.50.2024.07.03.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:00:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: stm32: Always do lazy disabling
Date: Wed,  3 Jul 2024 13:00:06 +0200
Message-ID: <20240703110010.672654-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=+HpQU6gozfMhxx/gK3ptpRjLMLOdhZfsXR4twlS01fQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmhS86WGTNadNOW9022Y1BJVZ0YoeD9AI4auTyP oXqPps71u+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZoUvOgAKCRCPgPtYfRL+ Tqu8B/wI+eGBZNzv4A1QkDusnMYU4hP2fpp2SYqvFd57lIMZtXJWJxiS5a5DBRXlf7lvxoadkn+ h43doYvsd7Rg0y5hmHZqye1bH7hTM2sSo4YjkLcVUleO0Ay9D/fv6MmQ486KDaE7CQ2Ck/3JgNM 7zSmQ5Xj3H7vsO03Hq3cxyJuvXS4kyGmy7mTgEbToRGaWtMqOqdBPUjxST2nevCuklD2QSNPGOS Q/g5tDpDeF+erR2rSMDRZN0DdY6Npe/UE1gE6Xs2EmmHykVr4UQ2KO1RUImrI7OKpYas2JNNi8z M/mo6b/EhVtyq+f5LLyCI2pQ6F9ck9HeopPW2ejiszIrHLYk
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When the state changes from enabled to disabled, polarity, duty_cycle
and period are not configured in hardware and TIM_CCER_CCxE is just
cleared. However if the state changes from one disabled state to
another, all parameters are written to hardware because the early exit
from stm32_pwm_apply() is only taken if the pwm is currently enabled.

This yields surprises like: Applying

	{ .period = 1, .duty_cycle = 0, .enabled = false }

succeeds if the pwm is initially on, but fails if it's already off
because 1 is a too small period.

Update the check for lazy disable to always exit early if the target
state is disabled, no matter what is currently configured.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index fba080daf445..fd754a99cf2e 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -452,8 +452,9 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	enabled = pwm->state.enabled;
 
-	if (enabled && !state->enabled) {
-		stm32_pwm_disable(priv, pwm->hwpwm);
+	if (!state->enabled) {
+		if (enabled)
+			stm32_pwm_disable(priv, pwm->hwpwm);
 		return 0;
 	}
 

base-commit: b8689bb9b901e5e2bc0f0905320b32e8c898a58b
-- 
2.43.0



Return-Path: <linux-pwm+bounces-5785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F40AA4A6D
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E722718828F8
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4425A2AB;
	Wed, 30 Apr 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U1lTjCq/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0A254859
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014186; cv=none; b=D3D9d3J1OkUswmNE2D57i+yPP5ldIHhdmD7gbhE5J/p0nLL4snWqGkmmgtx+uH227417TeN7g1hyb0NkylAfOte6Au6QRLXOAF1aYOSkmHXC6YO837phz5zye4x0F/DuX3E3R62cs3V/uhpCZ2IiG+vYhaW1pSBxNEtdD2CrWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014186; c=relaxed/simple;
	bh=pmPfZfdhpe08zFnN5tLlJkVDVkEeNQk+NEZc/D1fbGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8h6ldEIGn+tUiOfCUEnNf8u6KUwMo3DfcgTd2rPLxkQBJv4Nlga46xe+eGKdCSbqB8dvSIUqoN9UohCOVZWdZ/DaTxYSqoDyO/iiVDemXiWFQxZA76g2M4pR/EnLrqcJyM1tCZs8p+PDK/miTB+RdGFK/Z+lv/Fc28+dYFb7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U1lTjCq/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so42293505e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014183; x=1746618983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2xHxs3KnDeNu7WRbSnqj4aOhMB1CBDFvBqUKG0qcVk=;
        b=U1lTjCq/A/NsedpPy+FqXPajbHINPe4dUnxJsZ8BGfdZbfFo1915Va7zYqO/BjC613
         s9q98Nd6VZ9IvqLu9Hz3TsH0Pe1i+hJHtht2ozjRTll0CH2gFHzKxUxzvS/d3koDj1RC
         W7C1YPSna6De01HlTqm9w8+OEPbU5quI2mURzJxDyCTRLhmb0yTAtdMg9ik95paBfPKz
         owH6m+4Ab11AEeOZT6u/7MP9cw/TyzqcK7GSvS0L5uaG48POzBVd/nnamoDSxyZU8b3Y
         +QKF4esqJWRou94ZpeCt+zkfOe/O6eEayaQZSA1Fpjy2EdsjhbmW2uFG5broEf7RffWy
         LCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014183; x=1746618983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2xHxs3KnDeNu7WRbSnqj4aOhMB1CBDFvBqUKG0qcVk=;
        b=CD8tYpchCFCLRv4ryx9A6ffJZZTXakNwiWB8l4XZkEPeOC5y6LH2B3XGruq3/YCqfi
         i2jciJG0Sby2ryAhZL+z2wedZyy9osGZ2MCgOxphI0kKnHs4tqmx4aaFDJ5DDZmysAMC
         5Tr8HyG2H+e58OeNlnolECYU+q+rO8bp0RmiqpK2Ji0FXlOvUTiNYltHirhU+LoK1NqK
         aBTa1iWTZ0QNj23p/trq04ptUeGPSEu0PHZFVYCpTy4KSkj02/ZX5TZjgKzq2mjWte3j
         PXuztIg4ff3oz4bx+A0TZ/l1mBfGaH+LGKU3C6qoV1LtePe4AwqhICNvpIaOkwqOi0qz
         h/jQ==
X-Gm-Message-State: AOJu0Yzb0A/d1fYRc68eRC/ltVYX8UKHGJsbUM8LO3bd8ir7rZewteq9
	dO6t/FaSxxuvi29mACBO8g+2DxA2tSyOxwvpJtAxd/osMTSuT7HwK833HFXQGwa/HP/rmh5sBBh
	L
X-Gm-Gg: ASbGncufVHimpZOmUjRjNtWyx/xyhUzANckgnPAEVU1lEiXjFNhsfTBo7Vnj1MDQhNn
	mxbCRYrYYGKvp29Xr6jlwtHvICDwmu2M8UZqFZZHSLX+Ee4jP/HoJspYTzVqwPUdzCN+n57YM2y
	Vwes651HZRJvkQqaO5vWNGhDHw/s/ACTsdJ/++1SHLrlZC7MgUHAPKjY1jmBArf5loya/eSBC0Y
	77+YdETEf49lrhQFpGKzfQwHvVpe6HCyjZnMYVOND/EfU0/eoBKOpKlGCYDZnG43/+Gy6EH7nck
	fUOhglQ/nQwcCcaDWcCNq3WDWx16/OEVLj8CfOq4Nd4C9w+Dzl4Rrsijxuz3z/bP6yCLafjxFkG
	pU56X93E=
X-Google-Smtp-Source: AGHT+IEIVW9hCC7khpxN5eC7lwB7Nqf2uJEp51BVHaLSAHCM2w4LxwKU+3btSCLoZCrVcxQtJJXnLQ==
X-Received: by 2002:a05:600c:19c8:b0:43c:fee3:2bce with SMTP id 5b1f17b1804b1-441b1f5be9cmr20071305e9.26.1746014183134;
        Wed, 30 Apr 2025 04:56:23 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441ad81c19fsm39248705e9.0.2025.04.30.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:56:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] pwm: Let pwm_set_waveform_might_sleep() return 0 instead of 1 after rounding up
Date: Wed, 30 Apr 2025 13:55:59 +0200
Message-ID:  <528cc3bbd9e35dea8646b1bcc0fbfe6c498bb4ed.1746010245.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=pmPfZfdhpe08zFnN5tLlJkVDVkEeNQk+NEZc/D1fbGQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEg/VsjKyV93JzbnPFh5tLFh0UPbIAUVfCmmlT MRb5M0C+pSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBIP1QAKCRCPgPtYfRL+ TiS6B/sE4DJYf8tPuMmZjF5NMTHFVXtusXFoGZ7tEhv2XsdL4zhkmhdiPGvNJ/Vdo0hmA/+CGF0 ZPc8oeVrDfZpTtmfeitvKJxXrIpmHbOEET7HaqNwgqXDI/jkH5onHb8Q1VM7ndAdIHG6sOzn7eB TxuRnK9NarmXREUKOesQ5by0RYVpW1UM25BPne2kW5z6A/BrscgPkIYVGCtpU07jh9Ra/OE/B9S Zddt+uF0GmECErrKM8z2bRN5HqCnpfqRhVRLx8oIo1nn3m8nHkAu5MIIzPirKhsusSJ6RYcl0Af /nZckWkKkMMiiCBYjalpaxqnkpi0kvlkLQJ+62xuVFlHsyRe
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While telling the caller of pwm_set_waveform_might_sleep() if the
request was completed by rounding down only or (some) rounding up gives
additional information, it makes usage this function needlessly hard and
the additional information is not used. A prove for that is that
currently both users of this function just pass the returned value up to
their caller even though a positive value isn't intended there.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 28cb6ab0f62d..5cf64b3a4cdf 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -411,9 +411,8 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
  * possible/needed. In the above example requesting .period_length_ns = 94 and
  * @exact = true, you get the hardware configured with period = 93.5 ns.
  *
- * Returns: 0 on success, 1 if was rounded up (if !@exact), -EDOM if setting
- * failed due to the exact waveform not being possible (if @exact), or a
- * different negative errno on failure.
+ * Returns: 0 on success, -EDOM if setting failed due to the exact waveform not
+ * being possible (if @exact), or a different negative errno on failure.
  * Context: May sleep.
  */
 int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
@@ -442,14 +441,17 @@ int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
 	}
 
 	/*
-	 * map err == 1 to -EDOM for exact requests. Also make sure that -EDOM is
-	 * only returned in exactly that case. Note that __pwm_set_waveform()
-	 * should never return -EDOM which justifies the unlikely().
+	 * map err == 1 to -EDOM for exact requests and 0 for !exact ones. Also
+	 * make sure that -EDOM is only returned in exactly that case. Note that
+	 * __pwm_set_waveform() should never return -EDOM which justifies the
+	 * unlikely().
 	 */
 	if (unlikely(err == -EDOM))
 		err = -EINVAL;
 	else if (exact && err == 1)
 		err = -EDOM;
+	else if (err == 1)
+		err = 0;
 
 	return err;
 }
-- 
2.47.2



Return-Path: <linux-pwm+bounces-3962-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D479B54EE
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 22:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956561C22422
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594CD20A5F1;
	Tue, 29 Oct 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9n6x69N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53897209F32
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236746; cv=none; b=UYxidOSUGXpp8AZUuNwXoeVt4iqaQFWanwAvQ3kPAKkvII/m4IocldHpXIfVjvq9LcwDrFysdpprIPTi/pfpN+P8+9Wj4zLzLmKjB0sRzQgjY9ud1hbRy0LMQ041zKXlAy70yxdmTelsv7jSEM9Z3ymgSqL13fCEu6xhDEU0KY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236746; c=relaxed/simple;
	bh=Z4jZicEPho7E8Zh4ttgUAKuZdsP/ORrjJAHvxDm8eus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFabB5JCro4mOfESaFTIRrIvrIn3XhIl/cSN/LchIMdCwAMOJz+MB7s7HpjPqwBwACiPQ+cIj+s4Oq7TkqJ7DkdGlGaKhIHB+Qy3upoXhLwtqSbm6yPqBPguhz6HIwsR9ijCaCKWcM3phR1uqXyFNMCCVa6jhOY329ud+XaFcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9n6x69N; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7181b86a749so2826259a34.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730236742; x=1730841542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wrS1bMaCWm+0PSTkBvtfTirxbx+alGuE9jV95sT+0g=;
        b=l9n6x69N/NC5i6y2MK1hojV1deEp7hdw4fOA2CjxcfLsOqvLZSip4vqzmrhojtRl8A
         gwVpyO9MDf7KQjiHmSuuOxQOP4r/6Io5dAs6eGKomCzDX6TgTN2TaNq8yQUBe4o08Tk7
         xSlNHkY4f1kKRtTFCQaWXmY3EbZUMic1Ta7jbF95GFByhBK+9HE+mCEwfU+JGBPQA/II
         VGvcBKf+OqZHZCxvvk9/LQAu0Iy1OLDZvpUo3NcPG8ANb9L7+0sdVwOkgOz5MCL48cfg
         95eX13QWSU6Mk4jzgFN9C5JZEf7H4D7LUy2YItgr2cYvU8xTj3b21+rxMXtyZCsgHKw3
         6ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236742; x=1730841542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wrS1bMaCWm+0PSTkBvtfTirxbx+alGuE9jV95sT+0g=;
        b=W+nWHqd1uXabp/GghJ9sNDEvm0Xpxao+8VJA3FTYWT1Yc/4Q41zZFKcM/NaKkCyBrb
         RXuW5q6so6S0uuyz21uFJegRAUL9DM6yQ3dyUmT7jAJir4E5Aa6uscnFfLRGsPLyhbjp
         w1cdkKGuhm8qNO+IPaAsQ1xlxfFWN6Z0o2XjdPlEPgckBF6K4Ckz2MDiJaSkPxHavtGB
         GmfilNGyXxS7qeKLv7MqsqcNqwsc1KwrjmC1sAUqscb5oiiZDjdcusdnKZZ13aX0euo+
         Ytz1ZeXyuKmVczKLZ/+fQQjooiHn5tGixp8P7qPr9btMEaTjsQzyDDFCKFm+RxZTCOI2
         fbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUrEff6q8BKfFw+gNaQdWv2Sn3RxdooXNcJzEU3xM4fbI4UyeRVZEwuS04L9+EH2xgRdtsGsFvLyrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKU00OHjWe/azOSpNwlaH3g9e/j/k/Y7TvYZ8V1LNQeNUOakhh
	7NfkzNlF78W9heN/VKMaYIB8q24l/oYt42M0Dimmck8/to3k6zhEyVMwSVpdw2Q=
X-Google-Smtp-Source: AGHT+IE4ouNlt7GMXj3UaHhNZIzD8uGuth5uRj6lvR5euXNGEEeCXeLg1uNFb2UR4yEubecn6YCURA==
X-Received: by 2002:a05:6808:1311:b0:3e6:1218:45ed with SMTP id 5614622812f47-3e63845e9f7mr11856795b6e.20.1730236742510;
        Tue, 29 Oct 2024 14:19:02 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b87ecsm2280559b6e.54.2024.10.29.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:19:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 29 Oct 2024 16:18:49 -0500
Subject: [PATCH v2 1/2] pwm: core: export pwm_get_state_hw()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pwm-export-pwm_get_state_hw-v2-1-03ba063a3230@baylibre.com>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Export the pwm_get_state_hw() function. This is useful in cases where
we want to know what the hardware is actually doing, rather than what
what we requested it should do.

Locking had to be rearranged to ensure that the chip is still
operational before trying to access ops now that this can be called
from outside the pwm core.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Dropped __pwm_get_state_hw() function.
* Reworded commit message.
---
 drivers/pwm/core.c  | 40 +++++++++++++++++++++++++++-------------
 include/linux/pwm.h |  1 +
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4399e793efaf..ccbdd6dd1410 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -718,40 +718,54 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
+/**
+ * pwm_get_state_hw() - get the current PWM state from hardware
+ * @pwm: PWM device
+ * @state: state to fill with the current PWM state
+ *
+ * Similar to pwm_get_state() but reads the current PWM state from hardware
+ * instead of the requested state.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ * Context: May sleep.
+ */
+int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
 	int ret = -EOPNOTSUPP;
 
+	might_sleep();
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
 	if (ops->read_waveform) {
 		char wfhw[WFHWSIZE];
 		struct pwm_waveform wf;
 
 		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
-		scoped_guard(pwmchip, chip) {
+		ret = __pwm_read_waveform(chip, pwm, &wfhw);
+		if (ret)
+			return ret;
 
-			ret = __pwm_read_waveform(chip, pwm, &wfhw);
-			if (ret)
-				return ret;
-
-			ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
-			if (ret)
-				return ret;
-		}
+		ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
+		if (ret)
+			return ret;
 
 		pwm_wf2state(&wf, state);
 
 	} else if (ops->get_state) {
-		scoped_guard(pwmchip, chip)
-			ret = ops->get_state(chip, pwm, state);
-
+		ret = ops->get_state(chip, pwm, state);
 		trace_pwm_get(pwm, state, ret);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pwm_get_state_hw);
 
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f1cb1e5b0a36..5bcbcf2911c3 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -370,6 +370,7 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
 int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**

-- 
2.43.0



Return-Path: <linux-pwm+bounces-3777-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDB9AD5ED
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F474284659
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0941E7C2C;
	Wed, 23 Oct 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QFhtkj+X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193051E7C28
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717162; cv=none; b=AxEfIOw7397li+WMCvZ50hw05IU49GwT5hbaJkfzrmoRNhblhsWK1EZ4tdyM9g1LC+RdDru7Wdxvrq2jvAo/Sy6MjmHwO0drRPqtWWXwj49fvdGSv8DRZmO7oAOiXNoulUzLyPVeJQmmAwp5McQgN/XgDtNk0iX5tK3aQ4WpRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717162; c=relaxed/simple;
	bh=SlCysBgz0D/4+AADJGuHeqX6/WY754v+eDo0HNvP8C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifibcRYBqmy9ecxkoxpXdi0B0s/Au2iDhA3lMt/B6TylZB+WpcS7eZ4gXIJZwVmOo7XLLvJZN/m6pa+wtj+kgX5dZZG2Vzy+xUvPUwm3TjGgI/DIbHGq0BusBAFwEBfUpJbq/XM9c1fOVC/FUvukDFPADEnbcrbJy8F3Uhc8E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QFhtkj+X; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71822fabf4fso152058a34.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717159; x=1730321959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TxSe+My0zxdEn+4gVzAIjVmZG39HxjUCg8p7C0cMnI=;
        b=QFhtkj+XE0Gjpjnt27RxaEKUTNJeOSO8aweYhrtcy91DlH8n+4JJhQZmNvAZX9oeDP
         LYpBr+laTTWn/vyjYZc7T3a72llddv5t3RrGHrouFWuPX2U1pbnTsHg3Wg0oHqEaHpHN
         LosEeO16As6uDIb1YzhM8Ngc1zWWULHSv7PdaaixCUSrjUtcReerInLdVoZl0artcc4A
         Z6UxrgINOTcMaOCG8VhekcKxOBYxv9W30gZeasqfhOTuNznlkdiYROzlVWpRgfAADtY1
         Yw98PITB3WtaYkH7YKr3HAhSRWBvqcyulKsbJMjfHHnExkwbofEpfSWPDi9S7RmN2baQ
         3YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717159; x=1730321959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TxSe+My0zxdEn+4gVzAIjVmZG39HxjUCg8p7C0cMnI=;
        b=w5xeEUiAhOmrvG33JYLtUSsQWkVQFQBWV0jvoarK7IV4ntV8xJUqAhH9+zjFLawmwL
         hl6SPSJ0KdVKaWhVr4pf7vO6T25/myOy2YvZPHt3FiLjScFQbRJZGnt1OhXTDO2JyvPL
         F42X/mO+KhQFghyLnlBPTy1OxB6CLS507t8f1E5tiMfse9D+p73eHV5ZAlZoJ+0i6wWH
         vs2A5MtxznlBS0UVeBujef3/0oStaRi+m1CbkRlX/jnTVsQ0EEsGf12Xd8O/aVZ4QaZ5
         xUYNEVWUkz+LAf7Yj0eSq+LZCnrSuLm24PLEKOcR7+sxSVrbufTGJexvFEthOXR367GD
         JNeg==
X-Forwarded-Encrypted: i=1; AJvYcCW1VZ+xbBKNhvA7UPmU4ZtKFEdhzLNZshBwYDU5zwcmiWgBhZuMiK/cxJ1vn12G0tRFsZF/u0u9ra4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7L0Z0I3byKn+YpTS4V6bDBtSimaOSgtWBO/I2aA/JILeTUt4
	/r2bVsbo6NfEn/QLF5rNOusqgulgkc0X9Peb+usiaqr3JVkzkjtT7fQseOLvVeg=
X-Google-Smtp-Source: AGHT+IHLXaj2jzh6xyZqcUUi3HAROcbZJkyHzk/8HYjkhquqvm+FQrkdOY7a4q7lSibR/k9/2Gq7iA==
X-Received: by 2002:a05:6830:4981:b0:718:12af:7f01 with SMTP id 46e09a7af769-7184b2e6a7fmr5254614a34.13.1729717159246;
        Wed, 23 Oct 2024 13:59:19 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:08 -0500
Subject: [PATCH RFC v4 01/15] pwm: core: export pwm_get_state_hw()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Export the pwm_get_state_hw() function. This is useful in cases where
we want to know what the hardware is actually doing, rather than what
what we requested it should do.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4

And FYI for Uwe and Jonathan, there are a couple of other series
introducing PWM conversion triggers that could make use of this
so that the sampling_frequency attribute can return the actual rate
rather than the requested rate.

Already applied:
https://lore.kernel.org/linux-iio/20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com/

Under review:
https://lore.kernel.org/linux-iio/aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@baylibre.com/T/#m1377d5acd7e996acd1f59038bdd09f0742d3ac35
---
 drivers/pwm/core.c  | 55 +++++++++++++++++++++++++++++++++++++----------------
 include/linux/pwm.h |  1 +
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 634be56e204b..a214d0165d09 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -718,7 +718,7 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
+static int __pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
@@ -730,29 +730,50 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 
 		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
-		scoped_guard(pwmchip, chip) {
-
-			ret = __pwm_read_waveform(chip, pwm, &wfhw);
-			if (ret)
-				return ret;
+		ret = __pwm_read_waveform(chip, pwm, &wfhw);
+		if (ret)
+			return ret;
 
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
+{
+	struct pwm_chip *chip = pwm->chip;
+
+	might_sleep();
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	return __pwm_get_state_hw(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_get_state_hw);
+
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
  * @pwm: PWM device
@@ -906,9 +927,11 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		err = pwm_get_state_hw(pwm, &state);
-		if (!err)
-			pwm->state = state;
+		scoped_guard(pwmchip, chip) {
+			err = __pwm_get_state_hw(pwm, &state);
+			if (!err)
+				pwm->state = state;
+		}
 
 		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
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



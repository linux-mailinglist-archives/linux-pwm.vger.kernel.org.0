Return-Path: <linux-pwm+bounces-4722-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EAA1A8EE
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE03A865B
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCF14600F;
	Thu, 23 Jan 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J83qGHwN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AB12C7FD
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653245; cv=none; b=F0hAsJY9tQk+UiQhXtnrVeyfrlYYJu2qW/gZhUoetcyg2+ZtN+403c7dltlQ5VKM1HWaMThzng8jzuHf4O0k2X/7LcDdoo7t+tRrA37CwbcPzTvSPN+3i/vrXhdHlPQJ5VT0gdr4m2C8V9Du/dpyanfssakLyq/F1LyTjXoFzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653245; c=relaxed/simple;
	bh=5VcL1KJGY48tpjWVdAmlb3DjPOdtc97/ATAxZx5gYXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jjz42GgdZ1ah3RfvxHATjNRFAni+Ha720eYOv4u6RKS90vVlRmD9oNJL/grRHu+uMLIVpRDdmu0UW52Ja5lNTEgX2KpuRl9Ipcd3Lul8WGwU3H0GA2oQcCgAJo4fW6vHnaL8B1M/Ip/dzlVwk83EphAeWwzM9hv6ORUiltwRFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J83qGHwN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab322ecd75dso246255166b.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737653240; x=1738258040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OW4Kcq4MU1554DBuiBZTdsTL2Qlr9Xu/MuxWp82QmXc=;
        b=J83qGHwN/tAIY3I3Yk4nsg8777YWRg5sBEbL53VALz5QuxcyqkcL1+PiA5dHc6yzDs
         TWn9xbpsIbMYiqq8TOiHoRHRdPszcofPe5bXjMNUMiUPYAkvzr3+U9aFMlEG6nfhMSNx
         iahhksERYk+uscg05CbqltKhzKE+3myI/3WqT+WjzyWlb/bfrt0Zg3LpYiMPnExSbAfL
         wwnDRcXAA8aGCfkN0bEoIZeSduMbuyOXXtAP+M/FFdTKsh6j7fkJfLD/t3Qc08p/tLbK
         gKyCXlXvHpo2UBL4/9KVQrsCD2iyRhmGDkgl85mhNRdgV9Bo9JUx9g5Z+IluzsKpTe5O
         3TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653240; x=1738258040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW4Kcq4MU1554DBuiBZTdsTL2Qlr9Xu/MuxWp82QmXc=;
        b=M3wVyVZnYxiJ6FyuCX0jXyZ5nhGzr7+d8xgyigC354BL9ql35h2CjVVnf71/F31Yq7
         ORhhK5Mr6+Bui23F0kx7CsMFsIsQNhh1f9AgkWi8mUf7kF9jaCl7ItHupyZMyz7/doOL
         pzeP2o1zsaVpdZgEiRJwqnSv0O2YsgoNtrkxeyE5honelunIEWTYZ1S+778zlGW9nAXh
         Mdc7tVOiocS9A4Y0IsY3hdLq/CJBoNqwknT5RF/gJh5zNOpFj2Ol6EDlQk6/jG3YEaW3
         t7qkJbmAhrlPuqmBxye7Qh9HG1KglByaTIW2MgBCv7GIoXrbrXmeAWXwjRZa8zYw5XMk
         YTvg==
X-Gm-Message-State: AOJu0YwUXKXuOGNizcjlCqxHivLzCif/49s6qz3BOHZQuNnHT0EoqGa2
	6O3SChTsDsylazCRwRjd9+PlI/FIbmL5PpqEts7jY0IfIY9hY3UyZdtgSlNtE2+AC2/GFILaAmU
	WFGI=
X-Gm-Gg: ASbGncuvegKdTPj1LoQ+VYRfkDSRg73hpgt8MmpE1rNWN4+LrXI2vIixsuELCVV1APk
	V/3sCzVBXkjjQR72U1JsMkmIwl+48Cn0NjCWLMxpCWKuQ6xHdelOIJNa/hbXJpaTgWsbWd1UyKa
	3i91W7NL4z3PNhca+iPY+6LsFVGMPWYhZKftRzPNsa3NRCLpA47Y8MqK5EV+RsipqWgC/QDZiaK
	znZ0F3JCjOlAACqiVwm1w2JKszlEyTnuIDHRYEmVt4hZeV4FGWoUCMbrOw15oc9yvhg9J/+jbRN
	G++1oFDzsZwVkbqWb+VckVdB1/kOGLPmgxG4eQYh2H3gk2A=
X-Google-Smtp-Source: AGHT+IG+rMtYPI9i1zGELP9CcOm9R4pDZpJOWL7R/bF86HgB0WzYRRkQA427ujy0zDS/T/UeAP/jTA==
X-Received: by 2002:a17:907:7b96:b0:ab6:36fe:4c73 with SMTP id a640c23a62f3a-ab6745c45dfmr14901666b.10.1737653239936;
        Thu, 23 Jan 2025 09:27:19 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60751sm1096903666b.30.2025.01.23.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:27:19 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pwm: Ensure callbacks exist before calling them
Date: Thu, 23 Jan 2025 18:27:07 +0100
Message-ID: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5VcL1KJGY48tpjWVdAmlb3DjPOdtc97/ATAxZx5gYXE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRJ1W+fF+8Lzbn3uFyBycctu+JRcZ+r3ZKUa7PYbyftd 1h4ly25k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ+E7nYOh+HWDcNVOk4dW6 5kaGDd90H1tJhM9/1dhUXOPoaW3+icl2gk34ltvV8w43dD8ptZSao1HEqLJ9K/Nxgc/uGbI1JS6 PMn9ZHJQ7Ux/76VSTm9lD26Orrc9q8jAZLWvfbp8xn+nMgQ+nrUWD1nkG3Gm61vi8m8Eg3vr2Jn mFz39Os2zt0eMQmqfwa+8tVuksd6VP21sSe6a0+S97pi3BqmkjMp33+a3Q6gh7MdXljBMtmQ4Yn C+7J/pxKp+Ad/URCz6L1NeFt7aqm3+0PcgUwVQ634iN0UDESEFoe2a5udSkjUeK45lu6W7luV10 hv37C/XG63vW6//Onmq/JOSw+OJ/ulNWWInEPzyRMe0mAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If one of the waveform functions is called for a chip that only supports
.apply(), we want that an error code is returned and not a NULL pointer
exception.

Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

assuming nobody spots a problem I will send this patch to Linus next week for
inclusion in -rc1.

Best regards
Uwe

 drivers/pwm/core.c  | 13 +++++++++++--
 include/linux/pwm.h | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9c733877e98e..1a36ee3cab91 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -242,6 +242,9 @@ int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip))
+		return -EOPNOTSUPP;
+
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
@@ -294,6 +297,9 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip) || !ops->read_waveform)
+		return -EOPNOTSUPP;
+
 	guard(pwmchip)(chip);
 
 	if (!chip->operational)
@@ -320,6 +326,9 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
+	if (!pwmchip_supports_waveform(chip))
+		return -EOPNOTSUPP;
+
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
@@ -592,7 +601,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->usage_power == pwm->state.usage_power)
 		return 0;
 
-	if (ops->write_waveform) {
+	if (pwmchip_supports_waveform(chip)) {
 		struct pwm_waveform wf;
 		char wfhw[WFHWSIZE];
 
@@ -746,7 +755,7 @@ int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 	if (!chip->operational)
 		return -ENODEV;
 
-	if (ops->read_waveform) {
+	if (pwmchip_supports_waveform(chip) && ops->read_waveform) {
 		char wfhw[WFHWSIZE];
 		struct pwm_waveform wf;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 78827f312407..b8d78009e779 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -347,6 +347,23 @@ struct pwm_chip {
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
+/**
+ * pwmchip_supports_waveform() - checks if the given chip supports waveform callbacks
+ * @chip: The pwm_chip to test
+ *
+ * Returns true iff the pwm chip support the waveform functions like
+ * pwm_set_waveform_might_sleep() and pwm_round_waveform_might_sleep()
+ */
+static inline bool pwmchip_supports_waveform(struct pwm_chip *chip)
+{
+	/*
+	 * only check for .write_waveform(). If that is available,
+	 * .round_waveform_tohw() and .round_waveform_fromhw() asserted to be
+	 * available, too, in pwmchip_add().
+	 */
+	return chip->ops->write_waveform != NULL;
+}
+
 static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
 {
 	return chip->dev.parent;

base-commit: e8c59791ebb60790c74b2c3ab520f04a8a57219a
prerequisite-patch-id: f5f481d393ddd1fd20a685c86cd4e93dd40d26c7
-- 
2.47.1



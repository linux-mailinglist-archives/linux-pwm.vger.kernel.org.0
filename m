Return-Path: <linux-pwm+bounces-5317-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB8A778D3
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F52A1886F9A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D51EDA11;
	Tue,  1 Apr 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eQeqWv9Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F021E9B00
	for <linux-pwm@vger.kernel.org>; Tue,  1 Apr 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503371; cv=none; b=aHWWsXnrSFypv1YSnqItfEJP3R6wXR0cwiQSnEA+v21mK7+t7D652zx04j4CalWn8Bwu4mCsluYMq/PrS98Tqlz6ng7e8zXmCMLw5RHmJEGS4DBezaUGQh+jBTa8Darvbcn5CMLlro/ee9zpc3dbSlE6z9H1ews7tatHz1gHqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503371; c=relaxed/simple;
	bh=Y5eWYPL/Z9lk/J5o/TdRWO2TnWWprWjUng96J/cfugQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlDKkZbuEetk98UHxzSIhyhlezE2zM49EpRFIc3Z02xiQJORQEe180rOK0xeD7Rs/uyiwKR+0xIU8SP8pmJfaUf+QVC98761aUOKHl8MWNqlkIpn2ejDcdg0FIF0Rk2ap4r2e3dMF6IZUsXPD7Hl7l8RgqnqmGvhbmWScAcn4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eQeqWv9Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so32777565e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 01 Apr 2025 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743503367; x=1744108167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjsqA3gDw3vsFoOfThnaWmF+RlP5cysYPxWZ6uF7IBI=;
        b=eQeqWv9Zus1IotV7RaeKAKhRvQsNaQFANAD2kZ5FcXxQ4Lwbr+nsny06j52GMyZgl1
         gTbu4T6B8egfRfT1CrANEf2h/g/Q0GBgu9BmpjfMw/bhsJ77E+MEOE2mHWWGYNKrc5gU
         rajBt548jHjkCwEb0b4slJKzuuuju9dYfca1QwwLTGnBIS0XmgPMRfJtEt1vm18JwMAK
         KbZmIedLTd14MM4H7m2SZkIQPEgCcJGzh57pebOuUkwHjSyPIR/WNa034Ig/Bki0mBjw
         IOAYnAJXRmc9kH6tbw5/G4NE2UG0jsWH72osbxudak6wl8hm2jskxL2ye+V/FPmiQj0u
         va/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503367; x=1744108167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjsqA3gDw3vsFoOfThnaWmF+RlP5cysYPxWZ6uF7IBI=;
        b=jkWEjPb9DAt9FKtu3jglTs4dxhciAEi4ScL0RUOMCwq4yMfrhLnxCCEgZvzD6WeAMT
         1TpFqvNIFpm22w2Q2Yw/PHOg+nd8a3AYJiaHtTRvkxbfgU+IfQY/KuOTDc1pQCHJrcLS
         mUioZVsTVR2K0F4v1jsHtXmkvah3WuitssprL9b8jNc7zvkDcnPIGq5DktDpa0HP/yBL
         ZtemQffggIpuMoFeBtHQGBT4NFaY2OPSEkJk9zU5hzjB93vvN8foNAi59pdUN9T+1ci6
         8bYnm/390jxK3Lgwsut+f0sAbDs/C+N0/nppeYRWyCi4NI3hOPkMNbi1rMu65uNBGmhC
         zYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxSGVemT+EcuHDaEw4zPs4GtA0Ci+qWcKCIhBEjosMuzgBtp4ui3WzHF0H+pJeXKkfU6v5fVHGsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh4hwqDLentnkBOKtMxOlx954KQJY5N7E7Z2f+uJRH9jDFfls
	ZEayXaqDLuErBbqxsK92IKJnmuFrO2UU2bvoLhYcxtQLVinnT/ky+mSqMl22Rv4=
X-Gm-Gg: ASbGncvhpW4jPdM5WUE0YfPCsQhxGwsaf7KZ0sJpGd9bT39BxET/rItfAathSLTHpZA
	A1xIu5JX+eS0MhfL63P+nTezrep4lUx00aVMj1PTG/1jW43C9kCJbYHDccujhTKPd14Zss/vkml
	nedRjmNfJ0CTAOIfqkfD2QPOFZZFu0OmnZ0wXpJB4KYhbKbdaiE7FHYcITjfjcJOyID2uMZhtHE
	XeBTxDSDFE1brrY1jRa63lhwGHyzDDwkevHvPOz1AAEuROUu9e6TFqCBVSVfyhHwd9X8O4XwFi5
	btlGAzUrP+5uMpTSD6WHuyfiH5JqwZvMp71HRVH8hynBPZcT2jW3bM2nQJxsPf6MpR5g5F/Bjms
	I223iKX6XhFU=
X-Google-Smtp-Source: AGHT+IESufOiljk4frrAahmohlUOsZrIEconcQO5fsn0CZXoqSf/RGaMOqWyZ50ZL4wPD4y5T3O11g==
X-Received: by 2002:a05:600c:1c1c:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-43db62b6af6mr74727765e9.11.1743503367448;
        Tue, 01 Apr 2025 03:29:27 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d8fcd03adsm151150035e9.21.2025.04.01.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:29:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Patrick Havelange <patrick.havelange@essensium.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-pwm@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 3/3] pwm: fsl-ftm: Handle clk_get_rate() returning 0
Date: Tue,  1 Apr 2025 12:29:01 +0200
Message-ID:  <b68351a51017035651bc62ad3146afcb706874f0.1743501688.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Y5eWYPL/Z9lk/J5o/TdRWO2TnWWprWjUng96J/cfugQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn67/yGHo2SCF8SwHFDshujP9NFK3UAwd6dUQ3w KgXWrn8X6CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ+u/8gAKCRCPgPtYfRL+ To/GB/4jJY3+ahqJ+1OVhfIQkEp/Ddx/QGi3GfQlopjrSzHniEMK4EPdGy9m1YYaER548MlL3w5 MFBwT+s5VvicbOMsxzCAi0MdnCbZdz8Cr5Rwnj1VGmmPtwQVbQOFnyeOIG3R+RZA/Ew4MHaqYJu EBfVd2KmZvoGS/Yezj29r8MnLtp8YZzXyC0fFsAtTtB1jRMYkF2NourAIObJg8rtLz4dXeP5zBa 6NnO1Uw0wFs663tzbfmE0FoEa2gE0C47LJoaxXfUyphU8V8ayO4zr4X9OFfY+PlS6Lo636KF4Fm 5tzZanWs+V8lKIY/p/b0oxrul4Cwwk3SIbBsUbGv6ERHKI4z
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Considering that the driver doesn't enable the used clocks (and also
that clk_get_rate() returns 0 if CONFIG_HAVE_CLK is unset) better check
the return value of clk_get_rate() for being non-zero before dividing by
it.

Fixes: 3479bbd1e1f8 ("pwm: fsl-ftm: More relaxed permissions for updating period")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 2510c10ca473..c45a5fca4cbb 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -118,6 +118,9 @@ static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
 	unsigned long long exval;
 
 	rate = clk_get_rate(fpc->clk[fpc->period.clk_select]);
+	if (rate >> fpc->period.clk_ps == 0)
+		return 0;
+
 	exval = ticks;
 	exval *= 1000000000UL;
 	do_div(exval, rate >> fpc->period.clk_ps);
@@ -190,6 +193,9 @@ static unsigned int fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
 	unsigned int period = fpc->period.mod_period + 1;
 	unsigned int period_ns = fsl_pwm_ticks_to_ns(fpc, period);
 
+	if (!period_ns)
+		return 0;
+
 	duty = (unsigned long long)duty_ns * period;
 	do_div(duty, period_ns);
 
-- 
2.47.2



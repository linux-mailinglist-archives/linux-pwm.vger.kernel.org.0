Return-Path: <linux-pwm+bounces-5342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0DA7C891
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9D3BDAAF
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094B1EB5DD;
	Sat,  5 Apr 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tmi0N1EQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FD1E5B91
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845269; cv=none; b=Ozpm71rC3ZTGdKRuIQ46clmbgozhd80sCXPh5aiTNWXkd6ezuYtkT8Er9KHwvbfAC1Uktdcp0DpVwlqmtJjvYG3PXfhTitJt/rBirFSgUc2fXRo+3px1efsDAWPKw5T67t9O9tfUXaquA2EI7RWE6JrssSfV/xZeGzDZkUUQ1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845269; c=relaxed/simple;
	bh=OiM7+jqt6Q921Kpmw9b8tSzzTFzLcdB8tQr9oQGe03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5dY1VBSInBZq3DuyzGj9X4gC8Ji/AlCKVGcPFmimS6ZDFXkqDtmkekfzbW/4bvn06C+W2lOnuV1PEEtBe5WQdoYYzndYUFcWwFJsg0hQDWPLc4cdnsCIU6HgjIwIQZDoX/0M2pY+UvEQATzKT4cS9vWrTLzzuSYiYiBbmbOMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tmi0N1EQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso5201353a12.0
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845265; x=1744450065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qXAEECYwT3mvFz4b37atfzJpcEAFkVbCcjXByt9ryg=;
        b=tmi0N1EQzFnou2AgOrggkSKdEjjXyzpIG+CVZ+2L9CjaRNfCY0p6JmsJ7vqMbdleSb
         vOnxlJZzb1VdbEKCkBt2iwJqR50GEPDJOzAPmomrPe4aWX6Zho/qSutx5wKCD1St+YB7
         Tw+agm1lm3qVBTiOFRiV7L51ErD3K7u+EHYtFXz4wUMdwM1/4LTzAbgi0ax39Nsiwg1a
         kvkVJGKc5uYuKQyMZA8q+2+1X2gTYnrCwTtSg0werl/H8hrosEoX/kM8Ccwp2X4ukmNg
         34TSUeM3Pxe1Dw5fFmT7b837pd0vTK+4Ffy1aHbYAB0nTJwJdSkfWvTc7x3J9rKVAj00
         d7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845265; x=1744450065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qXAEECYwT3mvFz4b37atfzJpcEAFkVbCcjXByt9ryg=;
        b=ALEsZw5XwUUaZMfk6OLGizm1ehrS4+6IvR4FI31ahzbbhQ/79QXGDFH5rXFI52weh+
         ZcjJHU4F4eJ5NBgxp8vCnXU/NgxFnJohMBZcqyBwlvmF/c/cKYTZ3r8gY2Mnvk2FPfIq
         QaODM3DDPkwoCIEEU+8JniK5K+DNhSgF4Oai4Focg3noRMC5shaASsSOUIAn9hLrZZ3I
         NOKVdPXB5MdmEt4SeuksUX+r8CJMJeU//88AeprKohjd0BsmaKAVGWaGd+YlkWgEbZyB
         BxM/QQbUR7EokXUwEwkNKIu36qhTBHIUHupw3yrNv+t6IP5pdrbH++IUEvvrAEtyrJIg
         c+KA==
X-Gm-Message-State: AOJu0Ywvf2g1jjHL1jDyjUvCKR8hN3UDWyNbJZyF6pGVzt+GuwQyqWmV
	K03o3Yaa8c7MTwwMux/fBqj3wTN7cTbiZ5ei61P4NAY/RZi0H65UG8OoSvPdIwdGu/lOdlDCPEw
	E
X-Gm-Gg: ASbGncvsDHMeFRoOtuZuiVZYaoVUT8sT0iTS8qMNKZoeuDZaPAXtWYTO5NLxdISiuX/
	UNdJyW8wJ2pNkaB/hEGjncU4MGX2A+YpUNFhrcSeaP8gXuYCJf42zQkzkO/5/UpjBPSNArIvHNM
	HyGK8Jb+L+g0FmwZGe3/lS8r/FuPQ5MZ19NYjvnVP7IjevBkw1jDO99HnGk1sbb9Y4Y9ZerDdxN
	QemW8x3LE0QDDdycpz4410PVSQBlK5T3mIAPc7m+mzVLhRuttobu0TvnZupRidw2syolnMXpLLz
	pfvsAKmKEQgPNND1NE9YmtN0Lwa0NeaUNxZBk7opPU/CNkzkLGGMsM8gAKOx
X-Google-Smtp-Source: AGHT+IH/Vu+m+Mp96HrPw4Gc+WIBgyrjTJKLuS6DXnK5YxiYpNywofXLPxP1H8Q6LOOpccRFikcNhQ==
X-Received: by 2002:a05:6402:1941:b0:5f0:9eb3:8e6a with SMTP id 4fb4d7f45d1cf-5f0b471645fmr5054504a12.32.1743845264986;
        Sat, 05 Apr 2025 02:27:44 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f087f0945bsm3642602a12.45.2025.04.05.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was rounded up
Date: Sat,  5 Apr 2025 11:27:16 +0200
Message-ID:  <ba451573f0218d76645f068cec78bd97802cf010.1743844730.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=OiM7+jqt6Q921Kpmw9b8tSzzTFzLcdB8tQr9oQGe03Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pd80SugWzSxb6ho2jCZImiC2vqkQWOStcSd0 V4RR6iNKFaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3fAAKCRCPgPtYfRL+ Ti9cB/wM1fMEC3gf4eEravDOl/yv2NTu1+Sze6OydWWzWPeuLRUO2Cp5VV9e/I3a5z9ela0StAk qXXo0Pk/yGPLJXL75nXfBUf8nguCShWalSu57ZQI5PETtvUAD6PaXCBjHnV1MC4C8e8yEiDjt7B cg/s8T2keZctsewK+pI4biBczLymTI7WDTa7VbHMBnvsQPikdFtR0g9EKgbUZZxkHZ6i/OUHarI DqAQHRlzYT99WApwX7HISK2A1FUOx5oB28zZtswNPDx0NpcmuvkykKZwjS5Ho2vrIvPhNpFimlQ MZdU4ecdAHSYHDZ2RHmo4Myl5OpX9DAVXOSuSlCEC1aG3GIs
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .round_waveform_tohw() is supposed to return 1 if the requested
waveform cannot be implemented by rounding down all parameters. Also
adapt the corresponding comment to better describe why the implemented
procedure is right.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 4259a0db9ff4..4337c8f5acf0 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -75,6 +75,7 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 {
 	struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
+	int ret = 0;
 
 	if (wf->period_length_ns == 0) {
 		*wfhw = (struct axi_pwmgen_waveform){
@@ -91,12 +92,15 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 		if (wfhw->period_cnt == 0) {
 			/*
 			 * The specified period is too short for the hardware.
-			 * Let's round .duty_cycle down to 0 to get a (somewhat)
-			 * valid result.
+			 * So round up .period_cnt to 1 (i.e. the smallest
+			 * possible period). With .duty_cycle and .duty_offset
+			 * being less than or equal to .period, their rounded
+			 * value must be 0.
 			 */
 			wfhw->period_cnt = 1;
 			wfhw->duty_cycle_cnt = 0;
 			wfhw->duty_offset_cnt = 0;
+			ret = 1;
 		} else {
 			wfhw->duty_cycle_cnt = min_t(u64,
 						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
@@ -111,7 +115,7 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
 		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
 
-	return 0;
+	return ret;
 }
 
 static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.47.2



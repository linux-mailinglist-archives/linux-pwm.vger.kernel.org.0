Return-Path: <linux-pwm+bounces-5341-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C369A7C88E
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F50A1896794
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD61E9917;
	Sat,  5 Apr 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ycS583EC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB11C3C04
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845268; cv=none; b=GP/9L4QSIRLZUB8Mf27pHYYoxlyVCFJ5vHyUjQtaa0wGslYjfs6nLZdwsCnKJytkRstfY9MxkXov3YiRcV2OHdndmNXmMNwmyC6lfi0bef3huZkuiknPlLWajvkVZbfaD7jhIEvTyzEGM5xSs5vi7R2jbaNAmGyfK4/E08ROSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845268; c=relaxed/simple;
	bh=PeMUN5MaPR/iihGuaAYk1+RqNZDBvhqS1HijQAO+fo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USD0i8IOU2yu97uulupnuiK0dl9UW+aFicceSaceO6+VKzbgYouz9vVGb9lFEsYUG+RNjG4YKF4bsK9jrPXc2s/NwZG8n9AA20sB4/JA+k7svfQ88ykdaoB8u+ojy150WCssjIgH/mys0FLePNQgsOrJZ4vumANm9aquvHemafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ycS583EC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2963dc379so456685266b.2
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845263; x=1744450063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZnZ1QBH4c/cR2r7Z2I0IWQDQQpPtp/xF22TjNG8zFs=;
        b=ycS583ECOuUzKWKMfrY1W1xmumbs15pUWtPkZ76FQ86PZugNIy1oVVg3Md3h9QtYfM
         zkqwX0+aAg7WdNIvCyn+hAyXuMuSBDEjzl01FmeohcXh6F92BOpB3e5T71cByn6G/Cbi
         955P1+2ehCyiTS+xqBnpx34pMta46pJ0LPSCfTCt0xr2iamS/IiX2y0ziBljWyNbIP2q
         i5D9ON69ZgFJEWPZNTAUyS2wQYxRBDU5daUXmoflbeMGy+tHpa0CBPgz9kpZVGVnMOCn
         02kvx8G2QibNh52qs/Q92VPWyBe7YZiy1RE7SMuozkws2OQ5rtynAQnW2nx1UNGEj6Q/
         LcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845263; x=1744450063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZnZ1QBH4c/cR2r7Z2I0IWQDQQpPtp/xF22TjNG8zFs=;
        b=jhiyTfROdtUl1kZTmpwgQCxDkMmMVzBJYjJUf87A/O/MeXmRjOn4pQTW1milKodyhV
         O0Qbq+pQK/a0bmakTPD0WJ+zkoYoyGmosaHDsEUdPMz5SOXJ1fJHeoUr+yRAINh2HLfc
         IYK0BhOYVjRSwjM7kNxazrLOWKJq9impKe7B/qy02EbVm1XRZSBRmic7dpHQZqJVhq6B
         gv0y3cK7daDpHCQbGLw+lOPhC9oXFUnzFobFVitWNqUyDycPTe6qn8+cXVPfLKKRYkxj
         xdBBA0PXzyyopK5x3vEmpEBi1kHUqlCLjcCyc54fCkCaWnjmjqYlzXhn8KECdDDQHY73
         F6ag==
X-Gm-Message-State: AOJu0Yx6uLD9oL4ypExxWH1txyyHqtqhsZlU6NBDrlFmVGy/A6LOU5bV
	DXZrYSkH51hgnhhJ/LrtP5DQRNUdkzUQquxpWHcOjLnSjxUAtGzYSiJ2tZSJZ4uxGF+MPZltOz+
	5
X-Gm-Gg: ASbGncuYzhzr24JVuo7BnWkJIaMOkAIlNHmxD3tErf944lL65Kr6Gi8uyb8RxakwJiJ
	AapYi/8f8tFw09jRU6+XVihh4KJwPIdtFOjwjovCF49qjko+Eq7A3h3sFow8E/FCB+A9EpPgQyb
	KO2z8GlWvRwxIoXmQkH5+Et2flmHho6iwo5Lu/T3xdVRRb9w82IW1Y0+w+vGjkZMOFAUh4kQt1u
	KfThK0ldMXUUakI+eaHiPDyeqM55/xDcRzKz5HTmxSuSrnGjpAO+bWSNium7qlmd0i6BxRfaa2+
	gP7qaJr7CjJARM7I0N8USKew9nRFxZivBlIs5ix+g15+BauS1g==
X-Google-Smtp-Source: AGHT+IGWO7dBoEwfH+vhvetzVchvOebwHG0LSEkTGJ+mVXy0B0Ix45di+z7EJEIkw1x3jHja6bWBjg==
X-Received: by 2002:a17:907:7f07:b0:ac3:8a3a:e924 with SMTP id a640c23a62f3a-ac7d19903fdmr555132166b.39.1743845263101;
        Sat, 05 Apr 2025 02:27:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfea0eadsm394579766b.67.2025.04.05.02.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] pwm: stm32: Emit debug output also for corner cases of the rounding callbacks
Date: Sat,  5 Apr 2025 11:27:15 +0200
Message-ID:  <fe154e79319da5ff4159cdc71201a9d3b395e491.1743844730.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=PeMUN5MaPR/iihGuaAYk1+RqNZDBvhqS1HijQAO+fo4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pd6gBS/U7sm8gCc++Qe+H9FPvkAFOyatKX8B qZYNTVb/8WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3egAKCRCPgPtYfRL+ TiyKB/0dJZmWMtAaRs0WJ3PXT9d3VqFRF+ApoExKeBVC+2ES9YhZvF7McGhAzK48ik7Ly+LbIdd Il/cB2eBN8HrWNjZoHv/RVydoIwXGPyxm+7EVsFLjp6QVEbKfRjnonbncS3QTgmSKMIUL6e6JSC Exlph+FquJCDEjgnQZiyDNnKFMpId9mwZfG4STy0nFW4ohy/2CIVisdMr+VJ/Ku9COUq3a/FB+F QNpy10ntJAQfeJnxjycByIlnMBpPR+ouavHhm3lAae1baYZOSbounM633kPFBC43UuT9ehZ8ryi RmE7IGRwAQ/z49wXa8pqeOAbyygY5+bxUJ0PuQwUNrsaJoRK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When you're interested in the actual register settings the driver
chooses or interprets you want to see them also for calls that hit
corner cases.

Make sure that all calls to stm32_pwm_round_waveform_tohw() and
stm32_pwm_round_waveform_fromhw() emit the debug message about the
register settings.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index c6625f51a199..dca5d09d80b9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -180,11 +180,11 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 
 	wfhw->ccr = min_t(u64, ccr, wfhw->arr + 1);
 
+out:
 	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x\n",
 		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
 		rate, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr);
 
-out:
 	clk_disable(priv->clk);
 
 	return ret;
@@ -236,17 +236,16 @@ static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
 			wf->duty_length_ns = ccr_ns;
 			wf->duty_offset_ns = 0;
 		}
-
-		dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
-			pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
-			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
-
 	} else {
 		*wf = (struct pwm_waveform){
 			.period_length_ns = 0,
 		};
 	}
 
+	dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
+		pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
 	return 0;
 }
 
-- 
2.47.2



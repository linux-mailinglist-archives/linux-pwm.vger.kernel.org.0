Return-Path: <linux-pwm+bounces-2545-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78090E6F9
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37F01F21B7F
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8C80029;
	Wed, 19 Jun 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q9WR3sOF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44780038
	for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789210; cv=none; b=lbs48xyyAtWzyTFv8zNVts9ffeCV4VsbcoZ/v8c5kRCeWZbFjG5tUtNdMDtqGBerKANcUN34XJkyde2wfoBoEK9raRVb9UuxNXOjrPVw3I7m5+XnUffZgMoW27vp7jK8Ik+vFizmAA0+gecHravz+9OxW2DySdc2JtG1/sDf7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789210; c=relaxed/simple;
	bh=uprloTlZWW2ITNEvdDXN3a5XnP9pblOhaEltw1mAAZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA/sZQNizOdoDCpZ2JisTKG/PdWmlLZJ4yqyN+NK8IVllhjVUAvh45LRE+UncXD8NhiyiAzFeIW6WNgmuCojvlYuxJoKWVsxyxwv3p1S4WpZa9tT5bDwRF4AqLxfqWGfCIVSCaTPpcTIYscMF3FNqrHjibwIIrAjt/TH9y7EVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q9WR3sOF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so4573205e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718789206; x=1719394006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+qqb0yobL2/RGgvLBdYrDcwIAeg34/SRC7j1a+9BQM=;
        b=q9WR3sOFuUKCgBdDTYtcmlhaovJBlx/nAzjniddOs7l6qwQ0BKGF/Iy1UFSD8kEbu1
         IuWPI0PwcWoFUKzbODmNC7BrHe7uTds6ero1lSBrY06qccAd2EjZnKp+2BFTbG3M5XZH
         tTP3pu5l58mpMHivj2xe7lXKeeWSke1fACvJzkNJVDqKXCVu4KwYre7UTsP/C0s5G5/5
         J1Y5KCRgTF/paXfgHie6Nit+NuXPe4O6jCKU14Jn4Da/95VEKqOFsQaW/R44qHiWLlHU
         OIhSOcfr9MMglGuqQhP1KzEGRH+fFlYdi0ihJUark11WhoLGVG1b7pXPRTnPMIflfSHq
         MEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789206; x=1719394006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+qqb0yobL2/RGgvLBdYrDcwIAeg34/SRC7j1a+9BQM=;
        b=iaw/GMUrUk53GgOrHaf0VXL9IfTd3gQrDBGowXqV6noUFplBfm29KrR4MQsbOJQH4/
         N5yrz49AwL1hJCtjJgiLc89tdsiuuCyurKRI1TcN/+cMX8xyAuvosLYcYz/dpBOILa9Y
         KcLbaLw3vQ9wGY/6akLy3qXP4JZDNDDgeLvYAa9WpP7lFEHQINzceoTe9C3mrKEbIJwc
         LoJMrlELJpL2O9VT5WKok8vV+pTXmCj5bJt9A9Ru7I6KoY/5y5QhxaxUHcBYjk20TnjA
         3Hxym/TGsbbmrDI3za+fuQBCApZE4oT+pbRgN2MAFSWgdinnzBCKa3layIEWsvqCroz1
         OZfQ==
X-Gm-Message-State: AOJu0YxqAzT8DkQuvB6LuV+EyKGzJxcRxxeNcaeVLduhwm+cbkEOtCIv
	fhKYnRykNJhf4pCYXAQVnYzJWj5b8eVGldiVI/X2UKRqrFQwaegVyxvnWfXTddA=
X-Google-Smtp-Source: AGHT+IGfWLTr9ssnbsRhjkvHvT/KYb0ndiiJ29jhEvmScaQZp69vPy0UokUJtxlEqZze+8ABe7aCoQ==
X-Received: by 2002:a05:600c:319c:b0:424:71e6:258b with SMTP id 5b1f17b1804b1-42471e6273bmr40938175e9.6.1718789206193;
        Wed, 19 Jun 2024 02:26:46 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm16587999f8f.114.2024.06.19.02.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:26:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] pwm: stm32: Fix calculation of prescaler
Date: Wed, 19 Jun 2024 11:26:25 +0200
Message-ID:  <e6a1aa8343971c0b8f77d9e4d88c08b26279bf09.1718788826.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
References: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2596; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=uprloTlZWW2ITNEvdDXN3a5XnP9pblOhaEltw1mAAZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcqRH6SJGfFE/V8DVVjzbmOURvUhFQT3Nwp0Hw XiLMsfjVsuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKkRwAKCRCPgPtYfRL+ ThXDCACwzZkJ8F2VHE/jJurLEZHTn+Is/zOVkDK5pPfy6uPLFPgQ3wTiaffvjAojLi8o7SCenwc PTNzMByX0+QENQYaYOgU+aFImVfTMNOFytVtNlozMHJFc8iAttlSnpVgYcAJLwnfvL89sC6XdvA 4fNIeL29SRmOv2DbKR+JQFdDXUFKNbCecR3xbxhEmIwB6M8xAq3gfbLzT56M/N4JrdkMdpYfL0F tehelyoRLei/rPaRuqnx6q4oYk/YgB/nAkDayV+xexI9ls75YJTbTncg1CEldC3CNJJRSN5j/rD aIiTU5NiM9HiVv0hVmREkOTdZqZw5h1nmlOlUlCrdy/eW1mB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A small prescaler is beneficial, as this improves the resolution of the
duty_cycle configuration. However if the prescaler is too small, the
maximal possible period becomes considerably smaller than the requested
value.

One situation where this goes wrong is the following: With a parent
clock rate of 208877930 Hz and max_arr = 0xffff = 65535, a request for
period = 941243 ns currently results in PSC = 1. The value for ARR is
then calculated to

	PSC = 941243 * 208877930 / (1000000000 * 2) - 1 = 98301

This value is bigger than 65535 however and so doesn't fit into the
respective register. In this particular case the PWM was configured for
a period of 313733.4806027616 ns (with ARR = 98301 & 0xffff). Even if
ARR was configured to its maximal value, only period = 627495.6861167669
ns would be achievable.

Fix the calculation accordingly and adapt the comment to match the new
algorithm.

With the calculation fixed the above case results in PSC = 2 and so an
actual period of 941229.1667195285 ns.

Fixes: 8002fbeef1e4 ("pwm: stm32: Calculate prescaler with a division instead of a loop")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3e7b2a8e34e7..2de7195e43a9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -321,17 +321,24 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	 * First we need to find the minimal value for prescaler such that
 	 *
 	 *        period_ns * clkrate
-	 *   ------------------------------
+	 *   ------------------------------ ≤ max_arr
 	 *   NSEC_PER_SEC * (prescaler + 1)
 	 *
-	 * isn't bigger than max_arr.
+	 * This equation is equivalent to
+	 *
+	 *     period_ns * clkrate
+	 *   ---------------------- ≤ prescaler + 1
+	 *   NSEC_PER_SEC * max_arr
+	 *
+	 * As the left hand side might not be integer but the right hand side
+	 * is, the division must be rounded up when doing integer math. There
+	 * is no variant of mul_u64_u64_div_u64() that rounds up, so we're
+	 * trading that against the +1 which results in a non-optimal prescaler
+	 * only if the division's result is integer.
 	 */
 
 	prescaler = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
 					(u64)NSEC_PER_SEC * priv->max_arr);
-	if (prescaler > 0)
-		prescaler -= 1;
-
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
-- 
2.43.0



Return-Path: <linux-pwm+bounces-6790-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF38DAFD543
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0638B4232A5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438DF2BD590;
	Tue,  8 Jul 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZBBoQsDv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EB2367CE
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995484; cv=none; b=mmzledsJSrfUFcMEbEx3brrd0mSCWP+SlT2P20iZ3hW9+87ZoR0qTKYl2VPk6D8SN3MTSvvBZmMDy+Dl4K/mhNEP/53tLrz9oVJQlzDIXq+Ji5w1q4ZVoKGb3viC5JtL+H8vEfL0jS5W4w8PnPCgmE9UKqxrRtQA5PsMx+jMihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995484; c=relaxed/simple;
	bh=ymfoXwVJQmmSHxdV9VlOIwDKcC7/64feU2EIi90FIjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UREn6KWrqUdAYAfD/uJEip3nOb4klJ9YmK0jpYHgqqrYdto901BVKy+V1x6hkZfplLgGupYsbdM2Pkv+hGZNUP8zUZJHA83hBJ9ufpIeCuea6uMV77IKElp/PzT0t6wHtmceCyZcfSbqFb50Q626ofM/H0Evo+B63GKi5X9NRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZBBoQsDv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so8822429a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995480; x=1752600280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r25gtFOG6Zf7jDWrrmjrvx8vdkQan8tzE9Y/edQrmzM=;
        b=ZBBoQsDvcqfPrhhrKpJZgSA9/8VEiXoznIbn9VgBAzf+59gbw6ml+J3U8RLpYwgkhN
         GX4W7Pcx/yLOTBLDPiUfsJZdCbLhV1SsZbK1wEKFZYo110djCQwlGkF5gC4K1xn54Ox8
         pK3RiHC2selV5dY2gtY7KS7t+IffDsoL4gQaOHuLYAdL2AYBwFmT/xAhl0YwsT+683pE
         acm32IHOH5Qy78XHL1njTQf2fPFag7G8jD+cj5hdfCw42DjL7aAYDaXVeCCTkXTUVNFb
         3h5rnkE+pE8egspn9goybd8/nZ7ug0M21Cdl90XdFP3D+RR9zunzGRaEa/V6MEEE8O32
         sQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995480; x=1752600280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r25gtFOG6Zf7jDWrrmjrvx8vdkQan8tzE9Y/edQrmzM=;
        b=TimXktuaSPtoJrwvTI/aX+VcFcXuGzlbeB7K4BDTFgvpxj4DUBsMJ5C+SuPrqMd2lH
         5qIEDTkqpGnBdb/d2fPZUVdQKLXC23jomWA6SOJh/ZvuJKK282cvibTisVoLL0XH9YUw
         qXFvgUaV3QlFwHbHR+qdpOJ9K6L982lIqLDhm4G1BGQz+hfDtz0Go94c/6hZxpNc2vWc
         QQSpDk8csvYsmKdHONmddj8QQUHIvXUN28nLwoy6JvEMzyG0++kOKnQtNFjR9Ng5OR6m
         xMAeZ4q94ccgP3PFWToQpyNrGsqLDFlIlXrfKOpdLufIx76I3cDeAmVmD+Px/bqk+tT0
         IehQ==
X-Gm-Message-State: AOJu0YyFAgCFeycKsxkCepM1Kwy7yEYEDKi5e7R6UA29H+CVqbDgnYRf
	/43+ZeL4OKlBdWHTWaiBuYcXh/gKOfcu+ji9EhrKJjaXiw1g0MibcjaWK8DVXyOzNtoTu9jUe8d
	UDzZA
X-Gm-Gg: ASbGnctI8KjQK5ZzxOEtweDhZI3wpBkei0yLIUEc1LYv3q1MmZPkWP1wBo+3dvl4xZc
	ar8f0tsDFx4EXNkHIlf76cUCBRU9EgSfndIcALEeHrvzNOdOQR0ZTn+QdHLHffWm5o/jyqv5gE8
	Dvq6ah2rwDRTT+YZdIblq7H3EFamyxoxGaKfyLQhXnSAW85Em0h6PxpRyDwDXIg3e2mWUKy9atS
	GNzsSUbN26D4PemhuFC2kUSgtdfat7HzJy2dEHc0WgMePNyzzbRY8QONjLftTVwSb55QGNA2hWG
	i24csHAlg+WC0tqgYO29y7P+A1otnYgt4HUEbEnTsnCNmXZGGjlJVOBGeY0qwC9BYd8R01OTJrK
	udSSps3gffi9BlzQaaslvxIsIUCOT
X-Google-Smtp-Source: AGHT+IGj2l405bT9RxUELoQal5Q+SvTli/9daxZSV65ryDSqOGolE0/2SotXUXlexANDdSDYh+2ZBA==
X-Received: by 2002:a50:cd4b:0:b0:60c:4782:e4e1 with SMTP id 4fb4d7f45d1cf-60fd34a56b5mr13892838a12.27.1751995480086;
        Tue, 08 Jul 2025 10:24:40 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb2f3122sm7448966a12.57.2025.07.08.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:24:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm 2/4] sysfs: Fix polarity handling
Date: Tue,  8 Jul 2025 19:24:14 +0200
Message-ID:  <149cd2e217dfb90210cc6fff332ec776371b0387.1751995302.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
References: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4906; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ymfoXwVJQmmSHxdV9VlOIwDKcC7/64feU2EIi90FIjM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVRGG64LgodOUnN+iud4u+UvXBQMyDAf/8kkp 5dQ0GUHDieJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1URgAKCRCPgPtYfRL+ TvhRB/4meWDWETEb/WAAz6pdBMXxE2Kb4UZz6cmE/DawewzohLgq1goYgKN9DO9FCCqKdtu2+yM nypKNcICTHWCJOH/8V4YzyyaBwbFgxgkBYthpXM8NKRb+3XroaN/es+1l5OGJ8zG2bS5LVjaXNm pbulIt2+hVJwxrtcdYD2Ayn0QtO2laUe67h7nEiGP2NnSeBLo5I048HdoWVvcMfbKAdyBr0+OFK po8l9ZiXA18XMs8wHEqIEmQHMmNXfeKE/o1M6Pbrkj0vz0fH7uWNrYYZxFKLJwL04D79aROwqfL YD9V2ea25BGnQfiszolWCbu5OKbhb87Lg5aQMLu55NOdf7wB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Depending on polarity the sysfs duty_cycle either defines the active or the
inactive time of the PWM output. This has three effects that both were not
considered before in the sysfs backend:

 - If polarity changes this affects the waveform's duty_length;
 - if duty_length_ns changes and polarity is inverted this affects
   duty_offset; and
 - for inverted polarity the written duty_cycle value must be
   period_length_ns - duty_length_ns.

To simplify handling the first two items, rework the cache representation
to use the parameters of the sysfs representation.

For the second introduce a helper variable.

Fixes: 67f0b9f2a2aa ("First prototype for libpwm")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 sysfs.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 0f87f2b87028..151b035f72d1 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -22,9 +22,11 @@ struct pwm_sysfs {
 	struct pwm pwm;
 	int dirfd;
 
-	/* .wf tracks the wf assuming the PWM is enabled. */
-	struct pwm_waveform wf;
+	/* cached settings */
 	bool enabled;
+	uint64_t period;
+	uint64_t duty_cycle;
+	bool inverted_polarity;
 	bool cache_valid;
 };
 
@@ -155,6 +157,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 {
 	struct pwm_sysfs *pwm_sysfs = container_of(pwm, struct pwm_sysfs, pwm);
 	int ret;
+	uint64_t duty_cycle;
 
 	/* period_length_ns = 0 is interpreted as disabled */
 	if (wf->period_length_ns == 0) {
@@ -169,55 +172,58 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 	}
 
 	if (!pwm_sysfs->cache_valid ||
-	    (wf->duty_offset_ns < wf->period_length_ns - wf->duty_length_ns) !=
-	     (pwm_sysfs->wf.duty_offset_ns < pwm_sysfs->wf.period_length_ns - pwm_sysfs->wf.duty_length_ns)) {
+	    (wf->duty_offset_ns >= wf->period_length_ns - wf->duty_length_ns) != pwm_sysfs->inverted_polarity) {
 		if (wf->duty_offset_ns < wf->period_length_ns - wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "polarity", "normal\n");
 			if (ret)
 				return ret;
 
-			pwm_sysfs->wf.duty_offset_ns = 0;
+			pwm_sysfs->inverted_polarity = false;
 		} else {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "polarity", "inversed\n");
 			if (ret)
 				return ret;
 
-			pwm_sysfs->wf.duty_offset_ns = wf->period_length_ns - wf->duty_length_ns;
+			pwm_sysfs->inverted_polarity = true;
 		}
 	}
 
+	if (pwm_sysfs->inverted_polarity)
+		duty_cycle = wf->period_length_ns - wf->duty_length_ns;
+	else
+		duty_cycle = wf->duty_length_ns;
+
 	/*
-	 * Ensure that we never hit duty_length_ns > period_length_ns. As updating
-	 * period_length_ns and duty_length_ns cannot be done in a single step write
-	 * period_length_ns first if period_length_ns increases and write duty_length_ns first
-	 * if period_length_ns decreases.
+	 * Ensure that we never hit duty_cycle > period. As updating period and
+	 * duty_cycle cannot be done in a single step write period first if
+	 * period increases and write duty_cycle first if period decreases.
 	 */
 	if (!pwm_sysfs->cache_valid ||
-	    pwm_sysfs->wf.period_length_ns <= wf->period_length_ns) {
+	    pwm_sysfs->period <= wf->period_length_ns) {
 		if (!pwm_sysfs->cache_valid ||
-		    pwm_sysfs->wf.period_length_ns != wf->period_length_ns) {
+		    pwm_sysfs->period != wf->period_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "period",
 							"%" PRIu64 "\n", wf->period_length_ns);
 			if (ret)
 				return ret;
-			pwm_sysfs->wf.period_length_ns = wf->period_length_ns;
+			pwm_sysfs->period = wf->period_length_ns;
 		}
 
 		if (!pwm_sysfs->cache_valid ||
-		    pwm_sysfs->wf.duty_length_ns != wf->duty_length_ns) {
+		    pwm_sysfs->duty_cycle != wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "duty_cycle",
-							"%" PRIu64 "\n", wf->duty_length_ns);
+							"%" PRIu64 "\n", duty_cycle);
 			if (ret)
 				return ret;
-			pwm_sysfs->wf.duty_length_ns = wf->duty_length_ns;
+			pwm_sysfs->duty_cycle = duty_cycle;
 		}
 	} else {
-		if (pwm_sysfs->wf.duty_length_ns != wf->duty_length_ns) {
+		if (pwm_sysfs->duty_cycle != wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "duty_cycle",
-							"%" PRIu64 "\n", wf->duty_length_ns);
+							"%" PRIu64 "\n", duty_cycle);
 			if (ret)
 				return ret;
-			pwm_sysfs->wf.duty_length_ns = wf->duty_length_ns;
+			pwm_sysfs->duty_cycle = duty_cycle;
 		}
 
 		/*
@@ -229,7 +235,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 						"%" PRIu64 "\n", wf->period_length_ns);
 		if (ret)
 			return ret;
-		pwm_sysfs->wf.period_length_ns = wf->period_length_ns;
+		pwm_sysfs->period = wf->period_length_ns;
 	}
 
 	if (!pwm_sysfs->cache_valid || !pwm_sysfs->enabled) {
-- 
2.49.0



Return-Path: <linux-pwm+bounces-6789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13FAFD545
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6900188C63E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3B2E6139;
	Tue,  8 Jul 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pKYRacjv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6B2E613E
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995483; cv=none; b=JVZBbk7JeT/9k66gDeKV3nG+yDQRxVfQE9DjjBTbF2fMGL3lKNnltlGZ7q9unZtxjl+6E2dQWHvHuaE026iZwui2zKdMSU7NN2fURI7hRJBiUFrTJXbKmEycBgtJnTQQAVa16wec8x/UKdTJZGmtV+XqAt65UmoOjQqrkCG3oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995483; c=relaxed/simple;
	bh=v+AbI9oQruU+oTdfRYfoT+MDf3dg4XICL2CZMAA8Hoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ+8rB2PDWSyQjaVYSMZ0vxxQUhJ49RXqaucmeN1+Z0qLG/9mc2EfZI/r5pRuJDvkPvBA7zPFGm6XMcl1U3HOxMutO4DSZ0x/y9C3FRCu4iYqDq8bMyhNC2oqdQHVKE/tEOWbmVfpb03R6wJzJDhAD1ghbvMMHr8XjN8Yc/FEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pKYRacjv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so240655a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995479; x=1752600279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLqrPqQB6zxFJ4F2Ejzo9uVRdtFYGCNAE0sMM3fHXVc=;
        b=pKYRacjvgBc0Ilr881CT0AD208aLbB6SRBg/lEFV3xamhaSMpl9HxesB6hNrrmoiyG
         7kcbNjHMZTfHaAca5wZ5wLRVFSIKstdQ40ttj2B4eNa915DDcEwVrWddwhpWCGdwshT0
         Kb9Ys39Pnpz+GmIyqARd//LrX2cFzHBmhd5fcLgWteQJmvDTqehkdJn8yGSBdNuAxEVu
         DI/eG3XDUPQCRksfhXLghRAKA2NEr/Livx3zlmgSUDF9pZJvrukl3NxPyFQx1b8Bcz9s
         l1fYzrEMfjrotCRpdH4zHXNqVWlNbQ7U/VPMtL7+dgyiJo9aWPbuPsnBSh9yYabmTb6P
         TzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995479; x=1752600279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLqrPqQB6zxFJ4F2Ejzo9uVRdtFYGCNAE0sMM3fHXVc=;
        b=YAO6qXS1a1IWGmxRyAxRwsUVHb6ov47o8ml17ooRX3y0a0v8cuFoi8cXnK4mjq1Rle
         JjREjbWrSjRjlD8SFWDl5yf8uSbWXa028JtQ2g/tBqdot/s1IiEucxfgBNbhDVVXg4ta
         9Ucl0lMc37eDbBF9nVHhT/lOJALKKx2iwA1Bvw59zy4YILjVlLsmawyDHE1W6jq4OC7U
         lpTrQkwhLiRnjXFQTKX+9Sg/Qc5EKtLKvXj5vCenPFGuw734Ej1r8YSPmdWTT2pcfzV4
         HU2KlBVJA/mCINk8QpPsCzTZkO1EwpQvEB9fBaQgPGRa599WibCPM+CyG6BmxQKKPZOD
         Or8Q==
X-Gm-Message-State: AOJu0YxK7Jl2youGjwpum/m6oMcssqcumwt0GOfgzIldBETjiBaGpm10
	TGHpV7JMU0htmSBvSOTKRfni+1uBq6wHSsJDSWkFhswXRnO7kXOlM4MIa+fN2fpF9Flbxb/Nl5p
	rWLci
X-Gm-Gg: ASbGncseS5o+2O7YTJxjYpgqSo2J0foxcjgUPxsCz1lMpteDtibJTMekBNJi3ulLPlT
	BQwhepGpL6Ja53Ne9Z8Bis1xXkWVp+iD/BMQTfno0IvTclk1Vaw1a3fFZeFn8/naHOE/1AKYRKK
	Av24bt2yR9Ed8kHA3v0QAkxri69fn9nGOvsFLg1H5JQwUlxXFw1NH5V+f92nU0qA4ZfSFN6CRLF
	iHH7p5wPSI87dQPT7AcKnQwdCHFBVQZfbAMrrbUAbd+1j8X9s5KRyJVLiFEtjzMp6Fa/QW39zs/
	xfCwJ7QKrq72usxd1dthElXk+R2YazIvsQUqxXhHK+QPkyVGJ9QyQIB+PEbjDFVae8hC1X+ngvH
	sjJ6QArxgsohvYss8PPFh2o66Vrzl
X-Google-Smtp-Source: AGHT+IG7nZrvXx4O0RBL0V1SSV01965C/mUIbUcc0LnSQAAD/9n5iSQLwaw4kh5mbQUeDyEH6N3z3w==
X-Received: by 2002:a05:6402:2690:b0:60c:3b8e:7e24 with SMTP id 4fb4d7f45d1cf-6104bf79420mr3582276a12.10.1751995478608;
        Tue, 08 Jul 2025 10:24:38 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb8c63f9sm7393851a12.72.2025.07.08.10.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:24:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm 1/4] sysfs: Fix a wrong condition for duty_cycle writing
Date: Tue,  8 Jul 2025 19:24:13 +0200
Message-ID:  <edbef643dbd7489f232aee478e5b2d512c6db437.1751995302.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=v+AbI9oQruU+oTdfRYfoT+MDf3dg4XICL2CZMAA8Hoo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVRDl/M+3dahZcPbwQ+xERXf21V0hHUyhP65B riKvGccvwmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1UQwAKCRCPgPtYfRL+ TmFcB/0ZhqxY+c39VnW44WWsiDdYPKdPkOGqiRKO382rjlgmPSVO7ery8itMi/djcIFkgJ6Cz5O +yQ7t6hpfiBj6/LdvyZtPz62Gl+1cbIQ2WqaEh+QycuBDVzvOOa9Yk+piE57jMA6ZgZeudGDRWa hfCKdeWrvBEQg+ge4MxOkzmST0RQpUb682WrvqE1Vsx5AiMckIeWbWcBZeuiWJYBupXwOptkDHy DCgEJfYJ7mlG/bnO8VP6Z/cMVBM6S0HroH/scSaJREMXyzCK8iToMXCSOlNsP7rr+eAjrH9BIj/ aQJUV0ml20FcI7P88lWkG3C55lslTh+boXEq0Cjumj8/d11O
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

It's an invalid cache that must result in setting the duty_cycle
explicitly. In this else branch it's already known that cache_valid is
true. So the damage is small and the condition can just be dropped.

Fixes: 67f0b9f2a2aa ("First prototype for libpwm")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index fe4edea1e102..0f87f2b87028 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -212,8 +212,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 			pwm_sysfs->wf.duty_length_ns = wf->duty_length_ns;
 		}
 	} else {
-		if (!!pwm_sysfs->cache_valid ||
-		    pwm_sysfs->wf.duty_length_ns != wf->duty_length_ns) {
+		if (pwm_sysfs->wf.duty_length_ns != wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "duty_cycle",
 							"%" PRIu64 "\n", wf->duty_length_ns);
 			if (ret)
-- 
2.49.0



Return-Path: <linux-pwm+bounces-4934-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A13A3801A
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A2816343B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F023CE;
	Mon, 17 Feb 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CFBNJ1RG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2818DB1C
	for <linux-pwm@vger.kernel.org>; Mon, 17 Feb 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787919; cv=none; b=QhBCgMk4TngnsUx6dJZULP2lmfQCykbsmoKU3BZZVkw4OSTdab0Z/g8tleVp2Gd1Ds7uyy1tm+6aM0eQmAGFuEPa8drB1jt1e84vuztMW6SSBtuld/INSfCwt1USZO0co775O3TDj2NFe+utO/RqoNgh5v8w0ftCHdFjJb7WEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787919; c=relaxed/simple;
	bh=pkV3QDLau5yOCLVjOUftd/XupwhlBueSvQ/So/2Crew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRfMZc5fSEBxoIc5tNLKsqCrCiRjcp0LrKgPLVUbjWYylfiLDxdKEmIIbFgzfHBGDEMsuxI5AsHuUAkhLhwLITWlcF810Fhy2kh9sKGKg19RjETGg+cnr+jnrjniG7vzY4ls/cYU+tYgZCjX5IQb6fZE+fVfeTpVzY2R8mEHmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CFBNJ1RG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so3808815e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Feb 2025 02:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739787914; x=1740392714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FokGnFYa1P4z5L9nqT3eXO4+eNPgSU0f89vdK4WReX8=;
        b=CFBNJ1RGwmoIBPTpxjGUk/H8NMGkuMU5UcqTTC/0zf+YHxqCCkKS2ctbBuUDzEPVcz
         XUQOIO4AJ1zoOqp8+rV1Jn7wMJGxE/++xby4ZftPP57CT1j+M6B/yq8bcm9f280hsVTE
         JPARC4m1UNws89AR1NixDh5EZxrQ9IO2U4DxLI+/1zt2azUTG1vvfLUWo11iYdwzc5eq
         WrdIUJT/T+9XBHsA3o20zL0Ebn4B3oJunm8f+40sxNwtAJ6RLbIfRkDrmWROcE41IVka
         V8OyPL+8L454NSxbPUwy6MApZGW1wS/tCqSlq0fZgWLaSi03CvtSN/9aJRaO7AK946Ka
         Ac5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787914; x=1740392714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FokGnFYa1P4z5L9nqT3eXO4+eNPgSU0f89vdK4WReX8=;
        b=ZbA/6q/uuk7WnDXnH6uXxaE1mAKt15Qvq8Wnuj/2HI4DNs07HyEXW6bMQSPqc9iIaU
         fL4iIwOekt7VbDdJrqkUXC3m9ltklrvbRDr2fnIyW4+qU294g9tnp9DNu+hl9+FB5tU+
         wf0ZJyPDnrJPpcJpTB02QABikAisKrJEXOYcextWyoky6Ix1gA5I+u0Ce2FECfkYdZPk
         4emHSYEW95b0RJuzUcyHMFsUBOV8+WPRFlu/VPHYKuXAFcDpDLESl9ZEw9xl/eQ0jyCn
         1wMfET+XUFii67dGqgyK6uzKY/o2soo/pbJdfNUW7XLhgMTWMNb8VTonomgceI9X8DRI
         yQAw==
X-Gm-Message-State: AOJu0YxBF6usaPoUbXK5lyhqNk2HWcIJTEdAVcnbnJSlyQVRqcvKo6Gz
	/EbExReW4VQiYR6+b8FFwKyL8+cbYKvR8Nn3mrsirZwSr7909pqxZ+X27lmbm4m4IenlmYyJ7Cq
	F1tY=
X-Gm-Gg: ASbGncsZ/n/xZyl27T2wK5FTlvjmbmFCaFqMKwmR+SFLgSTMvlpfiCupGHD9Kc4yzBl
	mpcfkHxQXmu+tGqCIvR2WonqE8oUzGMuyf709nmRUHlNBIZ2hOW97EqV9/R+Qc7Cz1LA7U7QPUg
	IyCutQ4szI4WveuiWlxWYWZk4EvA9HRRRZl64TgQ7nIDGfEPEldFGcIO8XcT5CIImGnNu/Ag+KR
	bI5PCodSedcq/HN8vw4C4Xr9o0BZxzhCfN7F3qhCKJFBTG9K+0WPeEBP7K0b4VH6hN07wBzAvUr
	8vl6oWgS67z/UHkr8FaJKWRYRiUQhQw1XYS/THcVxkqdpxZErixVWFpxaQ==
X-Google-Smtp-Source: AGHT+IFbgwfFaINBoUR6Lxo6tueZODOf8RLyitK08qsHQ0MTRwrlA34mrSJU44XNJNxG3ZxRlFwwIQ==
X-Received: by 2002:a05:600c:12d1:b0:439:81e3:43ee with SMTP id 5b1f17b1804b1-43981e3454dmr27581175e9.6.1739787914562;
        Mon, 17 Feb 2025 02:25:14 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d20bsm149128265e9.20.2025.02.17.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:25:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Check for CONFIG_PWM using IS_REACHABLE() in main header
Date: Mon, 17 Feb 2025 11:25:02 +0100
Message-ID: <20250217102504.687916-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=pkV3QDLau5yOCLVjOUftd/XupwhlBueSvQ/So/2Crew=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnsw6AxnKJlmU8kH0dk8ygB1joD2NdnBaj0Gr8m s8pGCumgASJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7MOgAAKCRCPgPtYfRL+ TroYB/9qgGs7q9ogXoDRds9jSid5/mCc5Z36FetlADFR5ro8VvjtFlfWBwmrO+MCeLsE2vOfIqJ nal59/E6sxCr1poRDkbjnK5Hcy3PjlzDD2pnSLRcD/F6CDwn60MVNqe63YL4aucWdsTjdDMH9gb fDl780kbYn0COpOsF3GIDFuqb2fUikwGeEJo97svDhPSW+VUBTgF09wcyrin17Eyyklw+mdFILm 6JLG+TGpAA+2mrW3tUMayQGEbNGqGIJkr2kHhpK3rcAYddKXLH8P4jRU4Mb5pyAMAYe0UjwgDm7 WdGLlihjCLrfteYpYoNConujB3/yU8khsnaCq8u2a8zMEAEZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Preparing CONFIG_PWM becoming tristate the right magic to check for the
availability of the pwm functions is using IS_REACHABLE() and not
IS_ENABLED(). The latter gives the wrong result for built-in code with
CONFIG_PWM=m.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a2df509056ac..9ece4e5d3815 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -379,7 +379,7 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 	dev_set_drvdata(&chip->dev, data);
 }
 
-#if IS_ENABLED(CONFIG_PWM)
+#if IS_REACHABLE(CONFIG_PWM)
 
 /* PWM consumer APIs */
 int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
@@ -661,7 +661,7 @@ struct pwm_lookup {
 	PWM_LOOKUP_WITH_MODULE(_provider, _index, _dev_id, _con_id, _period, \
 			       _polarity, NULL)
 
-#if IS_ENABLED(CONFIG_PWM)
+#if IS_REACHABLE(CONFIG_PWM)
 void pwm_add_table(struct pwm_lookup *table, size_t num);
 void pwm_remove_table(struct pwm_lookup *table, size_t num);
 #else

base-commit: e8af7c083520a7b9b027b2bb282464013a96047d
-- 
2.47.1



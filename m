Return-Path: <linux-pwm+bounces-6886-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C6B1212C
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BACC7B89EE
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C92EAD06;
	Fri, 25 Jul 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wdVCu3oI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3132EF285
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458346; cv=none; b=S6hc4yITtLAFowKVf6NCI9VZb/4O+IGqfVNhoRoKZKoHpWJy878uOGFJx8mH2eyJvYwbCCr0k22qaNT5MWJC638yXcktSeQXvFjyNLRqU0G81nio6cSMLi9PfqhCYrzh3ZFopZpdtDUiK+YSHIUFOFzl/aPnG1nYofyw1B/Vtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458346; c=relaxed/simple;
	bh=3mJ4A/6Pmt4yLob6UGgS31y2jyn08FFUhgu5smHeo/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0tJarxt2aiOd3EC1fEVfGu3fU7CJyF2+vC6nHPDQ/kFW9vfpFZlt4HU+g0oS+ciEz3SbUPWktPUdDhfFZ+slhl/PFprjT5N+QlJ7gsuxuYN3u0C37rkPF9Y5aIcMo05PAX4oHLB6RxLSEe6PhEcp2mPOtM/KSuLImyIedlhG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wdVCu3oI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1361768f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458342; x=1754063142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxaYQHDh5cKo8mtT6NzRrhKRLaSvrukMWylmIT86P38=;
        b=wdVCu3oIVD1Qc/9E9gNkA0tTU/m/1VlhP4fa7E/oZPzdZy7p7MLO8a6AM037hARfPy
         FPVHcsmhLEFPOXk5+A+cclVO8JSe2FWQISxITQ83U+kNvvNVwYBJ20QxfBig7SKRvMpW
         9lSsA5Y5Obtz64JqJ45tCuLTojKJehtXRTwCXW2Qfs/r6/ylQ6JMLAk1lYOvWAGvxVKh
         HX+G6BzGoeDSZp+H7jYf3bBcdxJpaG9pDOymdwUJsbcAVK2EEDnJ3m2L9CWiWeFsDeEf
         e61+FwM3DvT1A96bzDhKpd27UFXjR7W+iVB/GH0SYX1vkHt+XoT5eWag3mXakZ6B7eGW
         hFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458342; x=1754063142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxaYQHDh5cKo8mtT6NzRrhKRLaSvrukMWylmIT86P38=;
        b=eZEPws+2ZCAWqozLj4uqatW6lh9wMPEqIfIzY6enMRYvNGVvfYsvqkfA+VNaXNBLh2
         5Udq3n/bpspmriSL390hW2pA+HyqXLjztO6TImFZsjRjZsWgYAaH3Pr3jTog4Htoden5
         3a3MKg3C7B/uyix7e60IC2Wq0ERanyX+WS6fBan1r7BxAaGtjxzYd068eqoA+Fp2p9wf
         jzLZm1YHpnthZbrJLxeEqlaxsLLF1VJ3Lwxc+C/WWiGIA6fRT21+CKE33mpD/Yl7DPJS
         4B6KB6MvcGFZapgLm1EXccLpE6AeHo0mEWgNWqpaQImkrh6Kuv/8SkvsbnCxDRUF+YmE
         qKNQ==
X-Gm-Message-State: AOJu0YyReFq/UACm763DhWz64EMQmM6n35ysxwBfO1uemwq1GA4TPFAS
	Bn0cfAwZs9dJTBNJoVcAgN5AuysfTiPj/SeLRpjpm1Vz3rm84K2AfQDlP84Z0BPVeKI=
X-Gm-Gg: ASbGncu8SRxQwXWywl2pR7kav8djI/3iVr0+hjcDw2sCcrSs151fu+K6LSF2vxU6Wa6
	2+GwBk85k8m0z7RtS37O0OAXMDhYnWt437hqtSnn0fy8xqXD3WArSEZ0zCkYkcHTsullsECzN1f
	lPzisDUbClD11N+uMrV9odvZc3Na9zgqUuW/67BSutQ+HrIk6ceUj0i4ItJWNKdkl9t/E1awOtE
	VOq7+zl7PCnuosbVLuukbqc4xaG+SRQOgQybhYuFfsW/YE1N4+h64imRI1iBeG06iQKLsgQLWE6
	2FzuIjWFlFhrQj2VsNxI5tGD/DIeWEI4TonccVqOBU+oh6L3HQl14XIxRBh88V7/Xeq7nQbFjn0
	MZbweC7F3tXtW4jRwTz/Fl5i0nPBuxhdX2AU/OiixA2tkhj3HC46dZp74g4elZhJT
X-Google-Smtp-Source: AGHT+IGLf0RaznLGubTb9GrWSWMqA4rv+UHjGWeJ9+UUUrOkSVNTMU1NKksbhZETQOgp46K2YKeCjQ==
X-Received: by 2002:a05:6000:2512:b0:3a4:dde7:ee12 with SMTP id ffacd0b85a97d-3b776683682mr2225218f8f.53.1753458341899;
        Fri, 25 Jul 2025 08:45:41 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f20f13sm216269f8f.74.2025.07.25.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/8] pwm: mediatek: Introduce and use a few more register defines
Date: Fri, 25 Jul 2025 17:45:06 +0200
Message-ID: <20250725154506.2610172-12-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=3mJ4A/6Pmt4yLob6UGgS31y2jyn08FFUhgu5smHeo/4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aImLDhXHCb6+d622T7jKufvSctxWiBTt29m OA/ALkdcA6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmiAAKCRCPgPtYfRL+ Til2B/9tjtEebAqhfh5ngLznwQUXXFNGgnSlF6oz1SeyDpnoN+OC4qnsM1qWdTqrdfdvA91hPEr O3S+BcFDco8tFtStM6LbUFyBv+oeo2Ij52cM8b+jW8ShPxiEjlddINOfYGCs+qvv/k/mCapmtZF 1qgPHFEZVgCkcPgWtfkTxB4Ja3PnoDVXg0p1Hh40y9KYZtDJpF8makBAKCITOPqdexyxgkA2cU1 KXe+2HS+wMGmPAR4l9qKXWBXXy/LWTEnJWDzsJcAoVqSL1E7tyZyorVS5rsV4PxFhbrGPPNPDH2 yTeVeFcSC8aChRRTY63bqZ2RPUyegW9R8gs6XrhaNCkfiVK1
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of using a magic constant for bound checking, derive the numbers
from appropriate register defines.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 4dfe657957bf..eb348337454d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -21,19 +22,19 @@
 
 /* PWM registers and bits definitions */
 #define PWMCON			0x00
+#define PWMCON_CLKDIV			GENMASK(2, 0)
 #define PWMHDUR			0x04
 #define PWMLDUR			0x08
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWMDWIDTH_PERIOD		GENMASK(12, 0)
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
 #define PWM45THRES_FIXUP	0x34
 #define PWM_CK_26M_SEL_V3	0x74
 #define PWM_CK_26M_SEL		0x210
 
-#define PWM_CLK_DIV_MAX		7
-
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
@@ -162,14 +163,14 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cnt_period)
 		return -EINVAL;
 
-	while (cnt_period > 8192) {
+	while (cnt_period - 1 > FIELD_MAX(PWMDWIDTH_PERIOD)) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
 						   resolution);
 	}
 
-	if (clkdiv > PWM_CLK_DIV_MAX) {
+	if (clkdiv > FIELD_MAX(PWMCON_CLKDIV)) {
 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
 		ret = -EINVAL;
 		goto out;
-- 
2.50.0



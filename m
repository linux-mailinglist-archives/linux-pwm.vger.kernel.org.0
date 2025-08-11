Return-Path: <linux-pwm+bounces-6996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B4B2115F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF31A505237
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBC29BD88;
	Mon, 11 Aug 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0tmTFSEV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F2E610C
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928088; cv=none; b=qAY4J2l+poboIgcRtUK+b9K6p8GVdtcFBfOXXYdAeKTKp3EewcrNpa0TvwhkqRpBu2ZY2/qdoKmlhH7VujTbzyqfkm/SPhCVJGwDUG+CasyLdyQXDX6u6X8uX9TEDaSMwi3KKT2YmUwXK+dtEjTFkhFgTFqNaY5GCXJTAzzc+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928088; c=relaxed/simple;
	bh=bQaGpZq7ZQAEDLZ1OQZUk2337eOtQCiOKcSYufYCZIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWrX2Dvu/uOK+YmrR7ll02RCueGUM+MuYeXqdBRQ9Ce77teaDGmanNLjz0E3JIuJTUvoENKWE7Ph78MOt/CUanYYN+gsD8w0d3AQYlX0WK/caUUUkCdmY+PHP3A9xON8rSxyf/risE3Q877g/gDpjxk4kDl0500ylozn78CdnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0tmTFSEV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2644279f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754928083; x=1755532883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxm8DK1GPy5SaZSloQVQzHGEU5aRqB+S8jq82e0dPbE=;
        b=0tmTFSEVT236ZtOe8MjTiqFFadgYNROdLTmwqDP7mo2sSYqwtzA9KAy/+flCnxuAX7
         QO793X2gNl417wPuOfmxmymQMwEClnNFxDNnXkon4hoOGpgILqyQe2puss8VsnfEeHj9
         Pl+HgijLMO6Jr5UpStZBu/IIeCq0JgTp9pf/WPeLeTzgZJ9g3vtfcAZkKeEgQjsi341+
         AbjPdbK78vYQKNWfs3BiDDZGZWa9yjgqLTkuxmMyhmCOxTcjbTcQnCGfeiuCjA32fcL/
         cvQYDy2z6SZA5q/Rvx0jukSfjILVd5gma6ikEU4FzA1Gyh5nZ9k8uxE6CQS/LBZsbBWS
         lVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928083; x=1755532883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxm8DK1GPy5SaZSloQVQzHGEU5aRqB+S8jq82e0dPbE=;
        b=Rft1X1xbkdgqPgbofXveAAVwUO0t/vFfJ3x+PkCPFKvegDUE7fOchDO4puGvjk816a
         FgU/bGULxHX6KEG1eQXL9iysSj3082h03zuRO0jlxgnL0WklAhUOgveXRnr7I/+G5cML
         daswbD9FkgfJBvingcd5JhDumMbzyVOfcUcjPtV3686hVO+ZVEaUx0SeesnwaJwR8vDO
         q0p4+zmvY55kqOK2R+VJOnIejqLOdgKW95Zm/QWFWrXFadRQxmoakB7DMLla7JbA9mUt
         2+GciPkyKo2pQsB7KCGGlQnec/THe3k+s1yffXHmg/cDkmYXv8Os3kGkRQUIHzjkHiU2
         7/dQ==
X-Gm-Message-State: AOJu0YxiXb1D0Gpkb5Sd9yMAftTLkRUprkeoxja5E28Srx6hH7fmwPyE
	Jn0EIDlHipCgF8yc4tHqvpOdn+qQtV2oRHGs8o/+bRf/Bn/XpvNErSDa1O5zujTA8CflhHz5qhB
	tvCY7
X-Gm-Gg: ASbGncsFyrxZmPJganl9DyN93ZNWHr3d2HtVbRMTyWuL9+0zmcAItO76ylWBpNVAp6u
	IsejpIvVXXEEVsPBm6pCJdo0VJs5JH/P4/sEehVxbx5HevzUycpnX0gT1FM+J1cvvAUxXZexwZj
	ludOuaU5/n7QxIHvYQmlW55AHaTFWhrzDhWfpvICDwP3oE3DQMWAhajEzuzhY47xzTKoYOU/eaM
	cXWOWLQ1ylW3lCW8moq8t9zc8GFbp/5KddF5BgffMYPzozpZJZhhHBRTPt9JMUNcks6RYrzCFvh
	URuqPqJZCRHiElPqLOyVIO+R8Kz+QGTjYf3rRux7B6+PF8fddZSAJPKF4zJGOxkXE2xS2TCmvb7
	mc4dpkLAriFKAlRMSAKhPFDhRaHaSzA82bOhESDuygBcDcyVgZUJ+/04KZjM/+b3J
X-Google-Smtp-Source: AGHT+IF+8lILgMLUALjSmCwqPnOw+BYgdkJJ2hwXjPzEXP1jkF/QKaeuX2JPiX03Pqi10ey7Ww95gQ==
X-Received: by 2002:a05:6000:1ac5:b0:3b7:9715:75f1 with SMTP id ffacd0b85a97d-3b900b735c9mr10323124f8f.36.1754928083166;
        Mon, 11 Aug 2025 09:01:23 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c466838sm43369471f8f.49.2025.08.11.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:01:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 1/4] pwm: tiehrpwm: Don't drop runtime PM reference in .free()
Date: Mon, 11 Aug 2025 18:00:59 +0200
Message-ID:  <bbb089c4b5650cc1f7b25cf582d817543fd25384.1754927682.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
References: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=bQaGpZq7ZQAEDLZ1OQZUk2337eOtQCiOKcSYufYCZIo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBomhO+ZzeTMpa2EYeaYFOMjex31TuIhCL0PrJre xcC2lSpy7iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaJoTvgAKCRCPgPtYfRL+ Tp/hB/0XiCkB5m4DSF9iFlX68EScKQOQJIIPSH+5BgIPZ2ghh4/Y3SwHlSvjS4S3ch7ItP6yjqd u9EEweSKnUK5OcHN7/Y7zZb+Yba7TTE3HS5Iuusedt1H6OOeKc6XRWopcBtO5eqx8x6BZasz1xf tFyUfN5nqd9yei7jlRp8DA6Y29qMamyYINfGG9UQ7dk1ck9zgufV3ourDUmB6jxsGDPqKSnrLYd OsVjYFAMUrNZVN1Jl/74UylZnpZR5oQNxMVY8QM1CpbqRQiKVj0q2OLK9dcxY7PmpJ2uzhMcOgM wmjOgKK2zTltUIYFKFkNhfOpAS+TF6vSeAK2Lex28o8Ocjbw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm driver calls pm_runtime_get_sync() when the hardware becomes
enabled and pm_runtime_put_sync() when it becomes disabled. The PWM's
state is kept when a consumer goes away, so the call to
pm_runtime_put_sync() in the .free() callback is unbalanced resulting in
a non-functional device and a reference underlow for the second consumer.

The easiest fix for that issue is to just not drop the runtime PM
reference in .free(), so do that.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..5e674a7bbf3b 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -391,11 +391,6 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	if (pwm_is_enabled(pwm)) {
-		dev_warn(pwmchip_parent(chip), "Removing PWM device without disabling\n");
-		pm_runtime_put_sync(pwmchip_parent(chip));
-	}
-
 	/* set period value to zero on free */
 	pc->period_cycles[pwm->hwpwm] = 0;
 }
-- 
2.50.1



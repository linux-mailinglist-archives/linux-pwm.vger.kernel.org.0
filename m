Return-Path: <linux-pwm+bounces-2365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E98FF2B7
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF09F1C237F7
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24EE197A8A;
	Thu,  6 Jun 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kcCBuzAN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3196198A17
	for <linux-pwm@vger.kernel.org>; Thu,  6 Jun 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692078; cv=none; b=CBSvlTek1z7Bvyz5xn0PUr7nMS7FnudW0cT6V8aMYL10DurGeSVtWz1gCECaKOZzZbC+cHJ+zaTssm29tnNM/hlMYLLjzw1xk1bfsaO2QKvSZCLJh5SDW+VMoh91N5V+JdUoRIpzx1yeFYJwOuvuShK1N/i2vNre9TsJf6OclJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692078; c=relaxed/simple;
	bh=nev6dUA4PRxNyzcD33S/YOMRpL0XAMy6tgmbvFp11ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGTFzBY0BAyBForQcCIMaTn0HXT93JnncfOqKv3lNLBFvPhIoQr9FOCQBizdYScgYGgtNbkJVPPWzyrN/h3cD5+F5x80bhJDvS/uAFQHCKE2j7AAHLIzAgssYH20AcvM2X2S2M+DXuEAOnf4dQQ6HiY52zIYb6O09ZCVeFhG6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kcCBuzAN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-356c4e926a3so1050680f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Jun 2024 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717692075; x=1718296875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEeTee/9GDdW4aYkXW9KgQrVIHd2u5SrXadCYSxBDm4=;
        b=kcCBuzAN8wAb3Gq3AugnsA/bUJML4AhJmwDvB0bv27MpyaAvdt+sCzS80CL0csk4gf
         Cdh8sRqpixfzb4oy/WOfGi5Y9Zp3i7R/k9x+jJOSsxEbKn6P3oI+xWMyqI3FBbPVtSds
         bdUbL89HJGC9lEOqhcJarTzioT1dDkmhGnTL3fNuWYgm7ChxkFIVivVnyeWSAOMzlkDx
         tVRclEyQ5raMQHyg646r0u1AP5dmk/g0SPwJm9H8iFkUZtMQJ+ZtVZNz6l8GdP2Cixpv
         P/MxUy8Ykhp/zrjniBvASbdiVuDKnf0DFG+9kfLCuOE6a+dmnhhN+Z5DztCjPO6bRAJ5
         Ol0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692075; x=1718296875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEeTee/9GDdW4aYkXW9KgQrVIHd2u5SrXadCYSxBDm4=;
        b=TUJxJRFqnimoCmvwXD4JPov/0Q/NovrcD8u9AGXBtbEbQDCHgpWdcs1g9QNe/MvDFW
         ZKd0wRsG8Ahoi4CCn6f4Pc/EMSXA16gwR8JDl1A6NOCFSvxrJmuQh45gPma+NkdOWBgC
         ba6TGDKrtONy1cWrrj5BTHNvhuyhryCz/AXhHDofzT5tA7VEIlHAeAUuIi1Sr1xnuYKq
         M1Nlp92l0bCtoGOqo2VVRy5uY9ti0G25tl/mCvbTUO/IuANbjE+PHz/B468mEUIjN/sA
         K+c48a4dLMrCQdFnvuulByVMSOSRkivklQbu2AaWHOrTFUx5FqOLMYAQCS0VExTlnYyz
         qD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAjow4FUCTbxeqvan5K4v6MsP37ZmiLEZxy+haPAQHWexoImw722CN636FRQRM4M3v31dQDNIqnE4nNMaXo+K9xEaedsLFHBzt
X-Gm-Message-State: AOJu0YwR6+1X4V2aqjEhCzsBXnhFPLXUkojLnW32mLAfSdJZ9uWIlj12
	i6nhxRp9yuhkYxhBv+36tNnqiXLTqbfsG+XcHiXL3gE70uWb7WwXdpVuO05jVvU61/fNWgv8tux
	bCNk=
X-Google-Smtp-Source: AGHT+IHRiGM4fiCfzIB8ncxH9DQB2mmupqiR8DMIpeH+89NXTVTS9Q5+9RZxhRE4qt8vLOCy852k9A==
X-Received: by 2002:a5d:6411:0:b0:354:e775:19ff with SMTP id ffacd0b85a97d-35efed52ce5mr117565f8f.38.1717692075142;
        Thu, 06 Jun 2024 09:41:15 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d49e43sm1996631f8f.31.2024.06.06.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:41:14 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] pwm: jz4740: Another few conversions to regmap_{set,clear}_bits()
Date: Thu,  6 Jun 2024 18:40:46 +0200
Message-ID: <20240606164047.534741-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=nev6dUA4PRxNyzcD33S/YOMRpL0XAMy6tgmbvFp11ZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYeaUzVfWQhxobNrb483+cyPM2Z3KAGdDCe2od gATs+6ysAiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmHmlAAKCRCPgPtYfRL+ Tvj7CACV+8GYOBSDa0inXHAgxuNqC9t9qSlNhRZMAsRlY15oJ6IrQoYMm+xaDptIHtURzK+udZ+ PI4IceTvcLqZYeRcqzL+H3URAnMJ8e298x5OXR0BbS7HqzZyloKuq/q/G0rFY6ljtOAM5yYiO5V LxaJCQdScLh+HGoEWMCasXnM248aHU1mg/PYbj8XpV1XA8yLAYubXfUxshUjkeaHXAnlBpp+zhD S3qX9DEhkbNGD9QKCxUwGpb4FiECZmxDVgR/LflAdkqYR8/fvFJRhcgpqSjRXus/6/E5AP7wvlm Ez9AakZEdmqHqViXCdHl1T0wjrFz+qtcyGPcduKGYP1X3kQR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Similar to commit 7d9199995412 ("pwm: jz4740: Use
regmap_{set,clear}_bits") convert two more regmap_update_bits() calls to
regmap_{set,clear}_bits() which were missed back then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-jz4740.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index da4bf543d357..6bdb01619380 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -201,12 +201,11 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * state instead of its inactive state.
 	 */
 	if ((state->polarity == PWM_POLARITY_NORMAL) ^ state->enabled)
-		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
-				   TCU_TCSR_PWM_INITL_HIGH, 0);
+		regmap_clear_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+				  TCU_TCSR_PWM_INITL_HIGH);
 	else
-		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
-				   TCU_TCSR_PWM_INITL_HIGH,
-				   TCU_TCSR_PWM_INITL_HIGH);
+		regmap_set_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+				TCU_TCSR_PWM_INITL_HIGH);
 
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
-- 
2.43.0



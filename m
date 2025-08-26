Return-Path: <linux-pwm+bounces-7172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09217B35993
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 11:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D392A7143
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C633CE97;
	Tue, 26 Aug 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rqeMuLeq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC333472E
	for <linux-pwm@vger.kernel.org>; Tue, 26 Aug 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202093; cv=none; b=E7OdmtmV4YiOEB1PCZoMe6ZoW/YqGb3lMUyFs2KqeTOOwUhRAUDv783ssy9cDYcIjPdlNfwFQRR0NWA/DNR4+yIfxje6NJe6lc3QosJIeFx6OARq3+1p1bvlDjZuue/dYsHgAiE6z6S0Z+kLx2YZPYI60gb1ghqJZpAcrYaFx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202093; c=relaxed/simple;
	bh=VZG22Y7WwpUKvg+GiHO5Hhl1+8C24TfueSt7vEtoG1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhW/3+iyz0viCow6aHdOg1SciD0OvkXQ3GDy8VuUFqA5Sa8cuhaaThWtxsSx9RHSCQaxYmyKBbYqvBdAL9PWSKAwNS0vpXJN3+oZA1gQ7WqX6uEcqy6+MLNIqqOVIUf3A6wxkhX7zeorY5CeA90zMkD+6aS1Lqd3dASw3p4Nzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rqeMuLeq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b65469a5bso7321105e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 26 Aug 2025 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202089; x=1756806889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYPPBVbCADpKhi1bi9q9qzWJoLo8lysoUYAIi1sKWso=;
        b=rqeMuLeq9HFlTZshfBWL0C74BXWxp0GT3m/IzpDm8H3KBoFYDLpW5mLLiN5KqaNudm
         VOA3gkfTBLK0j3ofkSXUnnzsEHPQx3D/S66kcZBikl3qfk3aoz8OesNUPkiIbVtmRM+k
         om/MokLRt3Rdf1PSJ8z3ZjLlEIy/gtPg0Iyr8DAjPYDdqEvEdbvj7SNR2eC/aKjXoDl9
         BA1KOIzGdSn/zTA7xSOlnyEu8hkaBhodpIbKWmgADApTcDkYMSN2NzwpI6ym3vhnLuzj
         2Viv7VBDxtQmWr3EmA8YpZiUBVnw+r8JIVtd0BLMPYHraMMKjhSLacEku+cjO60dq7GV
         dr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202089; x=1756806889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYPPBVbCADpKhi1bi9q9qzWJoLo8lysoUYAIi1sKWso=;
        b=Eiv2FcDNH5q5avI4QHrsyE99YPHZOBMpxgK7Sfj5IP0JKpUDOujQJyiRGE8pPMhSh1
         T7mn0UoWTrJaPrlG280YPLw1zwtzuqW8ZeJdB5NAbNXzpwZI4/SDeT7SlEbsLTy4Q3ZM
         mjME/ZlC6BFcuaGMTc4oEA1cVMTCK5KenPyV71BeHLJo3IL+8FE69k3PaiYimHpp51rs
         iuI7PgdyfAGm1YxnoxRdeIbjPMc90fxgLCK4j9oG3flsoGfAefjNHK33+u2TopiRM69B
         8F+F8N5iXf1u7mJGnxLyEK1z29YIBpBexfvUe8zx9GRJ2rwvfneYjcGIaWVAlNpnZ4aH
         BHDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfYXl43aJAzVcsore93H3Mn/qlC5bfwyK0pHdeno0fxlL3cbCmUcq5gAb6ngU0E7sj3Klcn8KrF1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABdCmFIy4ArlS/cH4MCphzrf2qcocJtkLZfFGsMbfxJ9BFqMZ
	gnhaeImNUp9YkkI1ysuByxwpEAsrYryapP5XX+q0EToVay1pJxmrsbub4L97X9f7Nuo=
X-Gm-Gg: ASbGncsQ0TCivrSWcdLJ/D4Oc31rzeZ+EfZBLaV+ny6yyWcsWEkBjZD/X6fcepiO/1E
	cLdG1Sc71ZQYt54R51IHzmepda1SYzn2B0t8VA4mDVaENZT0S4P2JCDlfIsFxXMfUOoHf3F4HLy
	l0dUCGryGHFSMuRnJ+qFx4K4t9oD0vlvdvCu6uS3KXOmCxdVjg6T9ub0FSnAurX54nw8XsaBYVx
	zjJgXBqNfo8XJ+2sklzc9hTsp08mad0eE1eebi06rrqs1OhaYBGti9pddUn7JV4b27nO7KKuGxb
	zUPmvXpUZVuqAr8+UBOkl99m6S6+ZSBhSKp134H7zYqtxkIGNCyiSlat5Pv1+ITdkc9JtMDiSxG
	Uvv26sGRiwDyP9J8lLg==
X-Google-Smtp-Source: AGHT+IGpWBizMY//MBhSvlr9tBPYwg0Y5CIU4h89Pdi4ol5gUDn6YVkBG9JRn0IY9DS4Uz+pdj2F+w==
X-Received: by 2002:a05:600c:a4b:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45b56f781f1mr93995895e9.13.1756202089140;
        Tue, 26 Aug 2025 02:54:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:39 +0200
Subject: [PATCH 5/6] gpio: mvebu: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-5-7f27cd7f2256@linaro.org>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ih0doZjhwnqEDQvY4BwLNFHdMVjlZY2PNt5pCcC7YMw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRhcpj4kqrJ8fCQz7UztTDjdV8EBVimDDXsl
 58MvqCng/aJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYQAKCRARpy6gFHHX
 clN6EADhb6sNqywomuQGbo2ieaNoLgLHDA7EmFyphMzWXyAawSNEGuBX4/n0ThtHi25Yi4innjv
 mCr991m26FZq3T/hcccGRbWPXAF5EvVzn8oFTa3ABrM9hxRg1uGzD6d6vdwzo9kp18GW0HfyQcs
 Fz+md/af5QDQzJRHzG2w4D2NDTc+iWdT0lX2nd8Vr08n3FPtw+yJvnaJbavDtGdCgpD41gTLUd8
 3vyl33Idw2mbNroYq2RQFezk84pCh5Y65qYyJAu/8cugvbwXkyFJ8qBHDQqKX6kiYOFGRUsyxuX
 A3wepapXNcOKLKAwA9b3s8SQJug6czXExk29z2Rv9ijJuPxArPScEv5LdYdwIhAEad7u43YpZm/
 sHfCTKhb3PbsY1R6u0J9EQ4GS7rScCaWU/L3ulx/aR8ocK2D+3mSEnIchmuHmmL5PRGzAS0E535
 H5ieprNvRn8jxG+T7OLs+3W70GIYk53ud0qSyduu6VUuN9Nul1eEtgKZplHMjiNkM05iIzDRY+t
 Ggl5wWu2ww+8AjSJnjxEtuTZS4DnKwSg+f4z4sN//F10F0SFquqsVrklUQxSQXFzutLCzrKbg4r
 t6/BU4KTwKIxNB+VFO2hx4KL0iKISjpUkEb7pNTtM6oDhaErh0AULImXD3xg5rgVRmQcToBtyN1
 X2vSa8ptjrUp0zQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 261ffd0c614b7189287c361f392f3df6d1b0bc57..ac799fced950e306a967d1965a13f8e1802e77b4 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -898,7 +898,7 @@ static void mvebu_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		msk = BIT(i);
 		is_out = !(io_conf & msk);
 
-		seq_printf(s, " gpio-%-3d (%-20.20s)", chip->base + i, label);
+		seq_printf(s, " gpio-%-3d (%-20.20s)", i, label);
 
 		if (is_out) {
 			seq_printf(s, " out %s %s\n",

-- 
2.48.1



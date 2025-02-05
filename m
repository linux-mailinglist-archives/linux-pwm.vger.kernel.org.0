Return-Path: <linux-pwm+bounces-4783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9EA29818
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775F1188231B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901161FC7CB;
	Wed,  5 Feb 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3bUbfs47"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9A193436
	for <linux-pwm@vger.kernel.org>; Wed,  5 Feb 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778068; cv=none; b=dCFuy98Un/619jUVyy5ifFCD76qTi2LgBcMIdto2/XdWcYuf75OurndMXbL1l8fHFP0v40I97vsVrpV8pU4q0hXp2TDe+0fQE3aAMAqa0bdMWtpvFXrDopKBdqnf5OnKZE7MCS/xhtsyjxLC51sEELYhrK9v8JVqMRDx47GYjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778068; c=relaxed/simple;
	bh=y7Oa0HXBmU0/PvBO5RRFWrwovXtwoap5Pkcr2yApIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWS8gtj35X6vPuvI/qjIiC/xKIIAVxFjicA6n4zJVov9yMJMPigW3wyGaUvSYZUzcNSTu4GdNg0+PMOUB7WnHle0+ZmxmAC6g0FkeNdYIIqNIVMu5Q6XL1SOvku7EqdUzQKJZ+VA1cSep1fFC3Fx2Ti8KEPZfgXQVFXBG1qTzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3bUbfs47; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab74ecfdae4so10861766b.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2025 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738778064; x=1739382864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejWrq6TGbjAd26qleaa7jEfcM/wgJg4o/vWWPpGilgU=;
        b=3bUbfs47UVTy32N/jptZGN0Qs/mLM9zFhSm4AcKcQ9rUSQloZW7tjOYvIxNcT8/xXk
         sCgEx+UIcusE7FRIiv27ASsTqS1l0H4yrk14V9fDZ7K5nvBIFHzrOY2FCb3vPuyaTVPD
         bvUytddJPm6vyDg+aw51bv10KHokz8qVyaSV0KSE8mVh1xkYdWSgIukWRtYGYgHWl0H8
         Mjyi0SCnZg+llaHX8odrXdhxSETARHYTugbisL56TUSphupMh3kDqffyWnHbHEWm2TL9
         DQACzg0Zb7nUWzc7Oy/EW1kLZ7Ty6YGDEOKUwUGnbMxNbSJE6Nr3PpjOUPLzGfNVqJYa
         1muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778064; x=1739382864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejWrq6TGbjAd26qleaa7jEfcM/wgJg4o/vWWPpGilgU=;
        b=vU8YS7uFrLQEkR8i6O83QzACLfXVGpiZVz81P69YKXv9rWpw+AvibY4vo1xnN1FAhw
         smZdy80F/Sqdozk9TvaxEXxRNXkFY3TO15Tp/w9K2if/ImG/nrxNGTzt9b95q4zxocFZ
         R91gTYkNoYXvQfSDiUR5tig3M6meqovZrXE4XC+HhTZwxULjD3jTSkEH/XFgga1dr1OP
         5kxvMUE/Kh1L1sRY8F/6ZB1pYwW53+QElsPfMjGo2NSGZRtP3kRRvlbw/kybikhS4V8a
         9AwtgAkLsLE3RxlPZQyOD7KwIHxksyZl02/rRe7mC+YVzBLLbr9O/VfRvVdxZhPYs+c/
         eI6A==
X-Forwarded-Encrypted: i=1; AJvYcCXf0ZBUKvfhR3u5yO8vFEK7VvMfsSO5lvfv55JqXKaHcKBVEdaxEmHAjsbSAtXG63BAazXGgkT9yTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUstdmp3TnSZRKDroGoGFg9/HPISlmnriPjQRTKWRJjTFs+ekc
	/uyb8xd6d86XubNaVYhM9HcseRI7SwA7k0D5syT6hVl4v/9fFq/ARncDTOCwzTg=
X-Gm-Gg: ASbGnctW9E+VsbUvvdTceFPNBFzYFT1YRNgU4wVQmh5B4frE+k7RyElRbKjISO1nMZ/
	+C//O+24JjvwuWzWayXf5i1Ic2pjUzznOcu2OEtVi+pxhrJHa2WgGqZQMEpUtiLN71tjwyLCwKT
	F5BEKpKfJ3/TQ/ioWLeZhH9INDRJGEVsOvGyK20eeUaNuuU4Nw8Oxupxo7w7RpSX60LW30+7jgQ
	9X4FDzLjCzSfOEMEbRviBjNFxrAIMlknA8y4r6LBqh+x+xkn/cZFkkeZlI7y27LOqs9L1GtJBUa
	rEOJmP8Gi7f9pe45Nnrn7fYtRsfa7x+IL0dObiyUsVw4kD0d+HkPG2qgdw==
X-Google-Smtp-Source: AGHT+IFi+I2QYC8SCv1Thd4fTlvD9JpT7oehKfpn2hd6Q7dIRYgFRRv14859tXC16oyIXhFfgdVHFA==
X-Received: by 2002:a17:907:7da6:b0:ab7:5c95:3a82 with SMTP id a640c23a62f3a-ab75e216488mr361291566b.1.1738778063563;
        Wed, 05 Feb 2025 09:54:23 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a560afsm1116492366b.163.2025.02.05.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:54:23 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?UTF-8?q?Herv=C3=A9=20Codina?= <herve.codina@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] pwm: Add upgrade path to #pwm-cells = <3> for users of of_pwm_single_xlate()
Date: Wed,  5 Feb 2025 18:54:00 +0100
Message-ID:  <1829c1a040c707326d9c53aee3577763e2139d58.1738777221.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=y7Oa0HXBmU0/PvBO5RRFWrwovXtwoap5Pkcr2yApIVs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBno6W63WuM92iNknmqYpooawZh3QTBAcb8wp4Xc xEhAhPpMxOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6OlugAKCRCPgPtYfRL+ TpnDB/9o3E5Rkl1Ie3Dz1olMCefNaINVPnui+wUhfYEqUbZraMf8EyoN2Is75BF97QrKk9EVG/O HypieBoLrrq8NTPejeFFWGOWqMdRvydtz/dm1RrryJBV4w1fEO8/egw0MNdwD4CtUkoL69q7N0s GfMipxg5eX5o4eEyibOheuTG6DgGnHHKVl4xkOftWNaaCKmvl2FBQmzlhZQahhnEzJTGZLQIAzF LIJ1vpsJxkN9EWvNp38NXdvcR9VCaGwdddPR+ko+Kw+vul3HuiCTrDls2fcXgFCctX10IbJHoj/ GbS2ikJyLim/5wOOqAcVWPfi/MCu+yjoKCupZ7Wi2c8tyJMW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The PWM chip on PXA only has a single output. Back when the device tree
binding was defined it was considered a good idea to not pass the PWM
line index as is done for all other PWM types as it would be always zero
anyhow and so doesn't add any value.

However for consistency reasons it is nice when all PWMs use the same
binding. For that reason let of_pwm_single_xlate() (i.e. the function
that implements the PXA behaviour) behave in the same way as
of_pwm_xlate_with_flags() for 3 (or more) parameters. With that in
place, the pxa-pwm binding can be updated to #pwm-cells = <3> without
breaking old device trees that stick to #pwm-cells = <1>.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ccd54c089bab..bc05818fa370 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1000,11 +1000,27 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *arg
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
+/*
+ * This callback is used for PXA PWM chips that only have a single PWM line.
+ * For such chips you could argue that passing the line number (i.e. the first
+ * parameter in the common case) is useless as it's always zero. So compared to
+ * the default xlate function of_pwm_xlate_with_flags() the first parameter is
+ * the default period and the second are flags.
+ *
+ * Note that if #pwm-cells = <3>, the semantic is the same as for
+ * of_pwm_xlate_with_flags() to allow converting the affected driver to
+ * #pwm-cells = <3> without breaking the legacy binding.
+ *
+ * Don't use for new drivers.
+ */
 struct pwm_device *
 of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	if (args->args_count >= 3)
+		return of_pwm_xlate_with_flags(chip, args);
+
 	pwm = pwm_request_from_chip(chip, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
-- 
2.47.1



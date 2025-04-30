Return-Path: <linux-pwm+bounces-5781-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB0AA47C5
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C317C9FE
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CB2356DA;
	Wed, 30 Apr 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V/obQBcE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9823537B
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007105; cv=none; b=aMEG/sZIzpkz86qBjyNseIuA488+t4YymmxRmmgXl2dxr8vnBsI/nQeH75axEg0/BJdPE6+P7wBhBqrs9aasxcFqUGtR6B4/ojbNamyvSbmO93EMf7Ta+nWxhMoO3HQgehcSa6caIASeuHvVMfJkUUNt83M8aW9HL/EQqESLGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007105; c=relaxed/simple;
	bh=WT01wGVMtz26jsQthh5ks0GmmRwDkfRQsTIGumy+IKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBvbTXcalmIhsOrnBhOCuwW2YZ2Qf2ttoHpETA3pqTKNze267nfLr2Ajai8TgicLYfoWJ+Ut5kRTdsr1htu5Q4OdFmJ2JD/PusPtJBClNg1VCNZxYnwg60a7VVzYiwcNvVmMDZGsBceaRc8n1r/RgBlzU/WyzdS3vnLIxUNpXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V/obQBcE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5217605e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746007102; x=1746611902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm719CaCs0841zOLo7ju4gU62GZo7ZjXGxw9gltgKiY=;
        b=V/obQBcE/VOZcf/uEv3YFrpamD3lW6iN92vZygo+8WP+EI0pNOJuUoDcfd6KxizkEB
         t97i06M5ThTTscjBNcZ7r3FcoDONADsZvrkAcmd3T6cvK3oqae0vDIyG0meZdOf7CFoX
         VKLSGoqrpyduWFhgMXPJKArPgGOx4BmjueUazirOJ/hNpAN1TTOevKBDBIizUDyOZlT2
         0LJNolwpqvu/alHoLI7w5qhZp9FPmn5b18C6nw5daUKyZb/AVy1Y2Fuf16p0AXNWKuGh
         l+MJsWTnVzNG/aY9JYrU1jBXRPURaLxeb1RIXv7cKni4Y7NLW0TfXhp+vSDxsWjopvcz
         oo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746007102; x=1746611902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm719CaCs0841zOLo7ju4gU62GZo7ZjXGxw9gltgKiY=;
        b=UjT31sFPlv/IueCWRF07yppEn3Zz1R6qMQ6I8atWbbMCS6VwRLyeSaL8AbPk7dOchi
         RFnT45BgVLdf0dzqMgaO14IPNNChkDHCdRKwRwmOO0+sYl6sXDW4P6bbdux5gL/oifWw
         EcN00aBcW2byH2hiAS2OidDJljw7+auxOfjhBZELP2ho1SXCsHCKQWbtNsUMggvcMVkA
         VxT3QO8Bqns03aqw/NaD55BfuroagU/ub4qyMxiXoNkCM0cR0MuGfaYReefyWPtGd/Fd
         tjr3IEx+aD/YVTbC2iJBznHOck6DsrqmXqaTTR+f85juzgLR51l+6zJLVEkM3g16vmrC
         NMJg==
X-Forwarded-Encrypted: i=1; AJvYcCVkNg7s7NxS4Nitq3X5USUbFQd8oo7hOteFvG72UrDh0LsZ0n56LlE/G2Vah5UUJkE8bxCis75Jgzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqdq2ytD/WTXiUPz5jvsBnfPQg49Inqi32GcTz1SSO0UbBf2ZW
	DNUj4ZFuN4abbklmhdgpZZOflKJSszxQf+GdAOMQEWoYvRTz7jQZnXTvnLo+Kik=
X-Gm-Gg: ASbGncv9pa8xixWnKMZ5xoI6aXyAPqXG3K7JS83YLmYjc+y0DPBP8nlPaQ49R9hkphm
	xye20fJAFA3gyVo6znjC8UnWbPv4gv1rm2Be6xS3/Os1ZS516xe1/dmE1JwgDNEETU5/MwEzKeZ
	EtHLC+d7udx5ELh8sAx+ulWi31xh8NwKA8FsiSZpQO11ekqxCupSF9L0PumlZ7eowhStD5oe6gN
	sfqmQJ3vH258LL4EXrV+/zVpwfVSby5EZxty098RUfuahGz8V0JnfAOClCdhcLQlU4Xnarir8uJ
	VtZN4nJ+BJQcy185JMGMyIU2Zj3toqbF6if+lEd6P2UAc9AyLxH8Fv+KnKbpdhTHt06XFUe8jYz
	X/l1NXqc=
X-Google-Smtp-Source: AGHT+IGqrjOo2DQKHc0O1IVZBpNMHo4FYWVqhFXgFonOACFW+GhUkms3OO44TpMe3c2btTrkrmk+jg==
X-Received: by 2002:a05:600c:4e52:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-441b23fdef4mr17217465e9.12.1746007102235;
        Wed, 30 Apr 2025 02:58:22 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2aecb54sm19004205e9.10.2025.04.30.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:58:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 3/4] clk: pwm: Don't reconfigure running PWM at probe time
Date: Wed, 30 Apr 2025 11:57:48 +0200
Message-ID:  <a974f1147e1a080bf5ad7f1752c92b24516df284.1746006578.git.ukleinek@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WT01wGVMtz26jsQthh5ks0GmmRwDkfRQsTIGumy+IKQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEfQiMMw/YDnA6nKRMEGdxoNFoVrglTzMIIT9N 7CshPyqkBuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBH0IgAKCRCPgPtYfRL+ Tu9BB/9yVq7eI0wUxz+2JWrLoF+6wpoMsck0nLquvDzP0wMOHuwgs0107owzS/JfcTlg4bbQCce jXoQLQInMibU7BYIjdLcmGzNDvwv7o0MwQNdSsEd1T+i/OdeujJEHAeyrUVFfwlCjh3S6ueGLBc 5ZtlWvsEFAL46WqbDkxKAiGoCJTPKgK1qaxlSz5DmHxB9du/AI3cvXT0U9xphPVeD1rRFn0YW9e ixEFs4G+YQmlfsWV5kf32+HoHnQh3EzyHekdB7pe/ZFbRgkw7UZVAUQgVIVf5s4s3JEvO5KXkeF cz7wUFRggsQmHXCQJYc/2eSgmQYTetpUiR5Am9h6j3CroWr2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If the PWM is enabled already when .probe() is entered, period and
duty_cycle are updated which essentially corresponds to a clock frequency
change. This is unusual and surprising. So update the settings only when
the clock gets prepared.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/clk/clk-pwm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index f5e6fef3f4d5..856828d5f58c 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -109,12 +109,6 @@ static int clk_pwm_probe(struct platform_device *pdev)
 
 	pwm_init_state(pwm, &clk_pwm->state);
 	pwm_set_relative_duty_cycle(&clk_pwm->state, 1, 2);
-
-	ret = pwm_apply_might_sleep(pwm, &clk_pwm->state);
-	if (ret < 0)
-		return ret;
-
-	/* set enabled only now to not enable output above */
 	clk_pwm->state.enabled = true;
 
 	clk_name = node->name;
-- 
2.47.2



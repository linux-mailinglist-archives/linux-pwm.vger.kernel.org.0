Return-Path: <linux-pwm+bounces-2800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF239312E4
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3013C1F239E8
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA018787F;
	Mon, 15 Jul 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vJ4yU+vq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577C1891B0
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042206; cv=none; b=Ot6uMovE2vtROusZ6uPkdug2x5eRLjsJ1b0XskVCdncDrgL/6tRnRrrV9P3L/JsHfQOqxYlUaprAWg4nzNP078v521akWYKXji0QQPwnklH2HHUd5Lt2hBFyWES17CWAh1lG+yuMRGsrxE9z+BUO0h6zhFgPHjH+59SLXzCU1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042206; c=relaxed/simple;
	bh=G8RzSgzqE3b/YQkVUMRKktKZQUWUi0ZOXcwktYDJ6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZktkQckd1qOx6HhaWSsJve50YcF24BahjE5BMn14TjPXbQtple7TGB92CENKI+OhDgg5JrRan0HvpZn4E48ZuMzvXERw7QQr/iKNQLWFOHv/4TECpkVqqhguy9Sc8wqL4gzwiuhd5y3n+BF2eQiEXenA927OXBILpdhyoT/WulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vJ4yU+vq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426526d30aaso28919245e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042201; x=1721647001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czqr3VJTl4Kc4YYcH1tRw4LJap/cuiBFRZk+Kq2Jw3s=;
        b=vJ4yU+vqAajUqnpm8lO940V1bg7c4mXfXLqzTgaNHIxhXYmEH2v1AGaNsD4YO4CL8l
         VHIsw6buwJBfObl2ZqjnjKWWSMXUZCaDmwmIpjgs//oioeVB2KhZA5xCzVEbVi7U+0ch
         nToWVWfvGoKcFKQJR51yFzsgrtIjdHPI+CtzLOYU+1Wc/MCBcWaK4mohk4Vp1e5paMAF
         KSyWhfPZXe5+/fTlfAtO2k8kCMymgs8r/GZKFoM3M2CJc4fWxN0lNtBU+UeHWzIOjaoU
         CM563Ji/bLCJXIeB1XDMYaae+KF/BPPNF/AYI3TZriBn1u+Dn28MLeu8wGJExXYwoXwJ
         +pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042201; x=1721647001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czqr3VJTl4Kc4YYcH1tRw4LJap/cuiBFRZk+Kq2Jw3s=;
        b=YeSsJKlY/f0dC8L5YnlwGwFcUMdisApSYEhO0rbr5JRqerV3aXC14B35Pgl1elzJem
         m0zMl3ubyYu8vHt53nmddYlLlMI+OvnTuKuRKnkUa2mS394vfRPuvhw9rqh91tM81+YF
         R/Fte/5LwzCsBG3dOO2bvFf19gYTPq3KG4NdbR947JxNKX+sgngLWAHpq8KRrhNgGGZw
         fcRNXfoU2T1yYrDe6DitD1eEu/S2HRxjAui376zVFAcTXMebbrERkJlw09BAnzlc616B
         kK3hirWLwvl5qjWyXCMlmgXUUTb7/QVH3btym1DRzaHmvA2sk6TtZ4RngsXdr3Rm182s
         +dbg==
X-Gm-Message-State: AOJu0YzE5b7ZU0xrt/s2rIbS3ebfeaMDV0K4pfjqQb50zckjAStRhbX4
	Cfznh+N3Px8Hbfj4sOSuSVg8C+njyoyOY3ZhMJ8YnL+u4yDDdlrpL+wHD+ljtRUMD2AdkxH3rzm
	e
X-Google-Smtp-Source: AGHT+IGEWbSe33MdHKmy2XMSwQlfjejH8ByhRWcYlpOgXKnqHKeRtl3HnL5b1YjkQSG4MbAY3pgeHw==
X-Received: by 2002:a05:600c:6d8f:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-426707e2ffdmr127297615e9.17.1721042201437;
        Mon, 15 Jul 2024 04:16:41 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e9a814sm82353195e9.27.2024.07.15.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 1/8] pwm: Simplify pwm_capture()
Date: Mon, 15 Jul 2024 13:16:06 +0200
Message-ID:  <e45a2ca87c0cb5e58e3fb3417787e601da41064b.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=G8RzSgzqE3b/YQkVUMRKktKZQUWUi0ZOXcwktYDJ6dI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQT5wcq3Lw86TBpbQ43p5wj4GDEBxi8zm7kP2 UGsclMjARKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUE+QAKCRCPgPtYfRL+ Tl6hB/49+gBE4rEqKhULQsaVbqbInKtlF1lwoNJT0g1Tpkw9cm7A5uhzREf9FJnLjbMNYMRZzoZ deEZYhv0pcBS5Ou7flAzKt1SHb6FDePuS5RAYR4Ui+rtDKLXJOVvpB9gD9OK4boDaI4k3ZJxyeD p2BsZndO3w7nQpcRCGDIOA8Jxjwua0isgvDHzERh6XmZ9wSWCgIpf3LV9Qn0kKzpkiJ9ZX7TC1Y ifq8/TjYDOSuwF9AHGk0uh3AdQHo9hdsQwVvydE6W4J1/tPgdHvKR+8XRBrOJdmZvIqJZ0OCHhX BfqjoCbnpIw6zj1sxZpQQ7UMZv5hwdGWMeq8stFYveEw8wpt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When pwm_capture() is called, pwm is valid, so the checks for pwm and
pwm->chip->ops being NULL can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 56d91c11f0d4..6e752e148b98 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -328,15 +328,15 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		       unsigned long timeout)
 {
-	if (!pwm || !pwm->chip->ops)
-		return -EINVAL;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
 
-	if (!pwm->chip->ops->capture)
+	if (!ops->capture)
 		return -ENOSYS;
 
 	guard(mutex)(&pwm_lock);
 
-	return pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	return ops->capture(chip, pwm, result, timeout);
 }
 
 static struct pwm_chip *pwmchip_find_by_name(const char *name)
-- 
2.43.0



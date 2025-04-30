Return-Path: <linux-pwm+bounces-5786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC612AA4A6F
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630CE3AAE32
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895A25A344;
	Wed, 30 Apr 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tD3GNvO7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEB259CA9
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014188; cv=none; b=akznMoS7pm7bQyZPFTq/SA3dDC0SMhUxl3BN6FLZ/IANWjW/7AYpgJs6HAxS38mDgZ8X7lv149b2fGRdZ7kYxUXOKxUhynDz/AXCkFS0QuYKgdn1pyN6RVZs65nnKDCI6zC1XhyjvZBtVAC/j0xdtTlH3cg5LfvnwD0axHcXTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014188; c=relaxed/simple;
	bh=RjoEXSIkY3DqTEk4/M+XxiagMUMOfWsaQZWgGc6PuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3YxuN2f047m4lfgn6841I0SKZwyWUBqW6t2XU1DHQjwX9XPPhgtkVG75RMTL8M1DHbcPtufUV54BP18pJhLl3NZWTO/XyT5X33BGU9DQ6/qATSIykswhtcaBM9Ld+kR7zSRrxc5OJPjKZXH2uSkhU9vp+D7IKEdxaP9nOjaq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tD3GNvO7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso5585152f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014185; x=1746618985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRxmOkREDtNcYi3zS5d08yarRVufAZekuzgf6z5cgxM=;
        b=tD3GNvO7uBNyIi74rDd3aFQ6CDs8e051ZWkHn0DMjp6+jsbEVVFNLhSrXl1viCHdTr
         8JClVAkD9QkWlvMhgthT0AA4lK17ZTQ4izksZ5qVJbl4OrJfRDoj/MhL2CGYXCWYR5IE
         eJHrsDWdiVNkffUyTfKaFljxIW0Fc4+zk42saJCM07pUFdfNDUcQf3xqKLxSwzEWDjp5
         n7yQX/1vVxr/PgeKSLdnIOUU4dmpDOkGnS44SiIzvMor5RVlq2dxH/rSmUVGoaUWpV1I
         8/7zbAjtZFTzVVvLjWHGfWShToDCdPxjvTcirp+KyFfr1uX8e0uqT36gzIR6AWPqB2EZ
         ugqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014185; x=1746618985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRxmOkREDtNcYi3zS5d08yarRVufAZekuzgf6z5cgxM=;
        b=ZOcMP+imUq/RZp7JQf0GpNYlu+qIGQZ/RUMTenMr8Z/szj2lgNCihuw2jym6piKb7Q
         9MsTdeaw3N5V+OgTGm1KgrHGCRPwgCq/TBXR31hK450NZh4M7FR91XaqTVJvb0ZIr9MN
         H/pVnr3o2BnccW01DMDeRhFFPjQ5VdV0D8vpci/StFVLXWU2YjH2J2vnpP1YocML6RHc
         L9OLvWfc1MYEJnE29wNsrUKgjF0IvYT4zOblJSnYvWo5UEke3R9BxDnFyHv856fzLE8u
         1US5eFdgT5ALfgeOoRPiMTj6FqaNH6V76gpeXGaC8WHuhk1tCnzYOFeOavjHtYBCqdHo
         MtcA==
X-Gm-Message-State: AOJu0YxmNMOA1VdpPS/TvEd9er9coGeC8zqvuRD36jdaE3af8uI9ZErW
	Nx0vPembYwD0dk5mmhLrxg40+22g1kfelN7coMOSnHGsJZPDcf/iNtMDdoSjyv4iHeKdQaY8Lwd
	W
X-Gm-Gg: ASbGncvgLGa75LeZJuzBPtrmcdS97eBHCjpLNtdcoT1rZ73L54Lg9erhAk2T+7im64S
	cWEj8YtwgRPDCzHLD8TGmoVW2UJs5lTKhlXzybLhzVwrgp1GLUBNmtRZ1nloYpNubpoX2wiH3Vc
	DxvBgJ3dUuTVkj9KH1mJ1Wh1wiGcbUWjtfrio6NHkuJLbi0zqs4NmTCD/jWvMANOIe5yLUL8QBL
	27gJFJNKxO2rKXFZj0zIuE3ma47V32j76vcbnaQISigQJrvOtHLWzhCBGEoi6wFnCNkyJLQmOkA
	BoggCJ345Slqrb5h2BTATBO+AOhJR9DcHvGURhA9ivfZVodgrTvsoXXFqd4pcYdKa8VBBZTuaNq
	CJ2PQm/g=
X-Google-Smtp-Source: AGHT+IFyQST3rH0YuQYldPgvha6jikAYlv7DUnoof5VueESfC3/kHD0oJ3b0nyoh4FA/mTRr6s2cVw==
X-Received: by 2002:a05:6000:1844:b0:3a0:7faa:309d with SMTP id ffacd0b85a97d-3a08f7c8ecdmr1805907f8f.37.1746014184884;
        Wed, 30 Apr 2025 04:56:24 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cc4025sm17070285f8f.56.2025.04.30.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:56:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] pwm: Formally describe the procedure used to pick a hardware waveform setting
Date: Wed, 30 Apr 2025 13:56:00 +0200
Message-ID:  <d2916bfa70274961ded26b07ab6998c36b90e69a.1746010245.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2752; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=RjoEXSIkY3DqTEk4/M+XxiagMUMOfWsaQZWgGc6PuWc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhgwh/htfS9ZlvdrfbJkx37ufs2/D9FXxGzJzPIP6srx5k 3Zk777fyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEGrs5GFY+VLOcGVGw9/6k 9o18nTYnuQu1c9rUBaZa/Dy6Tr063XLlEkWDZfzFk2Rkvr0U7ZRMeO/dqL7W9fLH91crg8WmnPx WLWym/e1/dLHujujGFNbAT4FrZ8e2RGRsf+S4sye12orTOrb9tOc8iW13jHRjp3zeH7jGL183z2 HTpI0VgYk9rjOPJxo2+b1NN3gf1zitoWyZ3/NXtUE2Xpxn+Xc/dbT87mVxNqXbf8HKW27dkXdn3 BEMOFW/nz1u06+Tzu53rs/K4X3D68wSZiMlvr/67uGAfrn6eXJtqtLKEvVl35l+3S6q9pik8tHl cdIZrmW3Q3U1wp+faVrHVBdh+OHayQvrIn99Vra702IMAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This serves as specification for both, PWM consumers and the respective
callback for lowlevel drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5cf64b3a4cdf..4d842c692194 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -231,7 +231,9 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
  *
  * Usually all values passed in @wf are rounded down to the nearest possible
  * value (in the order period_length_ns, duty_length_ns and then
- * duty_offset_ns). Only if this isn't possible, a value might grow.
+ * duty_offset_ns). Only if this isn't possible, a value might grow. See the
+ * documentation for pwm_set_waveform_might_sleep() for a more formal
+ * description.
  *
  * Returns: 0 on success, 1 if at least one value had to be rounded up or a
  * negative errno.
@@ -411,6 +413,26 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
  * possible/needed. In the above example requesting .period_length_ns = 94 and
  * @exact = true, you get the hardware configured with period = 93.5 ns.
  *
+ * Let C be the set of possible hardware configurations for a given PWM device,
+ * consisting of tuples (p, d, o) where p is the period length, d is the duty
+ * length and o the duty offset.
+ *
+ * The following algorithm is implemented to pick the hardware setting
+ * (p, d, o) ∈ C for a given request (p', d', o') with @exact = false::
+ *
+ *   p = max( { ṗ | ∃ ḋ, ȯ : (ṗ, ḋ, ȯ) ∈ C ∧ ṗ ≤ p' } ∪ { min({ ṗ | ∃ ḋ, ȯ : (ṗ, ḋ, ȯ) ∈ C }) })
+ *   d = max( { ḋ | ∃ ȯ : (p, ḋ, ȯ) ∈ C ∧ ḋ ≤ d' } ∪ { min({ ḋ | ∃ ȯ : (p, ḋ, ȯ) ∈ C }) })
+ *   o = max( { ȯ | (p, d, ȯ) ∈ C ∧ ȯ ≤ o' } ∪ { min({ ȯ | (p, d, ȯ) ∈ C }) })
+ *
+ * In words: The chosen period length is the maximal possible period length not
+ * bigger than the requested period length and if that doesn't exist, the
+ * minimal period length. The chosen duty length is the maximal possible duty
+ * length that is compatible with the chosen period length and isn't bigger than
+ * the requested duty length. Again if such a value doesn't exist, the minimal
+ * duty length compatible with the chosen period is picked. After that the duty
+ * offset compatible with the chosen period and duty length is chosen in the
+ * same way.
+ *
  * Returns: 0 on success, -EDOM if setting failed due to the exact waveform not
  * being possible (if @exact), or a different negative errno on failure.
  * Context: May sleep.
-- 
2.47.2



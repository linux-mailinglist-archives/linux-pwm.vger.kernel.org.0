Return-Path: <linux-pwm+bounces-2584-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FF912800
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6991A1C25ADC
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52337708;
	Fri, 21 Jun 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qVT3l1D/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CA37147
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980665; cv=none; b=NotScf73ELZ3/R08yhyKVxiKdNc6p2pbA/KE0jkWgM/QgjlKabha63J3qRbC8rJyQZYSRFg6MfamiF2CTbgJyUBm4WTttV4nDtZd0MLMKrRPl5B/xz+qHv/UZ6TsAJPpYcSz0tcbt41VBE14AhgLAEuf2qi1/TxZ1Xglacb9EjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980665; c=relaxed/simple;
	bh=k1b/UZlBPcg27jJ13+cEn2qIvvv2MFL41xaIuM2GWOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcNErieo1KwgAcp5wXi/fhdbTcmOUBcG03MM5D6w4n9J2HQiM3/9/USOAl8lt/uEiAS3KZlXH1V3rsS94EUXY/BU5h8ph1m5Z4uhRFo6ImIS4Jf/ituuYDNGdpfdPksJS6QOvzRMBCM1GWRL5G78tL6VmWEa6re3GbBDBPWcaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qVT3l1D/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f09eaf420so240574966b.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718980662; x=1719585462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFQvBp09SYhqBXHYcpVbluB3rmpVFZWSPU/sKj+XFgQ=;
        b=qVT3l1D/CxJpMyv76Nm6radXioj0kfk3jqpWjuXiL1p7Xm6oJEMwksV4BJViWUSD/B
         r3c9DKvv/E29xxs+jBMomKtpIVmFJn0S49am6flN0XafOylM6pQyolIuP3VLm+RLUczG
         vxNQrPk/DtqmBWquR2AWG1ZeWNSaTTpOMNe6XJ5cXB6+Sp1u6jOpXagvVYgdkrutkgvi
         FM39uK5ERO299Aow6T+aK/NbomnceI6iv6+IbMjcFa6bOQj+EzfZFnDroWwBMvjC+9DE
         xiXGVmfYweZje17syEMSa4nsvWq6j+JMlR2wSDCP825MfByDxtBRl4qdgjlGIspZVXTk
         xdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980662; x=1719585462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFQvBp09SYhqBXHYcpVbluB3rmpVFZWSPU/sKj+XFgQ=;
        b=au4wieKJeFWesBYKb0LHNCUyDau9MWXGK8dt3JATREV8BdbzupLqEg0/1PA19dUXWx
         FMOUMlOsFgmB+/9SdC+PjfsUhQvpIhh4wRvsi1LMFFz8X9H0dF6+sIi7T5VVDaYtET6u
         Qg2+WPggC3TWLJQyiFZwtuVRnVRKS8s2xCE+zQXGhlM/sFpZkRD4we56L82TNibu2bwW
         4m/BBkhph9lRC4qzO6N/DKtzFn+swxRIKP+gnlGZm/Fii3tUi9tUb2zNzoLvJZh//6Qg
         21mVi186YY0IeRdMhsDO7zaE9w0HtPLey2WFHWm2S9tO2O/dQoPWd8WIjwNJAHDwMNkz
         27tQ==
X-Gm-Message-State: AOJu0Yw65Srib8yXAXf+T02/QcrlJmJvMG94KjgACFqVkKBnXKt21gkm
	QJ7r093uQhuFijfxqgh4xmTt+3FQchTIIx+yExiU0r9xEHrmVu+at7tAm3veDZyRzI8CTtH6jJm
	r
X-Google-Smtp-Source: AGHT+IHhBkbnDwe6DC78mHyYrZoTEMrk9luPtrCGS6uQpBAuAlhQcl4/FTWTW5gRCSAfgVzjizpaQA==
X-Received: by 2002:a17:906:fe4d:b0:a6f:4b7d:599b with SMTP id a640c23a62f3a-a6fab64869dmr667183566b.33.1718980661770;
        Fri, 21 Jun 2024 07:37:41 -0700 (PDT)
Received: from localhost (p5091583d.dip0.t-ipconnect.de. [80.145.88.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56ee06sm90550566b.198.2024.06.21.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:37:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 2/3] pwm: stm32: Fix calculation of prescaler
Date: Fri, 21 Jun 2024 16:37:13 +0200
Message-ID:  <b4d96b79917617434a540df45f20cb5de4142f88.1718979150.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
References: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=k1b/UZlBPcg27jJ13+cEn2qIvvv2MFL41xaIuM2GWOg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmdZAdj6nX78OTtkGgf+zjfTRynFlrjHnlSPFLB /sXRGO38cqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnWQHQAKCRCPgPtYfRL+ TpsPCACpUFVr/Itd1iZOgd/j4VQ1XonbgsnD5G7pim5yCA1J/WsMS8mS+NJSuUN83vBBSyk8uEp Jr5j0peLUzVb3MKp8PcSn19eXTfXnkitfvvr+UnJ4HzcKZkUp3jCDf4f+WlNZRM/ZCdHJqDafs1 PGPOGdY3A7h6VtZtSNn40D/sMD9n+bgcS4ZGELGa/mnOQ0seYBXqYyT941X8UpSK60KZHgNAjRp dOVhv184I2YtPmfJGMkDM1jvDqtcOn3u/2mY3UyhNzXS5yEc1cBbm7ljRofEEBG87rZ1c1/oloS wBhYOqRr2nZ0UpEDKNNMyvaaxLinCMBBY32VQkGyLHg45K94
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A small prescaler is beneficial, as this improves the resolution of the
duty_cycle configuration. However if the prescaler is too small, the
maximal possible period becomes considerably smaller than the requested
value.

One situation where this goes wrong is the following: With a parent
clock rate of 208877930 Hz and max_arr = 0xffff = 65535, a request for
period = 941243 ns currently results in PSC = 1. The value for ARR is
then calculated to

	ARR = 941243 * 208877930 / (1000000000 * 2) - 1 = 98301

This value is bigger than 65535 however and so doesn't fit into the
respective register field. In this particular case the PWM was
configured for a period of 313733.4806027616 ns (with ARR = 98301 &
0xffff). Even if ARR was configured to its maximal value, only period =
627495.6861167669 ns would be achievable.

Fix the calculation accordingly and adapt the comment to match the new
algorithm.

With the calculation fixed the above case results in PSC = 2 and so an
actual period of 941229.1667195285 ns.

Fixes: 8002fbeef1e4 ("pwm: stm32: Calculate prescaler with a division instead of a loop")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3e7b2a8e34e7..a7ff39e9fc28 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -321,17 +321,23 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	 * First we need to find the minimal value for prescaler such that
 	 *
 	 *        period_ns * clkrate
-	 *   ------------------------------
+	 *   ------------------------------ < max_arr + 1
 	 *   NSEC_PER_SEC * (prescaler + 1)
 	 *
-	 * isn't bigger than max_arr.
+	 * This equation is equivalent to
+	 *
+	 *        period_ns * clkrate
+	 *   ---------------------------- < prescaler + 1
+	 *   NSEC_PER_SEC * (max_arr + 1)
+	 *
+	 * Using integer division and knowing that the right hand side is
+	 * integer, this is further equivalent to
+	 *
+	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
 	 */
 
 	prescaler = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
-					(u64)NSEC_PER_SEC * priv->max_arr);
-	if (prescaler > 0)
-		prescaler -= 1;
-
+					(u64)NSEC_PER_SEC * (priv->max_arr + 1));
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
-- 
2.43.0



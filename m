Return-Path: <linux-pwm+bounces-2585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EC912802
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B774B25EDE
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE828DD1;
	Fri, 21 Jun 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PxSKkSbY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1A23769
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980667; cv=none; b=EmORjTXFQ0jewxmvfpHfqx+jQQAEt9P79HX2ClDg3T9IxX7979nvOnI0fZ/bXs29IS2e7+5kGj2xVv+GQ83hI5NAo35Td5tCZArogiWFh7y4hK8myTAhOzimMWXP1Mya03f38VRRiqJbwJgmIZrVIkBrK6DOhcB6KRoxgazuBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980667; c=relaxed/simple;
	bh=SfN1/kmbTsUXBRgADyC88RwGMUteJe+oranzSQBC5Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8tU1laL9+HSVJhj7fTTnCYRLkVKO++WbpMumGp1YgIkAlHJWs0bQ3sL/KwroRbDdveByiIrShTwnP3EK3u1iarP5N6kysOizhaEu/Cvcci5unZKf+DS9NzMVf/7I7hxXGPqw4rmX26ScCRz5bZhGrciKZ3P4QgQNDD2coHCQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PxSKkSbY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso30235531fa.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718980663; x=1719585463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysq3uDxdRX+lWPBKjGMKWeUw8FNy+OKaKwytbRkcytM=;
        b=PxSKkSbY8ujUZWdqZGE1iqmlJgvfYLqP285i/PShGUQH+K3qBbxnFkPDbFom2ugVAL
         1EcBI7SAVO/5C98KFdcBG/F6KTAWOZgNYNlXozTmzENjfruIYFv+DedJ3rKPubj2nRna
         +xudg9zHDq9rVzcwVIqeaUZi8s97lvpQpZjoaD2wwThlobJTc0X6nlt7H8n8ejCKIz3E
         5SM5RXt9JS5iPG0Hk2OYvPmR+tV5Lv7fevIuS75ZSQqgBM507zTg5FW+W3aEE5YNq09X
         QN6evdvByx6aD+OQqPML3vKa2OmH7XDRF9lwcWwixvtlNzkFII/1adlOwsKKdLoJmhM3
         hYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980663; x=1719585463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysq3uDxdRX+lWPBKjGMKWeUw8FNy+OKaKwytbRkcytM=;
        b=DTV9ioD3ds06/wFhPPiyZvqI3ocgGLn1Hn4ETXHb71XkmPv6k7d3CWgyZeyVIDMgXv
         neemfm33D4z9n1QvVyj/qVpJvsChBAFkK5ve4auqFi2RNRklaLbOOZZEPPasa30ONYKn
         o+7bao93LVW/l8+fRfABuQesMEaojQbJBANpC4jWkZlyhAkKBsGnqbcx/GEzVZ3lMVoJ
         XQ3k3JL/bqM4LNBpbdtH4oTQQxl4Xi6e4RDjEA3GuX6y/i6e0Wu+f/1u+qG0WSoUeQg5
         K9Rb8W+8glVpGYIwyMPBQMkqrbz17S3Efw/2bu0LyfGYpUyXIm0ot/cFU0bptIZBqcdr
         WsoA==
X-Gm-Message-State: AOJu0YzTcNUXmjWkfn09xsy+tDB9JdkTMu2oPdWUNHcO4ZqV9hXCMW2z
	FLrHP8PRobd6I8lu5dS8tmmZhejBLm16YrxAsb93PcZqH5pwee+IwI+ikBrI8pc=
X-Google-Smtp-Source: AGHT+IFLJYSC6FgjmimkqI552OEyvALn0atKDFSRu4RIfBpKfbrvs9j00kDHZDdQpT6hofjonr2dCw==
X-Received: by 2002:a2e:860e:0:b0:2eb:d963:d8cc with SMTP id 38308e7fff4ca-2ec3cffc54dmr66022471fa.49.1718980663095;
        Fri, 21 Jun 2024 07:37:43 -0700 (PDT)
Received: from localhost (p5091583d.dip0.t-ipconnect.de. [80.145.88.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560632sm89872266b.160.2024.06.21.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:37:42 -0700 (PDT)
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
Subject: [PATCH v2 3/3] pwm: stm32: Fix error message to not describe the previous error path
Date: Fri, 21 Jun 2024 16:37:14 +0200
Message-ID:  <285182163211203fc823a65b180761f46e828dcb.1718979150.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SfN1/kmbTsUXBRgADyC88RwGMUteJe+oranzSQBC5Fk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmdZAfb+L0dKnD/968LLQzw7aJDYzoGaDBtRJAB NS3vUyhQRCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnWQHwAKCRCPgPtYfRL+ TpYoCACUHHNFQz4vsijVkCs9ya+JpnFPamzXqQOcAYtZspgBby/vtiTojF3PA+ZxfJwj7G430Jx 9ifJDujnDwnuPMbRfJFgXPJomcN5p3Ijc7iSJ2ToVfDkY4T9MUjYbl5Kzff22KmeOj0IfCOEpl4 4uoU9zsubXjvbpq5G/MnS7CnM7DJP3j8wE7icIh2aOMHqkCsDT36QAKpUAzhlyJdmJW2Lvhm51+ wn+O4Q4fa8z6CtH8UuaWMugsrFsJ6AXsA5PqGjVq0v0dFeE4Ava0FCLo1QwXh6zxhnXYXWawKlt 4MHbZtWkTvogh8CUvJ77vCWrdOkRqtuYrmTkH5dsC7khnrSK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

"Failed to lock the clock" is an appropriate error message for
clk_rate_exclusive_get() failing, but not for the clock running too
fast for the driver's calculations.

Adapt the error message accordingly.

Fixes: d44d635635a7 ("pwm: stm32: Fix for settings using period > UINT32_MAX")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a7ff39e9fc28..bc32e9abf2b1 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -681,7 +681,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	 * .apply() won't overflow.
 	 */
 	if (clk_get_rate(priv->clk) > 1000000000)
-		return dev_err_probe(dev, -EINVAL, "Failed to lock clock\n");
+		return dev_err_probe(dev, -EINVAL, "Clock freq too high (%lu)\n",
+				     clk_get_rate(priv->clk));
 
 	chip->ops = &stm32pwm_ops;
 
-- 
2.43.0



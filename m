Return-Path: <linux-pwm+bounces-5399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E216FA822F7
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25331BA1001
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80361DF99C;
	Wed,  9 Apr 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwlvHVZo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881717A312
	for <linux-pwm@vger.kernel.org>; Wed,  9 Apr 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196427; cv=none; b=arWnupM4oAN2kp5ahr+ukbDdqK5BoQpJdpcSKhAcqIRE4VLCs3GS+V0mNuN/9gd5JNAEVaG76yRb79f5F44hbh+Qo9jwV4w9TIqYyMyQoxBXET319GszaBM1k9exw0+yWZvTdiR6W2MhSiPd+fYUJzWbN0W5v8qblN96xnxR/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196427; c=relaxed/simple;
	bh=TXbbF1zjZi8YpyEwLeqY6OJ4Ffj6+deknefbHUzUNHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bQiq2PDy0zKaG3uZre4YqIhPqMslYy7jvJmOh6GoUMYOb2kpsuRfWC7R7w4Kh5M0rmGS1sGVPtbM2zdW5asfL0PBV7B3JI9mnrkHMYLkUWOK8g1Kfws6atRL8IlJDvtGqHfe1X4osL8Uy7a0XH/fWRTWdyau6DN+EvdO718AGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PwlvHVZo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf848528aso51605775e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2025 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744196424; x=1744801224; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbiuDHdVeIa3R6A3S/AmU2DqX1Wn9eEzl5pawdchrAM=;
        b=PwlvHVZoEUn0//wun9PYY3aH2bH+feMOEPMOZJIwh2Uz8QlArr8qKLhKwMnnJA1wt7
         Gr/VNcDzkDD12AumaK3gVIPAaAFhLTefHTL/aMivkWCqOCd25EXACSMJoj9SwELsHG5s
         4xdzTTW/B63aC8otcEDZ/y85E8XpyEMVd9orIMELijo0d90aYnQBxJNNS6gMSZsbfo+v
         wWih4mk8r/5FaFwEugAGeRQ0Yp7fpEDoedsGrbOn3c7IMn18plBzlyNSEOcobI++8W3f
         41oovLQ/0TjPYYXoVzMf4KnysHssba6mmTDK4ucy/BbMbG9MO8sqdhIiLQ0V/OLzUdHV
         ddvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196424; x=1744801224;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbiuDHdVeIa3R6A3S/AmU2DqX1Wn9eEzl5pawdchrAM=;
        b=OkaCC4po43qytgQvBnQDGCoQ2mLVlZ3+pCfQPUUPGEQV8XHiKTIwaA62W+Oy7cnuwY
         7Z5mhsH3WnyWl1QDepJRGoCbot072GjmzE4CTZKbuO14MVm8WjxvPX/5m2pLU81KMqRe
         derU06I5wbqwNmeLi6oxaRG3gYHSSQJRkOYBi/pe2iHrDai1PCzPtpxnX/2kUCSMUpOi
         Dj7Myrj0V1Bl4hezExmcMpzR/a0edeXpVdlD0XueN8fEj7CjBInnC2UxfuLGxLahtpYd
         AyHcmmaSJSKjL8hCY8bHV7ou3EWGtTZhbpAi3R9whWt9ufcOIw21RyKiUwz0pEo1LJFC
         J+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnaDxsP3nU9RTRcYMMtNIEj/fnnEbAOZm3czHgLNUJsCrDDI0cCpaGTkA1WJoPSLAfTN0Gcuf91Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi29v94Dl1GigLl8ylAk5ByGeeb2dSRxlMikQr59c0PlLyIoXv
	thInpAs7OeTRAOAi35rAuBBti+g4ENMvoWPIv4//ELfTKSGsqMHTF0FLW++c35E=
X-Gm-Gg: ASbGncvgAo/6YujdF55/WOZk9TH2mtEWATaqZC2aGq1Ln9rxS5w6JOMTP87XwkdKt7o
	N2XS2W0mR6JXC0i3PJ+DEKLpPVb1M3nr8noFfyuEf/bi93fkfXLvq6n6OUZETuPk0P2akffSkE2
	ZUHQyNBCnexhULxfnPSegu5IQjbyVyIxWcRTKejO9ZDWjzJr0CTTvXj61R4cVorS41KCFrsgjIi
	5dQRP2mcafVhxeJ8Dos0uI42DcdIM4/jMG005zhMyN1MlKFChQOMbRt4vhZxzJltqR6/BIl5QRc
	QWpI2Uav5ivh3T1TPDGvnbDAm576XOZzcXkO7x4bTHjHpLpar7oA4zDs
X-Google-Smtp-Source: AGHT+IEMjvJRXwtECocC18o7I7YJL0m4T21SAiMp4ugNPg39UK5Hf4bTJoM5nx1QtVGbXPOR2J/7dw==
X-Received: by 2002:a5d:5c84:0:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39d87ab92bamr2196525f8f.33.1744196424413;
        Wed, 09 Apr 2025 04:00:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d893611d0sm1278591f8f.6.2025.04.09.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:00:24 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:00:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pwm: loongson: Fix an error code in probe()
Message-ID: <6965a480-745c-426f-b17b-e96af532578f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug so we accidentally returned
PTR_ERR(ddata->clk) instead of "ret".

Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pwm/pwm-loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 412c67739ef9..e31afb11ddd7 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -211,7 +211,7 @@ static int pwm_loongson_probe(struct platform_device *pdev)
 	if (ddata->clk) {
 		ret = devm_clk_rate_exclusive_get(dev, ddata->clk);
 		if (ret)
-			return dev_err_probe(dev, PTR_ERR(ddata->clk),
+			return dev_err_probe(dev, ret,
 					     "Failed to get exclusive rate\n");
 
 		ddata->clk_rate = clk_get_rate(ddata->clk);
-- 
2.47.2



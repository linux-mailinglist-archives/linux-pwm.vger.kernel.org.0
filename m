Return-Path: <linux-pwm+bounces-4757-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D811AA25414
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5861881EC5
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C7214811;
	Mon,  3 Feb 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i3apWOqL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4122147FC
	for <linux-pwm@vger.kernel.org>; Mon,  3 Feb 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570389; cv=none; b=aX+CFKm1+j3kAQEW2PFI2BSPtr9Jt+jxX+QiKEGE0ShAQzG4JcBZu+H6ULKAGL/19hFRWNr5b/23xcKe/o57Nk0WAMiDkhS5nIKvNdGE2XDE7UnLEr3ocwuyXv6qjJa6MQHGgsUiwvKXavk7RbaXILroGwbsAPRBLsoamik4HF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570389; c=relaxed/simple;
	bh=8BzrjfzW6hMDq8JMBmAHvHJ/8jbUh41Fukiv4MAQV0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV265j6OrAwzw3uMyyfT1mEB8yfEc8o85obEvWPn3rRgDBeQp+KLWJjF3PfLL2aeagG7GnzibArG5RyqpX/E61Ep8Hssp6wRe5UffukORE/nVDNz2t0is0eruf3YeUxU0oTMYYyr/wA6ln9uWvDqzj4N2DDEcit3VjzYT1/qPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i3apWOqL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863c36a731so3174937f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 03 Feb 2025 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738570385; x=1739175185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IIA2EevMgnUnT2y0Tcftlgxz2rZdSe6sO6t8T4gDhc=;
        b=i3apWOqLHYC6bL1RzMegFXJE7HYUYkRMcGjbc90X9vOytR7yAWZxhKFnu6pjVbUb59
         JdocnU8BZZbfxuyxu9WMB/QBikj2BDJjt8dhXeqKy+ztRVfLejhJiU2BnHxVHbYgE82+
         asDluLlVVwMVUGL0daoY0HSiyJAj+LINHn43NvO0UUdiDlHfoP5DKo/2JEvmE8ymgzyr
         Xx5OnLRx2RBbBBi1RWQyEVD93Yv9fj/qichojPCL0f/+Gru0mdEwxwx00UbTGgjJMUTr
         bfSDXCagosr/BeMCs+R1UrWSXFztVusqTOqMqY7CfpxO26FTZ4tAQ1ubKlaSIhC0gsKF
         yO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570385; x=1739175185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IIA2EevMgnUnT2y0Tcftlgxz2rZdSe6sO6t8T4gDhc=;
        b=OLVZ2jgh0ratSisUC6pmcrOQwwMSCAJ7igaQlEP6KGDsGX+JbCknQ6El5yO0IZeKpU
         xKZwbDgRrRhKAhrKlbPmNzLTvapPJVDVCZw7wIIvmKSFebAphkDPEqsEAa8xgfe/fOUp
         wb4otMHkz3L+AQsbnrkVlNOEI1B5P6PIZ5B3v1or+YPprfCfVXMpgGV6+hLx5kUI4Mdx
         Q2TOTtj5B9V8yc/u3SpbhQJU3/LeKKjSMvOVTb51/XqDY7eZ4x66u7S18L7qIs3Yq7jA
         Cy9jL/EX3YBOiXZLJYCs6QBCwC8CmWaNyWDaPxE9M2m3mElnOTBX7DTLXjNEu087trjb
         vXtA==
X-Forwarded-Encrypted: i=1; AJvYcCX2zY5xLy6h02/kEAg1PoD9dO3kzkTcSK5xMMvxebVmV95+pkZFsvIq/NwJhNNz0DwAEOq++DnJa0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUhFZG4+XQ6obor2VbstmkbPDUctAkb/dHBKF2khInJmvmfun
	sfDnL7o6sEcOH+mn9dqv94uSIxPd1JtaS3cb/LMINmPLtniynkyZfP3Lq19C23w=
X-Gm-Gg: ASbGncsSYIWBsmC+B65fCRmaViVIFr87ga5avAziVbif+8hfWNDOFgwpAAQg0GOisYz
	hDqchU245xXZ/BefwG1jW0J0SpSioWXVJDHBzaGVIsAi6y3oxDVwET/4Vl5OxN5PxhrAO17Et+t
	o6ASovtxeMq6UcL+usJIPQ1lVJ3qz5NBnIK7xTKRCoh2a0/UNFnuAEhG8eqEcgpt96aiTEzHejy
	VlWgE2Tx+Qkp1zxog4o+0Y0XaGxtDLenYv9zEjYoWf79frzoY5dm4QqrCTX4XeAYUdw/xDOMxeE
	Nz0zmOO2rIzYpA==
X-Google-Smtp-Source: AGHT+IF3lNNZmS2B9T8gXfcE5kd5EuOjnSuh3iWUdY1d50Algj3kP3sHpQaRcW0lvgZf4+fEDGkUsw==
X-Received: by 2002:a05:6000:18a9:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38c51b5efb4mr18533137f8f.25.1738570385202;
        Mon, 03 Feb 2025 00:13:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:62d7:938e:c76:df44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b574fsm12019825f8f.70.2025.02.03.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 00:13:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	patches@opensource.cirrus.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: Use str_enable_disable-like helpers
Date: Mon,  3 Feb 2025 09:13:02 +0100
Message-ID: <173857038027.20723.17081473974273068659.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
References: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 14 Jan 2025 20:14:38 +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Applied, thanks!

[1/1] gpio: Use str_enable_disable-like helpers
      commit: de454ac4fc5a117a4264e8bdf60fca58021574b1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-pwm+bounces-489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D980C22C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 08:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C401F20EC4
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AE208A8;
	Mon, 11 Dec 2023 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaKMIsdS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FA911D
	for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 23:42:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cb20b965dbso34834651fa.1
        for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 23:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280530; x=1702885330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wKKZxDmRdHJfZg5vgJP9rGg6SAla387qKCYSstr8Kc=;
        b=YaKMIsdStTqdVebCXALV2nhdJ97QevgAtygQN8L9JsR+Pu2XoqY/X02wIQRPWH8XgK
         2oDFTKvGfewKBmLUCPlqysMZGhHHSAc28RQDvf+7rIO5OLKaozy37D/6HUoBiKRy5Y04
         X2D5C37EkVUc4uiGg+vZ+LwIB3POVK3LFrcNjg4gZqkVhkPpiKOWsh8KYXU41dWk9+qV
         HGV1OrsCSCEKFvXYjQUMH+FcQvNcccgys17xFyL8HUi/PplSnA+oHgSmzsFhuWDFJoKc
         agn2lY7SfhYvkVQnoDBe+9qByueHW+AeLmKmNiPezN6szQA0wsn0aLHF+asx9q4NYjI0
         5U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280530; x=1702885330;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wKKZxDmRdHJfZg5vgJP9rGg6SAla387qKCYSstr8Kc=;
        b=JWEDgZKY+QphKZN0avVwAkIfEe25xGIoNRd9OXVxZGZfyFLCUzV/pIWG9etYs3Ekht
         MXC21pp+B2AIpVgx0ajyOH/hWXIdxDQvEZmsBQ8P4HkR6zbKTl/YPo7ltwzSAA+mN0NZ
         J8eO6NIkM742TxwGzmAAXW05uYs0EXVdVuKsmgG8484qr8hdclhPNW2O0spI7/iJ6TJ8
         42bFrc4IixVPZA2xgWqMaU+fwn0ZfQxsBdcqb2nlJdiVFQX+dQ4/Snj0CvBznMFC5Kda
         i+lcJf0XPCSqmH9bxUDrCs4ozU3mhacgP1cSwiZaUqv2DQ6VCdRDJh1HfdD80P5MigHV
         AnVg==
X-Gm-Message-State: AOJu0YwvS/ZZNNbOAH0fEsgcQvfj62QrRr+MVyjz/eatdUZPBEAAXVJP
	vSR7TkPIQZh6nhVhX4EOmQe2zA==
X-Google-Smtp-Source: AGHT+IHrYWva0hhXwHNZ3bFsYGJLX8JxJFGhEdf2mByN3FJTQFZBPEd4cfcnGG/i7DGktj7oYGPqaA==
X-Received: by 2002:a2e:711:0:b0:2cc:1e7b:3612 with SMTP id 17-20020a2e0711000000b002cc1e7b3612mr329330ljh.65.1702280530479;
        Sun, 10 Dec 2023 23:42:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1116269ljo.65.2023.12.10.23.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-serial@vger.kernel.org
In-Reply-To: <20231208074527.50840-2-jaewon02.kim@samsung.com>
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p25f18d225f91f185085078461b290cb19@epcas2p2.samsung.com>
 <20231208074527.50840-2-jaewon02.kim@samsung.com>
Subject: Re: (subset) [PATCH v3 1/4] arm64: dts: exynos: add initial
 support for exynosautov920 SoC
Message-Id: <170228052808.12030.1188300498236704832.b4-ty@linaro.org>
Date: Mon, 11 Dec 2023 08:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 08 Dec 2023 16:45:24 +0900, Jaewon Kim wrote:
> Samsung ExynosAutov920 is ARMv8-based automotive-oriented SoC.
> It has AE(Automotive Enhanced) IPs for safety.
>  * Cortex-A78AE 10-cores
>  * GIC-600AE
> 
> This is minimal support for ExynosAutov920 SoC.
>  * Enumerate all pinctrl nodes
>  * Enable Chip-Id
>  * Serial0 for console
>  * PWM
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: exynos: add initial support for exynosautov920 SoC
      https://git.kernel.org/krzk/linux/c/c96dab1993d247b7b05ba2fdef8f185cbbd5454e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



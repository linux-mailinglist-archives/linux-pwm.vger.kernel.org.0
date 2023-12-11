Return-Path: <linux-pwm+bounces-490-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C080C234
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985DF280DB2
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E86208D4;
	Mon, 11 Dec 2023 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxAerYNe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878F197
	for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 23:42:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2cb54ab7ffeso17129021fa.3
        for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 23:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280533; x=1702885333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isEx4Px7vt9AwtBEcan27JIxTrceu09splFCoGA5dbc=;
        b=JxAerYNedVKcQNQpdXIHjtbelWHmxlKTWNOGHnx/hPSVzWWYSB3N8zYxpbNom2mBYP
         2fqhQ5UG9zEZLJ2WL8Q02Udmqq7dSz8j0iFa7n8+m4Y/xdRsDcyDlXRHjXR1JKSQlT21
         b27yTZsSTH9OcjCpi1ecybMdNzHm7mNxkgXGp1sAPSZ0wgVEWxTnSXU8Djp3zXxrk688
         AKB7Ru7Gs+IBj/s4F5w1c5/VzBn9aNGVahwrRq3M4cOrkDK13NBauMD2/so5PkK0ZFlv
         pdEq+oZz/oMP5WfSUKPFCnp8ctuJJsUdK5U9VBTEDu5BTRGTwKaM8AjRuoMSgkb3MM4l
         L3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280533; x=1702885333;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isEx4Px7vt9AwtBEcan27JIxTrceu09splFCoGA5dbc=;
        b=ZKH7lEfJT2gQGBmZm66vS0NcJUdzH3ALpbOxULpcIY0hmfxCPRLRCyk+tTW7MKNrpH
         CBCh9i2l9TlrJtZzdUgKDvbQ8OiI5ywzHgYU01J92hh2OBVE9Lg/C1EaZv5ivaAT5WaE
         4IRsxTzL3jgAc/ayMyly2L0eHaRO3aa8BURrIg0ys1hHiXc06utnPyYVomLodim067J0
         J4w5tv5N6CHu7ph5ESk7ONdLQFu3WOcUyksIU+jmzBA5e0c9Mo2ZK9o7xteV4ObjKKh7
         s/Mit246ewgSoaS63GCVS8Dj87I5TMvFA2UbgFwm317O6s7LkPZxOdRdqsCGeFrftYRB
         eFAA==
X-Gm-Message-State: AOJu0Yy5qv8OwFDb1pyfj5ik8qTUtEANLwJQkcsseGVomeIpG7tD+auD
	BrbQC3W3dPEwpjwiJ7418ReA/A==
X-Google-Smtp-Source: AGHT+IFNI74+YNQA3KSvGpKhUuTNU4PHfmLowVWnfUrcsdiQP4p/loRDXs+lYzLROz+4aagaMI7FQQ==
X-Received: by 2002:a2e:be21:0:b0:2cb:2b42:6d68 with SMTP id z33-20020a2ebe21000000b002cb2b426d68mr1342157ljq.4.1702280532766;
        Sun, 10 Dec 2023 23:42:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1116269ljo.65.2023.12.10.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:12 -0800 (PST)
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
In-Reply-To: <20231208074527.50840-3-jaewon02.kim@samsung.com>
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p30e46ea65e921664930b337510461892f@epcas2p3.samsung.com>
 <20231208074527.50840-3-jaewon02.kim@samsung.com>
Subject: Re: (subset) [PATCH v3 2/4] arm64: dts: exynos: add minimal
 support for exynosautov920 sadk board
Message-Id: <170228053058.12030.17311728279876504581.b4-ty@linaro.org>
Date: Mon, 11 Dec 2023 08:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 08 Dec 2023 16:45:25 +0900, Jaewon Kim wrote:
> ExynosAutov920 SADK is ExynosAutov920 SoC based SADK(Samsung Automotive
> Development Kit) board. It has 16GB(8GB + 8GB) LPDDR5 RAM and 256GB
> (128GB + 128GB) UFS.
> 
> This is minimal support board device-tree.
>  * Serial console
>  * GPIO Key
>  * PWM FAN
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: exynos: add minimal support for exynosautov920 sadk board
      https://git.kernel.org/krzk/linux/c/57de428eaca2b9af1a35df96c7adcad4b5ea79f9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



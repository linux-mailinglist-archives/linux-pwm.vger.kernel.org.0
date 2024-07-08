Return-Path: <linux-pwm+bounces-2727-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2192A378
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A9282A02
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D21386A7;
	Mon,  8 Jul 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pGcuOlP+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B342AF05
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444275; cv=none; b=BhIkXdFZxsZ+VrX8iM4U8LUKqxijsKzhjfZimFLt2tSbO9g6B5t73oWSwwLZDO1dE4Tk7BtwxV4g9LvofPg8VTmkT4i9FgFc8wDW1Tm/Mmmm33G8WwnUdKgf8BbInHgrXYEqC7ka1OrKlBTNETCC+sK4uQfpSjX7NB/pDUpqd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444275; c=relaxed/simple;
	bh=43iu9VAQ2RThVpFeiQ7MYTF+C24gcOSups8k1KeCHjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m6LQaACK7fSYnmzUt0Sjppt0p/oFCGDnGTRg3hRK2YWpdQs773EWYuctYvKqMnqiUTF1kk5F13OP/4ed/TbFx9oYwPMsRObH33Qesz6LgwzTDlDiA82Lx6zqLqYIW1ygHiU0mKj8Wq6zDZCeaETfs7nwRL0bHKiFQkyaU3wTvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pGcuOlP+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso26453075e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720444271; x=1721049071; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuWHS7n4JKE4Zhnq2fHCrq3JBbmX9LHIbWotNtCmupg=;
        b=pGcuOlP+He3OtTqcRN4rrRHDUTiDH/o0uEq5Er3e9s1qUuRZ7u0gp1zG4fCjxubqAq
         PiN6Tt92b4Md+pN8DeMKpBSDGItAWgvIYz9q2O+wIeYq++GdoCXz4sd5S6jC0HHSE8ZD
         zc5wTBPIx/Q28XipQC6pWwkJ1ysrfZR8+58N5b4Hra9UIhAPpJM4IC7CRhQzhT6g6dfa
         mA/xVwUWvvcyjbQ8bJmJZ2FK++cSIEA+CGe3x5Y2ICXHOXbXm8ux7TOLS+to2Obq5/Nz
         IziUwp876ZhkoO/D8d8UV+I/EpUFfmUWLIis8jM5Q0nZv5UFjXyPaPV0Ocz7fUgACA5R
         I+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720444271; x=1721049071;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuWHS7n4JKE4Zhnq2fHCrq3JBbmX9LHIbWotNtCmupg=;
        b=JypZN98b2WeK6G3DQ2lboz+bAXESFncbOyo1BqDXefQneqylTCdRxnP5YywZq/PVtS
         tXDrWmuabXtiiEGzcnaURNaFThqaaxhu0JG8eBrA6YCeHwNQZVKsFCU08Tn3Lwwe0lMF
         Pb6tX7J/PnuMUSBSAJJCpmHWvftd8NDEYiHC3i3i9m+U6pxrBtDPFbMT5pTAC3zLH0UP
         lzBaikJS4BkovML4ywfrXSNZnH61iZ03rzN683XY1AOJ5qRtSPh+NVQhYCxwZyU2Ier8
         SU9JiLzolSpFtiXOYyB3nsLC5vW5Ryw++3R39/kH5Zkpasx5lHeHypyIxetWXk6xqijD
         9n+A==
X-Forwarded-Encrypted: i=1; AJvYcCXP/YaAikWV0V/6vpiqc0q9xtTVt6gRK44IxPlLyYsO3x4ooVeE0l0hw0jozuLBrWPJ3rSlL4L3JeZS/TVGroqkPUAtE19KZi7s
X-Gm-Message-State: AOJu0YyYBJDexMOcZ/0Z65hYsYxOQ29QaG7OQaxH8lPcRq1m8pq8OuVt
	XdIm6t60TDzb5ws8wIY29zZF6+J8iCDfTyrJASAWPjw2v4lr4UYh+VNNJb4CbJY=
X-Google-Smtp-Source: AGHT+IG3y3s2abTIzMduavSusGk41h4eUyyiMJrCpnEXNNbVBBrdn+KPAsoARDJOB2DmaMtozMzthw==
X-Received: by 2002:a05:600c:4da3:b0:426:6eac:8314 with SMTP id 5b1f17b1804b1-4266eac83bfmr5970605e9.1.1720444270774;
        Mon, 08 Jul 2024 06:11:10 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5158:f510:c35c:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cb57sm163660395e9.21.2024.07.08.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:11:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: <ukleinek@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <neil.armstrong@linaro.org>,
  <khilman@baylibre.com>,  <martin.blumenstingl@googlemail.com>,
  <hkallweit1@gmail.com>,  <linux-pwm@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <kernel@salutedevices.com>,  Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
In-Reply-To: <20240702123425.584610-2-gnstark@salutedevices.com> (George
	Stark's message of "Tue, 2 Jul 2024 15:34:24 +0300")
References: <20240702123425.584610-1-gnstark@salutedevices.com>
	<20240702123425.584610-2-gnstark@salutedevices.com>
Date: Mon, 08 Jul 2024 15:11:09 +0200
Message-ID: <1j8qychvv6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 02 Jul 2024 at 15:34, George Stark <gnstark@salutedevices.com> wrote:

> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 1d71d4f8f328..e021cf59421a 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -37,6 +37,10 @@ properties:
>        - enum:
>            - amlogic,meson8-pwm-v2
>            - amlogic,meson-s4-pwm
> +      - items:
> +          - enum:
> +              - amlogic,meson-a1-pwm
> +          - const: amlogic,meson-s4-pwm
>        - items:
>            - enum:
>                - amlogic,meson8b-pwm-v2
> @@ -56,6 +60,9 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  power-domains:
> +    maxItems: 1
> +

The change is not only introducing a1 compatibility but also allowing a
power-domain for the other SoC, even if optional.

If that is intended, it should be stated in the description and probably
a separate change.

>    "#pwm-cells":
>      const: 3
>  
> @@ -136,6 +143,16 @@ allOf:
>        required:
>          - clocks
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson-a1-pwm
> +    then:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
>  
>  examples:

-- 
Jerome


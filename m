Return-Path: <linux-pwm+bounces-2331-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF28FA869
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 04:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30702B21D8D
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DB13D287;
	Tue,  4 Jun 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOgOuUAK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DE2AD04;
	Tue,  4 Jun 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717469507; cv=none; b=OBPQokWf5kg06gD69y6QBEfj/iG6C9AVKvi0ipeWRJaMUIrkCCV6/RCA/sdd3evnP7m505LGBnosmP2C8b3mZnG0fSDtX9yB2QejlUsVJbKuQB2w0wcK2wA/ILKEC40e10I00UokYOfZ+fwCQJhydBekypkCUW/P4zM6DjnK4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717469507; c=relaxed/simple;
	bh=RFkFNytbTrSt10Sfcqzgywulj5B4WbtJRMGMorXi1tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY63RRF6zUVYMXs5DaN+GgzI92IA9q/BvksiJtTKX19+TxNb5HUGfcmtdsXdcK5yPWf5Ke6sSTPhbEERbgK3lCmDA8g2Mdp3XxeXqCw0Gc1HIsJd4n0mP9qTRFqCJSHwO/Os7OvK7Um63nwz1WVEek/b4rhZse9jwaEQJdAadJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOgOuUAK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f62217f806so43220475ad.2;
        Mon, 03 Jun 2024 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717469506; x=1718074306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukY2v50UmUW2giWf10iPuYV8wPVIkj789dy6zfBNda0=;
        b=iOgOuUAKXFRqqphC7D/9LCpXn9+SfZL7l24Gg5xiCgxxVI5NoIjjUTkxxH9+JS8fZC
         NrUU3Fjq2x1kbz3jWhhvi2ArvXSzv22cDMEWWfCvluY61KCS29BgAMOuj0rjawULGuME
         tufYykEKcChJJNhpRLZK9ovTq4BenE86zhs0W7qjKL6kotfa7eQZjW8e95p4juUz3waH
         V7Iza8cbSQGWyjzibIGdgEppIg0IVEatcg9/DPg8Tqn/Fvj6tEH5fsdg2h8Pq3XA5rZb
         w/jUsWEg4HP9f2cSq4E+/ThyYAOQ7V25TIAiWe6bh3RydVF9iRDe3BDe2IfgUAZLcaVC
         JeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717469506; x=1718074306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukY2v50UmUW2giWf10iPuYV8wPVIkj789dy6zfBNda0=;
        b=FHPv/3Y0+2wHlDKgw3m9TfCgnAfTv+2y4xePecIOVcnM0yPVs78VJdbqD5i7QULirl
         TrxhMKzP9lqB23dONdou/rK3PAtAK9f9oM9ETTSFtRYl7xlR3MTolzzZJrLpzxVkSMA8
         QKoRlY0JIalSXrwx00Gt65na1SKbyOCQ+O0G6OooGwcYHGiSFCRWWEVCTcgx67LpaVsW
         dxKeA3hGboUGPfaHINwKWLpmgineyYHi/SJvrodTfEIGKMlZKfeGWwDbQkPb9rMFJokd
         0foMcU1IMVRDq0uWm+wQwTt9gwptufcLc0MZNeMZOmk6un92erzAV8H8MZ94kAWBGDvw
         eqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9bSIOnolN5nZY/yrPBNkub1lwbI37gm6XDk7EeJobCk81VqGCyXNUo8KvwKi4mcOUuvBaFcVJUrIAWm23ycObuvuX1ld9HnAdMkc/UKXuk+g5GSxp5ZnpM4WJV7Xcq4GOvF2NThq3IarcH0nAUdEV8wRw+p3dq8CFDZu9s1smFA=
X-Gm-Message-State: AOJu0YyHFFYtIR40molVp44JU28TPm3sFGnmsZhgNdPhLh2JPZ6ihzf9
	U1NdN3lPq9qJp+PKUgGxwgXB/etnhRmfordI9T7c765ORBUVrC0m
X-Google-Smtp-Source: AGHT+IHrZGPs74xrOoOyd9Wtl8I9QYEtdEDI6MqoNRDik2J6OrQBo9JTpfCDGP9JjX7c8xjF77d4/A==
X-Received: by 2002:a17:902:dacf:b0:1f4:f1dd:5b5 with SMTP id d9443c01a7336-1f636fec42fmr159518975ad.20.1717469505660;
        Mon, 03 Jun 2024 19:51:45 -0700 (PDT)
Received: from rigel (14-203-42-154.tpgi.com.au. [14.203.42.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241f76fsm71937725ad.307.2024.06.03.19.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 19:51:45 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:51:37 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240604025137.GA107618@rigel>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>

On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>
> Add bindings for PWM modulated by GPIO.
>

Shouldn't the bindings be added after the driver?

> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml          | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> new file mode 100644
> index 000000000000..1a1281e0fbd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic software PWM for modulating GPIOs
> +
> +maintainers:
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: pwm-gpio
> +
> +  "#pwm-cells":
> +    const: 3
> +

What is the significance of the 3 here?

Sorry if that is obvious, but it isn't to me.

Cheers,
Kent.

> +  gpios:
> +    description:
> +      GPIO to be modulated
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pwm {
> +        #pwm-cells = <3>;
> +        compatible = "pwm-gpio";
> +        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> +    };
>
> --
> 2.45.1
>


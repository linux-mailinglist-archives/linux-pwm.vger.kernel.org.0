Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1AF0871
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 22:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfKEVdW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 16:33:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41850 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEVdW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 16:33:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so18954160oty.8;
        Tue, 05 Nov 2019 13:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zsmPSGfU4VIabCEcquyi1hsnRpNdKZ9P9UXPGbIVCSk=;
        b=IPMZoMqyQUUqFkVlMnw3JnVIPWM9K6QoD9LrzfQ+7A9sM97v8ahGnUOuFfde+7hWGd
         RzPOR9JgCRwPJ1Y78wFs5d+Gf/gMrKkMY8zgzgmI0oupvVC6zcQqBHqJN+eC2YwN24gE
         BEp5r1P7dfrjMmaY7r8m/ngPmPq8rOYTjjFsIJ/YiLRGxHzXZTUU+ELG7i+y+Z9jSnIp
         1KZsdPi0Nfom2e9hmN9pgSmUtX1i7isuaygSFc6BsTvFCiJoz1u8dPyU2fiGTH2H4F4d
         qJwxEOd/EMLePFBPPqUbs8GTnsZxK/eNh9vL3sUObpMQAFfNUQQRz+TWarSJuSIHyzZt
         1xpA==
X-Gm-Message-State: APjAAAU/hcC11WJSpyo6o9WcpqNgKQti9Kb6mA9DIGZXIlvfUyfUX2t9
        fFLPlqLXKUjKIyDMXYU0FQ==
X-Google-Smtp-Source: APXvYqyuA6gQZu8HaSbrJ5/20jXgGV+3XUqpkaSV9Wbbgx/bbOF724lg2zbaq9jCmndj046bD68/WQ==
X-Received: by 2002:a9d:7441:: with SMTP id p1mr9387956otk.87.1572989601214;
        Tue, 05 Nov 2019 13:33:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm238414oti.49.2019.11.05.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:33:20 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:33:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        'Uwe =?iso-8859-1?Q?Kleine-K=F6nig'?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191105213319.GA30538@bogus>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105131456.32400-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:50PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
> 
> Expand Allwinner PWM binding with H6 PWM specifics.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..9fc32c1d94b4 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,50 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock

The order here doesn't match the if/then or the example.

> +
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clock-names: true

blank line here.

> +  resets:
>      maxItems: 1
>  
> +  if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: allwinner,sun50i-h6-pwm
> +
> +  then:
> +    properties:
> +      clocks:
> +        minItems: 2
> +
> +      clock-names:
> +        items:
> +          - const: mod
> +          - const: bus
> +
> +    required:
> +      - clock-names
> +      - resets
> +
> +  else:
> +    properties:
> +      clocks:
> +        maxItems: 1
> +
>  required:
>    - "#pwm-cells"
>    - compatible
> @@ -54,4 +91,14 @@ examples:
>          #pwm-cells = <3>;
>      };
>  
> +  - |
> +    pwm@300a000 {
> +      compatible = "allwinner,sun50i-h6-pwm";
> +      reg = <0x0300a000 0x400>;
> +      clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
> +      clock-names = "mod", "bus";
> +      resets = <&ccu RST_BUS_PWM>;
> +      #pwm-cells = <3>;
> +    };
> +
>  ...
> -- 
> 2.20.1
> 

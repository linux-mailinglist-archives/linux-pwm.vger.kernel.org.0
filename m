Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A780376C79
	for <lists+linux-pwm@lfdr.de>; Sat,  8 May 2021 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEGWXD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 18:23:03 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34454 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGWXD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 18:23:03 -0400
Received: by mail-ot1-f48.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso9240144ote.1;
        Fri, 07 May 2021 15:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJE+TC+b5jLMRQ3EZL0NyaJOHHWlrS4m1edurMUIrWE=;
        b=MIhLDolfsp+f/RFpcJwh8LacbmOvY4i7L/+iQTjK2DQUPAd2aMIu5HYiQRTHTnQXC8
         EncsxGfTcRTbiUSIuY6lzaygbk3g1LC4pG5xIIjB507rvFcP6PgmHBOw6WUs7snKK937
         d8vmcep1OlsfwEjZM6hhMkxO+XZNgZbADMLmDQhHCXTEQi0oq4QHfFpQ21iscF2ZlePO
         7w9+dQS0IjmIBcmoEvV24V0CWzVToDLfDSHxfD/F0wu6yIIi5ex3+ah3Gm3VDzFaf764
         Ptu7X+7aOt4wBQHP+i/MGnBrXpPbD4hsCqRbh6OpFSFCbW3VfJ+04KlDsZu3WhXaW9i3
         SCLA==
X-Gm-Message-State: AOAM532n65HcIosU/60GatY4a9mh0SV3pkarsUvcCBH9wCtxcueOWO21
        tT8ewQ9UBrsYSqRB/s5iHA==
X-Google-Smtp-Source: ABdhPJy+am6NARFsVfyMVq93tpVSfof2No3lbd73Pco+c4GCQHZ+rd7ceY+/jkcCkJUIgJ8gYXqAmA==
X-Received: by 2002:a9d:6359:: with SMTP id y25mr10422588otk.103.1620426121281;
        Fri, 07 May 2021 15:22:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f30sm1366213ooh.10.2021.05.07.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:21:59 -0700 (PDT)
Received: (nullmailer pid 3004259 invoked by uid 1000);
        Fri, 07 May 2021 22:21:57 -0000
Date:   Fri, 7 May 2021 17:21:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: renesas,tpu-pwm: Improve
 json-schema
Message-ID: <20210507222157.GA3000824@robh.at.kernel.org>
References: <cover.1620375445.git.geert+renesas@glider.be>
 <82dcf4b87f2b2149bb2e238c7fd654ca2397230e.1620375445.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82dcf4b87f2b2149bb2e238c7fd654ca2397230e.1620375445.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 07, 2021 at 10:25:12AM +0200, Geert Uytterhoeven wrote:
>   - Include the general PWM controller schema,
>   - Make clocks, power-domains, and resets properties required.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/pwm/renesas,tpu-pwm.yaml         | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index aa9a4570c9068226..3a072ee29815c695 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -58,8 +58,25 @@ required:
>    - compatible
>    - reg
>    - '#pwm-cells'
> +  - clocks
> +  - power-domains
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: pwm.yaml#

This doesn't add any other properties, so you can keep 
'additionalProperties: false'. 

> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,tpu-r8a73a4
> +                - renesas,tpu-r8a7740
> +    then:
> +      required:
> +        - resets
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.25.1
> 

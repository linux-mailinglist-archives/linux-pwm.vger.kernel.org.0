Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830E81D7B00
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgEROVp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 10:21:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45278 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROVp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 10:21:45 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so10672488iol.12;
        Mon, 18 May 2020 07:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nw3uL0prCIhvjDfJQqiTECtacq4+z7dFJzYGHhmiGAg=;
        b=rDhGJnp80LLMqV1MScErNl2UUFphDShzob34opdIz8l/BLeK/MJesFgA/T/YdqJnjK
         JxivT1zZ96KHxcwvzp/ChP0wd5TZg9KGLAg0iHKq0bRnVT/jPUt+7pn8fx5o7luunTSd
         6Yre3QQUsdXk7e3riYgBk2bj5Bdljl46M8sq+lcs6+SRrUjO0KeV5bwmMdYg7Ujy2Mht
         G5t0U94FSSxZb4i/NJIF6UE0Q5wqBgtqLX4YyQs1g3BZOviZ+uXqeQImzo40lNyfo7rV
         XpGZR3hvMpJBPcx23UIXXMR8RumBbwEKEKRW6Hwu7ZhIO5OkEut9ora2FujT/F4TDNOV
         Ki1A==
X-Gm-Message-State: AOAM533Z2SzRvmXqAsoPhMxLtWRABZHBaXyMvsWkXT9LgC9UISmO+MEh
        D1AoAr1s8ZNNkl4WvN6nqQ==
X-Google-Smtp-Source: ABdhPJyGUG7N7QD3iSv9jBNJrMrdAvkR+mi7qnLgIzeyksOsexqkUipe1pBU1VDBeFTg0/COJSU2jg==
X-Received: by 2002:a02:cf13:: with SMTP id q19mr14639139jar.42.1589811704654;
        Mon, 18 May 2020 07:21:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r8sm3870863iob.15.2020.05.18.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:21:44 -0700 (PDT)
Received: (nullmailer pid 8829 invoked by uid 1000);
        Mon, 18 May 2020 14:21:43 -0000
Date:   Mon, 18 May 2020 08:21:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200518142143.GB3594@bogus>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:52:40PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml

Use compatible string for filename: intel,keembay-pwn.yaml

> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> new file mode 100644
> index 0000000..00968d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Keem Bay PWM Device Tree Bindings
> +
> +maintainers:
> +  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,keembay-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +        phandle to the reference clock.

How many clocks? (maxItems: 1?)

You can drop the description.

> +
> +required:
> + - compatible
> + - reg
> + - clocks
> +
> +examples:
> +  - |
> +    pwm@203200a0 {
> +      compatible = "intel,keembay-pwm";
> +      reg = <0x0 0x203200a0 0x0 0xe8>;
> +      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
> +    };
> -- 
> 1.9.1
> 

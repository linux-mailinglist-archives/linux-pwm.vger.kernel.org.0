Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AA1E70D6
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2020 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437791AbgE1Xws (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 May 2020 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437703AbgE1Xwk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 May 2020 19:52:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FA5C08C5C9;
        Thu, 28 May 2020 16:32:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so418449ioo.4;
        Thu, 28 May 2020 16:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQDJ/K/BGN1NpHjjxjlRqW+bJrkk3nC7ccS8jJry1GY=;
        b=ZaRw6ans7TOiJdM2kRC4blfFpHglg+7xKc7xQwVVLWP1dPypzoPD/AwrEO785M4yy9
         gLoMXPCPvI+wRU8PyYqiWZdTXNTTLtWxAvIsC6QaBbBzBl1D+T/E1VE/pdTFn5eeh7fs
         Xc/iy7d8tRWRL4W1aQHbTOtcKJbjvx/IrwlxKWRQxLYInepwQQJp2JU1lnWxEMhl13bx
         lrRhWyq4s8p9vPHsyaBGXl9ILHoJfFyDPp4ZPImzAZiH4Yn8CaTD/4JVrtZ4LCK4hT0u
         rM54uAOnemZvAy3/CacjDvugEiQEYpGFZV6BvS4xDdYKdVsmredONwwqRvRAu8v0O5a9
         11rw==
X-Gm-Message-State: AOAM5323iY0UAvRVf5JVXnQFK692URnUUgNveweup4GsrfBsKFiOtGSw
        qwA7u1T96tUoAsVUevWXwA==
X-Google-Smtp-Source: ABdhPJzusT7uEAZWsJfwtK0/tbap4elm8WWwMNQ5e7+7HOm2fXq3XAviM98TIp5s4M6mHopuCwQaSA==
X-Received: by 2002:a05:6602:809:: with SMTP id z9mr4320866iow.79.1590708721032;
        Thu, 28 May 2020 16:32:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l6sm3108508ioh.32.2020.05.28.16.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:32:00 -0700 (PDT)
Received: (nullmailer pid 880564 invoked by uid 1000);
        Thu, 28 May 2020 23:31:59 -0000
Date:   Thu, 28 May 2020 17:31:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v1 1/2] Add YAML schema for a new PWM driver
Message-ID: <20200528233159.GA876777@bogus>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 03:41:58PM +0800, Rahul Tanwar wrote:
> Add DT bindings YAML schema for PWM controller driver of
> Lightning Mountain(LGM) SoC.

You need a better subject such as what h/w this is for. Bindings are for 
h/w blocks, not drivers.

> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     | 43 ++++++++++++++++++++++

Use the compatible string for filename.

>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> new file mode 100644
> index 000000000000..adb33265aa5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-intel-lgm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LGM SoC PWM controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - resets

additionalProperties: false

> +
> +examples:
> +  - |
> +    pwm: pwm@e0d00000 {
> +        compatible = "intel,lgm-pwm";
> +        reg = <0xe0d00000 0x30>;
> +        #pwm-cells = <2>;
> +        clocks = <&cgu0 126>;
> +        resets = <&rcu0 0x30 21>;
> +    };
> -- 
> 2.11.0
> 

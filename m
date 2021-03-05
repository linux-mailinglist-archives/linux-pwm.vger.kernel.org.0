Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D732F494
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Mar 2021 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEUWd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Mar 2021 15:22:33 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38387 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCEUW1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Mar 2021 15:22:27 -0500
Received: by mail-oi1-f182.google.com with SMTP id q203so3887184oih.5;
        Fri, 05 Mar 2021 12:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L6fiDRHOBx6wicwHAlBdQghdJU9EkaCoXvCSV20utCg=;
        b=sLCLWqLc2UY0S6i3//fHbUEom6YsAk3ECj1+M4Ia05gqpWYLEPKqDaKkOC0Ms/N0EW
         m5g0fQwl/QoSTpnUClwVl3G+Vl8LwaX7v81hNJRnXusz10mSdxxMdOamIxW3XmUPUKY1
         2k6muMeyZ0AMTmyMKfltbIXrN1EyNuiigJn/YIu/d7QYmZxiQSBgCGrxNRO45XnCwNPX
         Y03JyRDHYcCKTosDiXHwwxwQG97eANkOBu9dNufK9zShcDQmnq9CKi18nhju5by7NzB7
         BT0Pgu/mIIhfTEVHR7zqvvUv7Odo97Bm+IfskUydNOKrP6/2aRJ4araFOcseiYXpbpFw
         fXhA==
X-Gm-Message-State: AOAM533ADv/aze7SFPxA1ZVYYmJwhkUkgAz/leK2nVUwGC9j9BOcKJ8c
        OgvDNuppN9IQBoIIaVSDsQ==
X-Google-Smtp-Source: ABdhPJy127zX+LiOlwWsk56ZjC471+NVclR9wt3yY/+htyALJl7O+I5jJhN+5AyB5SSnbsjwEj6ywQ==
X-Received: by 2002:aca:90c:: with SMTP id 12mr1369336oij.21.1614975746678;
        Fri, 05 Mar 2021 12:22:26 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b9sm749249ooa.47.2021.03.05.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:22:25 -0800 (PST)
Received: (nullmailer pid 584975 invoked by uid 1000);
        Fri, 05 Mar 2021 20:22:24 -0000
Date:   Fri, 5 Mar 2021 14:22:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add bindings for Toshiba
 Visconti PWM Controller
Message-ID: <20210305202224.GA583007@robh.at.kernel.org>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212131910.557581-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Feb 12, 2021 at 10:19:09PM +0900, Nobuhiro Iwamatsu wrote:
> Add bindings for the Toshiba Visconti PWM Controller.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pwm/toshiba,pwm-visconti.yaml    | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> new file mode 100644
> index 000000000000..f11558cdc32f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/toshiba,pwm-visconti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti PWM Controller
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: toshiba,pwm-visconti

The 'normal' order is: toshiba,visconti-pwm

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#pwm-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pwm: pwm@241c0000 {
> +            compatible = "toshiba,pwm-visconti";
> +            reg = <0 0x241c0000 0 0x1000>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pwm_mux>;
> +            #pwm-cells = <2>;
> +        };
> +    };
> -- 
> 2.30.0.rc2
> 

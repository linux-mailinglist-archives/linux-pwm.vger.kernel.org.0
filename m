Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F5276238
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIWUhi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 16:37:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42075 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgIWUhi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 16:37:38 -0400
Received: by mail-io1-f66.google.com with SMTP id u6so902033iow.9;
        Wed, 23 Sep 2020 13:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zyDlLJKi1LCBEhn98FTUiRp7YabuHkI2jkXtBu/lK3s=;
        b=L2DTSDkxmOrvRgOvWlRJ4IK7fph2V9G4gGxje4KmD/j9ankw+bjpwvuPTV7F+PRWy5
         xBNdhbsrVn1FrsOL6VSUrQR/B/qyHhmrmKJ2cB2znrJwBmKewrtlZSHY7sam2ccStHRY
         DJPdmo24foPM8LBEbmK/Ry8yBKPXMBQh/PajGsQeMC1Npt3rlHXS4/RPh9Dnyh53Y5p3
         EniXrV893ne4N4LHsv1h81XojfztzK/IhunX+dJAwVplc3sZ3/yixSCBnNuwpzm+UrUT
         MacCQ072jC2NwtgXatOkEa8NDE7Doa2b1OlebRRsUXEcnYfcHhKw+6miPQDB1UG4s+V2
         abHg==
X-Gm-Message-State: AOAM532YS7Lqg2h21Fik14vK5wTXuJX1iOz1QoUkXJgY+oUU92cwZyqD
        /48tuOp7Vs9bbuDXdduKDw==
X-Google-Smtp-Source: ABdhPJzOk91DVHwMgV1G87qFRX0v0A4pJbMZa2BM4Q3CybLgZllhTEogwEBHo28xHFn87yVHkglBUg==
X-Received: by 2002:a05:6638:250d:: with SMTP id v13mr1002429jat.50.1600893457259;
        Wed, 23 Sep 2020 13:37:37 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k16sm383922ilc.38.2020.09.23.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:37:36 -0700 (PDT)
Received: (nullmailer pid 1262913 invoked by uid 1000);
        Wed, 23 Sep 2020 20:37:35 -0000
Date:   Wed, 23 Sep 2020 14:37:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti
 PWM Controller
Message-ID: <20200923203735.GA1257022@bogus>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200917223140.227542-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917223140.227542-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 18, 2020 at 07:31:39AM +0900, Nobuhiro Iwamatsu wrote:
> Add bindings for the Toshiba Visconti PWM Controller.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pwm/toshiba,pwm-visconti.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> new file mode 100644
> index 000000000000..9145e9478b41
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please.

(GPL-2.0-only OR BSD-2-Clause)

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
> +      - enum:
> +          - toshiba,pwm-tmpv7708

The normal order is: vendor,soc-block

> +      - const: toshiba,pwm-visconti

Do you expect a lot of chips with the exact same version of the IP? If 
not drop. Future chips can always use toshiba,pwm-tmpv7708 as a 
fallback.

> +
> +  reg:
> +    # base address and length of the registers block for the PWM.

Drop. No need to describe common properties.

> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    # should be 2. See pwm.yaml in this directory for a description of
> +    # the cells format.

Drop.

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
> +            compatible = "toshiba,pwm-tmpv7708", "toshiba,pwm-visconti";
> +            reg = <0 0x241c0000 0 0x1000>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pwm_mux>;
> +            #pwm-cells = <2>;
> +        };
> +    };
> -- 
> 2.27.0
> 

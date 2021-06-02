Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED33993D1
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jun 2021 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhFBTth (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Jun 2021 15:49:37 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43842 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhFBTth (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Jun 2021 15:49:37 -0400
Received: by mail-oi1-f181.google.com with SMTP id x196so3422450oif.10;
        Wed, 02 Jun 2021 12:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMBQsdEjo60dP+eGv84MsRwL9RIc/Ulop0Bl/gUWIjo=;
        b=KE/wLa4ISv5LU10MnSfsjh7GYcd3GoqypWCXIhfhNiMH/rk87DTZTqiJedc0qEclz0
         5V7hlC47Tl3L4WxSnPZ035ybk4yS5iOtN9sLO1jamA8Rs66353B2BfHS7otzAo6v7FKH
         Ejol8Oy/U6RmhEC0rIfpSYjU1ilWIHu+Gqm4n1C1NMZypAnTtzhN0TC6rLeWlEJY55K1
         OpDukfBBV3oDBQ670TgSd/HiUMbFE6dRhB+gBo0/tOaLcyRgqhE8pwOgaxiW9bJ320mv
         IImBtQVNIk5gzp/b8JKj3TbFEx38p6TJGuWZnAKInFfofpI14ulmdeF4OXKN6/8e+Iw8
         vR6Q==
X-Gm-Message-State: AOAM5320Ret9Yl6ZBAvOQXcHk4N4kqU95uPTyhmtJg0P6vp+8uB1QNcJ
        KXOsfzk78ziMDlOY4Et78A==
X-Google-Smtp-Source: ABdhPJyuIasiPFE4iw4kymp1gUAaIH++QsSOgS3+1fEjCuHp55zfCKeWJzwUfp/ismBdPyZx38p3kA==
X-Received: by 2002:aca:380a:: with SMTP id f10mr5020475oia.157.1622663273110;
        Wed, 02 Jun 2021 12:47:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p25sm191461ood.4.2021.06.02.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:47:52 -0700 (PDT)
Received: (nullmailer pid 3867811 invoked by uid 1000);
        Wed, 02 Jun 2021 19:47:51 -0000
Date:   Wed, 2 Jun 2021 14:47:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <20210602194751.GA3865096@robh.at.kernel.org>
References: <ea071bbcab92d4a296c7aee5d72de0427676847a.1621851644.git.baruch@tkos.co.il>
 <249bddc521b15e992d0846edf1813aeb577458b9.1621851644.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249bddc521b15e992d0846edf1813aeb577458b9.1621851644.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 24, 2021 at 01:20:43PM +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..f85ce808a14e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  "#pwm-cells":
> +    const: 2
> +
> +  compatible:
> +    const: qcom,pwm-ipq6018

qcom,ipq6018-pwm is the normal ordering.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pwm@1941010 {
> +            #pwm-cells = <2>;
> +            compatible = "qcom,pwm-ipq6018";
> +            reg = <0x0 0x1941010 0x0 0x20>;
> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            clock-names = "core";
> +        };
> +    };
> -- 
> 2.30.2

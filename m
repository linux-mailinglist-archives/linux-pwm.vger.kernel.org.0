Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA36F35A4FB
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhDIR4I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 13:56:08 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42997 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIR4G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 13:56:06 -0400
Received: by mail-oi1-f178.google.com with SMTP id n140so6581109oig.9;
        Fri, 09 Apr 2021 10:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqg2ntuQS/pbpLD9rz68eK+afesnc4sLjzCW0hn6Dis=;
        b=RzTJcwoCalZUGZ7qk3y8E8yiN9cd7Gj8Xz8lnZUJaRXpCNakXx5/Ep0Mk/DEfYSZV6
         fUMfKIgI31B3mxSTevCaavVtOztKkfCWSIpczOZte6COMXKEh3HOccASRcg5IEatk0Nd
         Kn9BRYiV+Nz5rQ0LqOmP+JAOeAUNk8XcAmpltbnIECXfZzW+L8iZXjgBAwFdhca3wXrj
         94ptcf5OrBevUHClf719WVzD+b3zviZk/xfq1DOQ5VzUHCu3QTsbdFWLot5Y+otHSvfU
         QuvPjxnTqkzldiSCAz7pWDjddUhQXPhyRuXPRKGOD4EZtzPcv8CtP8tcch2K6VXkBuYR
         BM3Q==
X-Gm-Message-State: AOAM530HKE04fGEimv2epRtKSRTL+rlzcwSKuIF0JZ4MXH2ZtwRLW807
        Z6/MYyj2js8aMb0hCeaVIA==
X-Google-Smtp-Source: ABdhPJz/4Ts1DrnoKYDSpqBA4EDAwkmQl+k0y2knHSDgabWoxRV2WFwqJtmQTIhpRQM8x/yMKgFlig==
X-Received: by 2002:a54:4703:: with SMTP id k3mr10658741oik.26.1617990952733;
        Fri, 09 Apr 2021 10:55:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p22sm782536otf.25.2021.04.09.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:55:52 -0700 (PDT)
Received: (nullmailer pid 3876842 invoked by uid 1000);
        Fri, 09 Apr 2021 17:55:51 -0000
Date:   Fri, 9 Apr 2021 12:55:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <20210409175551.GA3769113@robh.at.kernel.org>
References: <20210406155053.29101-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406155053.29101-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 06, 2021 at 05:50:52PM +0200, Johan Jonker wrote:
> Current dts files with 'pwm' nodes are manually verified.
> In order to automate this process pwm-rockchip.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 ---------
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> deleted file mode 100644
> index f70956dea..000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Rockchip PWM controller
> -
> -Required properties:
> - - compatible: should be "rockchip,<name>-pwm"
> -   "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
> -   "rockchip,rk3288-pwm": found on RK3288 SOC
> -   "rockchip,rv1108-pwm", "rockchip,rk3288-pwm": found on RV1108 SoC
> -   "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
> - - reg: physical base address and length of the controller's registers
> - - clocks: See ../clock/clock-bindings.txt
> -   - For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399):
> -     - There is one clock that's used both to derive the functional clock
> -       for the device and as the bus clock.
> -   - For newer hardware (rk3328 and future socs): specified by name
> -     - "pwm": This is used to derive the functional clock.
> -     - "pclk": This is the APB bus clock.
> - - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.yaml in this directory
> -   for a description of the cell format.
> -
> -Example:
> -
> -	pwm0: pwm@20030000 {
> -		compatible = "rockchip,rk2928-pwm";
> -		reg = <0x20030000 0x10>;
> -		clocks = <&cru PCLK_PWM01>;
> -		#pwm-cells = <2>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> new file mode 100644
> index 000000000..cfd637d3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PWM controller
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,rk2928-pwm
> +      - const: rockchip,rk3288-pwm
> +      - const: rockchip,vop-pwm
> +      - items:
> +          - enum:
> +              - rockchip,rv1108-pwm
> +          - const: rockchip,rk3288-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399)
> +        There is one clock that is used both to derive the functional clock
> +        for the device and as the bus clock.
> +      For newer hardware (rk3328 and future SoCs) that is also specified

Can you express this with a schema.

> +      with clock names.
> +        "pwm" is used to derive the functional clock for the device.
> +        "pclk" is used as the APB bus clock.

Let's not document the names twice.

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: pwm
> +      - const: pclk
> +
> +  "#pwm-cells":
> +    enum: [2, 3]
> +    description:
> +      Must be 2 (rk2928) or 3 (rk3288).
> +      See pwm.yaml for a description of the cell format.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3188-cru-common.h>
> +    pwm0: pwm@20030000 {
> +      compatible = "rockchip,rk2928-pwm";
> +      reg = <0x20030000 0x10>;
> +      clocks = <&cru PCLK_PWM01>;
> +      #pwm-cells = <2>;
> +    };
> -- 
> 2.11.0
> 

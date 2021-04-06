Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21113355BEF
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhDFTEo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhDFTEm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 15:04:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6EC06174A;
        Tue,  6 Apr 2021 12:04:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so17814980edt.13;
        Tue, 06 Apr 2021 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LUs9XCcyO38dnpQfCCErPK9kbceKsMJW9AomZ2ltfZg=;
        b=c06VSNerePCuaMgNeajGyGqs3sjrO1yx1Dg2G8q8SP7jjie93CVtIipY87mMEwQMLo
         HD120wLUiXqIuLFkFkzYTA8qkycws1676OsS3V+2Ig3DFetSsNTiBF43oS6EVSkYU+cM
         /asEvQPfM/OTYGtoycZjlu+FZ1qyKYqqu3HK5f1V2l4wtM6w2goLJyeVLRVlL3YaGlMb
         JDeBAN554nuNG7wI490hy/oQk73W22tWf0+Kgh1jF1gwauv5sX2baa4MBpXHjUtfd0Hq
         aeWVWhslHQSyWSB1MH+P3dN0EHUHUujzmoun0nd0Q9JglG8utSfbHt2iyyzREEbszKDN
         ZN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUs9XCcyO38dnpQfCCErPK9kbceKsMJW9AomZ2ltfZg=;
        b=Yw6B7WanU2x7Y3873N8K6RXMqXv7Rda6LcuFNExcw+qeALpLZOf/IH2dJbc3hhzijl
         fZS93i00qt9WAfz1qyLLtMcWrMrPgoYcuAuZqbjGi2lBve7XFlmFDI9L/mQYF79bG/89
         loGZOqwhMWzagC4vjiNdQA/eLz9a1aGdtRbMJ77A7VTVSvzpdlo35v+pbYfzFBqKFbpL
         MM6P10r8qjeEpSCdJdypwebZkz1zTUAE9A7zMcVcLAFEEbBcp2vQjVSEQNQRNRkV8wIV
         0D7ye6ZPiaU57eUOE0H1Ql+/pmEC4+n86rukTjB9gSER61Jd8pqzcjD1T6rNc365EH2s
         vSHg==
X-Gm-Message-State: AOAM5316CiwnPcz2dTAMqiWd/xfga0ZKSyd2v8fXyxATPtdnlOTrW9hk
        hNqFfjvX/7NaFVwQE8+O7mI7e0SSKidI+Q==
X-Google-Smtp-Source: ABdhPJwnwbybytM9+pESinCANbkSL/NZzrl3ilccwsjlyHnygG5SeKxP3e87GSHwhOU4fHnptGgj/w==
X-Received: by 2002:a05:6402:3493:: with SMTP id v19mr41022098edc.355.1617735872135;
        Tue, 06 Apr 2021 12:04:32 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h17sm14037494eds.26.2021.04.06.12.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:04:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210406155053.29101-1-jbx6244@gmail.com>
Message-ID: <8f05dc0d-8fb7-c200-5251-d9e147b1d00d@gmail.com>
Date:   Tue, 6 Apr 2021 21:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210406155053.29101-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Question for Heiko:
rv1108.dtsi and rk3328.dtsi have a undocumented "interrupts" property
AFAICT without driver support.
Please advise what to do with it.


See build log:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210406155053.29101-1-jbx6244@gmail.com/

====

Question for Rob:
It looks like that recent "improvements" with regard to checking for
undocumented compatible strings make it almost impossible to do any
useful dt_checking, let alone for the average user. Maybe reduce the
notification blurb output a bit for things that have nothing to do with
this document. Unable to fall back to previous versions for older kernels.

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
--upgrade

make ARCH=arm dtbs_check
make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

make ARCH=arm64 dtbs_check
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml


On 4/6/21 5:50 PM, Johan Jonker wrote:
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
> +      with clock names.
> +        "pwm" is used to derive the functional clock for the device.
> +        "pclk" is used as the APB bus clock.
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
> 


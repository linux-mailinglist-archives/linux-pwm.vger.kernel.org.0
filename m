Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D73FCD63
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Aug 2021 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhHaTD0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Aug 2021 15:03:26 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34768 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbhHaTDZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Aug 2021 15:03:25 -0400
Received: by mail-ot1-f43.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso432041otp.1;
        Tue, 31 Aug 2021 12:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g/wylqfbU2Ds4hPrqFZcDGrgHpasbQqYBGt6ciPf6Ao=;
        b=C+5NmTp7GacbLtFpGLKYv8XdxPwLxeBKRscZaUuuXSKAxn353jxade3LwQGRWYTTUB
         bkGubHh3sml5S52lnySiRiLeGcz6Ebp3gy5Z9OcfIfcsqKSWsLGAcntWlC4Ju5JngjDY
         TBl47wSbX0uxxx/UoawKSncNG3jw/TBiZiHXUGxVTl0/ff65M1/BFXGiOTdriDtvpTD5
         bLURnNpY+IZoEDKUALdqj9oxV8TMFigwKOx53+EljQEtdHz/dI7xhM0DRPJaG+TQlHao
         iorv0yTC6biXjmAlpZGUkVHacF3CitJLSPdOqQ4zzANP0KgHofWNHZvkuHpOe38LFQJH
         867Q==
X-Gm-Message-State: AOAM532u1rDuv5xiQMsEUoeQX3PMxW9Eawju66rrgpFi4TK7Eze3twAk
        A6fCt1Of2bzmT4pLOdQoPw==
X-Google-Smtp-Source: ABdhPJxmCHqLpisbCFuJaaVwlzf2HYOCGHVpu86uYy6MTZoZPDeQ6ydgSLYpeUkyXZK5Gs5GmKFt7g==
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr25303816otn.164.1630436549707;
        Tue, 31 Aug 2021 12:02:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 4sm3768624ooa.11.2021.08.31.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:02:29 -0700 (PDT)
Received: (nullmailer pid 479023 invoked by uid 1000);
        Tue, 31 Aug 2021 19:02:28 -0000
Date:   Tue, 31 Aug 2021 14:02:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YS58xAit1UrEtd0v@robh.at.kernel.org>
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
 <8238dfb5d5e4a40a995f047db36d9a7240431de5.1630323987.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8238dfb5d5e4a40a995f047db36d9a7240431de5.1630323987.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 30, 2021 at 02:46:26PM +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> This series does not convert the TCSR binding documentation to YAML. As
> a result, this commit adds new a dt_binding_check warning:
> 
> /example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']
> 
> If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
> for someone else to push them further.
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..96bc63e336bf
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
> +    const: qcom,ipq6018-pwm
> +
> +  reg:
> +    description: Offset of PWM register in the TCSR block.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    tcsr: syscon@1937000 {

Drop unused (by the example) labels.

> +        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
> +        reg = <0x01937000 0x21000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;

           ranges = <0 0x1937000 0x21000>;

Otherwise, the address is not translatable.

> +
> +        pwm: pwm@a010 {
> +            compatible = "qcom,ipq6018-pwm";
> +            reg = <0xa010 0x20>;
> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clock-rates = <100000000>;
> +            #pwm-cells = <2>;
> +        };
> +    };
> -- 
> 2.33.0
> 
> 

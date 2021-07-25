Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3D3D4F7E
	for <lists+linux-pwm@lfdr.de>; Sun, 25 Jul 2021 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGYRqs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Jul 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGYRqr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 25 Jul 2021 13:46:47 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545FC061764
        for <linux-pwm@vger.kernel.org>; Sun, 25 Jul 2021 11:27:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q6so8294050oiw.7
        for <linux-pwm@vger.kernel.org>; Sun, 25 Jul 2021 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tjZy0yxM4bICaX53nnUwJplVpr2U4hx6m3PxNQuPd3g=;
        b=WQeC84A+geBcNAHWJpZASnDakrpxpr1k50gczrFr+YSl4puCRmr1IL0MLrdOIVu/4v
         aG8xU1hV3ZvJH29DLuCUywYnaC49kPcy3exkYOczdxBqFgJiWgLzu1iziKu/7y25orTT
         JX9RztS5VzvMING7wAanV2xp0C9NVQ4U5kZ1mTlWPqWw2U2M1+L2xgRYjOkctMdBxJ9j
         cSciDSBzJGZv0szPOjzpPfylXH2STON80QZSz7uhQI6PE4in/CG4RV7itiHc9I9DPOZu
         gkgCMWGvub2kRzuqfGotCdmt2gGJeCJ7IoEpI4mBd0CQ23CkPKF94Rt+nIjVRE3oS8eF
         fZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tjZy0yxM4bICaX53nnUwJplVpr2U4hx6m3PxNQuPd3g=;
        b=umb00p6txemO34ZghxIfsee20EadNXradDzUWcPC2iwAJz/hZ5DLUD7pga4vInJbPl
         iVBPRi6UuRAeEH9NAJ49WCezY9uzedcz+IS/8W7+1fMmZSXatROd6j6GMZXf/h7Aq958
         1qKVFnQY7NwNsSKU7Rjq12Dg/sPOSRjkGSH/5PzvSM+IG1NJtWyyLJ0qY/lcbkAmltoa
         1HlZuDl4p0YjpHNBjYySPYAWMVEpZ5q88zfavCcha0YznccxrykoVCkHwvXS65fYeM6E
         038izFAENwdayzYZ2Mqo8NUsss011pyZeMjC/Ir3eYaKNkRnPPjehzox2i73Ks+Avtv7
         XY4A==
X-Gm-Message-State: AOAM532UKQRG3vfc2SQshmCvoq2uzaQ7zdkDYcRQzvcAfgU4gYHjxCo6
        186ZlQGyrbkWE9fyNMImMTvkIRg/vSe0Ag==
X-Google-Smtp-Source: ABdhPJwQHdnbIWUHBriC4kZkOhE6fOKo+sw2FqC+WTLU5+JDvcFE4VlXDjDOiGdqxSTKeWIQ+4ro0g==
X-Received: by 2002:aca:1802:: with SMTP id h2mr14390070oih.146.1627237636142;
        Sun, 25 Jul 2021 11:27:16 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u7sm2263004oop.11.2021.07.25.11.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 11:27:15 -0700 (PDT)
Date:   Sun, 25 Jul 2021 13:27:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YP2tAR+zZgJZQOgG@yoga>
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 22 Jul 05:01 CDT 2021, Baruch Siach wrote:

> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
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
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..ee2bb03a1223
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,69 @@
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
> +  offset:
> +    description: |

'|' maintains the formatting of the text, you don't need that.

> +      Offset of PWM register in the TCSR block.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core

With a single clock, it's nice to skip the -names.

> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1

These (assigned-*) are generic properties that may be used on a lot of
nodes, should they really be part of the individual binding, Rob?

> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
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

Skip soc and *-cells...

> +        tcsr: syscon@1937000 {
> +            compatible = "syscon", "simple-mfd";
> +            reg = <0x0 0x01937000 0x0 0x21000>;
> +

..and just make this "reg = <0x01937000 0x21000>", in the example. Then
as we put this in the particular dts we adjust for whatever *-cells that
has defined for the parent bus.

> +            pwm: pwm {
> +                #pwm-cells = <2>;

I know it's important that this is a pwm thing, but I would prefer to
see the node start with compatible, offset/reg, clocks. And then end
with whatever is exposed (i.e. #pwm-cells)

Regards,
Bjorn

> +                compatible = "qcom,ipq6018-pwm";
> +                offset = <0xa010>;
> +                clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +                clock-names = "core";
> +                assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +                assigned-clock-rates = <100000000>;
> +                status = "disabled";
> +            };
> +        };
> +    };
> -- 
> 2.30.2
> 

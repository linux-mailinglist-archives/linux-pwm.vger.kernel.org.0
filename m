Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAE3F7956
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbhHYPqn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 11:46:43 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37386 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbhHYPqn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Aug 2021 11:46:43 -0400
Received: by mail-ot1-f46.google.com with SMTP id i3-20020a056830210300b0051af5666070so45701762otc.4;
        Wed, 25 Aug 2021 08:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NsNMFFFFEFLAZuH245IhIJFqtd87059TgySDgcFY3v4=;
        b=EZSu7B9fxHSZthpjddds/j89ZCAfnEr4pFBSGgnMoV4TaMZvxyqH46NQroLdsRa33m
         QHzFp1GYsb3b1lp/T/HyIiAm7nY2eczCHc/ScR/hP0Xjr/6iEEc039wH0YaEggXMAewp
         T0tXpoftznOt0vADI0xuimLISBF6pJl6BChve6qgJQslQyP0sUzmPJKoZs25TihGAW4H
         PBvT6FYFHPMcVh/uHsxgHNp0LvGH6PtEBhfJ0YB/yNtg/FwqUN+p5FOanK8VXXGoUeyU
         dRhOf7oMPJLjPdqNVW995s2pInS/K29qhrD8yilxP39O/EVR7IzIjeJDtcN34LpNg454
         HmOA==
X-Gm-Message-State: AOAM532l0z+RGwbyGPbRd/Yb2m4rvi/zqway7/1V+xa2EH68nBvWbeMS
        pdA4obN5RHx54ff2FJaIfQ==
X-Google-Smtp-Source: ABdhPJzfkJFZqWY/Z2lBCK5ZHgQG7fxjiA4+qlFfRwKE1NQPrJ7s0h5NwB9+cWUFrFbBdsAQHYl9nw==
X-Received: by 2002:a05:6830:43a0:: with SMTP id s32mr13546006otv.284.1629906356700;
        Wed, 25 Aug 2021 08:45:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w15sm41445oiw.19.2021.08.25.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 08:45:56 -0700 (PDT)
Received: (nullmailer pid 2841976 invoked by uid 1000);
        Wed, 25 Aug 2021 15:45:54 -0000
Date:   Wed, 25 Aug 2021 10:45:54 -0500
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
Subject: Re: [PATCH v7 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YSZlsgRYqDSwnjPw@robh.at.kernel.org>
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
 <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 25, 2021 at 12:48:26PM +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
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
> index 000000000000..edfec41e77e5
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
> +        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";

This needs to be documented. Some visibility into what else is in this 
block would be nice so we can make some informed decisions as to what 
all this should look like.

> +        reg = <0x01937000 0x21000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pwm: pwm@a010 {
> +            compatible = "qcom,ipq6018-pwm";
> +            reg = <0xa010>;

There's not a length associated with the PWM registers.

> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clock-rates = <100000000>;
> +            #pwm-cells = <2>;
> +        };
> +    };
> -- 
> 2.32.0
> 
> 

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B781AF0D9E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfKFEPV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 23:15:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35219 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFEPU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 23:15:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id z6so19714110otb.2;
        Tue, 05 Nov 2019 20:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eU07epBZUVYLaHBjz3RtRcFaFle5kQt9relwi3C3BoI=;
        b=FsvSCwhNSpsQ3eFun1z70YCzCBOdZkM0v3lVcclhjCaiySJNjL2ak/Ifq3he7hd6Ci
         +3wXYQBpNX8i6AOb+4WCxxlp7fjm+1fOEfXON/A5jpIYk/grCyiNQ26FyHnkRanHsMJV
         Td2Q/CDgBHpi68lCkh95KQmsP3RoKLYR1MUItvXJMYr/59dVCrVHYu/4BfZ2L6gMMcLo
         aQSETJ+yPc6x1Gaqg3+gQhtIFuCs3Lz5z98TqxiPfOCs+LIHTxvQjcZ0RzRbpW3uk9sN
         r6y4RHebd+ht8vReH/xJNZ+/l5wEu9dTnrn31RTb5vPAehxVMBBszNU7/Wmd/+R5nlMm
         gNTQ==
X-Gm-Message-State: APjAAAXYW3/4epqtcK2YHlzYoxnKUWYfOCDdyPi1VRdkNIbSgn+xmDL1
        RZzodu04y3+l+GZ9Rr4wrQ==
X-Google-Smtp-Source: APXvYqyL7N4ZSd4YdH6F4tHPJTvw4bxJUurlUdTYajOsiR6wMLQz0zP3nOgOpX9idyBcv2QLfignhw==
X-Received: by 2002:a9d:6950:: with SMTP id p16mr289110oto.16.1573013719528;
        Tue, 05 Nov 2019 20:15:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm1946185otl.13.2019.11.05.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:15:18 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:15:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     mark.rutland@arm.com, alexandre.torgue@st.com,
        fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Message-ID: <20191106041518.GC5294@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-5-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031123040.26316-5-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 31, 2019 at 01:30:40PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 91 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       | 73 -----------------
>  2 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> new file mode 100644
> index 000000000000..3f0a65fb2bc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Timers bindings
> +
> +description: |
> +  This hardware block provides 3 types of timer along with PWM functionality: \

Don't need the \

> +    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable \
> +      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels. \
> +    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a \
> +      programmable prescaler and PWM outputs.\
> +    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +allOf:
> +  - $ref: "../pwm/st,stm32-pwm.yaml#"
> +  - $ref: "../iio/timer/st,stm32-timer-trigger.yaml#"
> +  - $ref: "../counter/st,stm32-timer-cnt.yaml#"

This works, but I prefer the child node names be listed under properties 
here with a ref:

counter:
  $ref: "../counter/st,stm32-timer-cnt.yaml#"

> +
> +properties:
> +  compatible:
> +    const: st,stm32-timers
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: int
> +
> +  reset:
> +    maxItems: 1
> +
> +  dmas: true

How many?

> +
> +  dma-names: true

What are the names?

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    timers2: timer@40000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "st,stm32-timers";
> +      reg = <0x40000000 0x400>;
> +      clocks = <&rcc TIM2_K>;
> +      clock-names = "int";
> +      dmas = <&dmamux1 18 0x400 0x1>,
> +             <&dmamux1 19 0x400 0x1>,
> +             <&dmamux1 20 0x400 0x1>,
> +             <&dmamux1 21 0x400 0x1>,
> +             <&dmamux1 22 0x400 0x1>;
> +      dma-names = "ch1", "ch2", "ch3", "ch4", "up";
> +      pwm {
> +        compatible = "st,stm32-pwm";
> +        #pwm-cells = <3>;
> +        st,breakinput = <0 1 5>;
> +      };
> +      timer@0 {
> +        compatible = "st,stm32-timer-trigger";
> +        reg = <0>;
> +      };
> +      counter {
> +        compatible = "st,stm32-timer-counter";
> +      };
> +    };
> +
> +...

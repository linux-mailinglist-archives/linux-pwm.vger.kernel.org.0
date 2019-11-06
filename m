Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882B7F0D98
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 05:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfKFEK2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 23:10:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43313 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFEK1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 23:10:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so7670925oie.10;
        Tue, 05 Nov 2019 20:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTqm+5ilx5cNXoALUuokKsa13a1L8tV/eJS9nqrIoLA=;
        b=AxRjLWUkheslZwJuMCM4tchOHlof1rZOUN9Lp5d8yP+KNvC6Z+CCSvvWXwbcx/S2Pd
         5FGkhkR32/X+a86Q+S2dKHC/SK8gsHv2YyEo7tWE1Kyc+OhZvLWf5TDvk2mC1Bj+AHd5
         dywO4AkfUWmuauuN33fn+krGCBcIfg/bL+WRbpitnyWyjKsPwZP87BJzhCtcHCpG4fNe
         PQ2UTSYZ+s0m1TOdrENtpwzqB3v35k+ck1sAgDphnIfj1KJFdwPO7XTYTbUXH/xzfMh7
         A0zXmWzoFDBu7wnQOYUARINvxJdc3qMTPLZ/9+GupdQPn4F6HuqJZx44rP4jIJOQ5mbf
         jt4Q==
X-Gm-Message-State: APjAAAUKIipVpu/AjGM2mZFkL1Gfiswv6RRuzi3qVfX064h5XyrHc3U8
        rMSeoqaTS8sa3+UeCm2jeQ==
X-Google-Smtp-Source: APXvYqylmIWEBXlGiig5sQDLxWMziJuvUvr8lMR4v+i6TBlZUwvxqcsWnINhAkMmXTCCEcsff6WZoQ==
X-Received: by 2002:aca:5dd5:: with SMTP id r204mr400621oib.73.1573013425171;
        Tue, 05 Nov 2019 20:10:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w33sm6874277otb.68.2019.11.05.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:10:24 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:10:23 -0600
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
Subject: Re: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Message-ID: <20191106041023.GB5294@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031123040.26316-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 31, 2019 at 01:30:37PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 counter binding to DT schema format using json-schema

Probably this should all be 1 file instead.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/counter/st,stm32-timer-cnt.yaml       | 38 ++++++++++++++++++++++
>  .../bindings/counter/stm32-timer-cnt.txt           | 31 ------------------
>  2 files changed, 38 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml b/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
> new file mode 100644
> index 000000000000..56192d613601
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/st,stm32-timer-cnt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Timers quadrature bindings
> +
> +description:
> +  STM32 Timer provides quadrature encoder to detect angular position
> +  and direction of rotary elements, from IN1 and IN2 input signals.
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +properties:
> +  counter:
> +    type: object
> +
> +    description:
> +      must be a sub-node of an STM32 Timer device tree node
> +
> +    properties:
> +      compatible:
> +        const: st,stm32-timer-counter
> +            
> +    required:
> +      - compatible
> +
> +examples:
> +  - |
> +    counter {
> +      compatible = "st,stm32-timer-counter";
> +    };
> +
> +...
> +
> diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> deleted file mode 100644
> index c52fcdd4bf6c..000000000000
> --- a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -STMicroelectronics STM32 Timer quadrature encoder
> -
> -STM32 Timer provides quadrature encoder to detect
> -angular position and direction of rotary elements,
> -from IN1 and IN2 input signals.
> -
> -Must be a sub-node of an STM32 Timer device tree node.
> -See ../mfd/stm32-timers.txt for details about the parent node.
> -
> -Required properties:
> -- compatible:		Must be "st,stm32-timer-counter".
> -- pinctrl-names: 	Set to "default".
> -- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
> -			to set CH1/CH2 pins in mode of operation for STM32
> -			Timer input on external pin.
> -
> -Example:
> -	timers@40010000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "st,stm32-timers";
> -		reg = <0x40010000 0x400>;
> -		clocks = <&rcc 0 160>;
> -		clock-names = "int";
> -
> -		counter {
> -			compatible = "st,stm32-timer-counter";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&tim1_in_pins>;
> -		};
> -	};
> -- 
> 2.15.0
> 

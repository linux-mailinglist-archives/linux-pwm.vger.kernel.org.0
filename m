Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA93F69F7
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Nov 2019 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKJP6m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 10 Nov 2019 10:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJP6m (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 10 Nov 2019 10:58:42 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3862077C;
        Sun, 10 Nov 2019 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573401520;
        bh=6wJ+i1d7XzsfKKuAZNjckdYPBns3/LQocyqrOKe2gh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0rndzS2Uqi9vBuRK5a0rEO3sUaRnuk/RwUQFHuSjKVCep8X6DioSXSkAqnY5tJVtG
         sl/LE5bB8/Sj3RGTOPGm3TzQlIppBsAUM79462QYtAQcC9qMnxsWNO2cGuJl2s/cd1
         7ReQpCTUxk61fiTAfthJNs3oTd90N4n9QM/YgXLM=
Date:   Sun, 10 Nov 2019 15:58:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Message-ID: <20191110155833.444d4a2e@archlinux>
In-Reply-To: <20191107191425.22273-1-benjamin.gaignard@st.com>
References: <20191107191425.22273-1-benjamin.gaignard@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 7 Nov 2019 20:14:25 +0100
Benjamin Gaignard <benjamin.gaignard@st.com> wrote:

> Convert the STM32 timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
As a total non expert on this, looks sane to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> version 2:
> - merge all (mfd, iio, pwm, counter) bindings in one file
> - fix typo and trailing spaces
> - rework dmas and dma-names properties to allow schemas like:
>   ch1 , ch2, ch4
>   ch2, up, com
> - use patternProperties to describe timer subnode
> - improve st,breakinput property definition to be able to check the values
>   inside de tuple
>  .../bindings/counter/stm32-timer-cnt.txt           |  31 -----
>  .../bindings/iio/timer/stm32-timer-trigger.txt     |  25 ----
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 155 +++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  73 ----------
>  .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 -----
>  5 files changed, 155 insertions(+), 167 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
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
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> deleted file mode 100644
> index b8e8c769d434..000000000000
> --- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -STMicroelectronics STM32 Timers IIO timer bindings
> -
> -Must be a sub-node of an STM32 Timers device tree node.
> -See ../mfd/stm32-timers.txt for details about the parent node.
> -
> -Required parameters:
> -- compatible:	Must be one of:
> -		"st,stm32-timer-trigger"
> -		"st,stm32h7-timer-trigger"
> -- reg:		Identify trigger hardware block.
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
> -		timer@0 {
> -			compatible = "st,stm32-timer-trigger";
> -			reg = <0>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> new file mode 100644
> index 000000000000..e8bd80038fa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Timers bindings
> +
> +description: |
> +  This hardware block provides 3 types of timer along with PWM functionality:
> +    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
> +      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
> +    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
> +      programmable prescaler and PWM outputs.
> +    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
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
> +  dmas:
> +    minItems: 1
> +    maxItems: 7
> +
> +  dma-names:
> +    items:
> +      - enum: [ ch1, ch2, ch3, ch4, up, trig, com ]
> +    minItems: 1
> +    maxItems: 7
> +    additionalItems: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  pwm:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: st,stm32-pwm
> +
> +      "#pwm-cells":
> +        const: 3
> +
> +      st,breakinput:
> +        description: |
> +          One or two <index level filter> to describe break input configurations.
> +
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +          - items:
> +              items:
> +                - description: |
> +                    "index" indicates on which break input (0 or 1) the configuration should be applied.
> +                  enum: [ 0 , 1]
> +                - description: |
> +                    "level" gives the active level (0=low or 1=high) of the input signal for this configuration
> +                  enum: [ 0, 1 ]
> +                - description: |
> +                    "filter" gives the filtering value (up to 15) to be applied.
> +                  maximum: 15
> +
> +    required:
> +      - "#pwm-cells"
> +      - compatible
> +
> +patternProperties:
> +  "^timer@[0-9]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - st,stm32-timer-trigger
> +          - st,stm32h7-timer-trigger
> +
> +      reg:
> +        maxItems: 1
> +        description: identify trigger hardware block.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +  counter:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: st,stm32-timer-counter
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    timers2: timers@40000000 {
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
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> deleted file mode 100644
> index 15c3b87f51d9..000000000000
> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -STM32 Timers driver bindings
> -
> -This IP provides 3 types of timer along with PWM functionality:
> -- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
> -  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
> -- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
> -  programmable prescaler and PWM outputs.
> -- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
> -
> -Required parameters:
> -- compatible: must be "st,stm32-timers"
> -
> -- reg:			Physical base address and length of the controller's
> -			registers.
> -- clock-names:		Set to "int".
> -- clocks: 		Phandle to the clock used by the timer module.
> -			For Clk properties, please refer to ../clock/clock-bindings.txt
> -
> -Optional parameters:
> -- resets:		Phandle to the parent reset controller.
> -			See ../reset/st,stm32-rcc.txt
> -- dmas:			List of phandle to dma channels that can be used for
> -			this timer instance. There may be up to 7 dma channels.
> -- dma-names:		List of dma names. Must match 'dmas' property. Valid
> -			names are: "ch1", "ch2", "ch3", "ch4", "up", "trig",
> -			"com".
> -
> -Optional subnodes:
> -- pwm:			See ../pwm/pwm-stm32.txt
> -- timer:		See ../iio/timer/stm32-timer-trigger.txt
> -- counter:		See ../counter/stm32-timer-cnt.txt
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
> -		pwm {
> -			compatible = "st,stm32-pwm";
> -			pinctrl-0	= <&pwm1_pins>;
> -			pinctrl-names	= "default";
> -		};
> -
> -		timer@0 {
> -			compatible = "st,stm32-timer-trigger";
> -			reg = <0>;
> -		};
> -
> -		counter {
> -			compatible = "st,stm32-timer-counter";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&tim1_in_pins>;
> -		};
> -	};
> -
> -Example with all dmas:
> -	timer@40010000 {
> -		...
> -		dmas = <&dmamux1 11 0x400 0x0>,
> -		       <&dmamux1 12 0x400 0x0>,
> -		       <&dmamux1 13 0x400 0x0>,
> -		       <&dmamux1 14 0x400 0x0>,
> -		       <&dmamux1 15 0x400 0x0>,
> -		       <&dmamux1 16 0x400 0x0>,
> -		       <&dmamux1 17 0x400 0x0>;
> -		dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig", "com";
> -		...
> -		child nodes...
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> deleted file mode 100644
> index a8690bfa5e1f..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -STMicroelectronics STM32 Timers PWM bindings
> -
> -Must be a sub-node of an STM32 Timers device tree node.
> -See ../mfd/stm32-timers.txt for details about the parent node.
> -
> -Required parameters:
> -- compatible:		Must be "st,stm32-pwm".
> -- pinctrl-names: 	Set to "default".
> -- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
> -			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> -- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
> -			bindings defined in pwm.txt.
> -
> -Optional parameters:
> -- st,breakinput:	One or two <index level filter> to describe break input configurations.
> -			"index" indicates on which break input (0 or 1) the configuration
> -			should be applied.
> -			"level" gives the active level (0=low or 1=high) of the input signal
> -			for this configuration.
> -			"filter" gives the filtering value to be applied.
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
> -		pwm {
> -			compatible = "st,stm32-pwm";
> -			#pwm-cells = <3>;
> -			pinctrl-0	= <&pwm1_pins>;
> -			pinctrl-names	= "default";
> -			st,breakinput = <0 1 5>;
> -		};
> -	};


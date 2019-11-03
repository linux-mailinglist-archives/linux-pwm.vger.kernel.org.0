Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7108EED307
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 12:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfKCLIt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 06:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKCLIt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 3 Nov 2019 06:08:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9974820842;
        Sun,  3 Nov 2019 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572779327;
        bh=FbaoVaWioLqr0Z7FxL6DKXeAOHtNY6YOT3zMnzdc8eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aD6PQEf1YtBiqkJF3yrAS2+/Z6KUwhqc68hNZX6/JK6K79E/SC6l/MJJK/XPvHMVo
         FKFtMgi5uMvstFpoEvL8wAOJ/0IAUtx1un5J0bwBbMya+o7K3qc6EBB8uSXwD0/x9c
         +PTJWqhrPJrpGPKRQQy4w5Ow7wodiZeOSRK/hR54=
Date:   Sun, 3 Nov 2019 11:08:41 +0000
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
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Message-ID: <20191103110841.3ad3ecfb@archlinux>
In-Reply-To: <20191031123040.26316-3-benjamin.gaignard@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
        <20191031123040.26316-3-benjamin.gaignard@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 31 Oct 2019 13:30:38 +0100
Benjamin Gaignard <benjamin.gaignard@st.com> wrote:

> Convert the STM32 IIO trigger binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
I'm far from great on these as still haven't taken the time I should to learn
the yaml syntax properly.  A few comments inline however based mostly on this
doesn't quite look like other ones I've seen recently.

Thanks,

Jonathan

> ---
>  .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++++++++++
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
>  2 files changed, 44 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> new file mode 100644
> index 000000000000..1c8c8b55e8cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Timers IIO timer bindings
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +properties:
> +  $nodemane:

nodename?

> +    pattern: "^timer@[0-9]+$"
> +    type: object
> +
> +    description:
> +      must be a sub-node of an STM32 Timer device tree node
> +
> +    properties:
> +      compatible:
> +        oneOf:

enum is I think preferred for these.

> +          - const: st,stm32-timer-trigger
> +          - const: st,stm32h7-timer-trigger
> +            
> +      reg: true

Normally some info for what the reg value is..

> +
> +    required:
> +      - compatible
> +      - reg
> +
> +examples:
> +  - |
> +    timers2: timer@40000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      timer@0 {
> +        compatible = "st,stm32-timer-trigger";
> +        reg = <0>;
> +      };
> +    };
> +    
> +...
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


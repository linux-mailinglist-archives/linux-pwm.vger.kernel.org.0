Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B710A77B99
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfG0Tsm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 15:48:42 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45078 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0Tsm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2019 15:48:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 69FA69E774D;
        Sat, 27 Jul 2019 20:48:39 +0100 (BST)
Date:   Sat, 27 Jul 2019 20:48:36 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Message-ID: <20190727204836.1514265d@archlinux>
In-Reply-To: <20190722154538.5314-2-david@lechnology.com>
References: <20190722154538.5314-1-david@lechnology.com>
        <20190722154538.5314-2-david@lechnology.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 22 Jul 2019 10:45:35 -0500
David Lechner <david@lechnology.com> wrote:

> This documents device tree binding for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Up to William given it is a counter binding, (unless Rob overrules)
but new bindings are generally preferred as yaml.

Content looks fine to me.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/counter/ti-eqep.txt    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.txt b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> new file mode 100644
> index 000000000000..fbcebc2c2cc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> @@ -0,0 +1,18 @@
> +Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
> +
> +Required properties:
> +- compatible:		Must be "ti,am3352-eqep".
> +- reg:			Physical base address and size of the registers map.
> +- clocks:		Handle to the PWM's functional clock.
> +- clock-names:		Must be "fck".
> +- interrupts:		Handle to the eQEP event interrupt
> +
> +Example:
> +
> +	eqep0: eqep@180 {
> +		compatible = "ti,am3352-eqep";
> +		reg = <0x180 0x80>;
> +		clocks = <&l4ls_gclk>;
> +		clock-names = "fck";
> +		interrupts = <79>;
> +	};


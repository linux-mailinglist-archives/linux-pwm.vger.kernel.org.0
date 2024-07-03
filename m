Return-Path: <linux-pwm+bounces-2695-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A792678A
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36443B2109E
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E921185E42;
	Wed,  3 Jul 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdkJI5WT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE117995;
	Wed,  3 Jul 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029672; cv=none; b=H/MKdj/drNNOp1OFEVvNNYYnItrmigABwgr1+X5ROIIdNn5qwdXzNdOvZlZR0it1RlDyz1KwDb4MXtqMyZAVscUuiPboMjQ0PcW93u9MryOJE+Dr+Fc3x/vy7dB3unEN690iYzWz/0YCyaQD4qYOjKpsaCZXZ6muBtC3d+JL9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029672; c=relaxed/simple;
	bh=Zf7O3ePlvok3MwLuehq8buoZy5+PWBs/kgvIKrrVIKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1BiRYs8nSWl9SipKYexNvOZVG1bdzlgpRba+SAT/A3bwL+HBK/h+HAu5b5mfmKCMzD38XN1Go10OMlowf/NGzsskv5NR0B9ABwR+1I4+/xpG9GEbA7e0y5ug0jXPP8KPSzXaqivwPtU6SO0MieQtKDQkCIpp9hbg+53p8GIEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdkJI5WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A5C2BD10;
	Wed,  3 Jul 2024 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720029672;
	bh=Zf7O3ePlvok3MwLuehq8buoZy5+PWBs/kgvIKrrVIKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdkJI5WT7xR8B3hhsVMq+7XqeIkJEsIaADXyaLtB4dJe9NXrYcxikXDJ/5KktssvA
	 7etBQGsm2VyizVMZQmA9ihpwtZYUhvkMhDqqm7DZaL9YJ8uOiDoPSmPVoICg9OuK8h
	 kf2w10dmNI2g0dOA0U+6i+Cgm8jgljOb/gfgRYI1OPkrO1v+GfL/rY1cUvohqOzaun
	 TOkDyEhrJNtkGWe8cABu77lnRtMdZJu1H5b2xga3Mp3ipQTM+FMCsdeacpzsjDre6d
	 /YbhzFbSXtxBcBUyDKr/EWUY3kR0SbLGgb2vJo3YUT8TlNsacvEqcfVsQLO/+01IoD
	 8zVzREV5iKd4A==
Date: Wed, 3 Jul 2024 12:01:11 -0600
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Leitner <richard.leitner@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 20/20] of: deprecate and rename of_property_for_each_u32()
Message-ID: <20240703180111.GA1245093-robh@kernel.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-20-42c1fc0b82aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-of_property_for_each_u32-v1-20-42c1fc0b82aa@bootlin.com>

On Wed, Jul 03, 2024 at 12:37:04PM +0200, Luca Ceresoli wrote:
> of_property_for_each_u32() is meant to disappear. All the call sites not
> using the 3rd and 4th arguments have already been replaced by
> of_property_for_each_u32_new().
> 
> Deprecate the old macro. Also rename it to minimize the number of new
> usages and encourage conversion to the of_property_for_each_u32_new() macro
> in not(-yet)-upstream code.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Notes:
> 
>  * The following files have not been build-tested simply because I haven't
>    managed to have a config that enables them so far:
> 
>      drivers/irqchip/irq-pic32-evic.c
>      drivers/pinctrl/pinctrl-k210.c
> 
>  * These have not been converted yet as they are not trivial, and they will
>    need to use a more specific function that does the lookup they need and
>    returns the result:
> 
>      drivers/clk/clk-si5351.c

I would do something like this:

	sz = of_property_read_variable_u32_array(np, "silabs,pll-source", array, 2, 4);
	if (sz >= 2)
		pdata->pll_src[array[0]] = val_to_src(array[1]);
	if (sz >= 4)
		pdata->pll_src[array[2]] = val_to_src(array[3]);


>      drivers/clk/clk.c

Wouldn't this work:

8<------------------------------------------------------

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8cca52be993f..33a8cc193556 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5371,6 +5371,7 @@ const char *of_clk_get_parent_name(const struct device_node *np, int index)
        int rc;
        int count;
        struct clk *clk;
+       bool found = false;
 
        rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
                                        &clkspec);
@@ -5383,15 +5384,16 @@ const char *of_clk_get_parent_name(const struct device_node *np, int index)
        /* if there is an indices property, use it to transfer the index
         * specified into an array offset for the clock-output-names property.
         */
-       of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
+       of_property_for_each_u32_new(clkspec.np, "clock-indices", pv) {
                if (index == pv) {
                        index = count;
+                       found = true;
                        break;
                }
                count++;
        }
        /* We went off the end of 'clock-indices' without finding it */
-       if (prop && !vp)
+       if (of_property_present(clkspec.np, "clock-indices") && !found)
                return NULL;
 
        if (of_property_read_string_index(clkspec.np, "clock-output-names",


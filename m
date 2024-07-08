Return-Path: <linux-pwm+bounces-2718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F4929D74
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 09:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C17A1F2267C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E338FA1;
	Mon,  8 Jul 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gh9N9Uw0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915132E3EB;
	Mon,  8 Jul 2024 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424750; cv=none; b=NgR0whhO6OV9IfubTDJPsRR5mZHJPjpmZXQV3nXenI5JJUr0//vI5+aWgfmWKeT8f1sl0MKykZ3byH/bvbIyEiWLB/Y+rM04Mgw5EeBMY09MRH+sR7RKXFnYzaGhPlHa2TAnsfsBZcrqMFra2N4je3CcYmmgr2t7rqnqe+Tj2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424750; c=relaxed/simple;
	bh=Ctg0u/mGa+VwyDSlNuzK+P613udK8Frsp14C56Ebnqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyoFKImpPMGN9sOnaJ8QVsZej0C6uOujQmNd6mYfLuIcZcFzEAyefJAQdrUqXzs28ZM0V4pr/iF0nHPtakwg6hsuXJooE90kNjNAmpeReUPOtsbgYjwY34V0iqh3PW0XjizHa/1KLpn7J7RPzwHUi5/LFTq+wi26IV0FDK6pvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gh9N9Uw0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720424745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6r0t4bqCeyTcKMQipHqJ13XIJ0M/NNLgBRa8TFFkq0k=;
	b=gh9N9Uw0u8C6T2INQwENuJbySC4x56TU/bCYId7J19tXTNv2leS8YvS59ZHGfqV5iEcc2W
	giRbXLJT0kVM9blL6cZF0eI0W/NaGwdLwsoCYd+qWtWL+ssOTOGgYIaHoZkEp8DXV+BDKD
	QBEscHkTSbtdZ0QzmCUfJBvJe1gdrAw=
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: saravanak@google.com
X-Envelope-To: nathan@kernel.org
X-Envelope-To: mturquette@baylibre.com
X-Envelope-To: sboyd@kernel.org
X-Envelope-To: tony@atomide.com
X-Envelope-To: andersson@kernel.org
X-Envelope-To: emilio@elopez.com.ar
X-Envelope-To: wens@csie.org
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: samuel@sholland.org
X-Envelope-To: krzk@kernel.org
X-Envelope-To: daniel.lezcano@linaro.org
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: florian.fainelli@broadcom.com
X-Envelope-To: bcm-kernel-feedback-list@broadcom.com
X-Envelope-To: linus.walleij@linaro.org
X-Envelope-To: brgl@bgdev.pl
X-Envelope-To: jic23@kernel.org
X-Envelope-To: lee@kernel.org
X-Envelope-To: shawnguo@kernel.org
X-Envelope-To: kernel@pengutronix.de
X-Envelope-To: ukleinek@kernel.org
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: jirislaby@kernel.org
X-Envelope-To: lgirdwood@gmail.com
X-Envelope-To: broonie@kernel.org
X-Envelope-To: nicolas.ferre@microchip.com
X-Envelope-To: mpe@ellerman.id.au
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: christophe.leroy@csgroup.eu
X-Envelope-To: naveen.n.rao@linux.ibm.com
X-Envelope-To: dlemoal@kernel.org
X-Envelope-To: peng.fan@oss.nxp.com
X-Envelope-To: thomas.petazzoni@bootlin.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: linux-clk@vger.kernel.org
X-Envelope-To: linux-omap@vger.kernel.org
X-Envelope-To: linux-arm-msm@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-sunxi@lists.linux.dev
X-Envelope-To: linux-samsung-soc@vger.kernel.org
X-Envelope-To: linux-gpio@vger.kernel.org
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-pwm@vger.kernel.org
X-Envelope-To: linux-serial@vger.kernel.org
X-Envelope-To: linux-usb@vger.kernel.org
X-Envelope-To: patches@opensource.cirrus.com
X-Envelope-To: linux-sound@vger.kernel.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: linux-riscv@lists.infradead.org
Date: Mon, 8 Jul 2024 09:45:39 +0200
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Bjorn Andersson <andersson@kernel.org>, 
	Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Damien Le Moal <dlemoal@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	llvm@lists.linux.dev, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 15/20] usb: usb251xb: convert to
 of_property_for_each_u32_new()
Message-ID: <34bbebxag4neccfkb4isi4bx5uvi2dk446bqqmfmtru4vwbehk@hp7vufvfyon4>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-15-42c1fc0b82aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-of_property_for_each_u32-v1-15-42c1fc0b82aa@bootlin.com>
X-Migadu-Flow: FLOW_OUT

Hi Luca,

On Wed, Jul 03, 2024 at 12:36:59PM GMT, Luca Ceresoli wrote:
> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

please feel free to add:

Acked-by: Richard Leitner <richard.leitner@linux.dev>

> ---
>  drivers/usb/misc/usb251xb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 7da404f55a6d..490004dbb9d8 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -382,11 +382,9 @@ static void usb251xb_get_ports_field(struct usb251xb *hub,
>  				    bool ds_only, u8 *fld)
>  {
>  	struct device *dev = hub->dev;
> -	struct property *prop;
> -	const __be32 *p;
>  	u32 port;
>  
> -	of_property_for_each_u32(dev->of_node, prop_name, prop, p, port) {
> +	of_property_for_each_u32_new(dev->of_node, prop_name, port) {
>  		if ((port >= ds_only ? 1 : 0) && (port <= port_cnt))
>  			*fld |= BIT(port);
>  		else
> 
> -- 
> 2.34.1



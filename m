Return-Path: <linux-pwm+bounces-5969-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26343AB5972
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE716C19D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1B2BE7CC;
	Tue, 13 May 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOJg0nk8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92A1DED77;
	Tue, 13 May 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152737; cv=none; b=D65lUNIPfxWCP1i8KhxAYwZUd4/4kWt9cAK1VOdXmR1PTbBPIuK14B91kdjFo6YiOEnMEkncMKc1WNDrA863yGPN72/PqhamWhvKZ5Zki+tQJKhqJCXrScUxMy7JGF67O/RRarxTghN+PujsyR2Zrj7lLOL8KiDZFO5sxjhAHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152737; c=relaxed/simple;
	bh=2aefmjxyDnxDNO6OiVmrY5fkLYtKdsDEmGqLPj3AGsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptkeA1bclxV6CAu2WOnSUN2HXdWTV02fPxtORpiJ601jWQQFl+bFQk0T/W1taLr1OmZRWxrVkdnKQ7GBZHu+EnrgiKXEAFA8xp+HnKmN/X/V7At9l48H2XgBcL/6N1z4AWE81dBXSAt0Ohtx/ii1nzRt/9n8O+DwMXlQaFWbgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOJg0nk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E30C4CEE4;
	Tue, 13 May 2025 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152735;
	bh=2aefmjxyDnxDNO6OiVmrY5fkLYtKdsDEmGqLPj3AGsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOJg0nk8Ne4r9d9FmEiwMg94QVPKbqC3+018ihTKNGP1v04C1SfZEVXYEWhWHKa+W
	 I5NHsK9e5jOYtE0NekO+anjZvYcI+AFXStDBLWVwE1oq6vXYf8N16mTUUqcDjFvPik
	 /kMWzyZvHdZL7bG1nzR1NfIxO0nFvyrqFP4GhZM8V1H6T+DleIfrxnlp0K9ug11d4P
	 +opzvIkAqvv7sis65NnKbY8mZ1cbmi6MJx71aVpik+CRKiGQn/vLAFj8+1tWvS4pjY
	 uc0ZMULC298N2HoBr/PLteGzXkIvGNXQbwOzVqSsOqYfVbPXIGqpRC1XjqEFFhWH1m
	 9hTnrcCEKpm3A==
Date: Tue, 13 May 2025 17:12:10 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
Message-ID: <20250513161210.GU2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
 <20250513143450.GM2936510@google.com>
 <8863db9b433d4911abba4480bb6ac59f799ed5c5.camel@gmail.com>
 <20250513151948.GA23592@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513151948.GA23592@pendragon.ideasonboard.com>

On Tue, 13 May 2025, Laurent Pinchart wrote:

> On Tue, May 13, 2025 at 04:02:11PM +0100, Nuno Sá wrote:
> > On Tue, 2025-05-13 at 15:34 +0100, Lee Jones wrote:
> > > On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> > > 
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > Not all devices (features) of the adp5585 device are mandatory to be
> > > > used in all platforms. Hence, check what's given in FW and dynamically
> > > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > > 
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/mfd/adp5585.c | 45 +++++++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0024d69886
> > > > e9fb7a 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -17,7 +17,13 @@
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/types.h>
> > > >  
> > > > -static const struct mfd_cell adp5585_devs[] = {
> > > > +enum {
> > > > +	ADP5585_DEV_GPIO,
> > > > +	ADP5585_DEV_PWM,
> > > > +	ADP5585_DEV_MAX
> > > > +};
> > > > +
> > > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
> > > >  	{ .name = "adp5585-gpio", },
> > > >  	{ .name = "adp5585-pwm", },
> > > >  };
> > > > @@ -110,12 +116,40 @@ static const struct regmap_config
> > > > adp5585_regmap_configs[] = {
> > > >  	},
> > > >  };
> > > >  
> > > > +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > > > *adp5585,
> > > > +			    struct mfd_cell **devs)
> > > > +{
> > > > +	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
> > > > +
> > > > +	if (device_property_present(dev, "#pwm-cells"))
> > > > +		has_pwm = 1;
> > > 
> > > This is a little sloppy.  Instead of using throwaway local variables, do
> > > what you're going to do in the if statement.
> > 
> > Then I would need to realloc my device cells... But as I realized below, this is
> > indeed not needed.
> > 
> > > > +	if (device_property_present(dev, "#gpio-cells"))
> > > > +		has_gpio = 1;
> > > > +
> > > > +	if (!has_pwm && !has_gpio)
> > > > +		return -ENODEV;
> > > 
> > > Are we really dictating which child devices to register based on random
> > > DT properties?  Why not register them anyway and have them fail if the
> 
> The properties are not random.
> 
> > > information they need is not available?  Missing / incorrect properties
> > > usually get a -EINVAL.
> > 
> > Well, this was something Laurent asked for... In the previous version I was
> > registering all the devices unconditionally.
> 
> Registering them all means we'll get error messages in the kernel log
> when the corresponding drivers will probe, while nothing is actually
> wrong. That's fairly confusing for the user.
> 
> In an ideal situation we would have child nodes in DT and only register
> child devices for existing child nodes. Unfortunately the DT bindings
> were not designed that way, so we have to live with the current
> situation.
> 
> > > > +	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
> > > > +			     GFP_KERNEL);
> > > > +	if (!*devs)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	if (has_pwm)
> > > > +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_PWM];
> > > > +	if (has_gpio)
> > > > +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_GPIO];
> > > 
> > > Passing around pointers to pointers for allocation (and later, pointer
> > > to functions) is not the way we wish to operate.  See how all of the
> > > other MFD drivers handle selective sub-drivers.
> > 
> > Any pointer from the top of your head (example driver)? Honestly, I do not see
> > this being that bad. Pretty much is a dynamic array of struct mfd_cel but
> > anyways, no strong feelings
> 
> I don't find it that bad either. I don't think you should use
> devm_kcalloc() though, as the memory should be freed as soon as it's not
> needed anymore.
> 
> > But... I was actually being very stupid. First I did looked at an API to only
> 
> Occasionally overseeing a possible solution isn't being stupid. Or at
> least I hope it isn't, otherwise I would be very stupid too.

Yes, likewise.  Never worry about that.

In general let's try to simplify things by not using pointers to
pointers and pointers to functions.  There are usually much nicer,
cleaner and simpler solutions.

IMHO, the above is C-hackery at its best.

Let's see where v4 takes us.

-- 
Lee Jones [李琼斯]


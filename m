Return-Path: <linux-pwm+bounces-6107-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D98AC2649
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A55CA232FC
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1C21B9F5;
	Fri, 23 May 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+yG4a3T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2E29B0;
	Fri, 23 May 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013575; cv=none; b=FzrLbBXrekqMRBdfpYCuCjZrj76ryZfSu3VjqPFy7oC7QjH+BdV5JFLyy0+UL4Yzh8XfC8U4eH51ua0YElgo7C9idcVKkZrXOl9oKmNuFzq04N/5qLlGamMni9mZtQUFyMUE/OEWg5HbVvp0FDAOXxdSbkEFZ1c0MsjKG+dcyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013575; c=relaxed/simple;
	bh=MQ0b9A9c/+xQvVpuMXh5/EktOaxqlJ4BG9/f88rEocQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id57acb1grGy//GuC15ixajf4aBB1LbVcpdIB7v9hJNI71Y/dTseSIcPIqQbDxiBhci5c9e/RoGyz9gqR//6FkMGuGuftupupDXlIxTvkhHfUVic2NCJbZYEx3tzcWEKipSWi6hNSfsKszVGxVENvsfLgggByjPcHHBWDSk2w0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+yG4a3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51965C4CEE9;
	Fri, 23 May 2025 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013575;
	bh=MQ0b9A9c/+xQvVpuMXh5/EktOaxqlJ4BG9/f88rEocQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+yG4a3T9+BIv9DY59kmyoz2176GQuevwjwmZKHyS6yxCb/KTxkYt5/wBizJI7XJV
	 sfwGTEIAFaWtUPJjC3TJtdWPaJbWLBdQdw9JyUo4G/UQlBMnOEgkvB+rwWsPCdknR9
	 rfB0JfLu0cCqZ1p68uL00L2wTvEH5DRBEFVhjCRs0s/rKL/SIDlukr3187eWucVFnw
	 6jQjKnvgCNbcQuJqNF2P3JUyVM4ZqQrhcZisHs0u4Hbfj1FFabkNr9w1ii9jW2VQGS
	 ahdYEEdTlQGJtJh4G63SUr7IYquRag5+J4P0C+uwDwLv0yZaHbWVwTLKdQLoRNkiS9
	 QFhs6O+9Lqafg==
Date: Fri, 23 May 2025 16:19:29 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v4 02/20] mfd: adp5585: only add devices given in FW
Message-ID: <20250523151929.GJ1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>
 <20250523145144.GF1378991@google.com>
 <196e5106d37121b394d0d70d34abeb33940c1de1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <196e5106d37121b394d0d70d34abeb33940c1de1.camel@gmail.com>

On Fri, 23 May 2025, Nuno Sá wrote:

> On Fri, 2025-05-23 at 15:51 +0100, Lee Jones wrote:
> > On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Not all devices (features) of the adp5585 device are mandatory to be
> > > used in all platforms. Hence, check what's given in FW and dynamically
> > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 48 +++++++++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 39 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..806867c56d6fb4ef1f461af26a424a3a05
> > > f46575 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -17,7 +17,13 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/types.h>
> > >  
> > > -static const struct mfd_cell adp5585_devs[] = {
> > > +enum {
> > > +	ADP5585_DEV_GPIO,
> > > +	ADP5585_DEV_PWM,
> > > +	ADP5585_DEV_MAX
> > > +};
> > > +
> > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
> > >  	{ .name = "adp5585-gpio", },
> > >  	{ .name = "adp5585-pwm", },
> > >  };
> > > @@ -110,6 +116,37 @@ static const struct regmap_config
> > > adp5585_regmap_configs[] = {
> > >  	},
> > >  };
> > >  
> > > +static void adp5585_remove_devices(void *dev)
> > > +{
> > > +	mfd_remove_devices(dev);
> > > +}
> > > +
> > > +static int adp5585_add_devices(struct device *dev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (device_property_present(dev, "#pwm-cells")) {
> > > +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > +				      &adp5585_devs[ADP5585_DEV_PWM], 1,
> > > NULL, 0, NULL);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "Failed to add pwm
> > > device\n");
> > 
> > PWM is an acronym, it should be capitalised.
> > 
> > > +	}
> > > +
> > > +	if (device_property_present(dev, "#gpio-cells")) {
> > > +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > +				      &adp5585_devs[ADP5585_DEV_GPIO], 1,
> > > NULL, 0, NULL);
> > > +		if (ret) {
> > > +			ret = dev_err_probe(dev, ret, "Failed to add gpio
> > > device\n");
> > 
> > Same with GPIO.
> > 
> > > +			goto out_error;
> > > +		}
> > > +	}
> > > +
> > > +	return devm_add_action_or_reset(dev, adp5585_remove_devices, dev);
> > 
> > We have 2 of these now.
> > 
> > Why do we need lots of unbinding functions?
> > 
> > What's wrong .remove() or devm_*()?
> 
> I do mention in the cover why I did not used devm_mfd_add_devices(). We would be
> adding an action per device and mfd_remove_devices() removes all of them in one
> call. Not that is an issue (I believe subsequent calls with be kind of no-ops)
> but this way felt more correct.

I haven't seen another device add a .remove() equivalent per device.

Why do you need it?  What's the use-case where this would become critical?

-- 
Lee Jones [李琼斯]


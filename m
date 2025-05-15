Return-Path: <linux-pwm+bounces-5993-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694FAB7E41
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 08:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18497ACB41
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 06:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FF27CCF5;
	Thu, 15 May 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQkgj75J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60D1C27;
	Thu, 15 May 2025 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291568; cv=none; b=D7GvksTKgDgtkcsEU2+9svkwn5pVg9xdx+sZRKzZUhG6gUhREznmYmgq6Jp9XbPbnNjqi6QYfujWK1LAjfqe3086OsyObQft86EQw243AQg/s+4VkQ3W3ZM9w1o/Woys0B0eKSRIdITLRhJ7DPSDyN34PMbvxfDinOJ0rD0+shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291568; c=relaxed/simple;
	bh=ikBz5LiUGUHOkhI4D5dUpL34JF4TY+y0f85pLCP3wwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpuKaYoxMDpMMKR8+ab5EikRUvd2VHN+I2ZGBbd3FNtPjhR9CsqsEIKjnSvTUoIuD/9sCMkrn2iHVeaRrEIJ+86Wu8V8zsS6NAGXRx4RUcv3sQz6ggS88omj+NiOAAYCg1lrGmnPaS4S0173R7gSLnCErAnD3MCY1pdvqYxeYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQkgj75J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso5597875e9.0;
        Wed, 14 May 2025 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747291565; x=1747896365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ip8TkvRbPXcsEhu0OT7fdyOavaf2G/sYDEsWUP/SwZY=;
        b=SQkgj75J+2EbuMloGOqyD+yZfyONGJglNu2qCL8SFWhQSBXa+RHxK2/1rtEhFtMfOI
         TVKVscmtTzYEbcbZcJ8e4y9V5Z/Jy0sKsr/RHR/3lQUwtjDNz5n77rWoC42tXkll5gJp
         vylLtZbOnaupz5pVUfKDlJe6DbMhXVicIvzxELJhk0mSTySln881CZ2arW5jLw9NY8V3
         1KcN4GUrh8yggNfyaCUe0MV41v6mWlcnL+np7+2Bqs6P89qukPbZTZD0Rr3TXlS3RJIH
         k/sIryyoKml25mU95kk7IJDXxQMFQ6EvfcHx8KlXy+H1G/FEcINkoXxU3hyTysFsgLQZ
         TuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747291565; x=1747896365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ip8TkvRbPXcsEhu0OT7fdyOavaf2G/sYDEsWUP/SwZY=;
        b=UONjTditGFyk4VO4gO+wtfgSfzZC4V/a/bo9w3uX2epnVFECAV0CsVnIuJfXCMJx6K
         pcDvNm67jt714YKNIyiMU5YXJLAzt1D66MRrDnQPDMToZx4yuO8zoqHCSlCPQFLwM1fC
         BMMT13Vqpx5/mRAaM1db4OYd/2OF07VsJbwtWIOIlQYwye1qn7M92L3q4d8eX8UTr7Wk
         nc0kwAAsBRW+iqX5QEiyjMfnYZdtRW5X7HgKtIlEQqEK6Z60XdYnMyZ89CXXHZjbhI6c
         jbeXVa0ODjB5/oWdRoQMkSOrAyDy2l8UyxAh+4BFIETY04wXw5r8Y2yQyOFn5eAfVd+p
         0vTA==
X-Forwarded-Encrypted: i=1; AJvYcCU/jtlBGcMJIf89f8RT/X6QzNSjbIlw4AHI2jlEoBemUknMc0iET4/B4if3nyUS7DpiSorQp6fB+G1h@vger.kernel.org, AJvYcCV6yo2zqoCIMB91mao/5Jgfvzw545M7xnzj3zeU8OB7gBKdbtMOu95Hz9FmpsnLX3lhwAk5U/rMymmhsQ==@vger.kernel.org, AJvYcCVtUWyhTF5jDvAwPB2vp3tiYB23gj/d2jM7SxmxBSWpltHLV7zUofemMUdFcPvTXC6ru51zT9k9FQCK@vger.kernel.org, AJvYcCXpSfg737FQaYA7mo2u9O5YS3NQ5j9OcC9WBsW/nKHsp1e2CjCQKeEsLzSr+w+anYeoHCNdczHUv4NA5pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlNvcD+LYTZDg8hlLCmU/p53bEFs/70WOH/8O0vB4nRXoXi4F
	ngEIaN6Y7DcpC7ai1wy9VBlhV9LDcMVWyccdoLDZB9NCCR8KcAv6
X-Gm-Gg: ASbGncvJVRNVMJPREfS01EO1vqgYQ4WB+UO4vzr+SLTpw4oe0HH2fcY5PiSNQi327cW
	gaP6jcjCMyzCQ1Qv/2RJXjLiLeplEEmqaUbHLNPNhSlnMpEcTpsRLTBrfmcTyv6z1iyrOA3eDru
	fsLZNPObVSjBgxm19LGJ32hSGJQ/P8d2H5+KEnqsi4LUhoEFabTLrrOgCHYQh/mcc+5QiinQXzv
	vD73w00R/La5+H31vhMhID56GmtbWohxfkYbZOyxz+hbV7+nLBomqD7ml4axnYb+vGhx4lc2Jn5
	xx8ZMil0z+xfTsFxtiS+ElGw5hYyzMx96seSsj1TpY8LuZQjfWHGf3+Bdc1UaKG1OOOLaFcCZ02
	bmQOE26yprnx9dGnNId/SGyG5D6YNhWTr0N8+
X-Google-Smtp-Source: AGHT+IGEa/kWpPWMoTLkzUQD/WXBfOC2suuSCHEhZIFhvtq5CP6KBCJLWm8qlf/OiW4kqPhpdf1htQ==
X-Received: by 2002:a05:600c:c09:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-442f2168c29mr47253855e9.23.1747291564285;
        Wed, 14 May 2025 23:46:04 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368fbasm56680835e9.2.2025.05.14.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:46:03 -0700 (PDT)
Message-ID: <35b609ce76bfbe5d0964486ba97cd8e3428dda16.camel@gmail.com>
Subject: Re: [PATCH v3 14/22] mfd: adp5585: support reset and unlock events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones
	 <lee@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Thu, 15 May 2025 06:46:29 +0100
In-Reply-To: <20250514083541.GG23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-14-092b14b79a88@analog.com>
	 <20250513162246.GV2936510@google.com>
	 <20250514083541.GG23592@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-14 at 10:35 +0200, Laurent Pinchart wrote:
> On Tue, May 13, 2025 at 05:22:46PM +0100, Lee Jones wrote:
> > On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> >=20
> > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >=20
> > > The ADP558x family of devices can be programmed to respond to some
> > > especial events, In case of the unlock events, one can lock the keypa=
d
> > > and use KEYS or GPIs events to unlock it. For the reset events, one c=
an
> > > again use a combinations of GPIs/KEYs in order to generate an event t=
hat
> > > will trigger the device to generate an output reset pulse.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 279=
 ++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 41 +++++++
> > > =C2=A02 files changed, 320 insertions(+)
> > >=20
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 5851ad30e7323bbb891878167d0786bc60ef5d90..b1227a390fe2f932ba8060b0d72=
2f53f45ec3
> > > b4b 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -157,6 +157,9 @@ static const struct adp5585_regs adp5585_regs =3D=
 {
> > > =C2=A0	.int_en =3D ADP5585_INT_EN,
> > > =C2=A0	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > > =C2=A0	.poll_ptime_cfg =3D ADP5585_POLL_PTIME_CFG,
> > > +	.reset_cfg =3D ADP5585_RESET_CFG,
> > > +	.reset1_event_a =3D ADP5585_RESET1_EVENT_A,
> > > +	.reset2_event_a =3D ADP5585_RESET2_EVENT_A,
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static const struct adp5585_regs adp5589_regs =3D {
> > > @@ -164,8 +167,52 @@ static const struct adp5585_regs adp5589_regs =
=3D {
> > > =C2=A0	.int_en =3D ADP5589_INT_EN,
> > > =C2=A0	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > > =C2=A0	.poll_ptime_cfg =3D ADP5589_POLL_PTIME_CFG,
> > > +	.reset_cfg =3D ADP5589_RESET_CFG,
> > > +	.reset1_event_a =3D ADP5589_RESET1_EVENT_A,
> > > +	.reset2_event_a =3D ADP5589_RESET2_EVENT_A,
> > > =C2=A0};
> > > =C2=A0
> > > +static int adp5585_validate_event(const struct adp5585_dev *adp5585,
> > > +				=C2=A0 unsigned int ev, bool has_pin5)
> >=20
> > has_pin5 (which doesn't actually mean much to me) is passed around a lo=
t
> > and is only used in one place, as far as I can see.=C2=A0 You also have=
 'dev'
> > available here, so why not drop it everywhere and call
> >=20
> > =C2=A0=C2=A0 if (!device_property_present(dev, "gpio-reserved-ranges"))
> >=20
> > ... here instead?
>=20
> The information can be stored in struct adp5585_dev. I wouldn't call
> device_property_present() here, as that's costly.

That's the plan for v4. TBH, I was never happy with attaching the pin5/row5
information with that property (I think something explicit in chip data str=
ucture to
be better) but this was a sneaky way of avoiding another chip_info varriabl=
e for the
the variant with this pin available.

But now that we'll be adding enums, It's easier.

>=20
> > > +{
> > > +	if (has_pin5) {
> > > +		if (ev >=3D ADP5585_ROW5_KEY_EVENT_START && ev <=3D
> > > ADP5585_ROW5_KEY_EVENT_END)
> > > +			return 0;
> > > +		if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D
> > > ADP5585_GPI_EVENT_END)
> > > +			return 0;
> > > +
> > > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for thi=
s
> > > device\n", ev);
> > > +	}
> > > +
> > > +	if (ev >=3D ADP5585_KEY_EVENT_START && ev <=3D ADP5585_KEY_EVENT_EN=
D)
> > > +		return 0;
> > > +	if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D ADP5585_GPI_EVENT_EN=
D) {
> > > +		/* if it's GPI5 */
> > > +		if (ev =3D=3D (ADP5585_GPI_EVENT_START + 5))
> > > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u).
> > > R5 not available\n",
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 ev);
> > > +		return 0;
> > > +	}
> > > +
> > > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for this
> > > device\n", ev);
> > > +}
> > > +
> > > +static int adp5589_validate_event(const struct adp5585_dev *adp5585,
> > > +				=C2=A0 unsigned int ev, bool has_pin5)
> > > +{
> > > +	if (ev >=3D ADP5589_KEY_EVENT_START && ev <=3D ADP5589_KEY_EVENT_EN=
D)
> > > +		return 0;
> > > +	if (ev >=3D ADP5589_GPI_EVENT_START && ev <=3D ADP5589_GPI_EVENT_EN=
D)
> > > +		return 0;
> > > +
> > > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for this
> > > device\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 ev);
> > > +}
> > > +
> > > =C2=A0static int adp5585_fill_chip_configs(struct adp5585_dev *adp558=
5,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_client *i2c,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config *regmap_confi=
g)
> > > @@ -180,10 +227,13 @@ static int adp5585_fill_chip_configs(struct adp=
5585_dev
> > > *adp5585,
> > > =C2=A0	case ADP5585_MAN_ID_VALUE:
> > > =C2=A0		*regmap_config =3D adp5585_regmap_config_template;
> > > =C2=A0		info->regs =3D &adp5585_regs;
> > > +		info->validate_event =3D adp5585_validate_event;
> >=20
> > I'd take an extra if() / switch() over a driver-level pointer to a func=
tion.
>=20
> Funny how we have different tastes for this kind of things, I find the
> function pointer more readable :-)

Yes :)

- Nuno S=C3=A1

>=20
> > > =C2=A0		break;
> > > =C2=A0	case ADP5589_MAN_ID_VALUE:
> > > =C2=A0		*regmap_config =3D adp5589_regmap_config_template;
> > > =C2=A0		info->regs =3D &adp5589_regs;
> > > +		info->validate_event =3D adp5589_validate_event;
> > > +		info->has_unlock =3D true;
> > > =C2=A0		break;
> > > =C2=A0	default:
> > > =C2=A0		return -ENODEV;
> > > @@ -215,11 +265,175 @@ static int adp5585_fill_chip_configs(struct ad=
p5585_dev
> > > *adp5585,
> > > =C2=A0	}
> > > =C2=A0}
> > > =C2=A0
> > > +static int adp5585_parse_ev_array(const struct adp5585_dev *adp5585,
> > > +				=C2=A0 const char *prop, u32 *events, u32
> > > *n_events,
> > > +				=C2=A0 u32 max_keys, bool reset_key, bool has_pin5)
> > > +{
> >=20
> > It's not clear to me what's happening in here.=C2=A0 Would you be kind =
enough
> > to add some commentary for readers who don't know the device?
> >=20
> > In fact, that applies throughout the driver please.
> >=20
> > > +	const struct adp5585_info *info =3D adp5585->info;
> > > +	struct device *dev =3D adp5585->dev;
> > > +	unsigned int ev;
> > > +	int ret;
> > > +
> > > +	ret =3D device_property_count_u32(dev, prop);
> > > +	if (ret < 0)
> > > +		return 0;
> > > +
> > > +	*n_events =3D ret;
> > > +
> > > +	if (!info->has_unlock && !reset_key)
> > > +		return dev_err_probe(dev, -EOPNOTSUPP,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unlock keys not supported\n");
> > > +
> > > +	if (*n_events > max_keys)
> > > +		return dev_err_probe(dev, -EINVAL,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid number of keys(%u > %u) for
> > > %s\n",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 *n_events, max_keys, prop);
> > > +
> > > +	ret =3D device_property_read_u32_array(dev, prop, events, *n_events=
);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	for (ev =3D 0; ev < *n_events; ev++) {
> > > +		/* wildcard key */
> > > +		if (!reset_key && events[ev] =3D=3D 127)
> > > +			continue;
> > > +
> > > +		ret =3D adp5585->info->validate_event(adp5585, events[ev],
> > > has_pin5);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int adp5585_unlock_ev_parse(struct adp5585_dev *adp5585, bool=
 has_pin5)
> > > +{
> > > +	struct device *dev =3D adp5585->dev;
> > > +	int ret;
> > > +
> > > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,unlock-events",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->unlock_keys,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_unlock,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->unlock_keys), false=
,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 has_pin5);
> > > +	if (ret)
> > > +		return ret;
> > > +	if (!adp5585->nkeys_unlock)
> > > +		return 0;
> > > +
> > > +	ret =3D device_property_read_u32(dev, "adi,unlock-trigger-sec",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->unlock_time);
> > > +	if (!ret) {
> > > +		if (adp5585->unlock_time > ADP5585_MAX_UNLOCK_TIME_SEC)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock time(%u > %d)\n",
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->unlock_time,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_MAX_UNLOCK_TIME_SEC);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int adp5585_reset_ev_parse(struct adp5585_dev *adp5585, bool =
has_pin5)
> > > +{
> > > +	struct device *dev =3D adp5585->dev;
> > > +	u32 prop_val;
> > > +	int ret;
> > > +
> > > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,reset1-events",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->reset1_keys,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset1,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset1_keys), true,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 has_pin5);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,reset2-events",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->reset2_keys,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset2,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset2_keys), true,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 has_pin5);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
> > > +		return 0;
> > > +
> > > +	if (adp5585->nkeys_reset1 && device_property_read_bool(dev,
> > > "adi,reset1-active-high"))
> > > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RESET1_POL, 1);
> > > +
> > > +	if (adp5585->nkeys_reset2 && device_property_read_bool(dev,
> > > "adi,reset2-active-high"))
> > > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RESET2_POL, 1);
> > > +
> > > +	if (device_property_read_bool(dev, "adi,rst-passthrough-enable"))
> > > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RST_PASSTHRU_EN, 1);
> > > +
> > > +	ret =3D device_property_read_u32(dev, "adi,reset-trigger-ms",
> > > &prop_val);
> > > +	if (!ret) {
> > > +		switch (prop_val) {
> > > +		case 0:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
> > > +			break;
> > > +		case 1000:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
> > > +			break;
> > > +		case 1500:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
> > > +			break;
> > > +		case 2000:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
> > > +			break;
> > > +		case 2500:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
> > > +			break;
> > > +		case 3000:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
> > > +			break;
> > > +		case 3500:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
> > > +			break;
> > > +		case 4000:
> > > +			adp5585->reset_cfg |=3D
> > > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
> > > +			break;
> > > +		default:
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for adi,reset-
> > > trigger-ms\n",
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > > +		}
> > > +	}
> > > +
> > > +	ret =3D device_property_read_u32(dev, "adi,reset-pulse-width-us",
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &prop_val);
> > > +	if (!ret) {
> > > +		switch (prop_val) {
> > > +		case 500:
> > > +			adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_PULSE_WIDTH,
> > > 0);
> > > +			break;
> > > +		case 1000:
> > > +			adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_PULSE_WIDTH,
> > > 1);
> > > +			break;
> > > +		case 2000:
> > > +			adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_PULSE_WIDTH,
> > > 2);
> > > +			break;
> > > +		case 10000:
> > > +			adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_PULSE_WIDTH,
> > > 3);
> > > +			break;
> > > +		default:
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for adi,reset-
> > > pulse-width-us\n",
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > =C2=A0static int adp5585_parse_fw(struct device *dev, struct adp5585_=
dev *adp5585,
> > > =C2=A0			=C2=A0=C2=A0=C2=A0 struct mfd_cell **devs)
> > > =C2=A0{
> > > =C2=A0	unsigned int has_pwm =3D 0, has_gpio =3D 0, rc =3D 0;
> > > =C2=A0	const struct mfd_cell *cells;
> > > +	bool has_pin5 =3D false;
> > > =C2=A0	unsigned int prop_val;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > @@ -232,6 +446,17 @@ static int adp5585_parse_fw(struct device *dev, =
struct
> > > adp5585_dev *adp5585,
> > > =C2=A0	if (!has_pwm && !has_gpio)
> > > =C2=A0		return -ENODEV;
> > > =C2=A0
> > > +	if (!device_property_present(dev, "gpio-reserved-ranges"))
> > > +		has_pin5 =3D true;
> > > +
> > > +	ret =3D adp5585_unlock_ev_parse(adp5585, has_pin5);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D adp5585_reset_ev_parse(adp5585, has_pin5);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > =C2=A0	ret =3D device_property_read_u32(dev, "poll-interval", &prop_v=
al);
> > > =C2=A0	if (!ret) {
> > > =C2=A0		switch (prop_val) {
> > > @@ -344,6 +569,60 @@ static int adp5585_setup(struct adp5585_dev *adp=
5585)
> > > =C2=A0	unsigned int reg_val, i;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > +	for (i =3D 0; i < adp5585->nkeys_unlock; i++) {
> > > +		ret =3D regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
> > > +				=C2=A0=C2=A0 adp5585->unlock_keys[i] |
> > > ADP5589_UNLOCK_EV_PRESS);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (adp5585->nkeys_unlock) {
> > > +		ret =3D regmap_update_bits(adp5585->regmap,
> > > ADP5589_UNLOCK_TIMERS,
> > > +					 ADP5589_UNLOCK_TIMER,
> > > +					 adp5585->unlock_time);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret =3D regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5589_LOCK_EN);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	for (i =3D 0; i < adp5585->nkeys_reset1; i++) {
> > > +		ret =3D regmap_write(adp5585->regmap, regs->reset1_event_a + i,
> > > +				=C2=A0=C2=A0 adp5585->reset1_keys[i] |
> > > ADP5585_RESET_EV_PRESS);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	for (i =3D 0; i < adp5585->nkeys_reset2; i++) {
> > > +		ret =3D regmap_write(adp5585->regmap, regs->reset2_event_a + i,
> > > +				=C2=A0=C2=A0 adp5585->reset2_keys[i] |
> > > ADP5585_RESET_EV_PRESS);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
> > > +		ret =3D regmap_write(adp5585->regmap, regs->reset_cfg,
> > > +				=C2=A0=C2=A0 adp5585->reset_cfg);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		reg_val =3D 0;
> > > +		if (adp5585->nkeys_reset1)
> > > +			reg_val =3D ADP5585_R4_EXTEND_CFG_RESET1;
> > > +		if (adp5585->nkeys_reset2)
> > > +			reg_val |=3D ADP5585_C4_EXTEND_CFG_RESET2;
> > > +
> > > +		ret =3D regmap_update_bits(adp5585->regmap, regs->ext_cfg,
> > > +					 ADP5585_C4_EXTEND_CFG_MASK |
> > > +					 ADP5585_R4_EXTEND_CFG_MASK,
> > > +					 reg_val);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > =C2=A0	for (i =3D 0; i < ADP5585_EV_MAX; i++) {
> > > =C2=A0		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
> > > &reg_val);
> > > =C2=A0		if (ret)
> > > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.=
h
> > > index
> > > 218c56bed2e0304de8b81c7090386fb4e1b6c281..034b7c18af83b1e801860ed4fca=
1755ff59fa
> > > ed1 100644
> > > --- a/include/linux/mfd/adp5585.h
> > > +++ b/include/linux/mfd/adp5585.h
> > > @@ -71,6 +71,7 @@
> > > =C2=A0#define ADP5585_GPIO_DIRECTION_A	0x27
> > > =C2=A0#define ADP5585_GPIO_DIRECTION_B	0x28
> > > =C2=A0#define ADP5585_RESET1_EVENT_A		0x29
> > > +#define		ADP5585_RESET_EV_PRESS		BIT(7)
> > > =C2=A0#define ADP5585_RESET1_EVENT_B		0x2a
> > > =C2=A0#define ADP5585_RESET1_EVENT_C		0x2b
> > > =C2=A0#define ADP5585_RESET2_EVENT_A		0x2c
> > > @@ -121,6 +122,13 @@
> > > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > > =C2=A0
> > > =C2=A0#define ADP5585_PIN_MAX			11
> > > +#define ADP5585_MAX_UNLOCK_TIME_SEC	7
> > > +#define ADP5585_KEY_EVENT_START		1
> > > +#define ADP5585_KEY_EVENT_END		25
> > > +#define ADP5585_GPI_EVENT_START		37
> > > +#define ADP5585_GPI_EVENT_END		47
> > > +#define ADP5585_ROW5_KEY_EVENT_START	1
> > > +#define ADP5585_ROW5_KEY_EVENT_END	30
> > > =C2=A0
> > > =C2=A0/* ADP5589 */
> > > =C2=A0#define		ADP5589_MAN_ID_VALUE		0x10
> > > @@ -131,6 +139,20 @@
> > > =C2=A0#define ADP5589_GPO_DATA_OUT_A		0x2a
> > > =C2=A0#define ADP5589_GPO_OUT_MODE_A		0x2d
> > > =C2=A0#define	ADP5589_GPIO_DIRECTION_A	0x30
> > > +#define ADP5589_UNLOCK1			0x33
> > > +#define		ADP5589_UNLOCK_EV_PRESS		BIT(7)
> > > +#define ADP5589_UNLOCK_TIMERS		0x36
> > > +#define		ADP5589_UNLOCK_TIMER		GENMASK(2, 0)
> > > +#define ADP5589_LOCK_CFG		0x37
> > > +#define		ADP5589_LOCK_EN			BIT(0)
> > > +#define ADP5589_RESET1_EVENT_A		0x38
> > > +#define ADP5589_RESET2_EVENT_A		0x3B
> > > +#define ADP5589_RESET_CFG		0x3D
> > > +#define		ADP5585_RESET2_POL		BIT(7)
> > > +#define		ADP5585_RESET1_POL		BIT(6)
> > > +#define		ADP5585_RST_PASSTHRU_EN		BIT(5)
> > > +#define		ADP5585_RESET_TRIG_TIME		GENMASK(4, 2)
> > > +#define		ADP5585_PULSE_WIDTH		GENMASK(1, 0)
> > > =C2=A0#define ADP5589_PWM_OFFT_LOW		0x3e
> > > =C2=A0#define ADP5589_PWM_ONT_LOW		0x40
> > > =C2=A0#define ADP5589_PWM_CFG			0x42
> > > @@ -141,8 +163,13 @@
> > > =C2=A0#define ADP5589_MAX_REG			ADP5589_INT_EN
> > > =C2=A0
> > > =C2=A0#define ADP5589_PIN_MAX			19
> > > +#define ADP5589_KEY_EVENT_START		1
> > > +#define ADP5589_KEY_EVENT_END		88
> > > +#define ADP5589_GPI_EVENT_START		97
> > > +#define ADP5589_GPI_EVENT_END		115
> > > =C2=A0
> > > =C2=A0struct regmap;
> > > +struct adp5585_dev;
> > > =C2=A0
> > > =C2=A0enum adp5585_regmap_type {
> > > =C2=A0	ADP5585_REGMAP_00,
> > > @@ -165,12 +192,18 @@ struct adp5585_regs {
> > > =C2=A0	unsigned int ext_cfg;
> > > =C2=A0	unsigned int int_en;
> > > =C2=A0	unsigned int poll_ptime_cfg;
> > > +	unsigned int reset_cfg;
> > > +	unsigned int reset1_event_a;
> > > +	unsigned int reset2_event_a;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0struct adp5585_info {
> > > =C2=A0	const struct adp5585_regs *regs;
> > > +	int (*validate_event)(const struct adp5585_dev *adp5585,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ev, bool has_pin5);
> > > =C2=A0	enum adp5585_regmap_type regmap_type;
> > > =C2=A0	unsigned int id;
> > > +	bool has_unlock;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0struct adp5585_dev {
> > > @@ -182,6 +215,14 @@ struct adp5585_dev {
> > > =C2=A0	struct list_head ev_handlers;
> > > =C2=A0	int irq;
> > > =C2=A0	unsigned int ev_poll_time;
> > > +	unsigned int unlock_time;
> > > +	unsigned int unlock_keys[2];
> > > +	unsigned int nkeys_unlock;
> > > +	unsigned int reset1_keys[3];
> > > +	unsigned int nkeys_reset1;
> > > +	unsigned int reset2_keys[2];
> > > +	unsigned int nkeys_reset2;
> > > +	u8 reset_cfg;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static inline void adp5585_ev_handler_remove(void *data)
>=20



Return-Path: <linux-pwm+bounces-4644-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EFA14DBF
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8196188B56B
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8A1FC0F5;
	Fri, 17 Jan 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mI3SylOo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FD1F76AD;
	Fri, 17 Jan 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110313; cv=none; b=AknHxFfzG6/v3wlZp7YKalANeOCOR9WtlySczRQUx7MKsgCv9cOs4xWBHfhM/JeEPDbcembz9zLSvd/NLtOdLdMpcJMB1Lzj26KYFNgiEVAYLLfq935jCKFcSIctuUmfLPScbxSTJ2dQiZLAquRYyO2JiZZtYeKmAq95AJMghu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110313; c=relaxed/simple;
	bh=kVtggdSW98bJORlZYnpdBDvmyfatrIrOsHKYOjQdcg0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=twUp3ikmxHJEPlTRHUU11cghWqyobFbe4+GQHNN+y9c9RWK+aADuMppCDn+/SiZIhXOZYcYNiFxxPySSYBrdf5teH22537XnLNRI3KSdkZdctcOvSv2NRGX8nf3UnDPSheERzFULgDDono6/JsisikldT4l3amE77MuhN/9qL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mI3SylOo; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF76CFF808;
	Fri, 17 Jan 2025 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737110308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjGnIYbv6jLQCj2OibAy1kloN5lKwcFpRZ7BkKxb2m4=;
	b=mI3SylOolo/uYot+pulW1bc3DvAvLtyvq+Q0dgQut4sjdvUhJEOsPCINGrW6+deX43bgHr
	YFyuJyOUgjtIG4lyH747+xphSOXW5nQ56EtWtCrmlwIzzWdup7mFJGvG84e65Y3PBe671Q
	9gbj4C9OWfxeZIZdxD4V0wRaw13FCGnYBgFPs9TwmAK/Pxj6/aOJ2GVu0EnVoshNm2v+7e
	TVwTdMzmFQx9dlY9WM6YqmcEd6gpk1eZoQucYWwoVjtMq2N/7W0JWo+rycUEm4M8i9h/9W
	oi98hSBotDEK/7hcOznKafcVbQpryhy2+f6lz0hHZhjS99SMAnEllYHH4OLMlg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 11:38:27 +0100
Message-Id: <D74A7MIVLFS2.HYUXZ072NCTQ@bootlin.com>
To: "Lee Jones" <lee@kernel.org>
Subject: Re: [PATCH v3 2/7] mfd: Add max7360 support
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-2-9519b4acb0b1@bootlin.com>
 <20250115154252.GK6763@google.com>
In-Reply-To: <20250115154252.GK6763@google.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Jan 15, 2025 at 4:42 PM CET, Lee Jones wrote:
> On Mon, 13 Jan 2025, mathieu.dubois-briand@bootlin.com wrote:
>
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > Add core driver to support MAX7360 i2c chip, multi function device
> > with keypad, gpio, pwm, gpo and rotary encoder submodules.
> >=20
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.c=
om>
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
...
> > +static int max7360_set_gpos_count(struct max7360_mfd *max7360_mfd)
> > +{
> > +	/*
> > +	 * Max7360 COL0 to COL7 pins can be used either as keypad columns,
> > +	 * general purpose output or a mix of both.
> > +	 * Get the number of pins requested by the corresponding drivers, ens=
ure
> > +	 * they are compatible with each others and apply the corresponding
> > +	 * configuration.
> > +	 */
> > +	struct device_node *np;
> > +	u32 gpos =3D 0;
> > +	u32 columns =3D 0;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	np =3D of_get_compatible_child(max7360_mfd->dev->of_node, GPO_COMPATI=
BLE);
>
> Why don't you do all of this in the GPO driver?
>

I first did this here, so the configuration was still done if the GPO
driver was missing. But on a second thought, we can just set the GPO
count to 0 here, and let the GPO driver handle all of this.

I will move this function to the GPO driver.

> > +	if (np) {
> > +		ret =3D of_property_read_u32(np, "ngpios", &gpos);
> > +		if (ret < 0) {
> > +			dev_err(max7360_mfd->dev, "Failed to read gpos count\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	ret =3D device_property_read_u32(max7360_mfd->dev,
> > +				       "keypad,num-columns", &columns);
> > +	if (ret < 0) {
> > +		dev_err(max7360_mfd->dev, "Failed to read columns count\n");
> > +		return ret;
> > +	}
> > +
> > +	if (gpos > MAX7360_MAX_GPO ||
> > +	    (gpos + columns > MAX7360_MAX_KEY_COLS)) {
> > +		dev_err(max7360_mfd->dev,
> > +			"Incompatible gpos and columns count (%u, %u)\n",
> > +			gpos, columns);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad deboun=
ce
> > +	 * timings and gpos/keypad columns repartition. Only the later is
> > +	 * modified here.
> > +	 */
> > +	val =3D FIELD_PREP(MAX7360_PORTS, gpos);
> > +	ret =3D regmap_write_bits(max7360_mfd->regmap, MAX7360_REG_DEBOUNCE,
> > +				MAX7360_PORTS, val);
> > +	if (ret) {
> > +		dev_err(max7360_mfd->dev,
> > +			"Failed to write max7360 columns/gpos configuration");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int max7360_port_pin_request(struct device *dev, unsigned int pin, boo=
l request)
>
> This whole function is rough.  What are you trying to achieve?
>

Some pins can be used either for PWM, rotary encoder or GPIO. The goal
here is to allow corresponding drivers to request the pin, making sure
only one driver use a given pin at some point.

> > +{
> > +	struct i2c_client *client;
> > +	struct max7360_mfd *max7360_mfd;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	client =3D to_i2c_client(dev);
> > +	max7360_mfd =3D i2c_get_clientdata(client);
> > +
> > +	spin_lock_irqsave(&request_lock, flags);
> > +	if (request) {
> > +		if (max7360_mfd->requested_ports & BIT(pin))
> > +			ret =3D -EBUSY;
> > +		else
> > +			max7360_mfd->requested_ports |=3D BIT(pin);
> > +	} else {
> > +		max7360_mfd->requested_ports &=3D ~BIT(pin);
> > +	}
> > +	spin_unlock_irqrestore(&request_lock, flags);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(max7360_port_pin_request);
...
> > +static int max7360_reset(struct max7360_mfd *max7360_mfd)
> > +{
> > +	int err;
> > +
> > +	/*
> > +	 * Set back the default values.
> > +	 * We do not use GPIO reset function here, as it does not work reliab=
ly.
>
> Why?  What's wrong with it?
>

I was going to update this comment to add details, but after some extra
testing, this was wrong actually. Reset function of the chip is working
correctly, it was just a caching issue. I will rework the whole
function.

> > +	 */
> > +	err =3D regmap_write(max7360_mfd->regmap, MAX7360_REG_GPIODEB, 0x00);
> > +	if (err) {
> > +		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
> > --=20
> > 2.39.5
> >=20

Thanks for your review. I fixed all other points listed in your mail.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



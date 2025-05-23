Return-Path: <linux-pwm+bounces-6105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42665AC2601
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29993BA045
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44845293755;
	Fri, 23 May 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I61bMbL/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D029375A;
	Fri, 23 May 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012847; cv=none; b=jIIyB+UVPcxC7WmsCVoy+muPpiCyoGr35A1I1oG4tIKXD+pro6kqZ0rf9yfbKR0+AGBmSVHMhN+qRrcuMTD1U/YTnnuA3Rj4oVCwIRfW4/xkyhseWwe7GaQASzUbZA7GmX6CXqeczVsfR19GLoQa5ezVQSnEJp3u2Z7p/rqYOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012847; c=relaxed/simple;
	bh=jqszsB0dQ94aeoJh4mKxtu13hgZ8bpZGyzFqySA/C0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxMLEw12DoPtUwlUEN2SsgP136sHmU+PPmR+gcm0Reyhd5VWlOeDq+O2FB/GFw0/lJo34jOTBZzQcrBBlvVsTbkdfUpC1pwhxXA0Id38R0vFQEFycT7rVSAFNRCazvFOHfEHyiKxPJ12iQVl+2mpr36lxc6ro/w8aAnn5muU2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I61bMbL/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a37a243388so34187f8f.1;
        Fri, 23 May 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748012843; x=1748617643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNfuFi4zqbWwugyGJ6n/SsGAygzTg13IwPmCN0ZOeDc=;
        b=I61bMbL/Jqe40mQXpZLMLALD3rOPAF/Y+mEWD3W7GIQTXXC0lVl51mV6JTZgZqXRrW
         LXqwISMuRXtTH51zRtMg9mUbxE1XY/Q9gXcg4FjYq/e12n147KjEVFSWMp3ZHc3rMuSC
         SAWkCzTfz5ioY+9ZcF5HsVxztXIQ4SlMnBzaqp0yYrn0uhlfVTpd5RXeS9RHgytJFmeY
         j6zOr6Wq+yns+VR+Bnry3Bmy0NZHLPI8X5bjunqqD33MhkT5G0DdGyTjmWYmoovfI2V4
         2PBJDIq8lEClpcfACnU1IQrIUoLazQsmw3hg+sIKhnK35P/nthoejgsoJuO35AwWnOFv
         h3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748012843; x=1748617643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNfuFi4zqbWwugyGJ6n/SsGAygzTg13IwPmCN0ZOeDc=;
        b=feRC8nF4iGmUZoIZnIBVw5XmKNOK+AVRcvDfH3DD4/GGaMRWB2y2p9qO2fHtEDUM6d
         Ph+7x5eToVBcim7PtwPidzuzdCeR+xRjUWF3HAOJvj4A8H5wwjQm2F9xpiAOiJjeCU8G
         GMgtwShFIbqAmzjZK+dDiAh+/mINMJ+2iLBFMGkNap2BS7KPEjhhlZeM1IiBeovw5PS3
         KpO4ZiGZHipth6tJV7YHFuSieppVHYWRf7W0Fk+fkpI21OMmrn/J2QqueMlWQEEzbq4r
         ZmspEqTPDn5ByZlCVdXWkZnTnSTAB0GtYa0Ldb1/LQBybXiJLedmsM4K/KkJcvcRZfUw
         yNIA==
X-Forwarded-Encrypted: i=1; AJvYcCURC3mLAfCmauflqVzwK1VF87gUTHe8BufDiXZKa83buTLYboD/An0kwR/O55pKV3KK/QhPcYfdm9AF@vger.kernel.org, AJvYcCVRDc1rOCYI1oR7K93Ju/yp/yoflFCDO0RgNNm1NEbdJ2yAXypcGUZmPlq7t8qNIdbrSWw55rvC1aCj@vger.kernel.org, AJvYcCWZnPPpA7MpSnFT6tvhxak713sQEN1JYNLeVX8XTRSbYAGbxsrdpsQYGSXuueI1pESWzfSUqKDrSd6U8Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU844r1kH7HufiBHJ9uV4znC1an4i6p9B6FMm8iRO/TWzsxENv
	ApFRs8wu5vHbo7PQbb9WL5vHstkLduUGtW5leZ05ZG0Qmz5BydtynqXa
X-Gm-Gg: ASbGncv+W/kAtKuYznQBUKjEPbQRB843kMSIqkgw7DEaIBTlSNVxHVlSthrQUMBPXuj
	vAstCQz2jXfhn5q1MOa6QOwUjjki7M1AmrRjCUxMQG2WMstJXkV6zDY2PLsW2C1nQAQrD5iEpbG
	fh0Evp9Y8uxwV6rRV2dTZUJ0gCXAglnlAnleAtwNOX7CIG0Iwqigp8pMKjBCwOkcaDedmuS2yAG
	spUQQXFMJhV8p5YlrRF8N4N9tTazBzT+/zAl5eQsKXo2y4n4+h3hWJQRpeG4ncMSiU14SqZLfkA
	0UxcNCnU2iuJEcZ0/KWq+QkJj4JBPDi8gMI8KUopiw0JX16rDaHmihsHSA==
X-Google-Smtp-Source: AGHT+IHcvfBQBSZkDo0RIGtxJr4lvpBVGnJGZH2VnC9UV3NY3Axi3+/XZkTfykhnwq8e0opFQvVcKg==
X-Received: by 2002:a05:6000:2083:b0:3a4:c95f:c1ca with SMTP id ffacd0b85a97d-3a4c95fc3damr288705f8f.50.1748012843050;
        Fri, 23 May 2025 08:07:23 -0700 (PDT)
Received: from [100.73.1.233] ([91.205.230.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3918esm12044030a12.68.2025.05.23.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:07:22 -0700 (PDT)
Message-ID: <196e5106d37121b394d0d70d34abeb33940c1de1.camel@gmail.com>
Subject: Re: [PATCH v4 02/20] mfd: adp5585: only add devices given in FW
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Fri, 23 May 2025 16:07:24 +0100
In-Reply-To: <20250523145144.GF1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>
	 <20250523145144.GF1378991@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-23 at 15:51 +0100, Lee Jones wrote:
> On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Not all devices (features) of the adp5585 device are mandatory to be
> > used in all platforms. Hence, check what's given in FW and dynamically
> > create the mfd_cell array to be given to devm_mfd_add_devices().
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 48 ++++++++++++++++++++++++++++++++++++++=
+---------
> > =C2=A01 file changed, 39 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..806867c56d6fb4ef1f461af26a424=
a3a05
> > f46575 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -17,7 +17,13 @@
> > =C2=A0#include <linux/regmap.h>
> > =C2=A0#include <linux/types.h>
> > =C2=A0
> > -static const struct mfd_cell adp5585_devs[] =3D {
> > +enum {
> > +	ADP5585_DEV_GPIO,
> > +	ADP5585_DEV_PWM,
> > +	ADP5585_DEV_MAX
> > +};
> > +
> > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] =3D {
> > =C2=A0	{ .name =3D "adp5585-gpio", },
> > =C2=A0	{ .name =3D "adp5585-pwm", },
> > =C2=A0};
> > @@ -110,6 +116,37 @@ static const struct regmap_config
> > adp5585_regmap_configs[] =3D {
> > =C2=A0	},
> > =C2=A0};
> > =C2=A0
> > +static void adp5585_remove_devices(void *dev)
> > +{
> > +	mfd_remove_devices(dev);
> > +}
> > +
> > +static int adp5585_add_devices(struct device *dev)
> > +{
> > +	int ret;
> > +
> > +	if (device_property_present(dev, "#pwm-cells")) {
> > +		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_PWM], 1,
> > NULL, 0, NULL);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to add pwm
> > device\n");
>=20
> PWM is an acronym, it should be capitalised.
>=20
> > +	}
> > +
> > +	if (device_property_present(dev, "#gpio-cells")) {
> > +		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_GPIO], 1,
> > NULL, 0, NULL);
> > +		if (ret) {
> > +			ret =3D dev_err_probe(dev, ret, "Failed to add gpio
> > device\n");
>=20
> Same with GPIO.
>=20
> > +			goto out_error;
> > +		}
> > +	}
> > +
> > +	return devm_add_action_or_reset(dev, adp5585_remove_devices, dev);
>=20
> We have 2 of these now.
>=20
> Why do we need lots of unbinding functions?
>=20
> What's wrong .remove() or devm_*()?

I do mention in the cover why I did not used devm_mfd_add_devices(). We wou=
ld be
adding an action per device and mfd_remove_devices() removes all of them in=
 one
call. Not that is an issue (I believe subsequent calls with be kind of no-o=
ps)
but this way felt more correct.

- Nuno S=C3=A1

>=20
> > +out_error:
> > +	mfd_remove_devices(dev);
> > +	return ret;
> > +}
> > +
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > =C2=A0	const struct regmap_config *regmap_config;
> > @@ -138,14 +175,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > -	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > -				=C2=A0=C2=A0 adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > -				=C2=A0=C2=A0 NULL, 0, NULL);
> > -	if (ret)
> > -		return dev_err_probe(&i2c->dev, ret,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n");
> > -
> > -	return 0;
> > +	return adp5585_add_devices(&i2c->dev);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_suspend(struct device *dev)
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20


Return-Path: <linux-pwm+bounces-6108-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A7AC26B0
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB51BC88CD
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC15293755;
	Fri, 23 May 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAWnwHEm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B92DCC14;
	Fri, 23 May 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015151; cv=none; b=W5nq6hTJ//XX6OUGBw1IOUpyzOQrBqg51sV/yL5FhW7FHiEXxzV4Ee9fl/M091Jbu+CysOznMXM4i6iuykgdSVm5yARpBhdvkibdHTIqEuePeT/LD5YMKAxlS5Z1TuHJbOkCFYYspD50ktM5/S+C+YMMASezEwd2g8JjqdhSFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015151; c=relaxed/simple;
	bh=RZCDAHKlOqUcvF6RheaFWWcjcHLMnyE35LMAUvGs3Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SW3GUgNMwjoTdFelbW2/DFpTiB2SrWWPpvdafiXgWZFLM5sNs21WoFxCfQNliVoGYre2UaE5mvCnltRsqU6hw4Mzn+PcFYMD6PBxbLFvXupkoDb0hFHt+mKeI+iyFwFaBuXvHjn3JMBCvUtnDU5OgNTNKKeRRzIlhg3vv3f5Dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAWnwHEm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so13526566b.0;
        Fri, 23 May 2025 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748015147; x=1748619947; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWsamnpdmvzAMKVsefhEIcOf8w3oLu0YbzacOSqPziM=;
        b=RAWnwHEmuJI+a46T3FayWkh7rxQue0BGVV6IwiannXoWeQ38q9nsRf0n1sq/9aCB4J
         uTtZfTGG6ZiyeQuozzzx+AUe80VKDJDYc+KgdJQE+FdFJn5MgGs16HSbms5XjNDLG8nw
         /iNAGkIO5BPtWneYV1iv1Dy62D9CRjw4KIj3v8XnmZmLSLy2KE5QYI3gbNymU7aJcwBM
         yxzDM6Wne4YI2iC/YcohDL+xJ6rd1yOa7klPYg7iOr6uowKAlX6je9azVafTh6uC6yHJ
         cTCNi3we6+wCBLGJPun7K5ehLBBrPyBduKUgx2zu0XRTUf8YyjrZ445Gl28bgkoiAJHl
         xRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015147; x=1748619947;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWsamnpdmvzAMKVsefhEIcOf8w3oLu0YbzacOSqPziM=;
        b=LRMMI/fSxgW1P5IrSozhc8X8n7QwMgLx5QiD/o6aGJKQ1BV+rek7gmO/Tu9y7DyRio
         ZV2GP4ggVPg3aceYoTEDyLjsIniSD4MuxA6EWrZh5HIF1NYJYj/vaTJ5sk+bleX10uKv
         OgX0qFQQ1ItG3nBbNLd33mcshvo+CmEKZz9qTPjI5VW9KKZ5K93pOYgjj6EA5Ijkgs54
         sl4neX8eRM9sg66Gy7DV8J7xzUD6C2QegWhKDEzuso0gjxnvCgjBuZt0dzvdvh5ba0lV
         A/7qsIJm2nFTqnmSoaUuNhw0ITYn6jc81tNn0epEYFLO8ZqIM/5DSG1A5OPiyQYObHuU
         KJWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJVbvXm8mHI4yTCMgM+28jfzVYeZ/x7Kj8laGlct6oykbqMslp1fRoPNdSbpolaBsWqT4NCdnOLjSpGKs=@vger.kernel.org, AJvYcCX3v9t0rAyAtfCBGd/JJ2dLTMcd0EOeErj+E+ZGiup39ATJZTto5BQxMeEBUYJtEPcIMMaSdLZa4cOk@vger.kernel.org, AJvYcCXNdwSiVct3AUhjqLwYmCYhW4VlSU7YY1WyLosrNB+iReAMw0ia0IH9rLHcBQSI3c73SVyVdpqEOIce@vger.kernel.org, AJvYcCXyTviSJTSZdLZw4iPLoyRCEY9FXic2AbckPaIj39Aib7paEL7D6khn7/+Acz/XVSCLYF1Io49VdmYlUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo04XW6SjR3BKMDxtZOhjD+pPZ/CedWWEIKbs0pzR5EUms0X3
	htRSLOeYIzOXrc8zwMcH0qxuNRi4MHCVFe5FXKyDZ1VVPtDWMNVAq17O
X-Gm-Gg: ASbGnctT8FRjFZquw+9otONeNnWNjtUp4ybxNd0E9SHSU7cIo2inqfnePBDIeYB1pGd
	dHypzer9Kyv65UH6aa1csRO8pudvDHbR/VakVU+q1bLD96YYOAqvLSPxK2W1UMyCLKiqT+rpFFd
	l/Zqlwco18ckgSrXfs1acyeRGvBXz/O7/PkImvWW4BEQHRHASxe2eIp1dgHKHodRizlL2o+3YXz
	SQdFHm+/nrblA07KF50a4lWEpdx6Jk6bhnb6UlWOtB57qAVy4BWmpgzD3TNluzatOfY4Bvmx8vX
	wII/bM0ZWxgXlcTY+ijfau+zsWo7Su0kwaQi2b09eGeXOgnM6ws5sTEEx4BiieuEROI4
X-Google-Smtp-Source: AGHT+IFtBnzprvk9f3WYANBhxkv8OPS2DFnZW0TpFBZRijifn0nv4sc9BPa/V4G9oZdcLEtMFyuWcg==
X-Received: by 2002:a17:907:7f04:b0:ad5:2d5d:2069 with SMTP id a640c23a62f3a-ad64e84f32emr419050966b.13.1748015147219;
        Fri, 23 May 2025 08:45:47 -0700 (PDT)
Received: from [100.73.1.233] ([91.205.230.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04772dsm1240560966b.3.2025.05.23.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:45:46 -0700 (PDT)
Message-ID: <e8991f6ffbec759a6c8b21baa5adfe2dc7b3aa8c.camel@gmail.com>
Subject: Re: [PATCH v4 02/20] mfd: adp5585: only add devices given in FW
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Date: Fri, 23 May 2025 16:45:48 +0100
In-Reply-To: <20250523151929.GJ1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>
	 <20250523145144.GF1378991@google.com>
	 <196e5106d37121b394d0d70d34abeb33940c1de1.camel@gmail.com>
	 <20250523151929.GJ1378991@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-23 at 16:19 +0100, Lee Jones wrote:
> On Fri, 23 May 2025, Nuno S=C3=A1 wrote:
>=20
> > On Fri, 2025-05-23 at 15:51 +0100, Lee Jones wrote:
> > > On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > >=20
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Not all devices (features) of the adp5585 device are mandatory to b=
e
> > > > used in all platforms. Hence, check what's given in FW and dynamica=
lly
> > > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c | 48 ++++++++++++++++++++++++++++++++++=
+++++-----
> > > > ----
> > > > =C2=A01 file changed, 39 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..806867c56d6fb4ef1f461af26=
a424a
> > > > 3a05
> > > > f46575 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -17,7 +17,13 @@
> > > > =C2=A0#include <linux/regmap.h>
> > > > =C2=A0#include <linux/types.h>
> > > > =C2=A0
> > > > -static const struct mfd_cell adp5585_devs[] =3D {
> > > > +enum {
> > > > +	ADP5585_DEV_GPIO,
> > > > +	ADP5585_DEV_PWM,
> > > > +	ADP5585_DEV_MAX
> > > > +};
> > > > +
> > > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] =3D {
> > > > =C2=A0	{ .name =3D "adp5585-gpio", },
> > > > =C2=A0	{ .name =3D "adp5585-pwm", },
> > > > =C2=A0};
> > > > @@ -110,6 +116,37 @@ static const struct regmap_config
> > > > adp5585_regmap_configs[] =3D {
> > > > =C2=A0	},
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static void adp5585_remove_devices(void *dev)
> > > > +{
> > > > +	mfd_remove_devices(dev);
> > > > +}
> > > > +
> > > > +static int adp5585_add_devices(struct device *dev)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (device_property_present(dev, "#pwm-cells")) {
> > > > +		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_PWM],
> > > > 1,
> > > > NULL, 0, NULL);
> > > > +		if (ret)
> > > > +			return dev_err_probe(dev, ret, "Failed to add
> > > > pwm
> > > > device\n");
> > >=20
> > > PWM is an acronym, it should be capitalised.
> > >=20
> > > > +	}
> > > > +
> > > > +	if (device_property_present(dev, "#gpio-cells")) {
> > > > +		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_GPIO]=
,
> > > > 1,
> > > > NULL, 0, NULL);
> > > > +		if (ret) {
> > > > +			ret =3D dev_err_probe(dev, ret, "Failed to add
> > > > gpio
> > > > device\n");
> > >=20
> > > Same with GPIO.
> > >=20
> > > > +			goto out_error;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return devm_add_action_or_reset(dev, adp5585_remove_devices,
> > > > dev);
> > >=20
> > > We have 2 of these now.
> > >=20
> > > Why do we need lots of unbinding functions?
> > >=20
> > > What's wrong .remove() or devm_*()?
> >=20
> > I do mention in the cover why I did not used devm_mfd_add_devices(). We
> > would be
> > adding an action per device and mfd_remove_devices() removes all of the=
m in
> > one
> > call. Not that is an issue (I believe subsequent calls with be kind of =
no-
> > ops)
> > but this way felt more correct.
>=20
> I haven't seen another device add a .remove() equivalent per device.
>=20
> Why do you need it?=C2=A0 What's the use-case where this would become cri=
tical?

No sure I'm following you. I don't need a .remove() per device (or it is no=
t
critical to have one). I just went with this because devm_mfd_add_devices()
would be adding more devres_add() than what we need given that
mfd_remove_devices() removes all child devices at once. So, logically, the =
above
makes sense to me. Now, I'm ok if you say, don't bother with this and just =
use=20
devm_mfd_add_devices() on every device we want to add.

- Nuno S=C3=A1



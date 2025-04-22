Return-Path: <linux-pwm+bounces-5639-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430ACA95FE3
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A413A8DE1
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0411EE039;
	Tue, 22 Apr 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Cp3T4d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67315B115;
	Tue, 22 Apr 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308209; cv=none; b=QHl65D+xfH1gR3OvDiqgcoj+lNJVQnTp2FjbuINnJYV9je2Kux3YpmWNEBkaGyTCrVneE1r+iuPz+WrX/CvmDtFAT/A1cJLqeuMdfE2wQdh1ZwUqfkg3R4EaIf+KMprpd/mXCPXbVV0yLcocS6NcHFkyTmIzWokQi7iUN6dwRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308209; c=relaxed/simple;
	bh=NJtgEOvcoWxtKXd1JFhHVKcXLnVSR8a6c//yHFlTBDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZaPGxDdSSMGfgAw4oGfV6cC9BtdndsND66YgXIJ8+P9SWtsrJvuLL8+8DmMf7p0usuz+n38YGx/F0j5V7CMhL0fEJW4OotSp7O/YcgMSFWQGnSUB4sD6ri8egLMopFwkGQnWHHIfrMwG9xt5cAs3IL7I9mN+A1vdv6muzgEdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Cp3T4d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee651e419so2620251f8f.3;
        Tue, 22 Apr 2025 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745308206; x=1745913006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AU68JbSJMerX79mNlx+AQyiWjCnknjAgapt7O28YwFs=;
        b=g2Cp3T4dNRcw7wlGPLvyzWn0jficwPCK9jAc7L1zbkWxPYifNHMZcj0Ppu/8VIucyf
         irtRq3ut/iGPusRrnWtutHS26TZLT+pthDVt942Q9x2R2P6Cmwtup0AQVMBzgEnGPQ97
         s02SvVhecy1WwN2soDjWPEYCfonWt/ldBC1DIVCp53NX4ipzHeRviR68HNMGuwvoA3VD
         VSywXmbekjqmCqyeKx12WJZAS27VNmDEB+ltov4MM7+gXAGFUd0SpItcVcLuoFl+HeJG
         y7DSkT+k0cbOJl7Ojo5nDMf+OtR3/c4230TZePvzGwizBZc9Yb3epI2NmYhcQDLnNtB4
         m4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745308206; x=1745913006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU68JbSJMerX79mNlx+AQyiWjCnknjAgapt7O28YwFs=;
        b=grIecwPkKfEwQsrUFlmxJ2sFPXQXLbXI0S4PN52l71AHEvpCvoIPrCFz0PrtN+5pvy
         +gldZS99VrETBrDpWQ5oEuShGsDK56EId0G9v4wKViI61h7KwZKBMC1flFaOfs40tU1G
         arJhttwI5a7uWr12g3wcDN8Jq3sDlnFbLpexDihLX03UQRJwoTk2ZeKEn5rr5W7oXhr+
         RuYSxKLGxG7htFlucsGMI39gZq8C4tz/q9qlS2zK9yBoZQCkaLuU+uh1BBoq7ywAIGM1
         5YDBxlIt1dQqX5KLj7j0VB6zGwZZ6viTG5zcy2LGfF25uVe5ft0LlN2+C35ehkiD1kJG
         gdZA==
X-Forwarded-Encrypted: i=1; AJvYcCVzas7xyUKxlnKy68/tCPHDfVzpQyQ1JGa9Ehsp7shDeFMI3iFVPG2DSLB7tY1P0vcmtc/ilg7YZkCu@vger.kernel.org, AJvYcCWJYdXSw3w0WYzUvUSzs6vcRA7oSe+HLE3qcPM7T7Hw+L26AcyQeVOW9UGDlVt35p2jFl5mC0R9WkQPwQ==@vger.kernel.org, AJvYcCWbSgoukuIkAn3A5FTUb3WQJlhz+4ojxSXo5bFowlKQHTKeK53tYoo3ujCUKC4v7cwUkr0IR9JAenqH@vger.kernel.org, AJvYcCXBUl1c3+14X1QuQea4pXV0IWCQV8SXqvAwmjy7EH49iCJ281OkgW0Nz9gDPpwGAvsOtQ8fd57P4Jntla0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWU6AXYxrxehJQFUtE1RC5RIegmHNIQwPz4QyKosLHrAlKcBM5
	pZpyx7JBkP7GNGLpfg1wiXWxrAkkVZDoMHea1LAUNRnDnSjisGky
X-Gm-Gg: ASbGncse+9cL/ijbsu3+BgoeNgP752uveGHJqJUOyAnJGsXajQMkrbTxa1d+w8nyI86
	kClEaEKIRH+TlMr9FM6YSfu2RxpzHi9h4cir+ZM0WWrigbIEKODw+gGHLs6Rhps6Ef/5dkWTToN
	NxvEtpnWu0x2j9FkKprg8qjzP7HPSzdny8WgiH6QraDiBkQWfA3kC2lwIKJNqtTiceuiWxqd3qg
	j8GKy85kMr8KJorfL3q15WIkrZAQAzKkO+SVUDvgCrp08E2ENp//WUnaBYACTXOTytBuGIhgOrQ
	ehKzTBnsB3zh/ZxxxavObVEK02vSfTSpKhHg/sPc1LPsrIIkXStzzk+cJQNG9PP0OiozKhsg7ou
	/F6T0wQqxmuzt
X-Google-Smtp-Source: AGHT+IF6dL2bJ9C5RvXlIDkCiyGCQfJ5fcWo3OkK/2v/CO8fK8JiWhGS5yE7Z+4rE/t9RZwKxPV7AA==
X-Received: by 2002:a05:6000:2281:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-39efba6dcb8mr13096953f8f.31.1745308205690;
        Tue, 22 Apr 2025 00:50:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d56328asm163855655e9.0.2025.04.22.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:50:05 -0700 (PDT)
Message-ID: <24be790f9c664dac31ac78ae6210b0bd55c04df0.camel@gmail.com>
Subject: Re: [PATCH v2 02/17] mfd: adp5585: enable oscilator during probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Date: Tue, 22 Apr 2025 08:50:08 +0100
In-Reply-To: <20250421220332.GU17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>
	 <20250421085758.GB29968@pendragon.ideasonboard.com>
	 <aadec5eae6645e3e9c2f8f09dcf842510515122f.camel@gmail.com>
	 <20250421220332.GU17813@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-22 at 01:03 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> On Mon, Apr 21, 2025 at 01:14:28PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2025-04-21 at 11:57 +0300, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:18PM +0100, Nuno S=C3=A1 via B4 Relay w=
rote:
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Make sure to enable the oscillator in the top device. This will all=
ow to
> > > > not control this in the child PWM device as that would not work wit=
h
> > > > future support for keyboard matrix where the oscillator needs to be
> > > > always enabled (and so cannot be disabled by disabling PWM).
> > >=20
> > > Setting this bit unconditionally increases power consumption. It shou=
ld
> > > only be set when needed.
> >=20
> > Well, not sure if the effort for that pays off... The only usecase were=
 it
> > would
> > make sense to do that would be for PWM. For the other devices (and assu=
ming
> > I'm
> > right with the GPI case) we need this always set.
>=20
> For the keypad, can't the device be kept powered off if the input device
> exposed to userspace is not open ? And for GPIOs, OSC_EN isn't needed
> when all requested GPIOs are configured as outputs, as far as I can
> tell.

Yes, I do know it's doable (well, TBH for the input case I just learned we =
can
define .open()/.close() callbacks). My point was just this adds some comple=
xity
and I'm not sure of the added value (while saving power is always nice)
>=20
> I'm fine addressing this issue on top of this series.

Agreed. I would prefer that. This series is already big enough.


>=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > > > =C2=A01 file changed, 16 insertions(+)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..f17b5f2474cac6a4035566940=
66f43
> > > > 8288
> > > > 264a49 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -110,6 +110,13 @@ static const struct regmap_config
> > > > adp5585_regmap_configs[] =3D {
> > > > =C2=A0	},
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static void adp5585_osc_disable(void *data)
> > > > +{
> > > > +	const struct adp5585_dev *adp5585 =3D data;
> > > > +
> > > > +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > > > +}
> > > > +
> > > > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > > =C2=A0{
> > > > =C2=A0	const struct regmap_config *regmap_config;
> > > > @@ -138,6 +145,15 @@ static int adp5585_i2c_probe(struct i2c_client
> > > > *i2c)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id=
);
> > > > =C2=A0
> > > > +	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_OSC_EN);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable,
> > > > adp5585);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > > > =C2=A0				=C2=A0=C2=A0 adp5585_devs,
> > > > ARRAY_SIZE(adp5585_devs),
> > > > =C2=A0				=C2=A0=C2=A0 NULL, 0, NULL);


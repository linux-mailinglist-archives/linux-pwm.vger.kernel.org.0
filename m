Return-Path: <linux-pwm+bounces-5992-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC7AB7E24
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BAB863C6F
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFA296718;
	Thu, 15 May 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxeo0jJY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200C8F6B;
	Thu, 15 May 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291134; cv=none; b=hSCRKn6UqeD7/cdxYIbJbi4TMHwlHo4NU3nRvXt+3T8ROXevp9Os5zcDLyHFdChwSjOGoYLqT2o1xHQJ5KK80Y5EhtFPI+DdPYgzuNkB5CaBtlaNGe1VI0eQn8H7L3Vjc3Cf9JRH2Yn6g3kKa8qZrmNMLmHeXDyDC+ItfFbXSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291134; c=relaxed/simple;
	bh=81HXXtpdh0x9wmGq+Qh7O5YbqBpBeDgwgelvH4LWm5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3lsRUEwTt00nsxr7hddmB5SDBl3iXhQnn2+k5jubz+Cpjv9TxPzD57pFmR4Pd0sRN7GmVD79k+60IGpsqWgCG/JPNey41nbHcpmR0oQ74wc/KeUxj661aMv/LDTR/ZkYrorJ2NdaiZdVP3fB486w7zbO6M3NBRagn1sN9Vn/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxeo0jJY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf257158fso3588645e9.2;
        Wed, 14 May 2025 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747291131; x=1747895931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90SP8Nc35kt+f9GTxzMXrMDJFOzVX8MGultL3ZhzdUk=;
        b=Yxeo0jJYREnb9OmfQ267m5RO8rS4JtJm4wIqc96s8bwi0ZS2oesAMigC/APFX26Avp
         ebTYOBLXdV5HCf4cyXumBRhYCLFWjSCsMw6sPDT183mc0ZgWfB1beoUj7Vha3WKjjSxr
         CST/j3mLD8f1GnjcF3S+iN93gZiPIJYnSRt7B6MUZHa4GnWNQdJNcWwZ1D6h4u6UiLk6
         J6ImEbNq5umwEVtDMrdhBJPKfhjK6XqAf3zTdcE8s4HLe+F06pa9OPexDA/F9OoV7gg4
         2V9STg+/Ucv+ddfQRwwl2muB3bZLW9VRzEgABnIJbn49leLg13rTAoKtllHoz39GuZJ/
         vCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747291131; x=1747895931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90SP8Nc35kt+f9GTxzMXrMDJFOzVX8MGultL3ZhzdUk=;
        b=Y4+dwAGGnMiFRDcF/pxpWwrODgYWRJVOBxhfTXaYrAJggjAIjungUodYUY1jHnmSMx
         X2RngDttPHns99Mn8SF0R5Qez5qXAr8N3EWcsAfMTw8BZfIWeHFz6d/iiYWALALQKoak
         Jhrjv6RLiFawbI1GsvF66zU9GNX2mFZPT9ysRXqwv7bZKH/21GeFbSi7Yl9eGcJ42Ze/
         I3fO2OgRNQJYRxQX+J7CE3UKzM2o6xO4AWUgN1GX3/xPvt8DngccMniyDQtHbtEY9Cy3
         qePka7cVKo7ub5IVxWt7AN3Uhqh+/Nato5I/G3BnJV9dW14BwZk4H408FR6SZVnM0My3
         Jotw==
X-Forwarded-Encrypted: i=1; AJvYcCUd23XQbL5TPdtzgLFSDGiY8kyxrTdYLiXDVb0B98pjiDMBWvy6jVnPNCa1GgqtvYfnSLM2QpV26RclAsU=@vger.kernel.org, AJvYcCWhMJXNIYIfo4a5IoSj0Q3KEWTsvGivRrLI2BIVk92PLMkv7geXn5OEt/9u5wWjDL40wvAFX/Dt2ZIb@vger.kernel.org, AJvYcCXNrsw3HWwkTDkMig2dutYHZRWef06WuaoaD152FtBgEpo8OyM3JnJ6q5gz9EoIDJetThsE7Y9xAfuf@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGT39BKv50W02wWtDMpB+rTqvUI/GaNs4bd07YklEUw08axrd
	esPaF6emSQGyjvDtJdBof6kw98v3dbgHXxy+gDbrvXExZrKu3Oez
X-Gm-Gg: ASbGncv+QnepTbxbyd0qDK+l+Est25BC4iwo03BJDqly1LA3kt8ic/ZP5z38xj8dkK0
	l5ZB8CedSk6Pm0JUo5VAk30FFJKjALOArruDhIchHymfuMm9IAhoMDhHnjwAqdPIJvoeMVAaoNp
	QvPzHRKp2n2AgHLvBevIMbI+oF5zQQAEUupJPdtlQP7aNZJNU1EZ1dMvgbmFS4fRAo/eoY6h8T1
	k8lGJHQ9Nb+qWFw7AHN31RvqAdx/724gUDaEZKO1bWPUHZIMpdu9jR++RtMuW49JAh4womFiv3T
	4KsqO011BHqezzvkY2z79eVRG/hG+6ISr0aa86qEoDEOHby5qPFIZcsZRUdv1SiouskhNfS485p
	wzLKHH27b3sfuEKnKLktZGPQfHz17AjKM9Qe+
X-Google-Smtp-Source: AGHT+IGcwg+ICVaEU98yQFZFmC/DzqCku2fq7x3AZ4pgS45BayMcvXFNkL/7KWdlJ8WWq/jQuosd3A==
X-Received: by 2002:a05:600c:190c:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-442f96e70a2mr12525205e9.10.1747291130967;
        Wed, 14 May 2025 23:38:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc44sm21356467f8f.85.2025.05.14.23.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:38:50 -0700 (PDT)
Message-ID: <d1079bc2b0ef55a0ae674d7a11f1eaa18ba9caa8.camel@gmail.com>
Subject: Re: [PATCH v3 21/22] mfd: adp5585: add support for a reset pin
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Thu, 15 May 2025 06:39:15 +0100
In-Reply-To: <20250513162622.GW2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-21-092b14b79a88@analog.com>
	 <20250513162622.GW2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 17:26 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to perform an Hardware reset during probe=C2=A0 if the pin is=
 given
> > in FW.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > =C2=A01 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 88401668f30e06ac201175470eeaf6216f3121d9..0fbe1f7f2582408b2e1b99f629182=
ceebce73fd
> > 7 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -11,6 +11,7 @@
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/i2c.h>
> > +#include <linux/gpio/consumer.h>
> > =C2=A0#include <linux/mfd/adp5585.h>
> > =C2=A0#include <linux/mfd/core.h>
> > =C2=A0#include <linux/mod_devicetable.h>
> > @@ -712,6 +713,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0{
> > =C2=A0	struct regmap_config regmap_config;
> > =C2=A0	struct adp5585_dev *adp5585;
> > +	struct gpio_desc *gpio;
> > =C2=A0	struct mfd_cell *devs;
> > =C2=A0	unsigned int id;
> > =C2=A0	int ret, n_devs;
> > @@ -730,6 +732,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > +	gpio =3D devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(gpio))
> > +		return PTR_ERR(gpio);
> > +
> > +	/*
> > +	 * Note the timings are not documented anywhere in the DS. They are j=
ust
>=20
> It's okay, you can say "datasheet". :)
>=20
> > +	 * reasonable values that work...
>=20
> What does "..." mean in this context?

Nothing :). Just an annoying habit I have. It comes automatically

>=20
> > +	 */
> > +	if (gpio) {
> > +		fsleep(30);
> > +		gpiod_set_value_cansleep(gpio, 0);
> > +		fsleep(60);
> > +	}
> > +
> > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, &regmap_config);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20
>=20



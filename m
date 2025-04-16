Return-Path: <linux-pwm+bounces-5530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004FA8B657
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04EC18979FE
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0DF229B1E;
	Wed, 16 Apr 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9TNB2uK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CD237700;
	Wed, 16 Apr 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797797; cv=none; b=hA+ZUCw4hmjO8PFynY15PlYrAZQ1YqCyML8BraxmxuGabx7xtEfWr9lwodOv/8NHvhmvQZGWwZAosvuKx/NbJ5Gme3z08AX9wN0yXNoNGoQCLu4csXCOecdCTVb5S6c6gQhHkUzm/Mg7HTxYxcc3XyPbvJaTIO0GhMYJwCTLkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797797; c=relaxed/simple;
	bh=du+Galkv30CIPUFNR3vxX3iDlkIQSfHZgKLgdwXSMYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccIXlwgxlc6hf6B8rQL7f5O8ttifOiwSuaTOENW1GjQjyCavuVFzZFcad5P1pwGy8Q4JcRXIo0V6r/wZiLoQ7Z53u2OzyYyr6Lf7w/FKvqZ7M43GcUo+E6GxSgmUS3Mu6+N7orWNzHBeLDctGIFmuH3duU3gC4wlIjRDGOmnnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9TNB2uK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so44707075e9.0;
        Wed, 16 Apr 2025 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744797793; x=1745402593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=du+Galkv30CIPUFNR3vxX3iDlkIQSfHZgKLgdwXSMYk=;
        b=W9TNB2uKyRU80ky74V2bxvP5xGQolIz9Ir9khF/2zE/u+yzPLnMJrlWRhBw0hG5KzG
         X6oQAJ/bck9zId+Ugf2i72iltt4IDYhTtsjDYSrHLFaJy/0ofZPWvb/rZfP19hIsJ5t/
         IEQCj8x/nfeqj6D9Ik1LVbJoVu8dtOqkdD13nttdPp7fbaekzENAqurYMyM2+eAWHYfO
         rVniVQ4YQxZCrFgsafCYqSwxBVY+6owCqcZf+1dzOs6Fx8cty20dzBXf8XAQTVrf9uvl
         xhLwPef6lumFlDtl3p4CGX7nC5h9hfJIqTvi6M7OXqMeCyunpbUFUV3Tov4528tOaZ+D
         dX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797793; x=1745402593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=du+Galkv30CIPUFNR3vxX3iDlkIQSfHZgKLgdwXSMYk=;
        b=nF9l4+NEBGWL0aHzwvWviN2bkPqeZ7B10IkXIQ63NwdBY7oXGN4AXKW/Xfe7AUwtyD
         djcyI2szWY5sIX1lVhkhmAqDPf/Z4QROZa7xTz9lY2ZxTiHnwy6uUoJsNszZ01osFc/B
         0dRqQqnKPtNe0yyQSGxOz9/33fRtIV3IokUXENA0AAaNWjLw+OOUTLsQmdMkudSpCXP4
         5Qxy5Hk6kBpDqWg7XvbLptVPGjZ+/Rpk8d1oz7u7f0mfh/3SkaybsG9gFVFmO1YS3/UQ
         9D5S7UjeBt3ihz5N0uSfHtoZuYlH8n9ZVdsAskIJN22fnCHPsPbs5M7xSIk/j3YOuOZ9
         Y/+g==
X-Forwarded-Encrypted: i=1; AJvYcCWQK/Cgf9l47MT7tEbGxH1UXUNqHh1ofaR5dlR3XmhQ7jgu24VZ0r9Savr4gA3Gh8SJw8vdpcm9cqEADQ==@vger.kernel.org, AJvYcCWuG+4lUnbt0oK32msSmLvRgIe2EimwDa8V/dEZ7aNu2UR1nQ3mefxc/7hsTCcD+HrZIKSmzWrWk+6R@vger.kernel.org, AJvYcCXt2Kun+YKqft2SEI0jSCFeMhIaLqBtLYXGxq3y08BW1f5mRfQh4mHd+3GkZhxgS1GPSb2k5o3xn3Tc@vger.kernel.org, AJvYcCXuY0WzNZFMnJ9W8TJofxXmRkn6zsmRePOCP9pjhKcZpPlbunRBsRxtq4imsXj+5dQAzSMNsuHXxvbLO/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvF4JLiLMedO5DAa2ErfZlT50YjiVTzW5Ichfo/qljEDmkQDgt
	NTtSg1uINMzYt1mSaBN9OpYGoxjCr95TeprGuWhXqkm8d/l7jJeBg4Vztf2nGDeGaA==
X-Gm-Gg: ASbGnctwD8TjqNoN8JckqyVn0gqjze/lRnGDwDZ+swpae9xMIUo+JHESNHHrYRJA2R4
	KLlVJq/Q63pvzHjeM0fcUA/s0eSOkA2huk2BmPyTq+fhvUvESFBIb5YY8Q/GiAB9idcd0awFrra
	GW/JClDc11qfX1241yRc8fqQQyBK+PtHJOYh3O0WOC5P8JvReOk04q8ZLqy0IjIPTJPTJCaKFLs
	WYc7PEP0jD8/COSAR26l7WGt3WY1IhJSlVtmW0KSdsVyUGP4/ACFO64OYD0INlxLbfhHaIb17ux
	YZFK3LPgUoVw3WeKgUvQ/QJI39vR0VMwgvz0wlI0xEOrg5X9mRs1ziJKI+Todevagp59O++Xpby
	NHaysxY4RQOrsPVWSg2qUJ8g=
X-Google-Smtp-Source: AGHT+IFd9LRvyIpsRChPTnY6Jq4uL69mgcVg+rRc/FuNlmiVUqIX1JKAXFvvJqfu6/mgFo1Dta7Hlw==
X-Received: by 2002:a05:600c:1f13:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-4405d5fcd76mr10280315e9.6.1744797792965;
        Wed, 16 Apr 2025 03:03:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c82d6sm16702835e9.8.2025.04.16.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:03:12 -0700 (PDT)
Message-ID: <79bacbf0fd1056e6d7435970a3f111138fcb180e.camel@gmail.com>
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Liu Ying <victor.liu@nxp.com>, nuno.sa@analog.com, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Krzysztof Kozlowski	
 <krzysztof.kozlowski@linaro.org>
Date: Wed, 16 Apr 2025 11:03:14 +0100
In-Reply-To: <3efb68e2-7091-47e1-81a2-39930da5a427@nxp.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <3efb68e2-7091-47e1-81a2-39930da5a427@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-16 at 17:02 +0800, Liu Ying wrote:
> On 04/15/2025, Nuno S=C3=A1 via B4 Relay wrote:
> > The adp5585 MFD driver was introduced in 6.11 adding support for gpio
> > and PWM. However, the gpio part of it was already supported as part of
> > the keyboard driver:
> >=20
> > https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboar=
d/adp5589-keys.c#L532
> >=20
> > On top of that it also overlapped with my refactoring of the above driv=
er
> > [1]
> > to drop usage of platform data and use FW properties instead.
> >=20
> > Now, it actually makes sense for this device to be supported under MFD
> > and since the "legacy" input device depends on platform data that is no=
t
> > defined anywhere the plan in this series is to add support for the
> > keyboard and adp5589 devices as part of the MFD driver. Once the MFD
> > driver supports all that's supported in the Input one, we drop it...
> >=20
> > For DT Maintainers:
> >=20
> > The compatible for adp5589 is part of trivial devices. To me, it makes
> > sense to remove it in the patch where we drop the driver but doing so
> > would result in a warning when adding the same compatible for the MFD
> > bindings. Hence, I remove it in that patch. Is that ok?
> >=20
> > Uwe:
> >=20
> > In my eval board, I could see that reading the GPIO value (when
> > configured as input) does not work when OSC_EN is not set. Therefore,
> > commit ("pwm: adp5585: don't control OSC_EN in the pwm driver") could
> > very well have a Fixes tag. However I'm not 100% sure it's a real issue
> > or something special to my eval board.
> >=20
> > It would be nice if Laurent or Liu could test the PWM bits or even
> > check that the above is also an issue for their platform.
>=20
> With this v2 patch series, PWM backlight(controlled by ADP5585 pin R3) st=
ill
> works for my i.MX93 11x11 EVK.=C2=A0 Without this v2 patch series, if I c=
hange PWM
> backlight to GPIO backlight(keep using pin R3), the GPIO backlight bright=
ness
> can be set to 0 or 1, meaning I can see the backlight is off or on.=C2=A0=
 So, it
> appears that GPIO output still works when OSC_EN is zero(I dumped GENERAL=
_CFG
> register @0x3b as 0x00), though I didn't test GPIO input.
>=20

Yeah, the input case seems to be the problematic one... Anyways, thanks for
testing and confirm that PWM is not broken by this series.

- Nuno S=C3=A1

> >=20
> > [1]:
> > https://lore.kernel.org/linux-input/d1395bd61ce58b3734121bca4e09605a3e9=
97af3.camel@gmail.com/
> >=20
> > BTW the series is based on linux-next/master
> >=20
> > ---
> > Changes in v2:
> > - Patch 5:
> > =C2=A0=C2=A0 * Do not nest if:then:else::if:then.
> > - Patch 6:
> > =C2=A0=C2=A0 * Make use of the adp5585 info variables and adp5589 volat=
ile regs.
> > - Patch 9:
> > =C2=A0=C2=A0 * Use standard "poll-interval" property (and move it befor=
e vendor
> > =C2=A0=C2=A0=C2=A0=C2=A0 properties).
> > - Patch 10:
> > =C2=A0=C2=A0 * Make sure to include bitfield.h.
> >=20
> > - Link to v1:
> > https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@ana=
log.com
> >=20
> > ---
> > Nuno S=C3=A1 (17):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: mfd: adp5585: ease on the r=
equired properties
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: enable oscilator during pr=
obe
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: adp5585: don't control OSC_EN in th=
e pwm driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: make use of MFD_CELL_NAME(=
)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: mfd: adp5585: document adp5=
589 I/O expander
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: add support for adp5589
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio: adp5585: add support for the ad558=
9 expander
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: adp5585: add support for adp5589
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: mfd: adp5585: add propertie=
s for input events
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: add support for key events
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio: adp5585: support gpi events
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Input: adp5585: Add Analog Devices ADP55=
85/89 support
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Input: adp5589: remove the driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: support getting vdd regula=
tor
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: mfd: adp5585: document rese=
t gpio
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd: adp5585: add support for a reset pi=
n
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: adp5585: make sure to include mod_d=
evicetable.h
> >=20
> > =C2=A0.../devicetree/bindings/mfd/adi,adp5585.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 240 ++++-
> > =C2=A0.../devicetree/bindings/trivial-devices.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 -
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 1 +
> > =C2=A0drivers/gpio/gpio-adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 299 +++++-
> > =C2=A0drivers/input/keyboard/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 21 +-
> > =C2=A0drivers/input/keyboard/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/input/keyboard/adp5585-keys.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 221 ++++
> > =C2=A0drivers/input/keyboard/adp5589-keys.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1066 ----------------=
-
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 808 +++++=
+++++++++-
> > =C2=A0drivers/pwm/pwm-adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 57 +-
> > =C2=A0include/linux/mfd/adp5585.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 153 ++-
> > =C2=A012 files changed, 1709 insertions(+), 1162 deletions(-)
> > ---
> > base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
> > change-id: 20250311-dev-adp5589-fw-e04cfd945286
> > --
> >=20
> > Thanks!
> > - Nuno S=C3=A1
> >=20
> >=20


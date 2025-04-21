Return-Path: <linux-pwm+bounces-5626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C29A95108
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844D87A8954
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B9264FBA;
	Mon, 21 Apr 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1wqNHvJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75313212A;
	Mon, 21 Apr 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238873; cv=none; b=eduGCeJa/rLAW5dMQlP8g5pC/Ff2QXRAGAaE4Q7AABEOQ9RLUPIxckA8TxtV1vP0qSFU7OTeeeHQ2ndu4ukGB365ukJMqAF55C+uWr9JZVY9YdJdWuClyzGYKlvOvB3irYyD8v+YZUefZgD4mV8sEOP30yLjIucQadweXcWNw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238873; c=relaxed/simple;
	bh=hPolTU4UOontXGbVhV9wBFW/VNL+PYNoBjR79HMOAHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoUxpMqt/5l2tik4eBfrcdjMIt3iICDEQW9APjjVB1XKSzSV8/QwC6q27z5gnEkN7eJYMOvcs9FUYc5A1RjiYLVUw+gBiw0OrkUPXW9scV8X6uGbPOytxVOCfvs65fiWAsx0fOnRqEOeqIR+Wyp7bR9n/JAL6jtqFwc2WfMIaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1wqNHvJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so2613771f8f.2;
        Mon, 21 Apr 2025 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238869; x=1745843669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhWaNjsFidNdImFtpsHHb/KHAZRAsxhnSW5h3UJtjVQ=;
        b=l1wqNHvJntMBKcBnPya+DkDmSpIwyrqMwF53dH7NEC5oiVjrLxvJoNbEfHecLbWRZe
         dG0BjB/itjXhZ9Mq5IpdJ/drx4ediC7qQR9JXlZdqdyDrqXRiI3lKDOVEJI4TLEFynfL
         JRxlyM2/XPQqw3OSCEVbhKIoecFs61Bl5kom4XN2afSFipeOP0r5aAKHjgZCPGXftsIS
         /dv3LkEjaGHHJgu7GnMxchn1UrY6X5jfBINBGJfUW3R6Er7RvdugkPWwVMOSoN6Ad5nh
         yvpzwCMLNt5ol9cHShABVfMnV2YlVfyaY2diWshJH6GSFsjmSeYednztjdwK9/heUUQ/
         bxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238869; x=1745843669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhWaNjsFidNdImFtpsHHb/KHAZRAsxhnSW5h3UJtjVQ=;
        b=KjTyaBpmosA5PrFBg4EGehdz9QS8pCo4ZCd1XIgLzjYeuMJiXcgtW4yk74pdf5pjKh
         ImR5R4gto1EcIqIDURWWOSxiZ4ubM7zVLzcUhdK9Uz4lfnL9MGW0yp64BsfH+BNMgHSQ
         ErrlzKOc3P07pKmayTHsnHzVt9q4hPMpWnlCvy2e1wTv6OxgJGhrCun9ATT1B1wRu4Uw
         ToK10cBHAcHs7vIypbeM2BMM61Vs5Wk11en55KlzW85+qAQvbdY/axbb49HXbB7iUZwu
         yF7vR7xESmnpj+1NFO2CLo7ugn2m2Unbwg9FD0xG75pz06Z1EB7oGKmnfAWkx6v0B+C5
         0juw==
X-Forwarded-Encrypted: i=1; AJvYcCURzIyX+8TWFPKdFCTCnWr+0tII5XQMkZzCYAUX1Pqf824VjExKF5yInCJjXnKvlBmdIDIigGE+rV/tpUc=@vger.kernel.org, AJvYcCUeRe0gNrwYZcGJeRaJBSRGaB1I1obScrbo2IS/Q8Fdj9QYXrh31mxDartcnvpwtKonWCtCKPYszZuk@vger.kernel.org, AJvYcCWuwGXC2HyHMZ43z9IXrWQvT3bOtHxn8iTcGTQ2EFPOakgrCdgohOTA0GFc6Vk/a4pSlkwop82KfRc0@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKdVlN3XYNmOkMMaoVyNU36UIJspHs7WiegRfJg0B0+l/XnZP
	f3tDbF6scIFiWZZOMBqxwpU3ylu2Nf1i70erNSh0lJB4GwU2gyuh
X-Gm-Gg: ASbGncvtsu+aZ+pPp2k0pIDWMc3DLqFw9VDVffjeoVNOpHRZIo7uIbYP64osHJL5FpR
	5li99RhtKp9aoak0rDD8KJcp9SuhBoPBwnk8WI0at3jSVG3VBjgpSEhajMwYvW70MI84KmMrE/c
	vuR/BC2K0AR6IliVWzl28Z4wqg3sPO527tRHFIKKQtLWSOuJJd47jw8NaVOnyp3UwCRk+R7l/6N
	K42Wpta0E8Hn+oJojafWj1Y8ozIAizVX66JhR53EUq0sBE2PNQ0m2FZSw/UHSgQdkL797VYMfnp
	Rwn+X6vDgqT/gaTQPji64Tt42pfYlf0xHjVmjQ0ipv2pEOvGG9vgKB9/qd5NvBDH5tgEFiR4SxY
	G/Rsoe5fhXNCKr9DCGGVchmo=
X-Google-Smtp-Source: AGHT+IEzvMP78Q22EhghuBKmJeCh9dI92Pg5qL8Oo0U8tiz3xCmemC6UFpXvslgi+0VCcHuS8485lg==
X-Received: by 2002:a5d:47aa:0:b0:39c:cd5:4bc0 with SMTP id ffacd0b85a97d-39efbaf70bfmr8670830f8f.52.1745238868386;
        Mon, 21 Apr 2025 05:34:28 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4931e7sm11880164f8f.67.2025.04.21.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:34:27 -0700 (PDT)
Message-ID: <c13f4a4ecd248c4cf2ca908480ea76874a5c0814.camel@gmail.com>
Subject: Re: [PATCH v2 13/17] Input: adp5589: remove the driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:34:31 +0100
In-Reply-To: <20250421094055.GK29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-13-3a799c3ed812@analog.com>
	 <20250421094055.GK29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:40 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:29PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The adp5589 support is based on legacy platform data and there's no
> > upstream pataform using this device.
> > Moreover, recently, with
> >=20
> > commit
> > 480a8ad683d7 ("mfd: adp5585: Add Analog Devices ADP5585 core support")
> >=20
> > we overlapped support for the adp5585 device (gpiochip part of it) but
> > since it actually makes sense for the device to be supported under MFD,=
 we
> > can complement it and add the keymap support for it (properly based on =
FW
> > properties). And that is what
> >=20
> > commit
> > 04840c5363a6 ("Input: adp5585: Add Analog Devices ADP5585/89 support")
>=20
> Those commit IDs won't exist in mainline. With that fixed,

Hmm, I'll fix this...

>=20
> > is doing.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/input/keyboard/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 10 -
> > =C2=A0drivers/input/keyboard/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 1 -
> > =C2=A0drivers/input/keyboard/adp5589-keys.c | 1066 --------------------=
----------
> > ---
>=20
> Shouldn't you also drop include/linux/input/adp5589.h ?
>=20

Definitely...

> With those issues fixed,
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> > =C2=A03 files changed, 1077 deletions(-)
> >=20
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index
> > 322da0957067db77c7f66ab26a181d39c2c1d513..76d3397961fa006de4d5979e134b8=
c6e7d
> > d52c73 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -61,16 +61,6 @@ config KEYBOARD_ADP5588
> > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> > =C2=A0	=C2=A0 module will be called adp5588-keys.
> > =C2=A0
> > -config KEYBOARD_ADP5589
> > -	tristate "ADP5585/ADP5589 I2C QWERTY Keypad and IO Expander"
> > -	depends on I2C
> > -	help
> > -	=C2=A0 Say Y here if you want to use a ADP5585/ADP5589 attached to yo=
ur
> > -	=C2=A0 system I2C bus.
> > -
> > -	=C2=A0 To compile this driver as a module, choose M here: the
> > -	=C2=A0 module will be called adp5589-keys.
> > -
> > =C2=A0config KEYBOARD_AMIGA
> > =C2=A0	tristate "Amiga keyboard"
> > =C2=A0	depends on AMIGA
> > diff --git a/drivers/input/keyboard/Makefile
> > b/drivers/input/keyboard/Makefile
> > index
> > f00ec003a59aa28577ae164c0539cc5aff9579fc..8bc20ab2b103b0b75c446e4aa919d=
ad01a
> > a5f405 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -9,7 +9,6 @@ obj-$(CONFIG_KEYBOARD_ADC)		+=3D adc-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5520)		+=3D adp5520-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5585)		+=3D adp5585-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5588)		+=3D adp5588-keys.o
> > -obj-$(CONFIG_KEYBOARD_ADP5589)		+=3D adp5589-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_AMIGA)		+=3D amikbd.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_APPLESPI)		+=3D applespi.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ATARI)		+=3D atakbd.o
> > diff --git a/drivers/input/keyboard/adp5589-keys.c
> > b/drivers/input/keyboard/adp5589-keys.c
> > deleted file mode 100644
> > index
> > 81d0876ee358ef4b521f3f936dc2ab108bb4cda3..00000000000000000000000000000=
00000
> > 000000
> > --- a/drivers/input/keyboard/adp5589-keys.c
> > +++ /dev/null
> > @@ -1,1066 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Description:=C2=A0 keypad driver for ADP5589, ADP5585
> > - *		 I2C QWERTY Keypad and IO Expander
> > - * Bugs: Enter bugs at http://blackfin.uclinux.org/
> > - *
> > - * Copyright (C) 2010-2011 Analog Devices Inc.
> > - */
> > -
> > -#include <linux/bitops.h>
> > -#include <linux/module.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/irq.h>
> > -#include <linux/workqueue.h>
> > -#include <linux/errno.h>
> > -#include <linux/pm.h>
> > -#include <linux/pm_wakeirq.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/input.h>
> > -#include <linux/i2c.h>
> > -#include <linux/gpio/driver.h>
> > -#include <linux/slab.h>
> > -
> > -#include <linux/input/adp5589.h>
> > -
> > -/* ADP5589/ADP5585 Common Registers */
> > -#define ADP5589_5_ID			0x00
> > -#define ADP5589_5_INT_STATUS		0x01
> > -#define ADP5589_5_STATUS		0x02
> > -#define ADP5589_5_FIFO_1		0x03
> > -#define ADP5589_5_FIFO_2		0x04
> > -#define ADP5589_5_FIFO_3		0x05
> > -#define ADP5589_5_FIFO_4		0x06
> > -#define ADP5589_5_FIFO_5		0x07
> > -#define ADP5589_5_FIFO_6		0x08
> > -#define ADP5589_5_FIFO_7		0x09
> > -#define ADP5589_5_FIFO_8		0x0A
> > -#define ADP5589_5_FIFO_9		0x0B
> > -#define ADP5589_5_FIFO_10		0x0C
> > -#define ADP5589_5_FIFO_11		0x0D
> > -#define ADP5589_5_FIFO_12		0x0E
> > -#define ADP5589_5_FIFO_13		0x0F
> > -#define ADP5589_5_FIFO_14		0x10
> > -#define ADP5589_5_FIFO_15		0x11
> > -#define ADP5589_5_FIFO_16		0x12
> > -#define ADP5589_5_GPI_INT_STAT_A	0x13
> > -#define ADP5589_5_GPI_INT_STAT_B	0x14
> > -
> > -/* ADP5589 Registers */
> > -#define ADP5589_GPI_INT_STAT_C		0x15
> > -#define ADP5589_GPI_STATUS_A		0x16
> > -#define ADP5589_GPI_STATUS_B		0x17
> > -#define ADP5589_GPI_STATUS_C		0x18
> > -#define ADP5589_RPULL_CONFIG_A		0x19
> > -#define ADP5589_RPULL_CONFIG_B		0x1A
> > -#define ADP5589_RPULL_CONFIG_C		0x1B
> > -#define ADP5589_RPULL_CONFIG_D		0x1C
> > -#define ADP5589_RPULL_CONFIG_E		0x1D
> > -#define ADP5589_GPI_INT_LEVEL_A		0x1E
> > -#define ADP5589_GPI_INT_LEVEL_B		0x1F
> > -#define ADP5589_GPI_INT_LEVEL_C		0x20
> > -#define ADP5589_GPI_EVENT_EN_A		0x21
> > -#define ADP5589_GPI_EVENT_EN_B		0x22
> > -#define ADP5589_GPI_EVENT_EN_C		0x23
> > -#define ADP5589_GPI_INTERRUPT_EN_A	0x24
> > -#define ADP5589_GPI_INTERRUPT_EN_B	0x25
> > -#define ADP5589_GPI_INTERRUPT_EN_C	0x26
> > -#define ADP5589_DEBOUNCE_DIS_A		0x27
> > -#define ADP5589_DEBOUNCE_DIS_B		0x28
> > -#define ADP5589_DEBOUNCE_DIS_C		0x29
> > -#define ADP5589_GPO_DATA_OUT_A		0x2A
> > -#define ADP5589_GPO_DATA_OUT_B		0x2B
> > -#define ADP5589_GPO_DATA_OUT_C		0x2C
> > -#define ADP5589_GPO_OUT_MODE_A		0x2D
> > -#define ADP5589_GPO_OUT_MODE_B		0x2E
> > -#define ADP5589_GPO_OUT_MODE_C		0x2F
> > -#define ADP5589_GPIO_DIRECTION_A	0x30
> > -#define ADP5589_GPIO_DIRECTION_B	0x31
> > -#define ADP5589_GPIO_DIRECTION_C	0x32
> > -#define ADP5589_UNLOCK1			0x33
> > -#define ADP5589_UNLOCK2			0x34
> > -#define ADP5589_EXT_LOCK_EVENT		0x35
> > -#define ADP5589_UNLOCK_TIMERS		0x36
> > -#define ADP5589_LOCK_CFG		0x37
> > -#define ADP5589_RESET1_EVENT_A		0x38
> > -#define ADP5589_RESET1_EVENT_B		0x39
> > -#define ADP5589_RESET1_EVENT_C		0x3A
> > -#define ADP5589_RESET2_EVENT_A		0x3B
> > -#define ADP5589_RESET2_EVENT_B		0x3C
> > -#define ADP5589_RESET_CFG		0x3D
> > -#define ADP5589_PWM_OFFT_LOW		0x3E
> > -#define ADP5589_PWM_OFFT_HIGH		0x3F
> > -#define ADP5589_PWM_ONT_LOW		0x40
> > -#define ADP5589_PWM_ONT_HIGH		0x41
> > -#define ADP5589_PWM_CFG			0x42
> > -#define ADP5589_CLOCK_DIV_CFG		0x43
> > -#define ADP5589_LOGIC_1_CFG		0x44
> > -#define ADP5589_LOGIC_2_CFG		0x45
> > -#define ADP5589_LOGIC_FF_CFG		0x46
> > -#define ADP5589_LOGIC_INT_EVENT_EN	0x47
> > -#define ADP5589_POLL_PTIME_CFG		0x48
> > -#define ADP5589_PIN_CONFIG_A		0x49
> > -#define ADP5589_PIN_CONFIG_B		0x4A
> > -#define ADP5589_PIN_CONFIG_C		0x4B
> > -#define ADP5589_PIN_CONFIG_D		0x4C
> > -#define ADP5589_GENERAL_CFG		0x4D
> > -#define ADP5589_INT_EN			0x4E
> > -
> > -/* ADP5585 Registers */
> > -#define ADP5585_GPI_STATUS_A		0x15
> > -#define ADP5585_GPI_STATUS_B		0x16
> > -#define ADP5585_RPULL_CONFIG_A		0x17
> > -#define ADP5585_RPULL_CONFIG_B		0x18
> > -#define ADP5585_RPULL_CONFIG_C		0x19
> > -#define ADP5585_RPULL_CONFIG_D		0x1A
> > -#define ADP5585_GPI_INT_LEVEL_A		0x1B
> > -#define ADP5585_GPI_INT_LEVEL_B		0x1C
> > -#define ADP5585_GPI_EVENT_EN_A		0x1D
> > -#define ADP5585_GPI_EVENT_EN_B		0x1E
> > -#define ADP5585_GPI_INTERRUPT_EN_A	0x1F
> > -#define ADP5585_GPI_INTERRUPT_EN_B	0x20
> > -#define ADP5585_DEBOUNCE_DIS_A		0x21
> > -#define ADP5585_DEBOUNCE_DIS_B		0x22
> > -#define ADP5585_GPO_DATA_OUT_A		0x23
> > -#define ADP5585_GPO_DATA_OUT_B		0x24
> > -#define ADP5585_GPO_OUT_MODE_A		0x25
> > -#define ADP5585_GPO_OUT_MODE_B		0x26
> > -#define ADP5585_GPIO_DIRECTION_A	0x27
> > -#define ADP5585_GPIO_DIRECTION_B	0x28
> > -#define ADP5585_RESET1_EVENT_A		0x29
> > -#define ADP5585_RESET1_EVENT_B		0x2A
> > -#define ADP5585_RESET1_EVENT_C		0x2B
> > -#define ADP5585_RESET2_EVENT_A		0x2C
> > -#define ADP5585_RESET2_EVENT_B		0x2D
> > -#define ADP5585_RESET_CFG		0x2E
> > -#define ADP5585_PWM_OFFT_LOW		0x2F
> > -#define ADP5585_PWM_OFFT_HIGH		0x30
> > -#define ADP5585_PWM_ONT_LOW		0x31
> > -#define ADP5585_PWM_ONT_HIGH		0x32
> > -#define ADP5585_PWM_CFG			0x33
> > -#define ADP5585_LOGIC_CFG		0x34
> > -#define ADP5585_LOGIC_FF_CFG		0x35
> > -#define ADP5585_LOGIC_INT_EVENT_EN	0x36
> > -#define ADP5585_POLL_PTIME_CFG		0x37
> > -#define ADP5585_PIN_CONFIG_A		0x38
> > -#define ADP5585_PIN_CONFIG_B		0x39
> > -#define ADP5585_PIN_CONFIG_D		0x3A
> > -#define ADP5585_GENERAL_CFG		0x3B
> > -#define ADP5585_INT_EN			0x3C
> > -
> > -/* ID Register */
> > -#define ADP5589_5_DEVICE_ID_MASK	0xF
> > -#define ADP5589_5_MAN_ID_MASK		0xF
> > -#define ADP5589_5_MAN_ID_SHIFT		4
> > -#define ADP5589_5_MAN_ID		0x02
> > -
> > -/* GENERAL_CFG Register */
> > -#define OSC_EN		BIT(7)
> > -#define CORE_CLK(x)	(((x) & 0x3) << 5)
> > -#define LCK_TRK_LOGIC	BIT(4)		/* ADP5589 only */
> > -#define LCK_TRK_GPI	BIT(3)		/* ADP5589 only */
> > -#define INT_CFG		BIT(1)
> > -#define RST_CFG		BIT(0)
> > -
> > -/* INT_EN Register */
> > -#define LOGIC2_IEN	BIT(5)		/* ADP5589 only */
> > -#define LOGIC1_IEN	BIT(4)
> > -#define LOCK_IEN	BIT(3)		/* ADP5589 only */
> > -#define OVRFLOW_IEN	BIT(2)
> > -#define GPI_IEN		BIT(1)
> > -#define EVENT_IEN	BIT(0)
> > -
> > -/* Interrupt Status Register */
> > -#define LOGIC2_INT	BIT(5)		/* ADP5589 only */
> > -#define LOGIC1_INT	BIT(4)
> > -#define LOCK_INT	BIT(3)		/* ADP5589 only */
> > -#define OVRFLOW_INT	BIT(2)
> > -#define GPI_INT		BIT(1)
> > -#define EVENT_INT	BIT(0)
> > -
> > -/* STATUS Register */
> > -#define LOGIC2_STAT	BIT(7)		/* ADP5589 only */
> > -#define LOGIC1_STAT	BIT(6)
> > -#define LOCK_STAT	BIT(5)		/* ADP5589 only */
> > -#define KEC		0x1F
> > -
> > -/* PIN_CONFIG_D Register */
> > -#define C4_EXTEND_CFG	BIT(6)		/* RESET2 */
> > -#define R4_EXTEND_CFG	BIT(5)		/* RESET1 */
> > -
> > -/* LOCK_CFG */
> > -#define LOCK_EN		BIT(0)
> > -
> > -#define PTIME_MASK	0x3
> > -#define LTIME_MASK	0x3		/* ADP5589 only */
> > -
> > -/* Key Event Register xy */
> > -#define KEY_EV_PRESSED	BIT(7)
> > -#define KEY_EV_MASK	0x7F
> > -
> > -#define KEYP_MAX_EVENT		16
> > -#define ADP5589_MAXGPIO		19
> > -#define ADP5585_MAXGPIO		11 /* 10 on the ADP5585-01, 11 on
> > ADP5585-02 */
> > -
> > -enum {
> > -	ADP5589,
> > -	ADP5585_01,
> > -	ADP5585_02
> > -};
> > -
> > -struct adp_constants {
> > -	u8 maxgpio;
> > -	u8 keymapsize;
> > -	u8 gpi_pin_row_base;
> > -	u8 gpi_pin_row_end;
> > -	u8 gpi_pin_col_base;
> > -	u8 gpi_pin_base;
> > -	u8 gpi_pin_end;
> > -	u8 gpimapsize_max;
> > -	u8 max_row_num;
> > -	u8 max_col_num;
> > -	u8 row_mask;
> > -	u8 col_mask;
> > -	u8 col_shift;
> > -	u8 c4_extend_cfg;
> > -	u8 (*bank) (u8 offset);
> > -	u8 (*bit) (u8 offset);
> > -	u8 (*reg) (u8 reg);
> > -};
> > -
> > -struct adp5589_kpad {
> > -	struct i2c_client *client;
> > -	struct input_dev *input;
> > -	const struct adp_constants *var;
> > -	unsigned short keycode[ADP5589_KEYMAPSIZE];
> > -	const struct adp5589_gpi_map *gpimap;
> > -	unsigned short gpimapsize;
> > -	unsigned extend_cfg;
> > -	bool is_adp5585;
> > -	bool support_row5;
> > -#ifdef CONFIG_GPIOLIB
> > -	unsigned char gpiomap[ADP5589_MAXGPIO];
> > -	struct gpio_chip gc;
> > -	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
> > -	u8 dat_out[3];
> > -	u8 dir[3];
> > -#endif
> > -};
> > -
> > -/*
> > - *=C2=A0 ADP5589 / ADP5585 derivative / variant handling
> > - */
> > -
> > -
> > -/* ADP5589 */
> > -
> > -static unsigned char adp5589_bank(unsigned char offset)
> > -{
> > -	return offset >> 3;
> > -}
> > -
> > -static unsigned char adp5589_bit(unsigned char offset)
> > -{
> > -	return 1u << (offset & 0x7);
> > -}
> > -
> > -static unsigned char adp5589_reg(unsigned char reg)
> > -{
> > -	return reg;
> > -}
> > -
> > -static const struct adp_constants const_adp5589 =3D {
> > -	.maxgpio		=3D ADP5589_MAXGPIO,
> > -	.keymapsize		=3D ADP5589_KEYMAPSIZE,
> > -	.gpi_pin_row_base	=3D ADP5589_GPI_PIN_ROW_BASE,
> > -	.gpi_pin_row_end	=3D ADP5589_GPI_PIN_ROW_END,
> > -	.gpi_pin_col_base	=3D ADP5589_GPI_PIN_COL_BASE,
> > -	.gpi_pin_base		=3D ADP5589_GPI_PIN_BASE,
> > -	.gpi_pin_end		=3D ADP5589_GPI_PIN_END,
> > -	.gpimapsize_max		=3D ADP5589_GPIMAPSIZE_MAX,
> > -	.c4_extend_cfg		=3D 12,
> > -	.max_row_num		=3D ADP5589_MAX_ROW_NUM,
> > -	.max_col_num		=3D ADP5589_MAX_COL_NUM,
> > -	.row_mask		=3D ADP5589_ROW_MASK,
> > -	.col_mask		=3D ADP5589_COL_MASK,
> > -	.col_shift		=3D ADP5589_COL_SHIFT,
> > -	.bank			=3D adp5589_bank,
> > -	.bit			=3D adp5589_bit,
> > -	.reg			=3D adp5589_reg,
> > -};
> > -
> > -/* ADP5585 */
> > -
> > -static unsigned char adp5585_bank(unsigned char offset)
> > -{
> > -	return offset > ADP5585_MAX_ROW_NUM;
> > -}
> > -
> > -static unsigned char adp5585_bit(unsigned char offset)
> > -{
> > -	return (offset > ADP5585_MAX_ROW_NUM) ?
> > -		1u << (offset - ADP5585_COL_SHIFT) : 1u << offset;
> > -}
> > -
> > -static const unsigned char adp5585_reg_lut[] =3D {
> > -	[ADP5589_GPI_STATUS_A]		=3D ADP5585_GPI_STATUS_A,
> > -	[ADP5589_GPI_STATUS_B]		=3D ADP5585_GPI_STATUS_B,
> > -	[ADP5589_RPULL_CONFIG_A]	=3D ADP5585_RPULL_CONFIG_A,
> > -	[ADP5589_RPULL_CONFIG_B]	=3D ADP5585_RPULL_CONFIG_B,
> > -	[ADP5589_RPULL_CONFIG_C]	=3D ADP5585_RPULL_CONFIG_C,
> > -	[ADP5589_RPULL_CONFIG_D]	=3D ADP5585_RPULL_CONFIG_D,
> > -	[ADP5589_GPI_INT_LEVEL_A]	=3D ADP5585_GPI_INT_LEVEL_A,
> > -	[ADP5589_GPI_INT_LEVEL_B]	=3D ADP5585_GPI_INT_LEVEL_B,
> > -	[ADP5589_GPI_EVENT_EN_A]	=3D ADP5585_GPI_EVENT_EN_A,
> > -	[ADP5589_GPI_EVENT_EN_B]	=3D ADP5585_GPI_EVENT_EN_B,
> > -	[ADP5589_GPI_INTERRUPT_EN_A]	=3D ADP5585_GPI_INTERRUPT_EN_A,
> > -	[ADP5589_GPI_INTERRUPT_EN_B]	=3D ADP5585_GPI_INTERRUPT_EN_B,
> > -	[ADP5589_DEBOUNCE_DIS_A]	=3D ADP5585_DEBOUNCE_DIS_A,
> > -	[ADP5589_DEBOUNCE_DIS_B]	=3D ADP5585_DEBOUNCE_DIS_B,
> > -	[ADP5589_GPO_DATA_OUT_A]	=3D ADP5585_GPO_DATA_OUT_A,
> > -	[ADP5589_GPO_DATA_OUT_B]	=3D ADP5585_GPO_DATA_OUT_B,
> > -	[ADP5589_GPO_OUT_MODE_A]	=3D ADP5585_GPO_OUT_MODE_A,
> > -	[ADP5589_GPO_OUT_MODE_B]	=3D ADP5585_GPO_OUT_MODE_B,
> > -	[ADP5589_GPIO_DIRECTION_A]	=3D ADP5585_GPIO_DIRECTION_A,
> > -	[ADP5589_GPIO_DIRECTION_B]	=3D ADP5585_GPIO_DIRECTION_B,
> > -	[ADP5589_RESET1_EVENT_A]	=3D ADP5585_RESET1_EVENT_A,
> > -	[ADP5589_RESET1_EVENT_B]	=3D ADP5585_RESET1_EVENT_B,
> > -	[ADP5589_RESET1_EVENT_C]	=3D ADP5585_RESET1_EVENT_C,
> > -	[ADP5589_RESET2_EVENT_A]	=3D ADP5585_RESET2_EVENT_A,
> > -	[ADP5589_RESET2_EVENT_B]	=3D ADP5585_RESET2_EVENT_B,
> > -	[ADP5589_RESET_CFG]		=3D ADP5585_RESET_CFG,
> > -	[ADP5589_PWM_OFFT_LOW]		=3D ADP5585_PWM_OFFT_LOW,
> > -	[ADP5589_PWM_OFFT_HIGH]		=3D ADP5585_PWM_OFFT_HIGH,
> > -	[ADP5589_PWM_ONT_LOW]		=3D ADP5585_PWM_ONT_LOW,
> > -	[ADP5589_PWM_ONT_HIGH]		=3D ADP5585_PWM_ONT_HIGH,
> > -	[ADP5589_PWM_CFG]		=3D ADP5585_PWM_CFG,
> > -	[ADP5589_LOGIC_1_CFG]		=3D ADP5585_LOGIC_CFG,
> > -	[ADP5589_LOGIC_FF_CFG]		=3D ADP5585_LOGIC_FF_CFG,
> > -	[ADP5589_LOGIC_INT_EVENT_EN]	=3D ADP5585_LOGIC_INT_EVENT_EN,
> > -	[ADP5589_POLL_PTIME_CFG]	=3D ADP5585_POLL_PTIME_CFG,
> > -	[ADP5589_PIN_CONFIG_A]		=3D ADP5585_PIN_CONFIG_A,
> > -	[ADP5589_PIN_CONFIG_B]		=3D ADP5585_PIN_CONFIG_B,
> > -	[ADP5589_PIN_CONFIG_D]		=3D ADP5585_PIN_CONFIG_D,
> > -	[ADP5589_GENERAL_CFG]		=3D ADP5585_GENERAL_CFG,
> > -	[ADP5589_INT_EN]		=3D ADP5585_INT_EN,
> > -};
> > -
> > -static unsigned char adp5585_reg(unsigned char reg)
> > -{
> > -	return adp5585_reg_lut[reg];
> > -}
> > -
> > -static const struct adp_constants const_adp5585 =3D {
> > -	.maxgpio		=3D ADP5585_MAXGPIO,
> > -	.keymapsize		=3D ADP5585_KEYMAPSIZE,
> > -	.gpi_pin_row_base	=3D ADP5585_GPI_PIN_ROW_BASE,
> > -	.gpi_pin_row_end	=3D ADP5585_GPI_PIN_ROW_END,
> > -	.gpi_pin_col_base	=3D ADP5585_GPI_PIN_COL_BASE,
> > -	.gpi_pin_base		=3D ADP5585_GPI_PIN_BASE,
> > -	.gpi_pin_end		=3D ADP5585_GPI_PIN_END,
> > -	.gpimapsize_max		=3D ADP5585_GPIMAPSIZE_MAX,
> > -	.c4_extend_cfg		=3D 10,
> > -	.max_row_num		=3D ADP5585_MAX_ROW_NUM,
> > -	.max_col_num		=3D ADP5585_MAX_COL_NUM,
> > -	.row_mask		=3D ADP5585_ROW_MASK,
> > -	.col_mask		=3D ADP5585_COL_MASK,
> > -	.col_shift		=3D ADP5585_COL_SHIFT,
> > -	.bank			=3D adp5585_bank,
> > -	.bit			=3D adp5585_bit,
> > -	.reg			=3D adp5585_reg,
> > -};
> > -
> > -static int adp5589_read(struct i2c_client *client, u8 reg)
> > -{
> > -	int ret =3D i2c_smbus_read_byte_data(client, reg);
> > -
> > -	if (ret < 0)
> > -		dev_err(&client->dev, "Read Error\n");
> > -
> > -	return ret;
> > -}
> > -
> > -static int adp5589_write(struct i2c_client *client, u8 reg, u8 val)
> > -{
> > -	return i2c_smbus_write_byte_data(client, reg, val);
> > -}
> > -
> > -#ifdef CONFIG_GPIOLIB
> > -static int adp5589_gpio_get_value(struct gpio_chip *chip, unsigned off=
)
> > -{
> > -	struct adp5589_kpad *kpad =3D gpiochip_get_data(chip);
> > -	unsigned int bank =3D kpad->var->bank(kpad->gpiomap[off]);
> > -	unsigned int bit =3D kpad->var->bit(kpad->gpiomap[off]);
> > -	int val;
> > -
> > -	mutex_lock(&kpad->gpio_lock);
> > -	if (kpad->dir[bank] & bit)
> > -		val =3D kpad->dat_out[bank];
> > -	else
> > -		val =3D adp5589_read(kpad->client,
> > -				=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPI_STATUS_A) +
> > bank);
> > -	mutex_unlock(&kpad->gpio_lock);
> > -
> > -	return !!(val & bit);
> > -}
> > -
> > -static void adp5589_gpio_set_value(struct gpio_chip *chip,
> > -				=C2=A0=C2=A0 unsigned off, int val)
> > -{
> > -	struct adp5589_kpad *kpad =3D gpiochip_get_data(chip);
> > -	unsigned int bank =3D kpad->var->bank(kpad->gpiomap[off]);
> > -	unsigned int bit =3D kpad->var->bit(kpad->gpiomap[off]);
> > -
> > -	guard(mutex)(&kpad->gpio_lock);
> > -
> > -	if (val)
> > -		kpad->dat_out[bank] |=3D bit;
> > -	else
> > -		kpad->dat_out[bank] &=3D ~bit;
> > -
> > -	adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A)
> > +
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bank, kpad->dat_out[bank]);
> > -}
> > -
> > -static int adp5589_gpio_direction_input(struct gpio_chip *chip, unsign=
ed
> > off)
> > -{
> > -	struct adp5589_kpad *kpad =3D gpiochip_get_data(chip);
> > -	unsigned int bank =3D kpad->var->bank(kpad->gpiomap[off]);
> > -	unsigned int bit =3D kpad->var->bit(kpad->gpiomap[off]);
> > -
> > -	guard(mutex)(&kpad->gpio_lock);
> > -
> > -	kpad->dir[bank] &=3D ~bit;
> > -	return adp5589_write(kpad->client,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPIO_DIRECTION_A) +
> > bank,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 kpad->dir[bank]);
> > -}
> > -
> > -static int adp5589_gpio_direction_output(struct gpio_chip *chip,
> > -					 unsigned off, int val)
> > -{
> > -	struct adp5589_kpad *kpad =3D gpiochip_get_data(chip);
> > -	unsigned int bank =3D kpad->var->bank(kpad->gpiomap[off]);
> > -	unsigned int bit =3D kpad->var->bit(kpad->gpiomap[off]);
> > -	int error;
> > -
> > -	guard(mutex)(&kpad->gpio_lock);
> > -
> > -	kpad->dir[bank] |=3D bit;
> > -
> > -	if (val)
> > -		kpad->dat_out[bank] |=3D bit;
> > -	else
> > -		kpad->dat_out[bank] &=3D ~bit;
> > -
> > -	error =3D adp5589_write(kpad->client,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPO_DATA_OUT_=
A) +
> > bank,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kpad->dat_out[bank]);
> > -	if (error)
> > -		return error;
> > -
> > -	error =3D adp5589_write(kpad->client,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPIO_DIRECTIO=
N_A) +
> > bank,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kpad->dir[bank]);
> > -	if (error)
> > -		return error;
> > -
> > -	return 0;
> > -}
> > -
> > -static int adp5589_build_gpiomap(struct adp5589_kpad *kpad,
> > -				const struct adp5589_kpad_platform_data
> > *pdata)
> > -{
> > -	bool pin_used[ADP5589_MAXGPIO];
> > -	int n_unused =3D 0;
> > -	int i;
> > -
> > -	memset(pin_used, false, sizeof(pin_used));
> > -
> > -	for (i =3D 0; i < kpad->var->maxgpio; i++)
> > -		if (pdata->keypad_en_mask & BIT(i))
> > -			pin_used[i] =3D true;
> > -
> > -	for (i =3D 0; i < kpad->gpimapsize; i++)
> > -		pin_used[kpad->gpimap[i].pin - kpad->var->gpi_pin_base] =3D
> > true;
> > -
> > -	if (kpad->extend_cfg & R4_EXTEND_CFG)
> > -		pin_used[4] =3D true;
> > -
> > -	if (kpad->extend_cfg & C4_EXTEND_CFG)
> > -		pin_used[kpad->var->c4_extend_cfg] =3D true;
> > -
> > -	if (!kpad->support_row5)
> > -		pin_used[5] =3D true;
> > -
> > -	for (i =3D 0; i < kpad->var->maxgpio; i++)
> > -		if (!pin_used[i])
> > -			kpad->gpiomap[n_unused++] =3D i;
> > -
> > -	return n_unused;
> > -}
> > -
> > -static int adp5589_gpio_add(struct adp5589_kpad *kpad)
> > -{
> > -	struct device *dev =3D &kpad->client->dev;
> > -	const struct adp5589_kpad_platform_data *pdata =3D
> > dev_get_platdata(dev);
> > -	const struct adp5589_gpio_platform_data *gpio_data =3D pdata-
> > >gpio_data;
> > -	int i, error;
> > -
> > -	if (!gpio_data)
> > -		return 0;
> > -
> > -	kpad->gc.parent =3D dev;
> > -	kpad->gc.ngpio =3D adp5589_build_gpiomap(kpad, pdata);
> > -	if (kpad->gc.ngpio =3D=3D 0) {
> > -		dev_info(dev, "No unused gpios left to export\n");
> > -		return 0;
> > -	}
> > -
> > -	kpad->gc.direction_input =3D adp5589_gpio_direction_input;
> > -	kpad->gc.direction_output =3D adp5589_gpio_direction_output;
> > -	kpad->gc.get =3D adp5589_gpio_get_value;
> > -	kpad->gc.set =3D adp5589_gpio_set_value;
> > -	kpad->gc.can_sleep =3D 1;
> > -
> > -	kpad->gc.base =3D gpio_data->gpio_start;
> > -	kpad->gc.label =3D kpad->client->name;
> > -	kpad->gc.owner =3D THIS_MODULE;
> > -
> > -	mutex_init(&kpad->gpio_lock);
> > -
> > -	error =3D devm_gpiochip_add_data(dev, &kpad->gc, kpad);
> > -	if (error)
> > -		return error;
> > -
> > -	for (i =3D 0; i <=3D kpad->var->bank(kpad->var->maxgpio); i++) {
> > -		kpad->dat_out[i] =3D adp5589_read(kpad->client, kpad->var-
> > >reg(
> > -						ADP5589_GPO_DATA_OUT_A) +
> > i);
> > -		kpad->dir[i] =3D adp5589_read(kpad->client, kpad->var->reg(
> > -					=C2=A0=C2=A0=C2=A0 ADP5589_GPIO_DIRECTION_A) + i);
> > -	}
> > -
> > -	return 0;
> > -}
> > -#else
> > -static inline int adp5589_gpio_add(struct adp5589_kpad *kpad)
> > -{
> > -	return 0;
> > -}
> > -#endif
> > -
> > -static void adp5589_report_switches(struct adp5589_kpad *kpad,
> > -				=C2=A0=C2=A0=C2=A0 int key, int key_val)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < kpad->gpimapsize; i++) {
> > -		if (key_val =3D=3D kpad->gpimap[i].pin) {
> > -			input_report_switch(kpad->input,
> > -					=C2=A0=C2=A0=C2=A0 kpad->gpimap[i].sw_evt,
> > -					=C2=A0=C2=A0=C2=A0 key & KEY_EV_PRESSED);
> > -			break;
> > -		}
> > -	}
> > -}
> > -
> > -static void adp5589_report_events(struct adp5589_kpad *kpad, int ev_cn=
t)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < ev_cnt; i++) {
> > -		int key =3D adp5589_read(kpad->client, ADP5589_5_FIFO_1 + i);
> > -		int key_val =3D key & KEY_EV_MASK;
> > -
> > -		if (key_val >=3D kpad->var->gpi_pin_base &&
> > -		=C2=A0=C2=A0=C2=A0 key_val <=3D kpad->var->gpi_pin_end) {
> > -			adp5589_report_switches(kpad, key, key_val);
> > -		} else {
> > -			input_report_key(kpad->input,
> > -					 kpad->keycode[key_val - 1],
> > -					 key & KEY_EV_PRESSED);
> > -		}
> > -	}
> > -}
> > -
> > -static irqreturn_t adp5589_irq(int irq, void *handle)
> > -{
> > -	struct adp5589_kpad *kpad =3D handle;
> > -	struct i2c_client *client =3D kpad->client;
> > -	int status, ev_cnt;
> > -
> > -	status =3D adp5589_read(client, ADP5589_5_INT_STATUS);
> > -
> > -	if (status & OVRFLOW_INT)	/* Unlikely and should never happen
> > */
> > -		dev_err(&client->dev, "Event Overflow Error\n");
> > -
> > -	if (status & EVENT_INT) {
> > -		ev_cnt =3D adp5589_read(client, ADP5589_5_STATUS) & KEC;
> > -		if (ev_cnt) {
> > -			adp5589_report_events(kpad, ev_cnt);
> > -			input_sync(kpad->input);
> > -		}
> > -	}
> > -
> > -	adp5589_write(client, ADP5589_5_INT_STATUS, status); /* Status is
> > W1C */
> > -
> > -	return IRQ_HANDLED;
> > -}
> > -
> > -static int adp5589_get_evcode(struct adp5589_kpad *kpad, unsigned shor=
t
> > key)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < kpad->var->keymapsize; i++)
> > -		if (key =3D=3D kpad->keycode[i])
> > -			return (i + 1) | KEY_EV_PRESSED;
> > -
> > -	dev_err(&kpad->client->dev, "RESET/UNLOCK key not in keycode
> > map\n");
> > -
> > -	return -EINVAL;
> > -}
> > -
> > -static int adp5589_setup(struct adp5589_kpad *kpad)
> > -{
> > -	struct i2c_client *client =3D kpad->client;
> > -	const struct adp5589_kpad_platform_data *pdata =3D
> > -		dev_get_platdata(&client->dev);
> > -	u8 (*reg) (u8) =3D kpad->var->reg;
> > -	unsigned char evt_mode1 =3D 0, evt_mode2 =3D 0, evt_mode3 =3D 0;
> > -	unsigned char pull_mask =3D 0;
> > -	int i, ret;
> > -
> > -	ret =3D adp5589_write(client, reg(ADP5589_PIN_CONFIG_A),
> > -			=C2=A0=C2=A0=C2=A0 pdata->keypad_en_mask & kpad->var->row_mask);
> > -	ret |=3D adp5589_write(client, reg(ADP5589_PIN_CONFIG_B),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 (pdata->keypad_en_mask >> kpad->var-
> > >col_shift) &
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->col_mask);
> > -
> > -	if (!kpad->is_adp5585)
> > -		ret |=3D adp5589_write(client, ADP5589_PIN_CONFIG_C,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 (pdata->keypad_en_mask >> 16) & 0xFF);
> > -
> > -	if (!kpad->is_adp5585 && pdata->en_keylock) {
> > -		ret |=3D adp5589_write(client, ADP5589_UNLOCK1,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 pdata->unlock_key1);
> > -		ret |=3D adp5589_write(client, ADP5589_UNLOCK2,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 pdata->unlock_key2);
> > -		ret |=3D adp5589_write(client, ADP5589_UNLOCK_TIMERS,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 pdata->unlock_timer & LTIME_MASK);
> > -		ret |=3D adp5589_write(client, ADP5589_LOCK_CFG, LOCK_EN);
> > -	}
> > -
> > -	for (i =3D 0; i < KEYP_MAX_EVENT; i++)
> > -		ret |=3D adp5589_read(client, ADP5589_5_FIFO_1 + i);
> > -
> > -	for (i =3D 0; i < pdata->gpimapsize; i++) {
> > -		unsigned short pin =3D pdata->gpimap[i].pin;
> > -
> > -		if (pin <=3D kpad->var->gpi_pin_row_end) {
> > -			evt_mode1 |=3D BIT(pin - kpad->var-
> > >gpi_pin_row_base);
> > -		} else {
> > -			evt_mode2 |=3D
> > -			=C2=A0=C2=A0=C2=A0 BIT(pin - kpad->var->gpi_pin_col_base) & 0xFF;
> > -			if (!kpad->is_adp5585)
> > -				evt_mode3 |=3D
> > -				=C2=A0=C2=A0=C2=A0 BIT(pin - kpad->var->gpi_pin_col_base)
> > >> 8;
> > -		}
> > -	}
> > -
> > -	if (pdata->gpimapsize) {
> > -		ret |=3D adp5589_write(client, reg(ADP5589_GPI_EVENT_EN_A),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 evt_mode1);
> > -		ret |=3D adp5589_write(client, reg(ADP5589_GPI_EVENT_EN_B),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 evt_mode2);
> > -		if (!kpad->is_adp5585)
> > -			ret |=3D adp5589_write(client,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 reg(ADP5589_GPI_EVENT_EN_C),
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 evt_mode3);
> > -	}
> > -
> > -	if (pdata->pull_dis_mask & pdata->pullup_en_100k &
> > -		pdata->pullup_en_300k & pdata->pulldown_en_300k)
> > -		dev_warn(&client->dev, "Conflicting pull resistor
> > config\n");
> > -
> > -	for (i =3D 0; i <=3D kpad->var->max_row_num; i++) {
> > -		unsigned int val =3D 0, bit =3D BIT(i);
> > -		if (pdata->pullup_en_300k & bit)
> > -			val =3D 0;
> > -		else if (pdata->pulldown_en_300k & bit)
> > -			val =3D 1;
> > -		else if (pdata->pullup_en_100k & bit)
> > -			val =3D 2;
> > -		else if (pdata->pull_dis_mask & bit)
> > -			val =3D 3;
> > -
> > -		pull_mask |=3D val << (2 * (i & 0x3));
> > -
> > -		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
> > -			ret |=3D adp5589_write(client,
> > reg(ADP5585_RPULL_CONFIG_A)
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 + (i >> 2), pull_mask);
> > -			pull_mask =3D 0;
> > -		}
> > -	}
> > -
> > -	for (i =3D 0; i <=3D kpad->var->max_col_num; i++) {
> > -		unsigned int val =3D 0, bit =3D BIT(i + kpad->var->col_shift);
> > -		if (pdata->pullup_en_300k & bit)
> > -			val =3D 0;
> > -		else if (pdata->pulldown_en_300k & bit)
> > -			val =3D 1;
> > -		else if (pdata->pullup_en_100k & bit)
> > -			val =3D 2;
> > -		else if (pdata->pull_dis_mask & bit)
> > -			val =3D 3;
> > -
> > -		pull_mask |=3D val << (2 * (i & 0x3));
> > -
> > -		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
> > -			ret |=3D adp5589_write(client,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 reg(ADP5585_RPULL_CONFIG_C) +
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 (i >> 2), pull_mask);
> > -			pull_mask =3D 0;
> > -		}
> > -	}
> > -
> > -	if (pdata->reset1_key_1 && pdata->reset1_key_2 && pdata-
> > >reset1_key_3) {
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET1_EVENT_A),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 adp5589_get_evcode(kpad,
> > -							pdata-
> > >reset1_key_1));
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET1_EVENT_B),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 adp5589_get_evcode(kpad,
> > -							pdata-
> > >reset1_key_2));
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET1_EVENT_C),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 adp5589_get_evcode(kpad,
> > -							pdata-
> > >reset1_key_3));
> > -		kpad->extend_cfg |=3D R4_EXTEND_CFG;
> > -	}
> > -
> > -	if (pdata->reset2_key_1 && pdata->reset2_key_2) {
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET2_EVENT_A),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 adp5589_get_evcode(kpad,
> > -							pdata-
> > >reset2_key_1));
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET2_EVENT_B),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 adp5589_get_evcode(kpad,
> > -							pdata-
> > >reset2_key_2));
> > -		kpad->extend_cfg |=3D C4_EXTEND_CFG;
> > -	}
> > -
> > -	if (kpad->extend_cfg) {
> > -		ret |=3D adp5589_write(client, reg(ADP5589_RESET_CFG),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 pdata->reset_cfg);
> > -		ret |=3D adp5589_write(client, reg(ADP5589_PIN_CONFIG_D),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 kpad->extend_cfg);
> > -	}
> > -
> > -	ret |=3D adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_A),
> > -			=C2=A0=C2=A0=C2=A0 pdata->debounce_dis_mask & kpad->var-
> > >row_mask);
> > -
> > -	ret |=3D adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_B),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 (pdata->debounce_dis_mask >> kpad->var-
> > >col_shift)
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 & kpad->var->col_mask);
> > -
> > -	if (!kpad->is_adp5585)
> > -		ret |=3D adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_C),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 (pdata->debounce_dis_mask >> 16) &
> > 0xFF);
> > -
> > -	ret |=3D adp5589_write(client, reg(ADP5589_POLL_PTIME_CFG),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 pdata->scan_cycle_time & PTIME_MASK);
> > -	ret |=3D adp5589_write(client, ADP5589_5_INT_STATUS,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 (kpad->is_adp5585 ? 0 : LOGIC2_INT) |
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 LOGIC1_INT | OVRFLOW_INT |
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 (kpad->is_adp5585 ? 0 : LOCK_INT) |
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 GPI_INT | EVENT_INT);	/* Status is W1C */
> > -
> > -	ret |=3D adp5589_write(client, reg(ADP5589_GENERAL_CFG),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 INT_CFG | OSC_EN | CORE_CLK(3));
> > -	ret |=3D adp5589_write(client, reg(ADP5589_INT_EN),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 OVRFLOW_IEN | GPI_IEN | EVENT_IEN);
> > -
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "Write Error\n");
> > -		return ret;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static void adp5589_report_switch_state(struct adp5589_kpad *kpad)
> > -{
> > -	int gpi_stat_tmp, pin_loc;
> > -	int i;
> > -	int gpi_stat1 =3D adp5589_read(kpad->client,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPI_STATUS_A));
> > -	int gpi_stat2 =3D adp5589_read(kpad->client,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 kpad->var->reg(ADP5589_GPI_STATUS_B));
> > -	int gpi_stat3 =3D !kpad->is_adp5585 ?
> > -			adp5589_read(kpad->client, ADP5589_GPI_STATUS_C) :
> > 0;
> > -
> > -	for (i =3D 0; i < kpad->gpimapsize; i++) {
> > -		unsigned short pin =3D kpad->gpimap[i].pin;
> > -
> > -		if (pin <=3D kpad->var->gpi_pin_row_end) {
> > -			gpi_stat_tmp =3D gpi_stat1;
> > -			pin_loc =3D pin - kpad->var->gpi_pin_row_base;
> > -		} else if ((pin - kpad->var->gpi_pin_col_base) < 8) {
> > -			gpi_stat_tmp =3D gpi_stat2;
> > -			pin_loc =3D pin - kpad->var->gpi_pin_col_base;
> > -		} else {
> > -			gpi_stat_tmp =3D gpi_stat3;
> > -			pin_loc =3D pin - kpad->var->gpi_pin_col_base - 8;
> > -		}
> > -
> > -		if (gpi_stat_tmp < 0) {
> > -			dev_err(&kpad->client->dev,
> > -				"Can't read GPIO_DAT_STAT switch %d,
> > default to OFF\n",
> > -				pin);
> > -			gpi_stat_tmp =3D 0;
> > -		}
> > -
> > -		input_report_switch(kpad->input,
> > -				=C2=A0=C2=A0=C2=A0 kpad->gpimap[i].sw_evt,
> > -				=C2=A0=C2=A0=C2=A0 !(gpi_stat_tmp & BIT(pin_loc)));
> > -	}
> > -
> > -	input_sync(kpad->input);
> > -}
> > -
> > -static int adp5589_keypad_add(struct adp5589_kpad *kpad, unsigned int
> > revid)
> > -{
> > -	struct i2c_client *client =3D kpad->client;
> > -	const struct adp5589_kpad_platform_data *pdata =3D
> > -		dev_get_platdata(&client->dev);
> > -	struct input_dev *input;
> > -	unsigned int i;
> > -	int error;
> > -
> > -	if (!((pdata->keypad_en_mask & kpad->var->row_mask) &&
> > -			(pdata->keypad_en_mask >> kpad->var->col_shift)) ||
> > -			!pdata->keymap) {
> > -		dev_err(&client->dev, "no rows, cols or keymap from
> > pdata\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (pdata->keymapsize !=3D kpad->var->keymapsize) {
> > -		dev_err(&client->dev, "invalid keymapsize\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (!pdata->gpimap && pdata->gpimapsize) {
> > -		dev_err(&client->dev, "invalid gpimap from pdata\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (pdata->gpimapsize > kpad->var->gpimapsize_max) {
> > -		dev_err(&client->dev, "invalid gpimapsize\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	for (i =3D 0; i < pdata->gpimapsize; i++) {
> > -		unsigned short pin =3D pdata->gpimap[i].pin;
> > -
> > -		if (pin < kpad->var->gpi_pin_base ||
> > -				pin > kpad->var->gpi_pin_end) {
> > -			dev_err(&client->dev, "invalid gpi pin data\n");
> > -			return -EINVAL;
> > -		}
> > -
> > -		if (BIT(pin - kpad->var->gpi_pin_row_base) &
> > -				pdata->keypad_en_mask) {
> > -			dev_err(&client->dev, "invalid gpi row/col
> > data\n");
> > -			return -EINVAL;
> > -		}
> > -	}
> > -
> > -	if (!client->irq) {
> > -		dev_err(&client->dev, "no IRQ?\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	input =3D devm_input_allocate_device(&client->dev);
> > -	if (!input)
> > -		return -ENOMEM;
> > -
> > -	kpad->input =3D input;
> > -
> > -	input->name =3D client->name;
> > -	input->phys =3D "adp5589-keys/input0";
> > -	input->dev.parent =3D &client->dev;
> > -
> > -	input_set_drvdata(input, kpad);
> > -
> > -	input->id.bustype =3D BUS_I2C;
> > -	input->id.vendor =3D 0x0001;
> > -	input->id.product =3D 0x0001;
> > -	input->id.version =3D revid;
> > -
> > -	input->keycodesize =3D sizeof(kpad->keycode[0]);
> > -	input->keycodemax =3D pdata->keymapsize;
> > -	input->keycode =3D kpad->keycode;
> > -
> > -	memcpy(kpad->keycode, pdata->keymap,
> > -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata->keymapsize * input->keyco=
desize);
> > -
> > -	kpad->gpimap =3D pdata->gpimap;
> > -	kpad->gpimapsize =3D pdata->gpimapsize;
> > -
> > -	/* setup input device */
> > -	__set_bit(EV_KEY, input->evbit);
> > -
> > -	if (pdata->repeat)
> > -		__set_bit(EV_REP, input->evbit);
> > -
> > -	for (i =3D 0; i < input->keycodemax; i++)
> > -		if (kpad->keycode[i] <=3D KEY_MAX)
> > -			__set_bit(kpad->keycode[i], input->keybit);
> > -	__clear_bit(KEY_RESERVED, input->keybit);
> > -
> > -	if (kpad->gpimapsize)
> > -		__set_bit(EV_SW, input->evbit);
> > -	for (i =3D 0; i < kpad->gpimapsize; i++)
> > -		__set_bit(kpad->gpimap[i].sw_evt, input->swbit);
> > -
> > -	error =3D input_register_device(input);
> > -	if (error) {
> > -		dev_err(&client->dev, "unable to register input device\n");
> > -		return error;
> > -	}
> > -
> > -	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> > -					=C2=A0 NULL, adp5589_irq,
> > -					=C2=A0 IRQF_TRIGGER_FALLING |
> > IRQF_ONESHOT,
> > -					=C2=A0 client->dev.driver->name, kpad);
> > -	if (error) {
> > -		dev_err(&client->dev, "unable to request irq %d\n", client-
> > >irq);
> > -		return error;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static void adp5589_clear_config(void *data)
> > -{
> > -	struct adp5589_kpad *kpad =3D data;
> > -
> > -	adp5589_write(kpad->client, kpad->var->reg(ADP5589_GENERAL_CFG),
> > 0);
> > -}
> > -
> > -static int adp5589_probe(struct i2c_client *client)
> > -{
> > -	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> > -	struct adp5589_kpad *kpad;
> > -	const struct adp5589_kpad_platform_data *pdata =3D
> > -		dev_get_platdata(&client->dev);
> > -	unsigned int revid;
> > -	int error, ret;
> > -
> > -	if (!i2c_check_functionality(client->adapter,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 I2C_FUNC_SMBUS_BYTE_DATA)) {
> > -		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
> > -		return -EIO;
> > -	}
> > -
> > -	if (!pdata) {
> > -		dev_err(&client->dev, "no platform data?\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	kpad =3D devm_kzalloc(&client->dev, sizeof(*kpad), GFP_KERNEL);
> > -	if (!kpad)
> > -		return -ENOMEM;
> > -
> > -	kpad->client =3D client;
> > -
> > -	switch (id->driver_data) {
> > -	case ADP5585_02:
> > -		kpad->support_row5 =3D true;
> > -		fallthrough;
> > -	case ADP5585_01:
> > -		kpad->is_adp5585 =3D true;
> > -		kpad->var =3D &const_adp5585;
> > -		break;
> > -	case ADP5589:
> > -		kpad->support_row5 =3D true;
> > -		kpad->var =3D &const_adp5589;
> > -		break;
> > -	}
> > -
> > -	error =3D devm_add_action_or_reset(&client->dev,
> > adp5589_clear_config,
> > -					 kpad);
> > -	if (error)
> > -		return error;
> > -
> > -	ret =3D adp5589_read(client, ADP5589_5_ID);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	revid =3D (u8) ret & ADP5589_5_DEVICE_ID_MASK;
> > -
> > -	if (pdata->keymapsize) {
> > -		error =3D adp5589_keypad_add(kpad, revid);
> > -		if (error)
> > -			return error;
> > -	}
> > -
> > -	error =3D adp5589_setup(kpad);
> > -	if (error)
> > -		return error;
> > -
> > -	if (kpad->gpimapsize)
> > -		adp5589_report_switch_state(kpad);
> > -
> > -	error =3D adp5589_gpio_add(kpad);
> > -	if (error)
> > -		return error;
> > -
> > -	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client-
> > >irq);
> > -	return 0;
> > -}
> > -
> > -static int adp5589_suspend(struct device *dev)
> > -{
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > -	struct adp5589_kpad *kpad =3D i2c_get_clientdata(client);
> > -
> > -	if (kpad->input)
> > -		disable_irq(client->irq);
> > -
> > -	return 0;
> > -}
> > -
> > -static int adp5589_resume(struct device *dev)
> > -{
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > -	struct adp5589_kpad *kpad =3D i2c_get_clientdata(client);
> > -
> > -	if (kpad->input)
> > -		enable_irq(client->irq);
> > -
> > -	return 0;
> > -}
> > -
> > -static DEFINE_SIMPLE_DEV_PM_OPS(adp5589_dev_pm_ops, adp5589_suspend,
> > adp5589_resume);
> > -
> > -static const struct i2c_device_id adp5589_id[] =3D {
> > -	{"adp5589-keys", ADP5589},
> > -	{"adp5585-keys", ADP5585_01},
> > -	{"adp5585-02-keys", ADP5585_02}, /* Adds ROW5 to ADP5585 */
> > -	{}
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, adp5589_id);
> > -
> > -static struct i2c_driver adp5589_driver =3D {
> > -	.driver =3D {
> > -		.name =3D KBUILD_MODNAME,
> > -		.pm =3D pm_sleep_ptr(&adp5589_dev_pm_ops),
> > -	},
> > -	.probe =3D adp5589_probe,
> > -	.id_table =3D adp5589_id,
> > -};
> > -
> > -module_i2c_driver(adp5589_driver);
> > -
> > -MODULE_LICENSE("GPL");
> > -MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > -MODULE_DESCRIPTION("ADP5589/ADP5585 Keypad driver");


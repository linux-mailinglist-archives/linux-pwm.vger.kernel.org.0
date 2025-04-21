Return-Path: <linux-pwm+bounces-5625-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DFA950FB
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF23A7CE3
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F205264A90;
	Mon, 21 Apr 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrsKwCO/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3B1D8A10;
	Mon, 21 Apr 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238807; cv=none; b=QRp6n/8DrTlNgU8zGvdxhyMMCuhgLx6JCb5CZNRhMy6Hvp3QXqqBJNuPhS8T4P7EQ9N13cui6e4LD8cqAT9tMvgWGm2/Z3ndaTGGHFD0vMGuBdTYPbDgc36SrbcbaeG0Cn6OBKBaIRJi9kMizF5FDdEWTKbfhI4wmQiLJoyPO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238807; c=relaxed/simple;
	bh=XYhs1QSYSNftVM2iKdS6m58WtbH/0U/2gs8X2yJh2mM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sn795/HT9GGK5pdNvcd9UiRGqkWPiR0NCg/N5tb0phTCPBN/8ND6E8lF0YbX8b4jzd21YHajHB08QN8i/r/qz7eIfrRonnDwIdyV+/JVT2s/vSTorcZJgjxUDTriUaqQMfvDAYkL2BVLtAegDvwQ3LMs34w4iJVqTYrfZBUfN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrsKwCO/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso29538695e9.2;
        Mon, 21 Apr 2025 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238803; x=1745843603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=efo80VRYiMCepf8aSp7sne2o+vO5Bogjl6QzIBkDjNw=;
        b=lrsKwCO/tH3IGAcOtzfxvkUT3eZo1iaiAJesRhCTzLSplRqg6P7fQe3Va4QSVaKQp6
         8lv27mbgHJLOJJeUxxUsI9Aquqktjjj7XM7FEXV5yOuodfeVEZOQQP3QDGhdIaO1yRw0
         0QHJwMwdYKaNpapHEbsiIYNcj+35imlZJe5VGw2zSq8hRY4iB3ZMdml2+iLrQc7K+uM8
         YLWRyS/JnsMRU+dD1LYg9c3p1xG4RcpSFI6769zCYppVkdnp6EU/VyMLU/HH4PM4QIZj
         mOvYoYYaAvRpJYmLB76E1aUVaz7DEPayd9CkhBINJU7xM02WN4Qdrscy65elqDuQRU0P
         YXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238803; x=1745843603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efo80VRYiMCepf8aSp7sne2o+vO5Bogjl6QzIBkDjNw=;
        b=WSXeJJUDLtiaJBf9EKV0dF2Jct4xtkO1tCdO9qNUcdOY9rZA0VTicNmubE3nxNN79n
         oPlkBMZwAbH/adGJRfLbcS14sdlS6lewXklfcNEgaZAIsdQUekprxNjwGRVNv/ltTJSa
         M0u88PZ8pm9SqtTeY1k6FzXf3VkmkooEYMMKpf9Szsg4ocOwZeGTya4HF1iuNijo8hQI
         UChdML9uZqI+Q+pGvMYwr1bXwbqzAWkBpEWlvqgIJaiFjRPr/onWi0NL4i6sQTQN6EbS
         1RAuPmflPK69LGpA2Q++KgLXqp+uKY1DEpOl//hPrToLdw5Io3Kopv57aoibahZ1C9vh
         Wrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUOJHGQcIbdGjUxZOFxpUPWq6O8UnuFvqT+lDjnbDvjFd3e3ipiFaexNrIB3VSWVHlVoHwT/X7f4gMQ@vger.kernel.org, AJvYcCWXqs1xFYmozgXEdNQiEBD0s5YCCRR/lObPm03/g2eRFpkpB2m/C5knjoZRzKJYtPP8bEDnNo+RHEuf0iE=@vger.kernel.org, AJvYcCWxFQcBez4I6jtzptPrexs+f8D7j5gxkzE1Nqe5MG3IR1wEOAesErpZwTG8URXo+npCmebiOhgnvSmP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0R6ayiUL0lsZoIw/TK7DOa+abiHfLGdbkja5R0twFNg8KzVjs
	EarrT63A2EgAJ+9nHYQgKt2WZBnxGgAoqzkcqZBi3/Itpm6lWIMZNcUlXyt2ZTw=
X-Gm-Gg: ASbGncssfNjCB9LvkylQyGmSKZL0evMVzfFAOhaAgC3mhXgHV/W0Kdy79DWKfV/EOnD
	95nmRN55iRfrhdsx5kMqcdxm7koHXo8nwnbYpSwK8aBeYvsx2kjdRtJVBF4cAjKVfjO1wZP39Q0
	h2rxY2uzHkAhw47cmNYbvvhf+JNzOmNJk1oPN7bU9uETv1e2j9o57Ldr30HewIQrbP+SFzz/9Da
	OzEx32XajONnHQdW6ypg9jOKkGwreDTg1w+wCJfxLUFwdPXQP+KWiIHkQimECsmGyPULal/Vvyk
	9Bc8e0qfJtiwPXhCgtL2wohSGvyQVD2siwliLRcaBqDf7c1fHhnM6Rm71OKuca2Q3MpuuO2iFr+
	1fxI8FA9C/kAp
X-Google-Smtp-Source: AGHT+IFTgyDm7cbA5B9xbJTkTE3f6RC1M7JDG7gduTo/ZV8LPoX+hfNHXJWYAqmuOSv5EjLNXhO2Bw==
X-Received: by 2002:a05:600c:3c87:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-4406aba2c6cmr108206515e9.14.1745238803232;
        Mon, 21 Apr 2025 05:33:23 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd35sm132707155e9.22.2025.04.21.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:33:22 -0700 (PDT)
Message-ID: <f6896ba5c4bc0596db5950220ef956b629df7b04.camel@gmail.com>
Subject: Re: [PATCH v2 12/17] Input: adp5585: Add Analog Devices ADP5585/89
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:33:23 +0100
In-Reply-To: <20250421093515.GI29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>
	 <20250421093515.GI29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:35 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:28PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The ADP5585 is a 10/11 input/output port expander with a built in keypa=
d
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the keyboard function using the platform device
> > registered by the core MFD driver.
> >=20
> > The ADP5589 has 19 pins and also features an unlock function.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/input/keyboard/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 ++
> > =C2=A0drivers/input/keyboard/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/input/keyboard/adp5585-keys.c | 221
> > ++++++++++++++++++++++++++++++++++
> > =C2=A04 files changed, 234 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index
> > b5acf50fc6af4322dec0dad2169b46c6a1903e3c..48bd39a1a96d9c57145cf2560eec5=
42484
> > 27fc89 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -549,6 +549,7 @@ L:	linux-pwm@vger.kernel.org
> > =C2=A0S:	Maintained
> > =C2=A0F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
> > =C2=A0F:	drivers/gpio/gpio-adp5585.c
> > +F:	drivers/input/adp5585-keys.c
> > =C2=A0F:	drivers/mfd/adp5585.c
> > =C2=A0F:	drivers/pwm/pwm-adp5585.c
> > =C2=A0F:	include/linux/mfd/adp5585.h
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index
> > 721ab69e84ac6586f4f19102890a15ca3fcf1910..322da0957067db77c7f66ab26a181=
d39c2
> > c1d513 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -37,6 +37,17 @@ config KEYBOARD_ADP5520
> > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the mo=
dule
> > will
> > =C2=A0	=C2=A0 be called adp5520-keys.
> > =C2=A0
> > +config KEYBOARD_ADP5585
> > +	tristate "ADP5585 and similar=C2=A0 I2C QWERTY Keypad and IO Expander=
s"
> > +	depends on MFD_ADP5585
> > +	select INPUT_MATRIXKMAP
> > +	help
> > +	=C2=A0 This option enables support for the KEYMAP function found in t=
he
> > Analog
> > +	=C2=A0 Devices ADP5585 and similar devices.
> > +
> > +	=C2=A0 To compile this driver as a module, choose M here: the
> > +	=C2=A0 module will be called adp5585-keys.
> > +
> > =C2=A0config KEYBOARD_ADP5588
> > =C2=A0	tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
> > =C2=A0	depends on I2C
> > diff --git a/drivers/input/keyboard/Makefile
> > b/drivers/input/keyboard/Makefile
> > index
> > 1e0721c3070968a6339a42f65a95af48364f6897..f00ec003a59aa28577ae164c0539c=
c5aff
> > 9579fc 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -7,6 +7,7 @@
> > =C2=A0
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADC)		+=3D adc-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5520)		+=3D adp5520-keys.o
> > +obj-$(CONFIG_KEYBOARD_ADP5585)		+=3D adp5585-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5588)		+=3D adp5588-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_ADP5589)		+=3D adp5589-keys.o
> > =C2=A0obj-$(CONFIG_KEYBOARD_AMIGA)		+=3D amikbd.o
> > diff --git a/drivers/input/keyboard/adp5585-keys.c
> > b/drivers/input/keyboard/adp5585-keys.c
> > new file mode 100644
> > index
> > 0000000000000000000000000000000000000000..93961a9e822f8b10b1bca526b9486=
eed4a
> > d7f8f7
> > --- /dev/null
> > +++ b/drivers/input/keyboard/adp5585-keys.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices ADP5585 Keys driver
> > + *
> > + * Copyright (C) 2025 Analog Devices, Inc.
> > + */
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/device.h>
> > +#include <linux/find.h>
> > +#include <linux/input.h>
> > +#include <linux/input/matrix_keypad.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> > +
> > +/* As needed for the matrix parsing code */
> > +#define ADP5589_MAX_KEYMAPSIZE		123
> > +
> > +struct adp5585_kpad {
> > +	struct input_dev *input;
> > +	unsigned short keycode[ADP5589_MAX_KEYMAPSIZE];
> > +	struct device *dev;
> > +	int row_shift;
> > +	u8 max_rows;
> > +	u8 max_cols;
> > +};
> > +
> > +static int adp5585_keys_parse_fw(const struct adp5585_dev *adp5585,
> > +				 struct adp5585_kpad *kpad)
> > +{
> > +	unsigned long row_map, col_map;
> > +	struct device *dev =3D kpad->dev;
> > +	u32 cols =3D 0, rows =3D 0;
> > +	int ret;
> > +
> > +	row_map =3D bitmap_read(adp5585->keypad, 0, kpad->max_rows);
> > +	col_map =3D bitmap_read(adp5585->keypad, kpad->max_rows, kpad-
> > >max_cols);
> > +	/*
> > +	 * Note that given that we get a mask (and the HW allows it), we
> > +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> > +	 * However, for the matrix parsing functions we need to pass the
> > +	 * number of rows/cols as the maximum row/col used plus 1. This
> > +	 * pretty much means we will also have holes in our SW keypad.
> > +	 */
> > +	if (!bitmap_empty(&row_map, kpad->max_rows))
> > +		rows =3D find_last_bit(&row_map, kpad->max_rows) + 1;
> > +	if (!bitmap_empty(&col_map, kpad->max_cols))
> > +		cols =3D find_last_bit(&col_map, kpad->max_cols) + 1;
> > +
> > +	if (!rows && !cols)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "No rows or columns defined for the
> > keypad\n");
> > +
> > +	if (cols && !rows)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot have columns with no
> > rows!\n");
> > +
> > +	if (rows && !cols)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot have rows with no
> > columns!\n");
> > +
> > +	ret =3D matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> > +					 kpad->keycode, kpad->input);
> > +	if (ret)
> > +		return ret;
> > +
> > +	kpad->row_shift =3D get_count_order(cols);
> > +
> > +	if (device_property_present(kpad->dev, "autorepeat"))
> > +		__set_bit(EV_REP, kpad->input->evbit);
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_keys_setup(const struct adp5585_dev *adp5585,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct adp5585_kpad *kpad)
> > +{
> > +	unsigned long keys_bits, start =3D 0, nbits =3D kpad->max_rows;
> > +	const struct adp5585_regs *regs =3D adp5585->info->regs;
> > +	unsigned int i =3D 0, max_cols =3D kpad->max_cols;
> > +	int ret;
> > +
> > +	/*
> > +	 * Take care as the below assumes max_rows is always less or equal
> > than
> > +	 * 8 which is true for the supported devices. If we happen to add
> > +	 * another device we need to make sure this still holds true.
> > Although
> > +	 * adding a new device is very unlikely.
> > +	 */
> > +	do {
> > +		keys_bits =3D bitmap_read(adp5585->keypad, start, nbits);
> > +		if (keys_bits) {
> > +			ret =3D regmap_write(adp5585->regmap, regs->pin_cfg_a
> > + i,
> > +					=C2=A0=C2=A0 keys_bits);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		start +=3D nbits;
> > +		if (max_cols > 8) {
> > +			nbits =3D 8;
> > +			max_cols -=3D nbits;
> > +		} else {
> > +			nbits =3D max_cols;
> > +		}
> > +
> > +		i++;
> > +	} while (start < kpad->max_rows + kpad->max_cols);
> > +
> > +	return 0;
> > +}
> > +
> > +static void adp5585_keys_ev_handle(struct device *dev, unsigned int ke=
y,
> > +				=C2=A0=C2=A0 bool key_press)
> > +{
> > +	struct adp5585_kpad *kpad =3D dev_get_drvdata(dev);
> > +	unsigned int row, col, code;
> > +
> > +	row =3D (key - 1) / (kpad->max_cols);
> > +	col =3D (key - 1) % (kpad->max_cols);
> > +	code =3D MATRIX_SCAN_CODE(row, col, kpad->row_shift);
> > +
> > +	dev_dbg_ratelimited(kpad->dev, "report key(%d) r(%d) c(%d)
> > code(%d)\n",
> > +			=C2=A0=C2=A0=C2=A0 key, row, col, kpad->keycode[code]);
> > +
> > +	input_report_key(kpad->input, kpad->keycode[code], key_press);
> > +	input_sync(kpad->input);
> > +}
> > +
> > +static void adp5585_keys_ev_handle_clean(void *adp5585)
> > +{
> > +	adp5585_keys_ev_handle_set(adp5585, NULL, NULL);
> > +}
> > +
> > +static int adp5585_keys_probe(struct platform_device *pdev)
> > +{
> > +	struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev =3D &pdev->dev;
> > +	struct adp5585_kpad *kpad;
> > +	unsigned int revid;
> > +	const char *phys;
> > +	int ret;
> > +
> > +	kpad =3D devm_kzalloc(dev, sizeof(*kpad), GFP_KERNEL);
> > +	if (!kpad)
> > +		return -ENOMEM;
> > +
> > +	if (!adp5585->irq)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "IRQ is mandatory for the keypad\n");
>=20
> This causes the following messages to be printed in the kernel log on a
> platform where the keypad feature is not declared in DT:
>=20
> [=C2=A0=C2=A0 11.625591] adp5585-keys adp5585-keys.1.auto: error -EINVAL:=
 IRQ is
> mandatory for the keypad
> [=C2=A0=C2=A0 11.625637] adp5585-keys adp5585-keys.1.auto: probe with dri=
ver adp5585-
> keys failed with error -22
>=20
> The MFD driver should detect which features are declared, and only
> register the corresponding MFD cells.

Oh right, the above does not look right!

- Nuno S=C3=A1
>=20
> > +
> > +	kpad->dev =3D dev;
> > +	kpad->max_cols =3D adp5585->info->max_cols;
> > +	kpad->max_rows =3D adp5585->info->max_rows;
> > +
> > +	kpad->input =3D devm_input_allocate_device(dev);
> > +	if (!kpad->input)
> > +		return -ENOMEM;
> > +
> > +	ret =3D regmap_read(adp5585->regmap, ADP5585_ID, &revid);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read device
> > ID\n");
> > +
> > +	phys =3D devm_kasprintf(dev, GFP_KERNEL, "%s/input0", pdev->name);
> > +	if (!phys)
> > +		return -ENOMEM;
> > +
> > +	kpad->input->name =3D pdev->name;
> > +	kpad->input->phys =3D phys;
> > +	kpad->input->dev.parent =3D dev;
> > +
> > +	input_set_drvdata(kpad->input, kpad);
> > +
> > +	kpad->input->id.bustype =3D BUS_I2C;
> > +	kpad->input->id.vendor =3D 0x0001;
> > +	kpad->input->id.product =3D 0x0001;
> > +	kpad->input->id.version =3D revid & ADP5585_REV_ID_MASK;
> > +
> > +	device_set_of_node_from_dev(dev, dev->parent);
> > +
> > +	ret =3D adp5585_keys_parse_fw(adp5585, kpad);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D adp5585_keys_setup(adp5585, kpad);
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, kpad);
> > +	adp5585_keys_ev_handle_set(adp5585, adp5585_keys_ev_handle, dev);
> > +	ret =3D devm_add_action_or_reset(dev, adp5585_keys_ev_handle_clean,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return input_register_device(kpad->input);
> > +}
> > +
> > +static const struct platform_device_id adp5585_keys_id_table[] =3D {
> > +	{ "adp5585-keys" },
> > +	{ "adp5589-keys" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, adp5585_keys_id_table);
> > +
> > +static struct platform_driver adp5585_keys_driver =3D {
> > +	.driver	=3D {
> > +		.name =3D "adp5585-keys",
> > +	},
> > +	.probe =3D adp5585_keys_probe,
> > +	.id_table =3D adp5585_keys_id_table,
> > +};
> > +module_platform_driver(adp5585_keys_driver);
> > +
> > +MODULE_AUTHOR("Nuno S=C3=A1 <nuno.sa@analog.com>");
> > +MODULE_DESCRIPTION("ADP5585 Keys Driver");
> > +MODULE_LICENSE("GPL");


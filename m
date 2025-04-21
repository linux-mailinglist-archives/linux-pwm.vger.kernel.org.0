Return-Path: <linux-pwm+bounces-5624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F2A950F3
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8183A16F294
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789772620D5;
	Mon, 21 Apr 2025 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZySa5ABH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4827463;
	Mon, 21 Apr 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238763; cv=none; b=FusTmoOSRjXEvLlFu0ewiurdKNqn82laJXQ8ECj7PlWew4EZAPUcWUu9cPlDTdYLhGRYm+1oQE3WN3pc4M8Y4xKD5rFaF1I7A5Atoq4u2JHco/8LRP802XPo7N+0+qrxdJhvmdKClyxNIjjPCaqwbzd9mCDr2Dom4mrK2u4uJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238763; c=relaxed/simple;
	bh=463Cd/gWdR4I2k7NEzvQMJDGik+OCV+atq+FocHrW0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAP9+ZNGYYYPLIL/1rx61JLujkSlPr5eA+nyYIG2eEgHE0851J5gviFBslSx/9g8CnRxURWsqw+bBWTtDhRJrcMTuOOjkHBzDEUO7+aAiZhTY5w8jAzG7cOJKckTzhfbFf6JDIzDuxSe3/V4M7XeMRRzzHWusE/4EAP6W/Mw0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZySa5ABH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so40575555e9.3;
        Mon, 21 Apr 2025 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238759; x=1745843559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSbTkooSHr/zf0+42n8yfjj5W2qKOdf/hISiX8t/Lsc=;
        b=ZySa5ABHRE/nUM9xAlWnCHMfiOHxmzOB+GT/TjZMgK8GzkGAGvu9/xdQgsWJGU4vJM
         tJrWx9fqFUQKSF6zB5tTftdSNzSSBU4r9YkiH3GFXjc8gUkbq9YLfTMc59GcIz0hS3HW
         xL7lUs9R00VVZmz3KTHG3sljsBWcepkptDWhQDdK7uSteWWhttQQLgUjv6DHY6EDFCVT
         Z1vGGunhKNYvyNUmpPv27Zj8KsLUSTVTvglyuHtGdkKJ+D4+85zXizgOhzF4YVEKPb4y
         2h2z8ofVzJBwkYx4RovEqxZk8XJtNvnfitWY1Ir7uWONKaBCNLVyG23sXR5c1b6WJNz/
         qDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238759; x=1745843559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSbTkooSHr/zf0+42n8yfjj5W2qKOdf/hISiX8t/Lsc=;
        b=NSIo825jMgVjG9ZiUDQen9qyritCSrVMYpjlqMZMip8GAAwT1Gh9UnLzYb5TKFUvIo
         V66LQfqbGNrkgj69Rxe1w3ttrMqjCH1fOpg3OVtxLzVp6sIrCuz6XTpYqn/BIhsew6uk
         HfCaLWxq17u1irlqLClSjHx0VdEMR2o3+QNB7WA/xMcjiF24Q06V4I6DWlUDZWrBgCrq
         XyBCFBSrAgzHVs1aeN8nBhfgIfA3jOZVESM3/gJHe5HgBNoBlEdtML8zMmjyWxvFNrRh
         VYbgagffEdOT+FbcoNB0CXLgL8vvKG92zdj/JQIVDRLqegnBBqTsA4OjIv7Q9qpUUnfp
         8etA==
X-Forwarded-Encrypted: i=1; AJvYcCWakzfHGizVwot1U8nweDLKcNX8+4nl3JaqbIdTehrOirGkXuMPUeR7RYFeGLzrpt0XBjhBiCWySoLS@vger.kernel.org, AJvYcCXPWq5ZzUECvaX+fDHLNbhRuUG3QJ1yTq+h2ZpP9ALOnF7jGA3+kijEo9KuCK27fV37kX3OmqQb5FdQ@vger.kernel.org, AJvYcCXkyGEe95IgXChoJ7IvlYesYb+vE457A/KUqonHbEiAoAyPVWQjSz1J0K81CCCZ6Z7nJaCd/9TW/x7EMa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnv8x3WprApdSzGoEmy3lWb1Y1xmZb5DJ6r4YeOfxJP1VtB5rp
	p0wiyR307erlRZmtDphMzj+XkIGXUCe6K2FvOfD0K8AoIbJxWIDsnQYNBuOuHlQ=
X-Gm-Gg: ASbGnctEay+DSnhlVwnoe4VY7Jkd9hqpkFxmgxaoLTdLb8Eetmt2tETsP6XP6VWX4iw
	KzUHugXxR0osRGezHZgytPIbuJ88vhRGOzCMMNHkVddQmjfLn2nmGrnUBvToDca9N/Ebhci0jtn
	hayQGuSliWnScIHqkgZMY1ATSDMrDdfljE8Ky9RCx/Idnvmo5yDSOMan7sKVspNZbVVFCz7jxMN
	Qo8z4q3gizC1e+b3Piin2a/hJCqHN/pmRQLCTcKfmC1aKj0XPLVgR0YboQKPhyeCW6LgXlQVrx5
	LAckbqjqL6PTAX5moJXExxqliVoK7/lNvb0wIY8B7StN39qSfBl92D3derxPaT8eW2hIjLMFN6w
	XokfrVx4i536zUjJbEioZedY=
X-Google-Smtp-Source: AGHT+IFJr+wxQM3mESQs7EllgJEAdA3pF0dLTu+4DAr2dKro2kUFXs/IAl8+ubYNpEAF9/RxGcfENg==
X-Received: by 2002:a05:600c:358b:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-4406ac17329mr109126795e9.30.1745238758619;
        Mon, 21 Apr 2025 05:32:38 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbc13sm131783225e9.17.2025.04.21.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:32:38 -0700 (PDT)
Message-ID: <ac49cbf86cc431b2152a31822c51e71c57a5483d.camel@gmail.com>
Subject: Re: [PATCH v2 10/17] mfd: adp5585: add support for key events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:32:41 +0100
In-Reply-To: <20250421093310.GH29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-10-3a799c3ed812@analog.com>
	 <20250421093310.GH29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:33 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:26PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > This adds support for key events. Basically, it adds support for all th=
e
> > FW parsing and configuration of the keys (also making sure there's no
> > overlaps). They can either be part of a matrix keymap (in which case
> > events will be handled by an input device) or they can be gpi's (in whi=
ch
> > case events will be handled by the gpiochip device via gpio_keys). Ther=
e's
> > also support for unlock keys as for reset keys.
>=20
> There's lots of code below specific to matrix keypad handling. Please
> move it to the keypad driver, and keep this driver as lean as possible.
>=20

Yeah, I gave this a lot of thought and initially I was doing it in the inpu=
t
driver (even giving that device it's own of_compatible) but then I went thi=
s
way. Basically because unlock and reset keys can also be done through gpio-=
keys
which is supported in the GPIO driver. Therefore, since these features are
shared between GPIO and INPUT, it made sense to me to put all of this in th=
e top
device. IOW, we can still have these features even if we're not using the i=
nput
device.

> > This patch adds all the foundation needed by subsequent changes where t=
he
> > child devices (actually handling the events) can "register" a callback
> > to handle the event.
> >=20
> > Also to note that enabling the internal oscillator in now done as part =
of
> > adp5585_setup().
> >=20
> > We also enable/disable the IRQ (if present) in the corresponding PM
> > event.
>=20
> The patch does too many things. The base rule should be "one logical
> change, one patch". At the very least the event reporting mechanism
> and the keypad handling should be split in two different patches.
>=20

Both things are related... Instead maybe we could split things as:

1) Add key handling (which also means DT parsing + device setup + IRQs)
2) Reset keys support
3) Unlock keys support

Thoughts?

- Nuno S=C3=A1

> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 551
> > +++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 96 ++++++++
> > =C2=A02 files changed, 642 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > c3586c0d6aa2e7e7d94667993410610be7fc3672..c1d51d50dca6c9367d4a1b98a4f8b=
bec12
> > dbf90b 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -8,11 +8,13 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/i2c.h>
> > =C2=A0#include <linux/mfd/adp5585.h>
> > =C2=A0#include <linux/mfd/core.h>
> > +#include <linux/minmax.h>
> > =C2=A0#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/regmap.h>
> > @@ -205,11 +207,19 @@ static const struct adp5585_regs adp5585_regs =3D=
 {
> > =C2=A0	.gpo_out_a =3D ADP5585_GPO_OUT_MODE_A,
> > =C2=A0	.gpio_dir_a =3D ADP5585_GPIO_DIRECTION_A,
> > =C2=A0	.gpi_stat_a =3D ADP5585_GPI_STATUS_A,
> > +	.gpi_ev_a =3D ADP5585_GPI_EVENT_EN_A,
> > +	.gpi_int_lvl_a =3D ADP5585_GPI_INT_LEVEL_A,
> > =C2=A0	.pwm_cfg =3D ADP5585_PWM_CFG,
> > =C2=A0	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
> > =C2=A0	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
> > +	.reset_cfg =3D ADP5585_RESET_CFG,
> > =C2=A0	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > =C2=A0	.ext_cfg =3D ADP5585_PIN_CONFIG_C,
> > +	.pin_cfg_a =3D ADP5585_PIN_CONFIG_A,
> > +	.poll_ptime_cfg =3D ADP5585_POLL_PTIME_CFG,
> > +	.int_en =3D ADP5585_INT_EN,
> > +	.reset1_event_a =3D ADP5585_RESET1_EVENT_A,
> > +	.reset2_event_a =3D ADP5585_RESET2_EVENT_A,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_regs adp5589_regs =3D {
> > @@ -219,11 +229,19 @@ static const struct adp5585_regs adp5589_regs =3D=
 {
> > =C2=A0	.gpo_out_a =3D ADP5589_GPO_OUT_MODE_A,
> > =C2=A0	.gpio_dir_a =3D ADP5589_GPIO_DIRECTION_A,
> > =C2=A0	.gpi_stat_a =3D ADP5589_GPI_STATUS_A,
> > +	.gpi_ev_a =3D ADP5589_GPI_EVENT_EN_A,
> > +	.gpi_int_lvl_a =3D ADP5589_GPI_INT_LEVEL_A,
> > =C2=A0	.pwm_cfg =3D ADP5589_PWM_CFG,
> > =C2=A0	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
> > =C2=A0	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,
> > +	.reset_cfg =3D ADP5589_RESET_CFG,
> > =C2=A0	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > =C2=A0	.ext_cfg =3D ADP5589_PIN_CONFIG_D,
> > +	.pin_cfg_a =3D ADP5589_PIN_CONFIG_A,
> > +	.poll_ptime_cfg =3D ADP5589_POLL_PTIME_CFG,
> > +	.int_en =3D ADP5589_INT_EN,
> > +	.reset1_event_a =3D ADP5589_RESET1_EVENT_A,
> > +	.reset2_event_a =3D ADP5589_RESET2_EVENT_A,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5585_info =3D {
> > @@ -234,6 +252,8 @@ static const struct adp5585_info adp5585_info =3D {
> > =C2=A0	.regs =3D &adp5585_regs,
> > =C2=A0	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5585_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5585_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5585_01_info =3D {
> > @@ -241,9 +261,12 @@ static const struct adp5585_info adp5585_01_info =
=3D {
> > =C2=A0	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > =C2=A0	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > =C2=A0	.id =3D ADP5585_MAN_ID_VALUE,
> > +	.has_row5 =3D true,
> > =C2=A0	.regs =3D &adp5585_regs,
> > =C2=A0	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5585_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5585_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5585_02_info =3D {
> > @@ -254,6 +277,8 @@ static const struct adp5585_info adp5585_02_info =
=3D {
> > =C2=A0	.regs =3D &adp5585_regs,
> > =C2=A0	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5585_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5585_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5585_04_info =3D {
> > @@ -264,6 +289,8 @@ static const struct adp5585_info adp5585_04_info =
=3D {
> > =C2=A0	.regs =3D &adp5585_regs,
> > =C2=A0	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5585_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5585_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5589_info =3D {
> > @@ -271,9 +298,13 @@ static const struct adp5585_info adp5589_info =3D =
{
> > =C2=A0	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_00],
> > =C2=A0	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > =C2=A0	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.has_row5 =3D true,
> > +	.has_unlock =3D true,
> > =C2=A0	.regs =3D &adp5589_regs,
> > =C2=A0	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5589_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5589_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5589_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5589_01_info =3D {
> > @@ -281,9 +312,13 @@ static const struct adp5585_info adp5589_01_info =
=3D {
> > =C2=A0	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_01],
> > =C2=A0	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > =C2=A0	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.has_row5 =3D true,
> > +	.has_unlock =3D true,
> > =C2=A0	.regs =3D &adp5589_regs,
> > =C2=A0	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5589_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5589_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5589_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_info adp5589_02_info =3D {
> > @@ -291,11 +326,379 @@ static const struct adp5585_info adp5589_02_info=
 =3D {
> > =C2=A0	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_02],
> > =C2=A0	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > =C2=A0	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.has_row5 =3D true,
> > +	.has_unlock =3D true,
> > =C2=A0	.regs =3D &adp5589_regs,
> > =C2=A0	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > =C2=A0	.max_cols =3D ADP5589_MAX_COL_NUM,
> > +	.gpi_ev_base =3D ADP5589_GPI_EVENT_START,
> > +	.gpi_ev_end =3D ADP5589_GPI_EVENT_END,
> > =C2=A0};
> > =C2=A0
> > +static int adp5585_keys_validate_key(const struct adp5585_dev *adp5585=
, u32
> > key,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 bool is_gpi)
> > +{
> > +	const struct adp5585_info *info =3D adp5585->info;
> > +	struct device *dev =3D adp5585->dev;
> > +	u32 row, col;
> > +
> > +	if (is_gpi) {
> > +		u32 gpi =3D key - adp5585->info->gpi_ev_base;
> > +
> > +		if (!info->has_row5 && gpi =3D=3D ADP5585_ROW5)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset GPI(%u)
> > not supported\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 gpi);
> > +
> > +		/* check if it's being used in the keypad */
> > +		if (test_bit(gpi, adp5585->keypad))
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset GPI(%u)
> > being used in the keypad\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 gpi);
> > +
> > +		return 0;
> > +	}
> > +
> > +	row =3D (key - 1) / info->max_cols;
> > +	col =3D (key - 1) % info->max_cols;
> > +
> > +	/* both the row and col must be part of the keypad */
> > +	if (test_bit(row, adp5585->keypad) &&
> > +	=C2=A0=C2=A0=C2=A0 test_bit(col + info->max_rows, adp5585->keypad))
> > +		return 0;
> > +
> > +	return dev_err_probe(dev, -EINVAL,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset key(%u) not used in =
the
> > keypad\n", key);
> > +}
> > +
> > +static int adp5585_keys_parse_array(const struct adp5585_dev *adp5585,
> > +				=C2=A0=C2=A0=C2=A0 const char *prop, u32 *keys, u32
> > *n_keys,
> > +				=C2=A0=C2=A0=C2=A0 u32 max_keys, bool reset_key)
> > +{
> > +	const struct adp5585_info *info =3D adp5585->info;
> > +	struct device *dev =3D adp5585->dev;
> > +	unsigned int key, max_keypad;
> > +	int ret;
> > +
> > +	ret =3D device_property_count_u32(dev, prop);
> > +	if (ret < 0)
> > +		return 0;
> > +
> > +	*n_keys =3D ret;
> > +
> > +	if (!info->has_unlock && !reset_key)
> > +		return dev_err_probe(dev, -EOPNOTSUPP,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unlock keys not supported\n");
> > +
> > +	if (*n_keys > max_keys)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid number of keys(%u > %u) for
> > %s\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 *n_keys, max_keys, prop);
> > +
> > +	ret =3D device_property_read_u32_array(dev, prop, keys, *n_keys);
> > +	if (ret)
> > +		return ret;
> > +
> > +	max_keypad =3D adp5585->info->max_rows * adp5585->info->max_cols;
> > +
> > +	for (key =3D 0; key < *n_keys; key++) {
> > +		/* part of the keypad... */
> > +		if (in_range(keys[key], 1, max_keypad)) {
> > +			/* is it part of the keypad?! */
> > +			ret =3D adp5585_keys_validate_key(adp5585, keys[key],
> > +							false);
> > +			if (ret)
> > +				return ret;
> > +
> > +			continue;
> > +		}
> > +
> > +		/* part of gpio-keys... */
> > +		if (in_range(keys[key], adp5585->info->gpi_ev_base,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 info->max_cols + info->max_rows)) {
> > +			/* is the GPI being used as part of the keypad?! */
> > +			ret =3D adp5585_keys_validate_key(adp5585, keys[key],
> > +							true);
> > +			if (ret)
> > +				return ret;
> > +
> > +			continue;
> > +		}
> > +
> > +		if (!reset_key && keys[key] =3D=3D 127)
> > +			continue;
> > +
> > +		return dev_err_probe(dev, -EINVAL, "Invalid key(%u) for
> > %s\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 keys[key], prop);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_keys_unlock_parse(struct adp5585_dev *adp5585)
> > +{
> > +	struct device *dev =3D adp5585->dev;
> > +	int ret;
> > +
> > +	ret =3D adp5585_keys_parse_array(adp5585, "adi,unlock-keys",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->unlock_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_unlock,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->unlock_ke=
ys),
> > false);
> > +	if (ret)
> > +		return ret;
> > +	if (!adp5585->nkeys_unlock)
> > +		/* no unlock keys */
> > +		return 0;
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,unlock-trigger-sec",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->unlock_time);
> > +	if (!ret) {
> > +		if (adp5585->unlock_time > ADP5585_MAX_UNLOCK_TIME_SEC)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock time(%u >
> > %d)\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->unlock_time,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_MAX_UNLOCK_TIME_SEC);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_keys_reset_parse(struct adp5585_dev *adp5585)
> > +{
> > +	const struct adp5585_info *info =3D adp5585->info;
> > +	struct device *dev =3D adp5585->dev;
> > +	u32 prop_val;
> > +	int ret;
> > +
> > +	ret =3D adp5585_keys_parse_array(adp5585, "adi,reset1-keys",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->reset1_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset1,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset1_ke=
ys),
> > true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adp5585->nkeys_reset1 > 0) {
> > +		if (test_bit(ADP5585_ROW4, adp5585->keypad))
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid reset1 output(R4)
> > being used in the keypad\n");
> > +
> > +		if (device_property_read_bool(dev, "adi,reset1-active-
> > high"))
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET1_POL, 1);
> > +	}
> > +
> > +	ret =3D adp5585_keys_parse_array(adp5585, "adi,reset2-keys",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->reset2_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset2,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset2_ke=
ys),
> > true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adp5585->nkeys_reset2 > 0) {
> > +		if (test_bit(info->max_rows + ADP5585_COL4, adp5585-
> > >keypad))
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid reset2 output(C4)
> > being used in the keypad\n");
> > +
> > +		if (device_property_read_bool(dev, "adi,reset2-active-
> > high"))
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET2_POL, 1);
> > +	}
> > +
> > +	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
> > +		return 0;
> > +
> > +	if (device_property_read_bool(dev, "adi,rst-passtrough-enable"))
> > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RST_PASSTHRU_EN,
> > 1);
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,reset-trigger-ms",
> > &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 0:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
> > +			break;
> > +		case 1500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
> > +			break;
> > +		case 2500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
> > +			break;
> > +		case 3000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
> > +			break;
> > +		case 3500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
> > +			break;
> > +		case 4000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for
> > adi,reset-trigger-ms\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,reset-pulse-width-us",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 1);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 2);
> > +			break;
> > +		case 10000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 3);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for
> > adi,reset-pulse-width-us\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > *adp5585)
> > +{
> > +	const struct adp5585_info *info =3D adp5585->info;
> > +	unsigned int n_pins =3D info->max_cols + info->max_rows;
> > +	unsigned int *keypad_pins;
> > +	unsigned int prop_val;
> > +	int n_keys, key, ret;
> > +
> > +	adp5585->keypad =3D devm_bitmap_zalloc(dev, n_pins, GFP_KERNEL);
> > +	if (!adp5585->keypad)
> > +		return -ENOMEM;
> > +
> > +	if (device_property_present(dev, "#pwm-cells"))
> > +		adp5585->has_pwm =3D true;
> > +
> > +	n_keys =3D device_property_count_u32(dev, "adi,keypad-pins");
> > +	if (n_keys <=3D 0)
> > +		goto no_keypad;
> > +	if (n_keys > n_pins)
> > +		return -EINVAL;
> > +
> > +	keypad_pins =3D devm_kcalloc(dev, n_keys, sizeof(*keypad_pins),
> > +				=C2=A0=C2=A0 GFP_KERNEL);
> > +	if (!keypad_pins)
> > +		return -ENOMEM;
> > +
> > +	ret =3D device_property_read_u32_array(dev, "adi,keypad-pins",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 keypad_pins, n_keys);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (key =3D 0; key < n_keys; key++) {
> > +		if (keypad_pins[key] >=3D n_pins)
> > +			return -EINVAL;
> > +		if (adp5585->has_pwm && keypad_pins[key] =3D=3D ADP5585_ROW3)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid PWM pin being used in
> > the keypad\n");
> > +		if (!info->has_row5 && keypad_pins[key] =3D=3D ADP5585_ROW5)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid row5 being used in
> > the keypad\n");
> > +		__set_bit(keypad_pins[key], adp5585->keypad);
> > +	}
> > +
> > +no_keypad:
> > +	ret =3D device_property_read_u32(dev, "adi,key-poll-ms", &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 10:
> > +			fallthrough;
> > +		case 20:
> > +			fallthrough;
> > +		case 30:
> > +			fallthrough;
> > +		case 40:
> > +			adp5585->key_poll_time =3D prop_val / 10 - 1;
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for
> > adi,key-poll-ms\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
> > +
> > +	ret =3D adp5585_keys_unlock_parse(adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return adp5585_keys_reset_parse(adp5585);
> > +}
> > +
> > +static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_=
cnt)
> > +{
> > +	unsigned int i;
> > +
> > +	guard(mutex)(&adp5585->ev_lock);
> > +
> > +	for (i =3D 0; i < ev_cnt; i++) {
> > +		unsigned int key, key_val, key_press;
> > +		int ret;
> > +
> > +		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
> > &key);
> > +		if (ret)
> > +			return;
> > +
> > +		key_val =3D FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
> > +		key_press =3D FIELD_GET(ADP5585_KEV_EV_PRESS_MASK, key);
> > +
> > +		if (key_val >=3D adp5585->info->gpi_ev_base &&
> > +		=C2=A0=C2=A0=C2=A0 key_val <=3D adp5585->info->gpi_ev_end) {
> > +			unsigned int gpi =3D key_val - adp5585->info-
> > >gpi_ev_base;
> > +
> > +			if (adp5585->gpio_irq_handle)
> > +				adp5585->gpio_irq_handle(adp5585->gpio_dev,
> > gpi,
> > +							 key_press);
> > +		} else if (adp5585->keys_irq_handle) {
> > +			adp5585->keys_irq_handle(adp5585->input_dev,
> > key_val,
> > +						 key_press);
> > +		}
> > +	}
> > +}
> > +
> > +static irqreturn_t adp5585_irq(int irq, void *data)
> > +{
> > +	struct adp5585_dev *adp5585 =3D data;
> > +	unsigned int status, ev_cnt;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &status);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> > +
> > +	if (status & ADP5585_OVRFLOW_INT)
> > +		dev_err_ratelimited(adp5585->dev, "Event Overflow
> > Error\n");
> > +
> > +	if (!(status & ADP5585_EVENT_INT))
> > +		goto out_irq;
> > +
> > +	ret =3D regmap_read(adp5585->regmap, ADP5585_STATUS, &ev_cnt);
> > +	if (ret)
> > +		goto out_irq;
> > +
> > +	ev_cnt =3D FIELD_GET(ADP5585_EC_MASK, ev_cnt);
> > +	if (!ev_cnt)
> > +		goto out_irq;
> > +
> > +	adp5585_report_events(adp5585, ev_cnt);
> > +out_irq:
> > +	regmap_write(adp5585->regmap, ADP5585_INT_STATUS, status);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > =C2=A0static void adp5585_osc_disable(void *data)
> > =C2=A0{
> > =C2=A0	const struct adp5585_dev *adp5585 =3D data;
> > @@ -303,6 +706,128 @@ static void adp5585_osc_disable(void *data)
> > =C2=A0	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > =C2=A0}
> > =C2=A0
> > +static int adp5585_setup(struct adp5585_dev *adp5585)
> > +{
> > +	const struct adp5585_regs *regs =3D adp5585->info->regs;
> > +	unsigned int reg_val, i;
> > +	int ret;
> > +
> > +	for (i =3D 0; i < adp5585->nkeys_unlock; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
> > +				=C2=A0=C2=A0 adp5585->unlock_keys[i] |
> > ADP5589_UNLOCK_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_unlock) {
> > +		ret =3D regmap_update_bits(adp5585->regmap,
> > ADP5589_UNLOCK_TIMERS,
> > +					 ADP5589_UNLOCK_TIMER,
> > +					 adp5585->unlock_time);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5589_LOCK_EN);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < adp5585->nkeys_reset1; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset1_event_a +
> > i,
> > +				=C2=A0=C2=A0 adp5585->reset1_keys[i] |
> > ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < adp5585->nkeys_reset2; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset2_event_a +
> > i,
> > +				=C2=A0=C2=A0 adp5585->reset2_keys[i] |
> > ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset_cfg,
> > +				=C2=A0=C2=A0 adp5585->reset_cfg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		reg_val =3D 0;
> > +		if (adp5585->nkeys_reset1)
> > +			reg_val =3D ADP5585_R4_EXTEND_CFG_RESET1;
> > +		if (adp5585->nkeys_reset2)
> > +			reg_val |=3D ADP5585_C4_EXTEND_CFG_RESET2;
> > +
> > +		ret =3D regmap_update_bits(adp5585->regmap, regs->ext_cfg,
> > +					 ADP5585_C4_EXTEND_CFG_MASK |
> > +					=09
> > ADP5585_R4_EXTEND_CFG_MASK,
> > +					 reg_val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < ADP5585_EV_MAX; i++) {
> > +		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
> > +				=C2=A0 &reg_val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret =3D regmap_write(adp5585->regmap, regs->poll_ptime_cfg,
> > +			=C2=A0=C2=A0 adp5585->key_poll_time);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(adp5585->regmap, regs->gen_cfg,
> > +			=C2=A0=C2=A0 ADP5585_OSC_FREQ_500KHZ | ADP5585_INT_CFG |
> > +			=C2=A0=C2=A0 ADP5585_OSC_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(adp5585->dev, adp5585_osc_disable,
> > +					adp5585);
> > +}
> > +
> > +static void adp5585_irq_disable(void *data)
> > +{
> > +	struct adp5585_dev *adp5585 =3D data;
> > +
> > +	regmap_write(adp5585->regmap, adp5585->info->regs->int_en, 0);
> > +}
> > +
> > +static int adp5585_irq_enable(struct i2c_client *i2c,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct adp5585_dev *adp5585)
> > +{
> > +	const struct adp5585_regs *regs =3D adp5585->info->regs;
> > +	unsigned int stat;
> > +	int ret;
> > +
> > +	if (i2c->irq <=3D 0)
> > +		return 0;
> > +
> > +	ret =3D devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
> > adp5585_irq,
> > +					IRQF_ONESHOT, i2c->name, adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* clear any possible outstanding interrupt before enabling them...
> > */
> > +	ret =3D regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &stat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(adp5585->regmap, ADP5585_INT_STATUS, stat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(adp5585->regmap, regs->int_en,
> > +			=C2=A0=C2=A0 ADP5585_OVRFLOW_IEN | ADP5585_EVENT_IEN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(&i2c->dev, adp5585_irq_disable,
> > +					adp5585);
> > +}
> > +
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > =C2=A0	const struct adp5585_info *info;
> > @@ -321,6 +846,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0		return -ENODEV;
> > =C2=A0
> > =C2=A0	adp5585->info =3D info;
> > +	adp5585->dev =3D &i2c->dev;
> > +	adp5585->irq =3D i2c->irq;
> > =C2=A0
> > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info->regmap_confi=
g);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > @@ -337,12 +864,15 @@ static int adp5585_i2c_probe(struct i2c_client *i=
2c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > -	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_OSC_EN);
> > +	ret =3D adp5585_parse_fw(&i2c->dev, adp5585);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable,
> > adp5585);
> > +	ret =3D adp5585_setup(adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_mutex_init(&i2c->dev, &adp5585->ev_lock);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -353,13 +883,16 @@ static int adp5585_i2c_probe(struct i2c_client *i=
2c)
> > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n");
> > =C2=A0
> > -	return 0;
> > +	return adp5585_irq_enable(i2c, adp5585);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_suspend(struct device *dev)
> > =C2=A0{
> > =C2=A0	struct adp5585_dev *adp5585 =3D dev_get_drvdata(dev);
> > =C2=A0
> > +	if (adp5585->irq)
> > +		disable_irq(adp5585->irq);
> > +
> > =C2=A0	regcache_cache_only(adp5585->regmap, true);
> > =C2=A0
> > =C2=A0	return 0;
> > @@ -368,11 +901,19 @@ static int adp5585_suspend(struct device *dev)
> > =C2=A0static int adp5585_resume(struct device *dev)
> > =C2=A0{
> > =C2=A0	struct adp5585_dev *adp5585 =3D dev_get_drvdata(dev);
> > +	int ret;
> > =C2=A0
> > =C2=A0	regcache_cache_only(adp5585->regmap, false);
> > =C2=A0	regcache_mark_dirty(adp5585->regmap);
> > =C2=A0
> > -	return regcache_sync(adp5585->regmap);
> > +	ret =3D regcache_sync(adp5585->regmap);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adp5585->irq)
> > +		enable_irq(adp5585->irq);
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend,
> > adp5585_resume);
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > dffe1449de01dacf8fe78cf0e87d1f176d11f620..3ec542bed9c1c44899cc869d95755=
7813e
> > 2d0aab 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -10,13 +10,21 @@
> > =C2=A0#define __MFD_ADP5585_H_
> > =C2=A0
> > =C2=A0#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > =C2=A0
> > =C2=A0#define ADP5585_ID			0x00
> > =C2=A0#define		ADP5585_MAN_ID_VALUE		0x20
> > =C2=A0#define		ADP5585_MAN_ID_MASK		GENMASK(7, 4)
> > +#define		ADP5585_REV_ID_MASK		GENMASK(3, 0)
> > =C2=A0#define ADP5585_INT_STATUS		0x01
> > +#define		ADP5585_OVRFLOW_INT		BIT(2)
> > +#define		ADP5585_EVENT_INT		BIT(0)
> > =C2=A0#define ADP5585_STATUS			0x02
> > +#define		ADP5585_EC_MASK			GENMASK(4,
> > 0)
> > =C2=A0#define ADP5585_FIFO_1			0x03
> > +#define		ADP5585_KEV_EV_PRESS_MASK	BIT(7)
> > +#define		ADP5585_KEY_EVENT_MASK		GENMASK(6, 0)
> > =C2=A0#define ADP5585_FIFO_2			0x04
> > =C2=A0#define ADP5585_FIFO_3			0x05
> > =C2=A0#define ADP5585_FIFO_4			0x06
> > @@ -32,6 +40,7 @@
> > =C2=A0#define ADP5585_FIFO_14			0x10
> > =C2=A0#define ADP5585_FIFO_15			0x11
> > =C2=A0#define ADP5585_FIFO_16			0x12
> > +#define		ADP5585_EV_MAX			(ADP5585_FIFO_16 -
> > ADP5585_FIFO_1 + 1)
> > =C2=A0#define ADP5585_GPI_INT_STAT_A		0x13
> > =C2=A0#define ADP5585_GPI_INT_STAT_B		0x14
> > =C2=A0#define ADP5585_GPI_STATUS_A		0x15
> > @@ -60,6 +69,7 @@
> > =C2=A0#define ADP5585_GPIO_DIRECTION_A	0x27
> > =C2=A0#define ADP5585_GPIO_DIRECTION_B	0x28
> > =C2=A0#define ADP5585_RESET1_EVENT_A		0x29
> > +#define		ADP5585_RESET_EV_PRESS		BIT(7)
> > =C2=A0#define ADP5585_RESET1_EVENT_B		0x2a
> > =C2=A0#define ADP5585_RESET1_EVENT_C		0x2b
> > =C2=A0#define ADP5585_RESET2_EVENT_A		0x2c
> > @@ -104,8 +114,17 @@
> > =C2=A0#define		ADP5585_INT_CFG			BIT(1)
> > =C2=A0#define		ADP5585_RST_CFG			BIT(0)
> > =C2=A0#define ADP5585_INT_EN			0x3c
> > +#define		ADP5585_OVRFLOW_IEN		BIT(2)
> > +#define		ADP5585_EVENT_IEN		BIT(0)
> > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > =C2=A0
> > +#define ADP5585_ROW3			3
> > +#define ADP5585_ROW4			4
> > +#define ADP5585_ROW5			5
> > +#define ADP5585_COL4			4
> > +#define ADP5585_MAX_UNLOCK_TIME_SEC	7
> > +#define ADP5585_GPI_EVENT_START		37
> > +#define ADP5585_GPI_EVENT_END		47
> > =C2=A0#define ADP5585_MAX_ROW_NUM		6
> > =C2=A0#define ADP5585_MAX_COL_NUM		5
> > =C2=A0
> > @@ -124,18 +143,38 @@
> > =C2=A0#define ADP5589_GPI_STATUS_A		0x16
> > =C2=A0#define ADP5589_GPI_STATUS_C		0x18
> > =C2=A0#define ADP5589_RPULL_CONFIG_A		0x19
> > +#define ADP5589_GPI_INT_LEVEL_A		0x1e
> > +#define ADP5589_GPI_EVENT_EN_A		0x21
> > =C2=A0#define ADP5589_DEBOUNCE_DIS_A		0x27
> > =C2=A0#define ADP5589_GPO_DATA_OUT_A		0x2a
> > =C2=A0#define ADP5589_GPO_OUT_MODE_A		0x2d
> > =C2=A0#define	ADP5589_GPIO_DIRECTION_A	0x30
> > +#define ADP5589_UNLOCK1			0x33
> > +#define		ADP5589_UNLOCK_EV_PRESS		BIT(7)
> > +#define ADP5589_UNLOCK_TIMERS		0x36
> > +#define		ADP5589_UNLOCK_TIMER		GENMASK(2, 0)
> > +#define ADP5589_LOCK_CFG		0x37
> > +#define		ADP5589_LOCK_EN			BIT(0)
> > +#define ADP5589_RESET1_EVENT_A		0x38
> > +#define ADP5589_RESET2_EVENT_A		0x3B
> > +#define ADP5589_RESET_CFG		0x3D
> > +#define		ADP5585_RESET2_POL		BIT(7)
> > +#define		ADP5585_RESET1_POL		BIT(6)
> > +#define		ADP5585_RST_PASSTHRU_EN		BIT(5)
> > +#define		ADP5585_RESET_TRIG_TIME		GENMASK(4,
> > 2)
> > +#define		ADP5585_PULSE_WIDTH		GENMASK(1, 0)
> > =C2=A0#define ADP5589_PWM_OFFT_LOW		0x3e
> > =C2=A0#define ADP5589_PWM_ONT_LOW		0x40
> > =C2=A0#define ADP5589_PWM_CFG			0x42
> > +#define ADP5589_POLL_PTIME_CFG		0x48
> > +#define ADP5589_PIN_CONFIG_A		0x49
> > =C2=A0#define ADP5589_PIN_CONFIG_D		0x4C
> > =C2=A0#define ADP5589_GENERAL_CFG		0x4d
> > =C2=A0#define ADP5589_INT_EN			0x4e
> > =C2=A0#define ADP5589_MAX_REG			ADP5589_INT_EN
> > =C2=A0
> > +#define ADP5589_GPI_EVENT_START		97
> > +#define ADP5589_GPI_EVENT_END		115
> > =C2=A0#define ADP5589_MAX_ROW_NUM		8
> > =C2=A0#define ADP5589_MAX_COL_NUM		11
> > =C2=A0
> > @@ -154,11 +193,19 @@ struct adp5585_regs {
> > =C2=A0	unsigned int gpo_out_a;
> > =C2=A0	unsigned int gpio_dir_a;
> > =C2=A0	unsigned int gpi_stat_a;
> > +	unsigned int gpi_ev_a;
> > +	unsigned int gpi_int_lvl_a;
> > =C2=A0	unsigned int pwm_cfg;
> > =C2=A0	unsigned int pwm_offt_low;
> > =C2=A0	unsigned int pwm_ont_low;
> > +	unsigned int reset_cfg;
> > =C2=A0	unsigned int gen_cfg;
> > =C2=A0	unsigned int ext_cfg;
> > +	unsigned int pin_cfg_a;
> > +	unsigned int poll_ptime_cfg;
> > +	unsigned int int_en;
> > +	unsigned int reset1_event_a;
> > +	unsigned int reset2_event_a;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct adp5585_info {
> > @@ -169,6 +216,10 @@ struct adp5585_info {
> > =C2=A0	unsigned int id;
> > =C2=A0	u8 max_rows;
> > =C2=A0	u8 max_cols;
> > +	u8 gpi_ev_base;
> > +	u8 gpi_ev_end;
> > +	bool has_row5;
> > +	bool has_unlock;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct regmap;
> > @@ -176,6 +227,51 @@ struct regmap;
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > =C2=A0	const struct adp5585_info *info;
> > +	struct device *dev;
> > +	unsigned long *keypad;
> > +	void (*gpio_irq_handle)(struct device *dev, unsigned int off,
> > +				bool key_press);
> > +	struct device *gpio_dev;
> > +	void (*keys_irq_handle)(struct device *dev, unsigned int off,
> > +				bool key_press);
> > +	struct device *input_dev;
> > +	/*
> > +	 * Used to synchronize usage (and availability) of
> > gpio_irq_handle()
> > +	 * and keys_irq_handle().
> > +	 */
> > +	struct mutex ev_lock;
> > +	int irq;
> > +	u32 key_poll_time;
> > +	u32 unlock_time;
> > +	u32 unlock_keys[2];
> > +	u32 nkeys_unlock;
> > +	u32 reset1_keys[3];
> > +	u32 nkeys_reset1;
> > +	u32 reset2_keys[2];
> > +	u32 nkeys_reset2;
> > +	u8 reset_cfg;
> > +	bool has_pwm;
> > =C2=A0};
> > =C2=A0
> > +static inline void adp5585_gpio_ev_handle_set(struct adp5585_dev *adp5=
585,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*handle)(struct device
> > *dev,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int
> > off,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0 bool
> > key_press),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *gpio_dev)
> > +{
> > +	guard(mutex)(&adp5585->ev_lock);
> > +	adp5585->gpio_irq_handle =3D handle;
> > +	adp5585->gpio_dev =3D gpio_dev;
> > +}
> > +
> > +static inline void adp5585_keys_ev_handle_set(struct adp5585_dev *adp5=
585,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*handle)(struct device
> > *dev,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int
> > off,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0 bool
> > key_press),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *input_dev)
> > +{
> > +	guard(mutex)(&adp5585->ev_lock);
> > +	adp5585->keys_irq_handle =3D handle;
> > +	adp5585->input_dev =3D input_dev;
> > +}
> > =C2=A0#endif
> >=20


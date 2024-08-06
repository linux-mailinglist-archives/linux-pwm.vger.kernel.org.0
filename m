Return-Path: <linux-pwm+bounces-2971-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32122949440
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 17:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9B32882F8
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE61EA0D5;
	Tue,  6 Aug 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nyexg0HP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4B1BCA09
	for <linux-pwm@vger.kernel.org>; Tue,  6 Aug 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957182; cv=none; b=g00GupSRKlaEXTj405vjVUVrWD4G5biY0iNnOoc98JSBwfHSEI17zlb1sovVFNpJMEBfswdo/q/7Tt1P2ngX3cA6K8hDr+mdXFw9Yddb+Rozz2k5rjJ8K9VGRuO1FUK/XGqVLIuRzHfDnUwGC9a8Vj+AeyCzrWCzTo+Mc6tP7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957182; c=relaxed/simple;
	bh=pjR8Os6yrA/j8jdP7OCLYVREIGpqEpvc+amwNGlooCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmvQf52By7s2MVBha7Q55R6gdcscYSPIihNSJVfje/5m84G6rzmiqHB7s4PjQX90cPjao2jJyP/gqLL2G6zqxxv3dCB7kBbGarulDXb8MDR5Hft4Ma3lnftLBmYAresXfjIksyBypBX0FcHXBftvT4zaXdKOh2v3bfNBQQ+Bs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nyexg0HP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1044690a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 06 Aug 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722957177; x=1723561977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7a4P/FyUJ5dmvEi2k87q9zZKNUEe1jU6FxpoN7R+XCo=;
        b=Nyexg0HP78kDJkLS+QsSSGGIJ7anZB9kJsVUe7pcLYnCFyfZSjLb6t/IhRJIku25/m
         Q0eOK/D9396Jc59X2lHkjsX3ucEQlxc6cXZa4AmGDwmeNkFKm28g3miRCM1TWItqS95r
         PqxtBNkiQnamPbj3/eqhEsvxcuSWvt/jrq7dCUKH7VDv/tRChAUVmHuw4x5RfI4IvQtE
         TOd0D5YeCB1zzZFr1Tlu0y4L++YST8g+diRj2RIL0mkf8le7Q8idIUSrILMSWfefhtxF
         ZRM7nvAtXgf6uzSqONi2Xs+vQP4USIOd3b3rxyMTaJREvmEz4dNr8rNMvPcRiQvp9KtQ
         nGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722957177; x=1723561977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a4P/FyUJ5dmvEi2k87q9zZKNUEe1jU6FxpoN7R+XCo=;
        b=nCmYgKnWpeQacRXC1ZcMll6vg0jOkJnmhiUMBCIIji3BlcZzA9ySZifjsCdf0KXyPY
         N/xyiZ0KesHSVDRKIl1FLv9qR9mlKv79Ez5BQqyJptwm5bPpBLuaLrytKjwe5RtaQrNZ
         wKSHO9+e5tqhlXaqf9dnyG8rLNzpRP0vlU9MMATxla0fHbFQKYTG38RUMuwAhWETRw0t
         +hWd8lj2fs5w9KSsp+aXJDSz3Pmj7KYhr1kd8XyMkcRVv0eBopprnbdrcIOv5e++lSyX
         FVBQ94lBccH6CCIHnAu+9vyRBb523MctjRSg0VKeoXS2ExK6gBQbTsKXAf7C7HYvKAcb
         C38w==
X-Forwarded-Encrypted: i=1; AJvYcCW534m4EFOUGccdFtk2opc2ACJB4PNdhfqhVl1jip0ynK95rzKMJn+bg92sJn6uWZ7yflypEFpggb266q+t5EdIFL2rRsHNXoj5
X-Gm-Message-State: AOJu0YxLjqAHf86nieN770iCH80zgTdse9ifH1ptozThXjwAnqzXZA7V
	mI14UhEb3O1aEMpYzGmle7mwF1xIBgRPY7kLBP7xWMnkaHZu1xS9BCWS31Ihuz4=
X-Google-Smtp-Source: AGHT+IGqCJvLc1QNKQS80dPtrqP6daybCUfoTTLK3gct/kU9ydPH2EzJg+PPNGeKJN74PsrRMr/ZTA==
X-Received: by 2002:a50:ff0b:0:b0:5a1:a447:9fab with SMTP id 4fb4d7f45d1cf-5b7f54148a1mr9785330a12.28.1722957177259;
        Tue, 06 Aug 2024 08:12:57 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:deb2:1e03:7213:3dc4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a24fdedsm5970184a12.50.2024.08.06.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:12:56 -0700 (PDT)
Date: Tue, 6 Aug 2024 17:12:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Subject: Re: [PATCH v20 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <azkn7g7fsoupilafhuu3walz5ecwyqeb42citlrimuey2oyuc6@4tmsaq2kaymd>
References: <20240614154242.419043-1-biju.das.jz@bp.renesas.com>
 <20240614154242.419043-4-biju.das.jz@bp.renesas.com>
 <yli3bq6i2467mzdtwkn3czls4w2snvegkzyun3uq4lto35wuhv@2wcju755otau>
 <TY3PR01MB11346D2E29B1A8E4F71EFF15E86B32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <cbgy643dk54zx2l6px7oe6vgqc6swihymmcyjrtcorflgi5t3l@aqnd5byiqwt6>
 <TY3PR01MB11346F097EF5CEB6C05884B1286BF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kephizyyiahpjuov"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346F097EF5CEB6C05884B1286BF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--kephizyyiahpjuov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Tue, Aug 06, 2024 at 08:35:39AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Sent: Tuesday, August 6, 2024 7:47 AM
> > Subject: Re: [PATCH v20 3/4] pwm: Add support for RZ/G2L GPT
> >=20
> > Hello Biju,
> >=20
> > On Fri, Aug 02, 2024 at 07:02:19AM +0000, Biju Das wrote:
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > > Sent: Tuesday, July 30, 2024 8:54 PM
> > > > Subject: Re: [PATCH v20 3/4] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hello,
> > > >
> > > > I'm a bit unlucky about this driver. I have the impression it is
> > > > complicated and wonder if that is necessary because the hardware is=
 unusual or if we just have to
> > spot some simplifications.
> > >
> > > I agree it is little bit complex driver. Once this driver is accepted,
> > > going forward, I need to support other drivers like (Counter , ADC tr=
iggering and POEG(Output
> > disable) support).
> > >
> > > > I guess another problem is that the time between two consecutive
> > > > reviews is long and I forget most things I learned about the
> > > > hardware from one to the other. While this is mostly my problem, the
> > > > same problem arises if the driver is touched later again. So I
> > > > wonder if some more documentation is needed about the relation
> > > > between channels and outputs and subchannels. If the driver only su=
pported one output per channel,
> > it could be considerably simpler (I think). But I guess that would be a=
 practically relevant
> > restriction??
> > >
> > > Yes, one output per channel means, we cannot use POEG IP which is for
> > > short circuit protection in switching circuits.  So, we need to use b=
oth IOs in the channel.
> > >
> > > I will add the below documentation to make it clear.
> > >
> > > * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
> > > *   each HW channel have 2 IOs.
> > > * - Each IO is modelled as an independent PWM channel.
> > >
> > > Please let me know is it ok with respect to the initial driver?
> >=20
> > looks fine.
> >=20
> > > > Some simplifications spotted below.
> > > >
> > > > On Fri, Jun 14, 2024 at 04:42:41PM +0100, Biju Das wrote:
> > > > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > > > timer (GPT32E). It supports the following functions
> > > > >  * 32 bits x 8 channels
> > > > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > > > >    (triangle waves) for each counter.
> > > > >  * Clock sources independently selectable for each channel
> > > > >  * Two I/O pins per channel
> > > > >  * Two output compare/input capture registers per channel
> > > > >  * For the two output compare/input capture registers of each cha=
nnel,
> > > > >    four registers are provided as buffer registers and are capabl=
e of
> > > > >    operating as comparison registers when buffering is not in use.
> > > > >  * In output compare operation, buffer switching can be at crests=
 or
> > > > >    troughs, enabling the generation of laterally asymmetric PWM w=
aveforms.
> > > > >  * Registers for setting up frame cycles in each channel (with ca=
pability
> > > > >    for generating interrupts at overflow or underflow)
> > > > >  * Generation of dead times in PWM operation
> > > > >  * Synchronous starting, stopping and clearing counters for arbit=
rary
> > > > >    channels
> > > > >  * Starting, stopping, clearing and up/down counters in response =
to input
> > > > >    level comparison
> > > > >  * Starting, clearing, stopping and up/down counters in response =
to a
> > > > >    maximum of four external triggers
> > > > >  * Output pin disable function by dead time error and detected
> > > > >    short-circuits between output pins
> > > > >  * A/D converter start triggers can be generated (GPT32E0 to
> > > > > GPT32E3)
> > > > >  * Enables the noise filter for input capture and external trigger
> > > > >    operation
> > > > >
> > > > > Add basic pwm support for RZ/G2L GPT driver by creating separate
> > > > > logical channels for each IOs.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > ---
> > > > > v19->v20:
> > > > >  * Added locks for rmw operations in rzg2l_gpt_{en,dis}able().
> > > > >  * Dropped decremeng enable_count based ch_en_bits in rzg2l_gpt_d=
isable().
> > > > >  * Added a comment in calculate_period_or_duty() related to overf=
low.
> > > > >  * Replaced ch_en_bits->bootloader_enabled_channels and used this=
 variable
> > > > >    in probe(), apply() and remove() for simplification
> > > > >  * Replaced pm_runtime_enable()->devm_pm_runtime_enable()
> > > > > [...]
> > > > > ---
> > > > >  drivers/pwm/Kconfig         |  11 +
> > > > >  drivers/pwm/Makefile        |   1 +
> > > > >  drivers/pwm/pwm-rzg2l-gpt.c | 555
> > > > > ++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 567 insertions(+)  create mode 100644
> > > > > drivers/pwm/pwm-rzg2l-gpt.c
> > > > >
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > > > 00a543de8f82..3d398b308e3f 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -522,6 +522,17 @@ config PWM_ROCKCHIP
> > > > >  	  Generic PWM framework driver for the PWM controller found on
> > > > >  	  Rockchip SoCs.
> > > > >
> > > > > +config PWM_RZG2L_GPT
> > > > > +	tristate "Renesas RZ/G2L General PWM Timer support"
> > > > > +	depends on ARCH_RZG2L || COMPILE_TEST
> > > > > +	depends on HAS_IOMEM
> > > > > +	help
> > > > > +	  This driver exposes the General PWM Timer controller found in=
 Renesas
> > > > > +	  RZ/G2L like chips through the PWM API.
> > > > > +
> > > > > +	  To compile this driver as a module, choose M here: the module
> > > > > +	  will be called pwm-rzg2l-gpt.
> > > > > +
> > > > >  config PWM_RZ_MTU3
> > > > >  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > > >  	depends on RZ_MTU3
> > > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > > > > 6964ba45c795..fb9a2d9b9adb 100644
> > > > > --- a/drivers/pwm/Makefile
> > > > > +++ b/drivers/pwm/Makefile
> > > > > @@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-rasp=
berrypi-poe.o
> > > > >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > > > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > > > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > > > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> > > > >  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > > > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > > > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > > > > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c
> > > > > b/drivers/pwm/pwm-rzg2l-gpt.c new file mode 100644 index
> > > > > 000000000000..6005a689173e
> > > > > --- /dev/null
> > > > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > > > @@ -0,0 +1,555 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > > > > + *
> > > > > + * Copyright (C) 2024 Renesas Electronics Corporation
> > > > > + *
> > > > > + * Hardware manual for this IP can be found here
> > > > > + *
> > > > > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-gro
> > > > > +up-u sers-manual-hardware-0?language=3Den
> > > > > + *
> > > > > + * Limitations:
> > > > > + * - Counter must be stopped before modifying Mode and Prescaler.
> > > > > + * - When PWM is disabled, the output is driven to inactive.
> > > > > + * - While the hardware supports both polarities, the driver (fo=
r now)
> > > > > + *   only handles normal polarity.
> > > > > + * - When both channels are used, disabling the channel on one s=
tops the
> > > > > + *   other.
> > > > > + */
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/limits.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/platform_device.h> #include <linux/pm_runtime.h>
> > > > > +#include <linux/pwm.h> #include <linux/reset.h> #include
> > > > > +<linux/time.h> #include <linux/units.h>
> > > > > +
> > > > > +#define RZG2L_GTCR		0x2c
> > > > > +#define RZG2L_GTUDDTYC		0x30
> > > > > +#define RZG2L_GTIOR		0x34
> > > > > +#define RZG2L_GTBER		0x40
> > > > > +#define RZG2L_GTCNT		0x48
> > > > > +#define RZG2L_GTCCR(i)		(0x4c + 4 * (i))
> > > > > +#define RZG2L_GTPR		0x64
> > >
> > > These will be replaced as
> > >
> > > +#define RZG2L_GET_CH_OFFS(i)   (0x100 * (i))
> > > +
> > > +#define RZG2L_GTCR(ch)         (0x2c + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTUDDTYC(ch)     (0x30 + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTIOR(ch)                (0x34 + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTINTAD(ch)      (0x38 + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTBER(ch)                (0x40 + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTCNT(ch)                (0x48 + RZG2L_GET_CH_OFFS(ch))
> > > +#define RZG2L_GTCCR(ch, sub_ch)        (0x4c + RZG2L_GET_CH_OFFS(ch)=
 + 4 * (sub_ch))
> > > +#define RZG2L_GTPR(ch)         (0x64 + RZG2L_GET_CH_OFFS(ch))
> >=20
> > I like this better, thanks.
> >=20
> > > > > +	 */
> > > > > +	tmp =3D (u64)val << (2 * prescale);
> > > > > +	tmp *=3D USEC_PER_SEC;
> > > > > +
> > > > > +	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz); }
> > > > > +
> > > > > +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > > > > +			       struct pwm_state *state) {
> > > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > > +	int rc;
> > > > > +
> > > > > +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> > > > > +	if (rc)
> > > > > +		return rc;
> > > > > +
> > > > > +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpw=
m);
> > > > > +	if (state->enabled) {
> > > > > +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > > > +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > > > > +		u8 prescale;
> > > > > +		u32 val;
> > > > > +
> > > > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> > > > > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > > >
> > > > Can it happen that prescale is > 5 here?
> > >
> > > Yes, if bootloader wrongly set it to 6 or 7. I will add a check in
> > > Probe and forcefully set to 5, if that the case. Is it ok?
> >=20
> > >
> > > +                       if (prescale > 5) {
> > > +                               dev_warn(dev, "Invalid prescale %d > =
5, force setting to 5",
> > prescale);
> > > +                               /* Set prescale value of 5. */
> > > +                               rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTC=
R(ch), RZG2L_GTCR_TPCS,
> > > +                                                FIELD_PREP(RZG2L_GTC=
R_TPCS, 5));
> > > +                       }
> >=20
> > I wouldn't write back the 5 then. Just assume that the value read back =
was 5. (Well unless the
> > hardware behaves according to the normal formula that applies for presc=
ale =E2=89=A4 5, then it might make
> > sense to continue with the read value.)
>=20
> OK, will just print the warning.
>=20
> dev_warn(dev, "Invalid prescale set %d > 5, prescale);

No, please don't warn (or do it at most once per pwm_device).

Best regards
Uwe

--kephizyyiahpjuov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmayPXIACgkQj4D7WH0S
/k4eLQf/RgjYIPMG+rMsEppe4QEm3ObH5u6/lZdla9x6WgyncZZ0fQ0TR9dbgT1e
Je3aO8OgdjrKtU3W17Finco5PViuo9FeZSbyLEaSlISJQcG9AEPc/pucx/n9ZqJW
MVgJ0+9svNr1bQ0KuwpUEIHZJg4RFcew/BFPP9ElRnM62FU0qgtUPVBgtRBlz9c+
8a5dcI/JoHCLNiWXa6tsd10r37lnZgbMIiF+iQU9JZL3LRS0DSmtif/m5RnVcUKo
CoZZiycvb9wEfTXWojsvO6pMM4RI1j87VY0JoCyD5vh0dBGcNDEi0a7vH0IhLxPS
dSajVoavtYlBLzqBA6mXKCzqtRXppA==
=NyBs
-----END PGP SIGNATURE-----

--kephizyyiahpjuov--


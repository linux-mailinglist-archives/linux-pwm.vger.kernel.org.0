Return-Path: <linux-pwm+bounces-5995-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CEAB7E92
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121033B9EEE
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7A280A57;
	Thu, 15 May 2025 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1oxaD2D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909A2797BB;
	Thu, 15 May 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293265; cv=none; b=T533wjQiqk/U+u+4kAwRvMcpKZwS+8qujQX1m3LVraROLg8j0BMO6qRBeS75pxjxJUj1zbH+Emlc6PkVJj4zk84DHVao27pRhBNftce0r3yiGTQ7+5MSmga+lnuuBqDTwTMlRqVKXT0eCocP3ccWFjoB78Hcd7rwZHRBkZvt5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293265; c=relaxed/simple;
	bh=o/ecv9yXIKZlFDqFrsLArJP2qQJ3aZihxXztamxxomI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuIPin/4iXZ++MHtHVeVPavBKFsXZTlMpI4rSM0B0O61lGJya6FPo3y+5lF0aUypHQn3BNUprnQ5xiG/U9ZSeQr4jPWhGDPyLlwM2VUevCp5NtO7yIAkjoJDSvb7gQJjkeYizwB9vnI3wmRyIFu8rK7B8gkY+JwRIpcmmQ+c+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1oxaD2D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so6263435e9.3;
        Thu, 15 May 2025 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747293260; x=1747898060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KD8cS6cgzj5Uiq1H5FJM1CE0gy4jEfoCs/JvaXo6r+k=;
        b=h1oxaD2DPjuDohXkt08c0hWeU0BC3msgv9P+nO9H5XxKzkqghn3ccPCgMyQea2aoBg
         RIX9VklMXw0LpNvldlEiEnCSAHfmqqkhbxJswWkXS8ZiZZe5SVAoGd+7bvC2lKvGBZJD
         sjztYx9f4iFU++BJL2EbljwBAyOaQZ+drGVnniDJooW/gZUbdjtmUT+aXPZ/MnXhmTDR
         oM3nRrC8vPv4Uuh2PMI9lHIKYbpca1L2j5AeqpYjjlcIfju80x2AcTkkLtrOjCfGMSn9
         RSHsYHUQm8ocdV9rZGzCUBx0FOlHMQ1KJ21EuPU8c9+ufkMxtE6rQLNIoWH4WWZ8q+02
         Ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747293260; x=1747898060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD8cS6cgzj5Uiq1H5FJM1CE0gy4jEfoCs/JvaXo6r+k=;
        b=KrCypPer9U/jAVLTUykJNdhLaNZ33YPPl2UNFHsVv9qxI31c5eU3u/g5rotV7HroaL
         EshfPGweXyRbwWffCMJlJ1/M1cb10enYQ3XVVJ7bDlqgXdR9qPvgA3OgRy7t59u28nwM
         y+kAqE7+ih2E4L82W0eA8kWP7ZKGcoKpLdEv1fl/ET7SL2Uo2AculxqMu91zPiN3V7HC
         cqlOo7hvDHi5zJLWDuZZGwQrKtWycQb5qV4RYnn9j60PnmE+b/hf8pKx2S5t6JVUBTHD
         T3kc/vAh+cPdqsT2MCmdFVeYGgLhrxLKKEh9O7qrcfLfDU1J/UEdcyU7rHoNBQlJYcyT
         lbvA==
X-Forwarded-Encrypted: i=1; AJvYcCVmWj4Q2QgGxxv2bHCoJUJ7m9WVvbpXxSSefMsoSRW3vpLSeirtiXGlpAmdJD8SJcDu+3qtSDhPPqz2@vger.kernel.org, AJvYcCX2C6cfWirgdR9xSucqkhq4tZFQ5bt0IceurVw7FS2QNXRbwZscP2buLDh3Mp6m4jI/zNrE9abAQ/p4@vger.kernel.org, AJvYcCXyB8C3eXeFhhEilenjf6s4YbyLBcSIdParga1bLO1ayhDphTa/foTuT5zOZ4EYa6ARnXZT8vw1iseDWBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJh3B4DZOAMxEv791eUoYGFh3q14fn8kBQ+HdhhtJXFg1n/EY1
	S+P3Jp2Q8UHUJlukutS4VCJUbnCgkAPDJ4xvkh58rAZzgI7fDtaP
X-Gm-Gg: ASbGncsE2TMUY0XqJo4x5o6GJTb7IsaVVj46hkiuaLzsmrGf/h6S8vEmIxYN6oooFY8
	emlCwzC3qWUgNlAyzc2ms0tv3zCclpIzFIvuxnRl4U4K6lEOWQKo23cYpbmnCnWEDsTl2Myu1ww
	qOuJw382xykTvjeYjmAtIVgwvuRLfqqIxAL8oiRLgU3qu+a9I36RlCN5HSb7a1EOx+h+aK1okJc
	OyjI5EAVy99296PHtAHkzzfrFMzxo2BwDZVSwExkQ6qzBP5A4NgyY8SKUJ/j+st4pc1KG/bHL/c
	qAXPG9wNULLPBHURsCMThzSmQx5LFu7RWidNjBjE6iLuvJTjpEg2n8LAfeZNnZZabJuCeczUYpE
	Z6H2nZTfD5oqEkV4KDk05x0dk9Q==
X-Google-Smtp-Source: AGHT+IGn1IPdtVB1lBv/1nov3WjqcuSR8LVs0rfZoL9s5KeW8wcX4ImAqjh4I5NXGTnCcyqGwbQndw==
X-Received: by 2002:a05:600c:1e02:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-442f970a8dcmr8938885e9.22.1747293260107;
        Thu, 15 May 2025 00:14:20 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2fc4sm22119816f8f.56.2025.05.15.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 00:14:19 -0700 (PDT)
Message-ID: <332b3f951b91f56acbeae9b01bb89f108f8838e6.camel@gmail.com>
Subject: Re: [PATCH v3 13/22] mfd: adp5585: add support for event handling
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
Date: Thu, 15 May 2025 07:14:45 +0100
In-Reply-To: <20250513155920.GQ2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-13-092b14b79a88@analog.com>
	 <20250513155920.GQ2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 16:59 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > These devices are capable of generate FIFO based events based on KEY or
> > GPI presses. Add support for handling these events. This is in
> > preparation of adding full support for keymap and gpis based events.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 180 +=
+++++++++++++++++++++++++++++++++++++++++--
> > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 48 ++++++++++++
> > =C2=A02 files changed, 223 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 8be7a76842f639cbe90ad0eb956a7a3eef43fa3d..5851ad30e7323bbb891878167d078=
6bc60ef5d9
> > 0 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -154,10 +154,16 @@ static const struct regmap_config
> > adp5585_regmap_config_template =3D {
> > =C2=A0
> > =C2=A0static const struct adp5585_regs adp5585_regs =3D {
> > =C2=A0	.ext_cfg =3D ADP5585_PIN_CONFIG_C,
> > +	.int_en =3D ADP5585_INT_EN,
> > +	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > +	.poll_ptime_cfg =3D ADP5585_POLL_PTIME_CFG,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_regs adp5589_regs =3D {
> > =C2=A0	.ext_cfg =3D ADP5589_PIN_CONFIG_D,
> > +	.int_en =3D ADP5589_INT_EN,
> > +	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > +	.poll_ptime_cfg =3D ADP5589_POLL_PTIME_CFG,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> > @@ -214,6 +220,8 @@ static int adp5585_parse_fw(struct device *dev, str=
uct
> > adp5585_dev *adp5585,
> > =C2=A0{
> > =C2=A0	unsigned int has_pwm =3D 0, has_gpio =3D 0, rc =3D 0;
> > =C2=A0	const struct mfd_cell *cells;
> > +	unsigned int prop_val;
> > +	int ret;
> > =C2=A0
> > =C2=A0	if (device_property_present(dev, "#pwm-cells"))
> > =C2=A0		has_pwm =3D 1;
> > @@ -224,6 +232,25 @@ static int adp5585_parse_fw(struct device *dev, st=
ruct
> > adp5585_dev *adp5585,
> > =C2=A0	if (!has_pwm && !has_gpio)
> > =C2=A0		return -ENODEV;
> > =C2=A0
> > +	ret =3D device_property_read_u32(dev, "poll-interval", &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 10:
> > +			fallthrough;
> > +		case 20:
> > +			fallthrough;
> > +		case 30:
> > +			fallthrough;
> > +		case 40:
> > +			adp5585->ev_poll_time =3D prop_val / 10 - 1;
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for poll-
> > interval\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
>=20
> This all seems like a lot of code for:
>=20
> 	ev_poll_time =3D prop_val / 10 - 1;
> 	if (ev_poll_time > 3 || ev_poll_time < 0)
> 		return dev_err_probe();
>=20
> > +
> > =C2=A0	*devs =3D devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mf=
d_cell),
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > =C2=A0	if (!*devs)
> > @@ -249,6 +276,135 @@ static void adp5585_osc_disable(void *data)
> > =C2=A0	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > =C2=A0}
> > =C2=A0
> > +static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_=
cnt)
> > +{
> > +	struct adp5585_ev_handler *h;
> > +	unsigned int i;
> > +
> > +	guard(mutex)(&adp5585->ev_lock);
> > +
> > +	if (list_empty(&adp5585->ev_handlers)) {
> > +		dev_warn_ratelimited(adp5585->dev, "No event handlers
> > registered\n");
> > +		return;
> > +	}
> > +
> > +	for (i =3D 0; i < ev_cnt; i++) {
> > +		unsigned int key, key_val, key_press;
> > +		int ret;
> > +
> > +		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &key);
> > +		if (ret)
> > +			return;
> > +
> > +		key_val =3D FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
> > +		key_press =3D FIELD_GET(ADP5585_KEV_EV_PRESS_MASK, key);
> > +
> > +		list_for_each_entry(h, &adp5585->ev_handlers, entry) {
> > +			ret =3D h->handler(h->dev, key_val, key_press);
>=20
> Rather than rolling your own call-back handler mechanism.=C2=A0 Are you s=
ure
> the kernel doesn't provide a generic solution for this?=C2=A0 For instanc=
e,
> would a shared workqueue be better?=C2=A0 This way you could also exit IR=
Q
> context sooner as well.
>=20
> > +			if (!ret)
> > +				/* handled! */
>=20
> All comments should start with an upper case char.
>=20
> > +				break;
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
> > +		dev_err_ratelimited(adp5585->dev, "Event Overflow Error\n");
>=20
> Strange capitalisation.
>=20
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
>=20
> You don't want to propagate any errors?
>=20
> > +out_irq:
> > +	regmap_write(adp5585->regmap, ADP5585_INT_STATUS, status);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int adp5585_setup(struct adp5585_dev *adp5585)
> > +{
> > +	const struct adp5585_regs *regs =3D adp5585->info->regs;
> > +	unsigned int reg_val, i;
> > +	int ret;
>=20
> The final version of this function needs some nice commentary to explain
> what each step is doing.=C2=A0 May as well start now.
>=20
> > +	for (i =3D 0; i < ADP5585_EV_MAX; i++) {
> > +		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
> > &reg_val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret =3D regmap_write(adp5585->regmap, regs->poll_ptime_cfg,
> > +			=C2=A0=C2=A0 adp5585->ev_poll_time);
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
> > +	ret =3D devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, adp5585_=
irq,
> > +					IRQF_ONESHOT, i2c->name, adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* clear any possible outstanding interrupt before enabling them... *=
/
>=20
> Uppercase char (I won't report on this again) and now silly punctuation
> please...
>=20
> > +	ret =3D regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &stat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(adp5585->regmap, ADP5585_INT_STATUS, stat);
> > +	if (ret)
> > +		return ret;
>=20
> What does reading status values then writing them right back do?
>=20
> Commentary throughout please.
>=20
> > +	ret =3D regmap_write(adp5585->regmap, regs->int_en,
> > +			=C2=A0=C2=A0 ADP5585_OVRFLOW_IEN | ADP5585_EVENT_IEN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(&i2c->dev, adp5585_irq_disable,
> > +					adp5585);
>=20
> Feel free to use 100-chars to help with these early line breaks.
>=20
> > +}
> > +
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > =C2=A0	struct regmap_config regmap_config;
> > @@ -282,16 +438,19 @@ static int adp5585_i2c_probe(struct i2c_client *i=
2c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > +	adp5585->dev =3D &i2c->dev;
> > +	adp5585->irq =3D i2c->irq;
> > +	INIT_LIST_HEAD(&adp5585->ev_handlers);
> > +
> > =C2=A0	n_devs =3D adp5585_parse_fw(&i2c->dev, adp5585, &devs);
> > =C2=A0	if (n_devs < 0)
> > =C2=A0		return n_devs;
> > =C2=A0
> > -	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_OSC_EN);
> > +	ret =3D adp5585_setup(adp5585);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5=
585);
> > +	ret =3D devm_mutex_init(&i2c->dev, &adp5585->ev_lock);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -301,13 +460,16 @@ static int adp5585_i2c_probe(struct i2c_client *i=
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
> > @@ -316,11 +478,19 @@ static int adp5585_suspend(struct device *dev)
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
> > =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5=
585_resume);
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > 9a925a91c772722db559c9ec8ae334b2159ede79..218c56bed2e0304de8b81c7090386=
fb4e1b6c28
> > 1 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -10,13 +10,23 @@
> > =C2=A0#define __MFD_ADP5585_H_
> > =C2=A0
> > =C2=A0#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/list.h>
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
> > +#define		ADP5585_EC_MASK			GENMASK(4, 0)
> > =C2=A0#define ADP5585_FIFO_1			0x03
> > +#define		ADP5585_KEV_EV_PRESS_MASK	BIT(7)
> > +#define		ADP5585_KEY_EVENT_MASK		GENMASK(6, 0)
> > =C2=A0#define ADP5585_FIFO_2			0x04
> > =C2=A0#define ADP5585_FIFO_3			0x05
> > =C2=A0#define ADP5585_FIFO_4			0x06
> > @@ -32,6 +42,7 @@
> > =C2=A0#define ADP5585_FIFO_14			0x10
> > =C2=A0#define ADP5585_FIFO_15			0x11
> > =C2=A0#define ADP5585_FIFO_16			0x12
> > +#define		ADP5585_EV_MAX			(ADP5585_FIFO_16 -
> > ADP5585_FIFO_1 + 1)
> > =C2=A0#define ADP5585_GPI_INT_STAT_A		0x13
> > =C2=A0#define ADP5585_GPI_INT_STAT_B		0x14
> > =C2=A0#define ADP5585_GPI_STATUS_A		0x15
> > @@ -104,6 +115,8 @@
> > =C2=A0#define		ADP5585_INT_CFG			BIT(1)
> > =C2=A0#define		ADP5585_RST_CFG			BIT(0)
> > =C2=A0#define ADP5585_INT_EN			0x3c
> > +#define		ADP5585_OVRFLOW_IEN		BIT(2)
> > +#define		ADP5585_EVENT_IEN		BIT(0)
> > =C2=A0
> > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > =C2=A0
> > @@ -121,7 +134,9 @@
> > =C2=A0#define ADP5589_PWM_OFFT_LOW		0x3e
> > =C2=A0#define ADP5589_PWM_ONT_LOW		0x40
> > =C2=A0#define ADP5589_PWM_CFG			0x42
> > +#define ADP5589_POLL_PTIME_CFG		0x48
> > =C2=A0#define ADP5589_PIN_CONFIG_D		0x4C
> > +#define ADP5589_GENERAL_CFG		0x4d
> > =C2=A0#define ADP5589_INT_EN			0x4e
> > =C2=A0#define ADP5589_MAX_REG			ADP5589_INT_EN
> > =C2=A0
> > @@ -138,8 +153,18 @@ enum adp5585_regmap_type {
> > =C2=A0	ADP5589_REGMAP_02,
> > =C2=A0};
> > =C2=A0
> > +struct adp5585_ev_handler {
> > +	struct list_head entry;
> > +	struct device *dev;
> > +	int (*handler)(struct device *dev, unsigned int key_val,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int key_press);
>=20
> Pointer to functions outside of subsystem-level ops are generally
> frowned upon.=C2=A0 Are you sure there isn't a standard way to achieve yo=
ur
> goal without them?

Actually, it was fast. I think the notifier API will do fine here. I guess =
that would
make you happier?

- Nuno S=C3=A1=20
>=20
> > +};
> > +
> > =C2=A0struct adp5585_regs {
> > +	unsigned int gen_cfg;
> > =C2=A0	unsigned int ext_cfg;
> > +	unsigned int int_en;
> > +	unsigned int poll_ptime_cfg;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct adp5585_info {
> > @@ -150,7 +175,30 @@ struct adp5585_info {
> > =C2=A0
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > +	struct device *dev;
> > =C2=A0	const struct adp5585_info *info;
> > +	/* Used to synchronize the availability of the event handlers */
> > +	struct mutex ev_lock;
> > +	struct list_head ev_handlers;
> > +	int irq;
> > +	unsigned int ev_poll_time;
> > =C2=A0};
> > =C2=A0
> > +static inline void adp5585_ev_handler_remove(void *data)
> > +{
> > +	struct adp5585_ev_handler *handler =3D data;
> > +	struct adp5585_dev *adp5585 =3D dev_get_drvdata(handler->dev->parent)=
;
> > +
> > +	guard(mutex)(&adp5585->ev_lock);
> > +	list_del(&handler->entry);
> > +}
> > +
> > +static inline int devm_adp5585_ev_handler_add(struct adp5585_dev *adp5=
585,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct adp5585_ev_handler
> > *handler)
> > +{
> > +	guard(mutex)(&adp5585->ev_lock);
> > +	list_add_tail(&handler->entry, &adp5585->ev_handlers);
> > +	return devm_add_action_or_reset(handler->dev, adp5585_ev_handler_remo=
ve,
> > +					handler);
> > +}
> > =C2=A0#endif
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20
>=20



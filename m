Return-Path: <linux-pwm+bounces-8367-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFXIKdbiw2lvugQAu9opvQ
	(envelope-from <linux-pwm+bounces-8367-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:27:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBEA325BCE
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6879313A764
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF73D890A;
	Wed, 25 Mar 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlUEcTUS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28D3D8126
	for <linux-pwm@vger.kernel.org>; Wed, 25 Mar 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444303; cv=none; b=dOrG26PKj1X75jx7OQ/RyBxx2JzxJmfGE6aTS/lhinkBUHwdzEAlj6jNXWuZTY28w6F32l3H8TtG5cCUlYVSNyeaWjMiT7ehO3Kq+e+bkK80P1kqT2JD6csAY7n1kBRsU6MwJCjti6JTPnWVNGd5m7J6rwqZvsdJIjSqVKVW4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444303; c=relaxed/simple;
	bh=g4wYbCrQQciM5eAA7bNgeswNgh+jLdm3yzIf2O7Ct2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=or4Yfvh+Dq0Q1SHFKbyojwl2VXa6pWoK6SHdcEYtIuI9RLRvC0wP6UGwUmazQwtOn/c4/Vh61B29lpqSaH8n93/YYN/sXmU7n8EsuBz9SgEaGq00g86Lf7HtnNDJDuoQEefFsG8zbSdrkoPNzfxfjtuM5zWmL2ZA6FyBa4/HHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlUEcTUS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fb14227cso26017155e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 25 Mar 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444301; x=1775049101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3GPRX2Yqkh2fKcDql2NbbWnYF5EebgqjYrmp0cfTJ5I=;
        b=FlUEcTUSYKpCxvw92RDkKefbBgYBLc4ykoYW58S+9zQ3sNCSyItFQKnJX0mKXARFO2
         E9oo13U9zxVGkgarArAhzOZQliIG4F3CzAppc+X/xd1UklAGVxE+Pyv8oVqSR8Nmk7pW
         D3/JeMcd/wjGKnW3U0iac994/Akstb/UZtq1CSVlJBeKPWLqELnkrYUAXL7CWpb1vgGH
         uRdr/b4OWGQhJTwuP2vZIpjKAFm519CweJHdSicKy3nE3BYWKzM8/f0/tOJmVnsWc3CK
         ofbPmE+kU383DzjJOFdNEjTZNRmX4Ospc/wb2eylB7QgKfdyW+OtmehKkRFnpycQdcm1
         EZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444301; x=1775049101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GPRX2Yqkh2fKcDql2NbbWnYF5EebgqjYrmp0cfTJ5I=;
        b=hA/sUKWo/6xEBjfjUMtMHGlxjvsF0WMQaOhqgUoFLYA+oRLeWJHd2XZ4zJmkLzelsC
         tzSZzmg3qFUOMCIJex3fb2Ex1HqsneHMRwNCXp+ficPJOGpLG+uQf6Bs4zD2GGNeVqPT
         roSQtvd2bTtGuaz3zyrSMIXrjAJccLORrX4L3YlXObWGXNMHOcGt3NHYp3B4V+ZOJbQL
         DufwT+mM9bX1KwAOWO25QY3K6/znQ6FeXaq3Nx9Q+7BDNBol7C1rWhUVRQ2rLVXrbmOB
         EF5Gin1KHlgvfJOpqLBlujapzYxL5HLillGNU2Ctfn7h/FHZQIZKUIbImGod3x+C9NZ7
         EOYw==
X-Forwarded-Encrypted: i=1; AJvYcCVHoXRW/nMgYkG8YAS6dHdJTwC93YCmElmwgE6Hg8yknMMeKBG65/kTlkfHq69x3Ipw/1kdZ6qB3ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+uf3GbBLtzYP33QzNgh6NFpBDRhnxJw/i8E+5XoEY3ROqSJX
	QWxKYNESjIl7O7Alodam2vcvUu5Nz7LX6cW2hAgXam1bm3YuW1D5sp7N
X-Gm-Gg: ATEYQzzR5Q09wBM2oDHhIR8ZawSCrketiVb8SA8SF3hDK0E/3RUeLcJo4Uj0VeMbV1m
	gtlh4eO0PuBsbSE7QRVsjgZ1JJ1Qpcr0WWkKrqjVEKZj8kt3gzTMZQcMmXtFAZsYFY1p/85nDNR
	SENs2wHmKQYISLeHyFVg9agj7SDtSei/8TUcvLGCMSSlYrl3L36b3VgHxQWGtOboo5w7UfUN0yd
	bEL/NBMcDaQYnfUjd/DqvzMDZk127+KbSz5BgYezR1xo5tiSnMK9V96qRdf1mdH2/oPmR9qvzUh
	E7L3wDyOwncO1ryOvEl2Gwk0KcX4T0Dfs/xmA3lRP3Ovv/1iQ0CV91szmg9bR6LrbggrJUpDmtE
	URzTXPWM0to2sgzkDsdocsWoBy9tCjworEa0lPNjKLjl7Xfz3Zb2CNcEiaVeKj1fzCZFnZva20m
	LKI0arHHCzon3l79kf0AVMaWhljATAr6M=
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-487160aa232mr49865885e9.31.1774444300774;
        Wed, 25 Mar 2026 06:11:40 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711709e95sm132827945e9.8.2026.03.25.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:11:40 -0700 (PDT)
Message-ID: <852233180cce9c9adffc491e4cdc16f281bfe09c.camel@gmail.com>
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, "Sa, Nuno"	 <Nuno.Sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	 <linux-gpio@vger.kernel.org>
Date: Wed, 25 Mar 2026 13:12:26 +0000
In-Reply-To: <SA5PR03MB84250500F1FB9567F7FD2701F749A@SA5PR03MB8425.namprd03.prod.outlook.com>
References: 
	<20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
		 <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
	 <83d87ff35002e5c7b9448a5ee7f2791a63c38c38.camel@gmail.com>
	 <SA5PR03MB84250500F1FB9567F7FD2701F749A@SA5PR03MB8425.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8367-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DBEA325BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-25 at 12:47 +0000, Sabau, Radu bogdan wrote:
>=20
>=20
> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Tuesday, March 24, 2026 2:23 PM
>=20
> ...
>=20
> > > +static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio=
_dev)
> > > +{
> > > +	struct ad4691_state *st =3D iio_priv(indio_dev);
> > > +	struct device *dev =3D regmap_get_device(st->regmap);
> > > +	int ret;
> > > +
> > > +	disable_irq(st->irq);
> >=20
> > Should we use disable_irq_sync()?
>=20
> Isn't disable_irq() already calling synchronize_irq() inside it? I can't =
see
> disable_irq_sync() in the current kernel, only disable_irq_nosync().

You're right! Sorry for the noise

- Nuno S=C3=A1

>=20
> > > +
> > > +	ret =3D ad4691_sampling_enable(st, false);
> > > +	if (ret)
> > > +		return ret;
> > > +


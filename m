Return-Path: <linux-pwm+bounces-4680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589BA169C3
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B13A62D8
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818081A8F93;
	Mon, 20 Jan 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfV0moEF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7A191489;
	Mon, 20 Jan 2025 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366286; cv=none; b=JSm5etUOXwnK2KK0pSVKjxDeLkFItWXaLwdukOVpykYznU7NMJaK2yt7JfTHocjB50I/1jxtyRaTJte3vvj4duV/byd86iDKVEaiEBi1qMFjmjZWhb8XweXDp3LkjSCxEuMQxx9K8UVDKpbyNXHa8pAmGb+X4U+h7e7VX3Y9NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366286; c=relaxed/simple;
	bh=dY06NJPrc7NKbOBXttQ2Q9ra4GxFQJv2VLv098HDvEI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYUCve0QYskgugOOWVFyWthCIziKSvzyqxLupLCPrp7Di7QbBQAtxV+R3l3yTKJ8JasSprbX0iA8nMsBDGcXwQZcHEQYveVLwQyma2d8bJ+fML/RLh4GQtzmEzOAFgY8b6kg+Tf1ilcpvhzA/WWHAv0AxEigg8xLigGAFsEvd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfV0moEF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso43504555e9.2;
        Mon, 20 Jan 2025 01:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737366283; x=1737971083; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k009fKRRxVFxiBuxTyjlZVVSU8LeE2j0qz2UAIvn4k=;
        b=LfV0moEFR0OftE5RqHg02jXOe0lbp8fuwI+RXR7d0XcZ0QvTRfaTfkf+ktcO/h/Nl5
         tsZKo3ReaGOwx2F6G8Yyy7SoN7E1lbbl1Vj/sLAkOsQ167JBj6+X5LNQIDRyN85uATjF
         ajfNi7rz+YpWC7jkUxNYGgOucSofewscmufzgE2gNWXm21mSbRih0AdDMCfQQ2eXkkVF
         EIKond+Qec5GCKB7C7jqM/jffZ6vn3PX8WzBVTSyPPPVXZX5mHhuj4ol7AwVOHGj3LKK
         2QVlTZnxp3y3gRv5Nk+UwDHCIW6atZntyRo+RHggPbth83ln+nbFYHBp7Pd4QnHOl9WE
         9/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366283; x=1737971083;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+k009fKRRxVFxiBuxTyjlZVVSU8LeE2j0qz2UAIvn4k=;
        b=GKiwNZiN7OrLqFxcGQEHymDRNWMcxU424zKATlQ/YcPMxq39dWa6DU0hISTYpxHVBY
         7IY9/JIPomo7Tc+/JeHySW0RBnxOWG/X6Gx531NMULRDaY2AcJbzzsyB0VDRIx4DALKQ
         LVEZXxPxANgtczeVP4R6f8ae1M12/g1xL8PapAGkdCQyTG34jRVcC9/9EEeoQ3N4ii1H
         /9IQvvpS6ix04oNGb0njbi1JqsMJwKv4nILZgLFHTuPltyyHHNIhNqIlseI7uiSw4BiI
         JI0Dg0gODhplg2NWqe4HrWiWa4ZewyLxbUV7W3jNop1jR9ttkJBScGyQvjRI1yu0FTt9
         wBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTbbsS665BPhKxrkGI9DqinluQuEWnKLZF4hT6Yl3awfkuhyC1msTXm1dl82iONGGcl/q9zvi0AYH@vger.kernel.org, AJvYcCVehxzUjx/KX8vxoAN7MIQlxxU4eKeHbaZ5A+D7ZOvS22kU8xq0VoadAW7BKpRuh6IcrQJnHWMTkOa0@vger.kernel.org, AJvYcCW84QB/bzM8EaITi5JUFtoSUKrdnnbKqZO6OmxHpSTgTStsLFC4dGhDzGSQjzNvC/CdFbJVK9CD4TnLMJri@vger.kernel.org, AJvYcCWYPgHEJyUyEfB00+/ptKNwyC8N4xaxrN93PWXclTbOv3iVuCzD89LIpkJGOonstI7kmMHN9jY/ChFj@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuB7XTeLkCguz9BlhUYcBWhmZqj8xVM6sdyE4QhDk4lIdHYhG
	2ExuF9bqt4uFmTfc+a9LUKA20K0B9XJfJISnuiBUOSZjiOm4+IM7UAI5C00mwlQ=
X-Gm-Gg: ASbGncv0P5NGj4XXkqHSuv1wcXoYVWKm2tS/ymJBkknjhpHjIfRuDAddlKiCVA3hbM8
	OBFgSA1jXuVlgwW76zyxbwK1AX4U5CRbEig6x6Modohg8423YQVjgwfaLygwuEJGBsc/wGwFbhp
	QdbzgM6GPGiR8ViZ+MuT0D4Vph144HFB2rreZAnABfvNsajx0lVB/8AUW65zwfEzaxS3E4pebSS
	w6LCenPs4kna46BqDvS+jj8V6gogGkbjhS9lVNaS4ZY06Bz3ozr88uhWvANFMIsTStXowiJuvG1
	jxVo/uQf+OwCWtpN8WMEkj/DXtydy1qq+WnBUI2eCA==
X-Google-Smtp-Source: AGHT+IGyAVa4vi5Ac8o4nfdzUyjXWDt/AbAoJ3A/0ApJz1wMgXqV3aMI05mnOhljTAiXDSzUxckelg==
X-Received: by 2002:a7b:c3d8:0:b0:436:17e4:ad4c with SMTP id 5b1f17b1804b1-438a0d3c71fmr62629895e9.6.1737366282654;
        Mon, 20 Jan 2025 01:44:42 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c16610a0sm124812965e9.1.2025.01.20.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:44:42 -0800 (PST)
Message-ID: <87f3aeeb767e90dbdd7b39da20af7c3d88706002.camel@gmail.com>
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, jic23@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Mon, 20 Jan 2025 09:44:42 +0000
In-Reply-To: <d0253e41-3cab-4263-91b2-81682529f9a0@baylibre.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-9-antoniu.miclaus@analog.com>
	 <a45c60fe9fff0f517032a7e9eb3881cf340a8c1e.camel@gmail.com>
	 <d0253e41-3cab-4263-91b2-81682529f9a0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-18 at 11:37 -0600, David Lechner wrote:
> On 1/18/25 9:10 AM, Nuno S=C3=A1 wrote:
> > On Fri, 2025-01-17 at 15:07 +0200, Antoniu Miclaus wrote:
> > > Add support for the AD485X a fully buffered, 8-channel simultaneous
> > > sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> > > differential, wide common-mode range inputs.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
>=20
> ...
>=20
> > ...
> >=20
> > > +static int ad4851_read_raw(struct iio_dev *indio_dev,
> > > +			=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > > +			=C2=A0=C2=A0 int *val, int *val2, long info)
> > > +{
> > > +	struct ad4851_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		*val =3D st->cnv_trigger_rate_hz / st->osr;
> > > +		return IIO_VAL_FRACTIONAL;
> > > +	case IIO_CHAN_INFO_CALIBSCALE:
> > > +		return ad4851_get_calibscale(st, chan->channel, val,
> > > val2);
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		return ad4851_get_scale(indio_dev, chan, val, val2);
> >=20
> > Maybe this was discussed already and I missed it but I'm a bit puzzled.
> > Don't we
> > still need OFFSET for differential channels? How do you express negativ=
e
> > voltages?
> >=20
> > - Nuno S=C3=A1
> >=20
> >=20
>=20
> It was discussed in early revisions of the series. :-)
>=20
> There was an OFFSET back then, but we removed it because chip uses twos
> complement encoding for bipolar single-ended and (bipolar) differential. =
We
> have 's' and 'u' set in the scan_type.sign in those cases. The current
> implementation looks correct to me in this regard.
>=20

Yeah, my bad. I was also the one suggesting the OFFSET (IIRC) in internal r=
eview
as I assumed this was typical "straight" binary encoding. I did bothered to
check the datasheet this time and all looks good. Sorry for the noise...

- Nuno S=C3=A1


Return-Path: <linux-pwm+bounces-6946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20124B19FBE
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866807A63AF
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BE244667;
	Mon,  4 Aug 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tKhuBG/O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C971ACECE
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303455; cv=none; b=LeEysljqqTfzxn6Mymv3PzpX8FUyU3qtjXCQV1oudeEUTL2CMD1sx5s/RRHkLlm9R6nChacZWDCACzl+q/zNsMfCOsFivpMKJ30hCt6IfpeAjc23lkKLxcsmtuij+DOt25Lm3fIjOpvuIPQR3bz9IhyQEP7SnVCSI9GWt05CMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303455; c=relaxed/simple;
	bh=ODFBaCX/2tzXQUFf12BlZcO5AEvllti2tfT8T3Hos5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIgezRh602dNaEdwBduSZ3g/DVcXnBYOMbnLKj4opCClga4qZSWZuuk9x2qvDFMyZTqIzFRIKHrNsilQJtUH1grk/HEGhjdszeveL+TNPZ7XVE+U00SfB1B+m5lG+2mmUBf4+8uQl+BX0KxMmOlUnrUeytxLyPUSg9MSYHJsoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tKhuBG/O; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso5825770a12.3
        for <linux-pwm@vger.kernel.org>; Mon, 04 Aug 2025 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754303450; x=1754908250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTN6DQNpcMHKpy2OvEV2qP5hGAy9yu+IDmfs1+NjDFw=;
        b=tKhuBG/OZli8JedncboyQPGaUGr/ixp3BaHD9Q8WbUCh19L5uvNSYq73oTVacj5HI0
         pUtojcs1+N/Kc39/Nm1L2NNgl7vfb72I/9Khqd3kTl4uSmsifhH+KRQbo4Ki8LjmvCB8
         E4ZnNdETjC8xoPrUGWPh7PaP8LiP6T0lqx1as4PuDWkj6WPszuFcvZaNQfsPiyYIh/fh
         gj1rdHLAKUsuIKiJq86ud+UYmQE/+95ah1joWfiFhxVfzp96M8RYjucQmmRTgudaFjAX
         UlGxQkcq2QUch3sAu9cnL9IczAnp61sle0HBicQ0R0d4Mrw7M9dW9X35CzGIcXl9Z9WX
         UsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303450; x=1754908250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTN6DQNpcMHKpy2OvEV2qP5hGAy9yu+IDmfs1+NjDFw=;
        b=eawExGP9/fOb9XMGFj0Yc0/Xp145tBfTmA8lcVc2ShaPD3IAkdAg1d2ycZCy/HvSZ6
         WvOE3ERRKJH1/25FtcIeQlZKjHszMYv4+2hTvLdejQYRH7eTKm4pbDPyWE1NRNqchAK/
         OR3sBmNMBBdFsftlZ6/shYQAkebWHMhf0LhpTkXf148eTHXTfMIBM6f5uTfr9P0EuW3B
         l6brmwJFpjMeyy5i+4qsVahQMz5RdMn5gTAb9a9MU838X+DZAtgwVT1ej4ZbVAwj44o6
         t4zbxF7P/kwpmg/+1/j/YT7izDJbfVDd2hxxQV2AB7NG4MQoCr2e8GyX7K66cfinox3k
         sCog==
X-Forwarded-Encrypted: i=1; AJvYcCX5IzCBB0qUTLIFGXm8vjq0Cuv6yVBMXbeor7nmOnBbV/2K8ycoQgWzq1Ce9lYbPR0UuuukV1XWims=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qKcFAcr4Q+irBZ8Q0qZw7zG1bb5H9zHdHH8rSrEJ2N+ijc2S
	/vPmXOyXc4kWTO6GekVWqTOzag3dgzewJGiwXXgVOEk2ch5eYeAhIas/l6CjOBKnD6A=
X-Gm-Gg: ASbGnct1LN4I+RD90UAVkxO+DcXn9ZVRvd1sRmFiZHqNcBZwvJCdtf8G5ni0AOZtRZe
	c96ioTottKcd+DdtsGZQ88k5cAJm4cnzVe2C9+hRRiDmllxqc8PxnhR2TnvNYzlQUeiKNV3EvhJ
	4B1iDv6+92ywqu8SDDiH0+M9AHCUSB/i9d8rPXB5R28G41UHnxAxyznGGONG3Skkk5YEaO7C2Ld
	Iw121YswToDl7nXSvh60SWfky6Ujx7fmBQWXaYQzUd5NXFalc2uqJhEmGwNTvmHXQY9uRLxmvyq
	9NJgLqEf/g4oNmohsxL5woMq5WOxMgVUHuS6kHnwIXuT55llCV1hzkYclxP6oF/u8pfp5/rYTlZ
	STPA5bhRbQdmiVw7xC0o92ZcUNnk=
X-Google-Smtp-Source: AGHT+IHSUiWGu/+IUmZfr7UuZTzuzqt4FpzSovbXhqhrTAZ/3nG/5APGMONyYDA0Ula6YRbTqUNTlg==
X-Received: by 2002:a05:6402:4403:b0:612:a86b:ac79 with SMTP id 4fb4d7f45d1cf-615e6eb6935mr6975874a12.2.1754303447934;
        Mon, 04 Aug 2025 03:30:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a8eff8d3sm6674755a12.6.2025.08.04.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:30:47 -0700 (PDT)
Date: Mon, 4 Aug 2025 12:30:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
Message-ID: <g4qrehzi44mgvmy76wnrhabmin454wwrngubvvikgjv3w5udl7@wmxrly3mxoiu>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
 <e3495f99-4a78-4910-9b67-6c25dfe7f989@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eaj2ceowxzk5qqet"
Content-Disposition: inline
In-Reply-To: <e3495f99-4a78-4910-9b67-6c25dfe7f989@collabora.com>


--eaj2ceowxzk5qqet
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
MIME-Version: 1.0

Hallo AngeloGioacchino,

On Mon, Aug 04, 2025 at 10:50:01AM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/07/25 17:45, Uwe Kleine-K=F6nig ha scritto:
> > The general register layout contains some per-chip registers starting at
> > offset 0 and then at a higher address there are n nearly identical and
> > equidistant blocks for the registers of the n channels.
> >=20
> > This allows to represent the offsets of per-channel registers as $base +
> > i * $width instead of listing all (or too many) offsets explicitly in an
> > array. So for a small additional effort in pwm_mediatek_writel() the
> > three arrays with the channel offsets can be dropped.
> >=20
> > The size changes according to bloat-o-meter are:
> >=20
> > 	add/remove: 0/3 grow/shrink: 1/0 up/down: 12/-96 (-84)
> > 	Function                                     old     new   delta
> > 	pwm_mediatek_apply                           696     708     +12
> > 	mtk_pwm_reg_offset_v3                         32       -     -32
> > 	mtk_pwm_reg_offset_v2                         32       -     -32
> > 	mtk_pwm_reg_offset_v1                         32       -     -32
> > 	Total: Before=3D5347, After=3D5263, chg -1.57%
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> What if we do, instead...
>=20
> struct pwm_mediatek_regs {
> 	u16 pwm_ck_26m_sel_reg;
> 	u16 chan_base;
> 	u16 chan_width;
> };
>=20
> struct pwm_mediatek_regs pwm_v1_reg_data =3D {
> 	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
> 	.chan_base =3D 0x10,
> 	.chan_width =3D 0x40,
> };
>=20
> static const struct pwm_mediatek_of_data mt7986_pwm_data =3D {
> 	....
> 	.reg_data =3D &pwm_v1_reg_data,
> };
>=20
> ...that should reduce the bloat even more :-)

Having the three u16 directly in pwm_mediatek_of_data is cheaper because
=2Ereg_data is a pointer and so 64 bits wide (on arm64) and so bigger than
3xu16. Also having the data directly in pwm_mediatek_of_data saves one
indirection and so it should also be slightly faster.

Best regards
Uwe

--eaj2ceowxzk5qqet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQi9IACgkQj4D7WH0S
/k6FSwf/bHraub08qdDH7NGDbse/dAus/PfuLOMMUmvWdr3WYZSQWeXZpzuysXdx
iX3pSR6SloJ3NDNN04P1in8Dj6VoPVVk+6xsyiJKfKLTq5mgJ/qcMrB0xXSI0gII
6JQi0z26kRjVF2x4642gsDRjQzztfJwiZpW7XfJtrxJfmWLua4gvTngXai3TS6tk
C9pmm9I8WkZm7TNKBa7mzYgqjeet4tuSujRZiOAwMtBKh8lT/RSZvv2cIeon31Uh
1FKeSzDTO3WyMiTC17z7WpZlWVxpAefUGaqsfa/3tYImC4xWvi+4cscMIPVjJCe/
SFIRoPIZusi/eUHVETsQ4f57cYg0IQ==
=UIdE
-----END PGP SIGNATURE-----

--eaj2ceowxzk5qqet--


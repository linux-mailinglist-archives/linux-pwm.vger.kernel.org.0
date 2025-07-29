Return-Path: <linux-pwm+bounces-6913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EDB15440
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577D2560A74
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221F1581EE;
	Tue, 29 Jul 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hz+qrJgA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFF2A1D1
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820247; cv=none; b=TGwEjpjYV7ITxPJecsaGAFN/4hb8j+jOHtB8LB6y9v1CN8CaE+bapmdGO69HHglTodi8nnMw0gYTxY3ZAGiwAhrPL75fPYdeKM7cYUO2ci4UQb/DO3pXLqshoVHeDdaeGdiF3RvvzUNvNsFe1C5+J2M7vPlsdDQSFe2hjeBwbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820247; c=relaxed/simple;
	bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmVYtAt0ruks6TL6rhHSnp8j5cGN5LgtzEa5PYJtjC1LntNO12g7hMAflYRsXcQfAtT8nKkszZrThaKmO4FaN6XdxcbF2yUkz9BeH8WJYSc8VjPLms2lq833mciTRBOQYqUeEe8fbZAzwgdAwXrNqfIdwjzu4jvQbWb0zIzJ5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hz+qrJgA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61557997574so362861a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753820244; x=1754425044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
        b=hz+qrJgAk9W297WtkxuXqNM/GUn7mOcrFPD/xijgwi3t6XZkISD6xTronVpcc6s6cb
         MYrJKSXcg0mwD5nh1iS6Ov0DdvfhuLmI/16t25hvwa0ZmzQPaIohB8W+aA3CjHlz1lvb
         CX7QHXi9oceNp5fsSN8TDPP6lHofLoQQT2iQZ30NQNpwhXDhcBzdy94cWStWl9NuPaDm
         WbR5opD4LnBLln7M/LroyvLC+3xmNY5pBXIyTFRPT9aw6vA5VY6xhxR7mbXWpe2RHT6n
         1YpRupn6Ktm5fR2BTxZRg8z0+ICUGFm4l5aR833kY2nEkN+zih3q+nojSDBtir6HRNI2
         IbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753820244; x=1754425044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV9Qd8VswLll4F/W1lnqlWzljnHTNQ+aOkT7Q5f8HDM=;
        b=uaB1hsbeLmxJ+A3pVHkV0fm6QRgXVepBYRHLezpgv5nKmHJ+2UDRJE/Gr9fsFscJKy
         A3C/NdUCXKTNAtIwNvBrd37qRtnE6zV8zj6EniGCGhl/rS753pSl9UvQqm3QoH2lPuC5
         kKr9+PmXOW2ilx0jkg1aUZKH2sQMn1og38zZo2LM2qV+anmb19K++2cfefw0Au2sDu6M
         NYSlyK/TVN6OF3td62iq1YLaBggTQPh2tgBr0s0lKIy0DppIDTTD1hFnG1iOVW3Rerw+
         osCD5fuhbXQIG3dZUHg7XllAyxM4S3/mPJDoqBuJ/5X90RDdxxdAnWSFJVodLQqP7TtL
         TIgg==
X-Forwarded-Encrypted: i=1; AJvYcCV2+g40GxwSDj7pb6Jafrwr0kkLzFUtM5qmYeIfr3G+n0HRkosTpALfgcagA4rMnGyLWf20AkWEV5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9p9lNKGCMyoGiqg7wnRlxw0qfNCspI7Odvn/0fVhqOJJPfAk
	jSLYdtgI+4FnLaNjmz4MiC0wEEscXM4EPG+yMuXwKh5U2ypwuNDDEoJFo4+KIN0K44M=
X-Gm-Gg: ASbGncstcTnxd2dujk50bNOj5l3UIrl78PJNIRPLO9A7rO5P3rremp/R8V944YGiALR
	DORd8JruLYgmniPYXjXY7bpnUhXKeLm/qGxOl7Sjd4elzaONqDtQY0ErWAPrMSL2kpJRVimAg4s
	wPto2w3+rdWHoVcS0W2Eu1mh8FyFtDx8413UWm9bDmZC9yHOM0CxSxa49JAJa4Ue9Ze0R8X+AuG
	AzmaQa6sJOD9EvoEdrcNxWCrRsqV78nRqYQFsbvL4pEnMGkYI7K4LfUBhp8F4i7r3IMn46AHwEV
	SR2/uppKvxEeJtADJXRGHGQ+Zc155gB5qV1yuavayGSpJdpnPzQAJOS6dlCbYrlhN3rMF56rjcR
	6tJ/RpvQZVNpP9fZ1981BPgKt9ONxPuf+RnWnZw==
X-Google-Smtp-Source: AGHT+IEFcub92jjAML4HPfzljPRcZ/77M1VzhjyaMyYsWNiY6ZAsBgO9tT8uZc14CT8rztQkaVJldw==
X-Received: by 2002:a05:6402:3595:b0:612:a77e:1816 with SMTP id 4fb4d7f45d1cf-61586a81e8emr904905a12.0.1753820243958;
        Tue, 29 Jul 2025 13:17:23 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61539ab9188sm3192426a12.26.2025.07.29.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:17:23 -0700 (PDT)
Date: Tue, 29 Jul 2025 22:17:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: FLAVIO SULIGOI <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Daniel Thompson <danielt@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <lv6otiqcqa434anam2gx4czhh3jac4stlkl6w5aasqlb5c2ohj@mzvf4gc2bxsz>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <PH0PR22MB37899F7A6262C599400AF912FA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndpangs3ennqytsz"
Content-Disposition: inline
In-Reply-To: <PH0PR22MB37899F7A6262C599400AF912FA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>


--ndpangs3ennqytsz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: EXTERNAL: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
MIME-Version: 1.0

[Updating Daniel's email address as the linaro one stopped working]

Hello,

On Mon, Jul 07, 2025 at 03:44:25PM +0000, FLAVIO SULIGOI wrote:
> > the first patch of this series is what I really care about: There are
> > hardly any drivers left that use pwm_apply_args(). When all of them are
> > converted to not use it any more, I intend to drop that function.
> >=20
> > The 2nd patch is just a change that I noticed while editing the driver
> > that is IMHO nice. If you don't agree and only apply the first patch, I
> > won't argue. It's an alternative approach to what Daniel Thompson did in
> > commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> > backlight_properties during probe").
>=20
> I've tested your patches on my board and all is ok.

@Flavio:
A Tested-by in this reply to the cover letter is understood by b4 (which
is the tool most maintainers use to apply patches from the mailing
list). So there wouldn't have been a need to reply to each mail
individually.

@backlight maintainers:
This patch didn't make it into next yet, I guess it's too late for
6.17-rc1 now?

Best regards
Uwe

--ndpangs3ennqytsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiJLE0ACgkQj4D7WH0S
/k62qwgAnN30pyYbtWid6YYqnkI/SakoRr8lH8xnQ7FpBuTLizy1TJ+Rq5QPBW9G
OHoyHIkdXLY98NluE1dEAL4OhwsHkKOtuU2LUe+d4tCvANSdr3dSuqf8VGkwtrvH
hIVM2oiS0gGNdfvBHmEJ/TTd3Aw8bif3F4L2zkwmOGruxi6eAkh+TXkOXHkBZNXJ
wdY7mjnO6XkXB4OG6cUvX0N01zRjxtT6Bv+NQcLqnQL2n69erh9XmFvgMPBwA5v5
aPURv9W38wM/QTCGrs0H56lnCFFp4FJy1w8P7CUnSjnhvqhCs6KbyTt1VD7eFX9K
MXDbvP6A5jwrE/7msBl9s7d6MIVqlg==
=tAXd
-----END PGP SIGNATURE-----

--ndpangs3ennqytsz--


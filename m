Return-Path: <linux-pwm+bounces-3085-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04296B2E4
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 09:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7511C21E42
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E31146A69;
	Wed,  4 Sep 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="taODg3Gf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCA146A7A
	for <linux-pwm@vger.kernel.org>; Wed,  4 Sep 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434964; cv=none; b=l1UA9Sr7fjD5hagbJGlroKxMiH0hFhpjLC3qYeGFHicUwx4axYalq1fImLcvMuGctrPrxo1T7UDVccBRB4UogxwF9P1ES16J13XzGwC6dLBCOx/YS0/GvOOSaYVVzq9Gz4LCmDozCUVgofvIL8yqDwabaH3ncFobmdeTQfSuH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434964; c=relaxed/simple;
	bh=wVqp4v2MBbpPDtmMTUzr1XWAIzt4DFlG0jSkVrSLnqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6mVvIM8VZYeoQaXqsyO70bDXIBLxXlAQU1VDG0ZJERierTF21A+TBY9MRhZFT0rLhN91n+Uu21GlLNlq3OxR1PqqbooRlRCjRyqhwWFB8pjttfo5W9/fqygToRV9hpeNpf6ubuG8NlqtQj93uKXkoOcHo2ERix+wtKijIueMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=taODg3Gf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86acbaddb4so746530266b.1
        for <linux-pwm@vger.kernel.org>; Wed, 04 Sep 2024 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434961; x=1726039761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRHS+Bb6eRIluLTOiJWMKc8/Fv6pjoKNuk2bUIZvIl0=;
        b=taODg3Gf1oJEBFcHixAyKxdaOBOO7uqPTnNAQfJcsUpRplWmmY1pMvUtWMRYnU80zP
         ekd8q+yXHTiK0WN8VdIsdbwhrdPV1uHWRV7mtFaXfIaZ2AIGt2R9RxsDTDvH3VOQVk3I
         sPXKebz4DQxjvolr//E2+VGS0NkE9T6H6aqthKvRhZNtn/o3mMjzcdq1Qmdjl9ZY1E9v
         pTY2pT2zBP6wg0yUYP6zW8UeCpRNebkY4gVmrXJ1xUldYl0DKKtLz/koyftzwfYDGEJO
         kNQN4mN0lneO+k4t4ys4CLcyo+/8d71urruGPsBJWjh4dlnc2TrlJixm44wOLZM53Sbl
         8Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434961; x=1726039761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRHS+Bb6eRIluLTOiJWMKc8/Fv6pjoKNuk2bUIZvIl0=;
        b=QzdMjDIDkTpcvlRf9UXs/LL5krG4kHJGlX0HJLWuJ0tu5Cq0Xhg42x70Dkm4Vwv7+s
         atVN0ff0tDN1qXe3pllRf1W6eN+GdlHhTwFdoeti04jdDz4BIEJMsLnqAna3R03ZR/f8
         ab/2FW9/p3mxP+Yt3p8p4tp3R7PBj+n2T/jqF8uw2uDg7Ud6L+/de2qSsTi36+hvIar0
         HjbKy1vz5Qzt1o+ZN/AZ5EMW9PC4bemewMH2iSgbBYxlRFRcGuOf8xuKcjkD6ZWXJ1Jw
         aDs9ZWe/VHB24IxYDQNf2nRTmQq05q420Eo8URNlyZlkA1psdQUbNUgoTfprAI2KB58u
         WMOQ==
X-Gm-Message-State: AOJu0YzGUizgLgZ0811U4+rDwCAlDAUmsNIxVNzxMIfzC/jYDUDNTcHX
	rlBnx9Nkh7z471Bq8LPJWTLscUasaBW2KCBgEjZLijfGgUj0x9xOCRZFK4RgPsY=
X-Google-Smtp-Source: AGHT+IEVwdmEMJVoetmAC9YPNHzK4Idsj0Gqqr7YvEFcwYLFtxKeA5QngTdsELa5sUMMT3/3MKhi3w==
X-Received: by 2002:a17:907:7ba3:b0:a86:bd58:ecfb with SMTP id a640c23a62f3a-a897fad6fc2mr1481779666b.66.1725434960732;
        Wed, 04 Sep 2024 00:29:20 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6bf2sm768695366b.153.2024.09.04.00.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:29:19 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:29:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Use of_property_read_bool()
Message-ID: <mwk24tc2fr2rwe2u7ynulxgjx5butzs6nuykxulx53vmhauczp@we73jfksuqpu>
References: <20240731191312.1710417-25-robh@kernel.org>
 <syfawfdkulanw7kile7qfg5qpfzakaqolh2qkjqwyarskgg2sg@ond7ytjil2yi>
 <CAL_Jsq+GVSwiEVRRcN5xL7pgOn7rRNLsWU8s-5ByCP4rpj9JGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6kbcp4flba75orsl"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+GVSwiEVRRcN5xL7pgOn7rRNLsWU8s-5ByCP4rpj9JGw@mail.gmail.com>


--6kbcp4flba75orsl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 02:19:01PM -0500, Rob Herring wrote:
> On Thu, Aug 1, 2024 at 3:41=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello,
> >
> > On Wed, Jul 31, 2024 at 01:13:03PM -0600, Rob Herring (Arm) wrote:
> > > Use of_property_read_bool() to read boolean properties rather than
> > > of_get_property(). This is part of a larger effort to remove callers
> > > of of_get_property() and similar functions. of_get_property() leaks
> > > the DT property data pointer which is a problem for dynamically
> > > allocated nodes which may be freed.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Looks good to me. Unless you object I'd apply with adding
> > "omap-dmtimer: " to the short log.
>=20
> No objection and sorry I missed that.

No problem for me, applied with the mentioned change to the short log to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--6kbcp4flba75orsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbYDEsACgkQj4D7WH0S
/k4/JQf/Wb1y1an5zKhqlLV7e00fnKeNYAK6q58a8bmCfNOiNQETeISBAI4mpPMz
QLw3hCk/gwnZoQEvuSwxWY8CnS4MYu8+0EAfd8PDLuJ606f7YFCCkwbmbh11oFU/
Xhy5LYD2WonPdxp0h5sobFuCJZn3wpTfgORjRP3x1mgsMkYlwZptc8p9sQXyx45o
hXMmcpf5Gp7KebNiNQr37yaxTKA6WRUhZuyn2xedlFwKtfOUGV7l46RMtCISswLh
XqZ5tilFHl6kV7uflTTrYGNHdBT524kgi/IB9W4qbVYniQ9y6YkhcDJMK5qMbYlO
q7KzDUmGkF/1+y0htXoekvftydCHIg==
=DwkA
-----END PGP SIGNATURE-----

--6kbcp4flba75orsl--


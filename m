Return-Path: <linux-pwm+bounces-3428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA998CE57
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90A61C212DB
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06084A40;
	Wed,  2 Oct 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qE2tqjpl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6181723
	for <linux-pwm@vger.kernel.org>; Wed,  2 Oct 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856184; cv=none; b=mFCGKaLyXpr/3AbJunvgliRxRDXzHoDevEp8aXkw4rGKvhNe4/bbtc+UX6YLt8Jz6loHbq3jXaD2XujI4wqyww3Xzz4gZP3BvmFsS1H6b/DFJbXN3TVq/nCj0zeGDMi9kENcoQSKQUslEb9CZAq5fF35GWu477L/D1z+Sv0OrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856184; c=relaxed/simple;
	bh=ryeKUacjvqqQUkwVPydYYH5r3fymWIkSLATzfrwZqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1xGF40fWJfy+V8MsVZBNGIvvNs9Z3tbKAaTgsX3Bifx4HdlnTNd5ToKOXb8pjEaBPS4W1JrjhgpxsnIGeC+Zkr+slGlV12dB/Rc7k/fpHqmfWJrf/UfZH0y/PsaHg5e/7R1RoFGeneJ4Sdu1jEa6hmBnE0/gVv9S2SAQvk+sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qE2tqjpl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso137157966b.1
        for <linux-pwm@vger.kernel.org>; Wed, 02 Oct 2024 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727856179; x=1728460979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdcJyRPpVgyLrAYHhcOHffwlDloxz/bcgIEwIdRrCLc=;
        b=qE2tqjpl2Pv2vlPwvVAOn9wejUOxhk82zXROn7tQJ84VR71VZ9KCLVyJ/hiHAccuN8
         7rda/BfYWfMjTQSo/yB0So43ygyJY50zsS2vcm9p6fKfKJ8MSXiNtLmda3kz/g580Dov
         DjHjndiTH+7DRgMy/lYox+1dgj/74jVi4dIRgfRJKpV811BmcLti5uAUn0MwOioquMfK
         7iCiI/xXQdt2r/gQo9dzOb19UdexF3gUxgbkegGpMOaoDJCiTroF71t1nubR619GIBAr
         2hr6zFXr3UpkeprnNWUf8Wky/c8CXNYhwX79X+Kszt+/W+WuxDD1MRa03+weCxe/eGMi
         dv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727856179; x=1728460979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdcJyRPpVgyLrAYHhcOHffwlDloxz/bcgIEwIdRrCLc=;
        b=Lu9W0cxvuReD6tzqARD/Gb0w6Vx0s0YIcqkvk3+0HuVqpXG2SgF7aHU6EB/hVJ8HOy
         AdVBHWMXWj+FhXdsVPtYRfArcRsApc0B5PvsuvcZZazMWAjEOB0TXkp2gujIAzBAhNoo
         /NyqJ0YjIcl+DZT+Xq9UKntnSEhXyEiSqArgH39AYNTJSCzDqOwbsDwU3UBE1WdOoyhE
         01N23H1MWbBSuIjaIgWK3UYCy+7oTUy5sd6/0t+NQzoSz0qHAlIAmmL4f7+37QRqbF8/
         yjNggImukaYK1za6qUjkovybiydu8LDJLF6DbeNyjaJ8Ri5cOBEFUpeUejoezzYOd7Fi
         wW4Q==
X-Gm-Message-State: AOJu0YzXye9ns1r63N5qP/K7zQ1EifYVJW35Zbls6jf+ovx6fv8sWCf5
	TXlS8PhPe3WNZqAwYhcN1U3I4XesC2IRenIqrcXeSbPSvsQLd5LdfexQzqtljLI=
X-Google-Smtp-Source: AGHT+IGf6A0q+qgQWjijjqt+Tz0p7nyHr8dMHpu1Hkc/80jtLo+MhLmWkP69hGodPJJFwuXzTaJEaQ==
X-Received: by 2002:a17:906:6a20:b0:a8a:4e39:a462 with SMTP id a640c23a62f3a-a98f8207942mr206253566b.7.1727856179420;
        Wed, 02 Oct 2024 01:02:59 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27770desm820149366b.32.2024.10.02.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:02:59 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:02:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, Kent Gibson <warthog618@gmail.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/8] pwm: stm32: Implementation of the waveform
 callbacks
Message-ID: <wl4wpipx2jaixlmdjv7uq5ghewwid5wo6gpmz5bkqj5chnu3vc@6bougxe3rzbx>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <332d4f736d8360038d03f109c013441c655eea23.1726819463.git.u.kleine-koenig@baylibre.com>
 <b0199625-9dbb-414b-8948-26ad86fd2740@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lw6wwepyh7fx5yuf"
Content-Disposition: inline
In-Reply-To: <b0199625-9dbb-414b-8948-26ad86fd2740@ijzerbout.nl>


--lw6wwepyh7fx5yuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kees,

On Tue, Oct 01, 2024 at 09:17:47PM +0200, Kees Bakker wrote:
> Op 20-09-2024 om 10:58 schreef Uwe Kleine-K=F6nig:
> > +			regmap_read(priv->regmap, TIM_ARR, &arr);
> Did you forget to assign to ret?
> > +			if (ret)
> > +				goto out;
> > +
> > [...]

It seems so, yes. How did you find that one?

When I create a patch, is it ok if I add a Reported-by: for you?

Best reagrds
Uwe

--lw6wwepyh7fx5yuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb8/i8ACgkQj4D7WH0S
/k4LjQf+IuQXl7qrFJl9cpY+KX3OCGqk4Jj7v5/cv2R0jEn6bCZlJpgSxmPU50ir
C7H6qhNKKrGXivDS3CqeFFtbzDKha7sk/SJkRGFfSsFNawdAtBQnV//VzdNEFEEL
/NWC4hzyTo/Jyji5UuSQfXalLIoBK3fwZ1I0uC9nrbRvaf4OEBT3ozo3TqsHU+64
JgyOsypiVfgH1V+QGOFj9LcqE3QIsd1f1fdvYx1snilU8d8r9Ky8FDvrtwok5ELX
b5kny40D3wAg1LKC0iMa+aP0+4bNz1XU+PqsoY8ogtjzPLYpeuBI+f0kgCXW5nYM
N2K+48tvR32EiZkDqrBQmYMlXWuAKw==
=Fe7s
-----END PGP SIGNATURE-----

--lw6wwepyh7fx5yuf--


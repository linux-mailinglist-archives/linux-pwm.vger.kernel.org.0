Return-Path: <linux-pwm+bounces-2977-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45569949F96
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 08:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CDBB230DF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AC1990D6;
	Wed,  7 Aug 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R2SG/m62"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF95198E99
	for <linux-pwm@vger.kernel.org>; Wed,  7 Aug 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010670; cv=none; b=SZPMItyp7+CeeSKvtauawfIyiKxfBohhu+dZbYUVQlC8U8kTKrvTB5Mzy1pQtme//zLoANyVh406wgFjvlfzogVd3cmD9cKfNiLxhOfI2l+mLCLFs7NvC/Uy3MMOOIxjR04R/bZuMLMkIQuRVIEOOl5gzVG/JFdYgRYk2O1yRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010670; c=relaxed/simple;
	bh=DqK7/8s7fk2ZpBeRKSQKz8PUpbmnimcX4++4g+48sos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh3r++i0HqWPM9EcMr5AOEPpFbUl+2fiT4jwQB2Q72xw6jREnkBa+aaDrHsbTEPgmAaVECJVvC8le1RZYYZ5hnKVj/J2STDO8zEMk8OsqHx7FkkrcWsEX55aohqltL/E8sZkofQ229avA5XtxK35MLj/ePzsHaN1JoHee6N1eD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R2SG/m62; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so1561203a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 06 Aug 2024 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723010665; x=1723615465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMv2xpIxwtsAQlfhoQOnGF0CdWu52UF0V/oClSiw2DE=;
        b=R2SG/m62tHDcRBdMXXcv1NAgwGCVi2PjUE3LWX7oHsX7dKq4paq31tvdmosDwnvgqq
         QWsT9T0EOtt1AP5R2FAMobwJTKqVXU1Vk2GObW6Er4o0VHzUd6NnIM4KKaXgGjA1tgs9
         GBoDq/K2/2ndkAWkVecd8v74k2VFpQfZ76U3xN9gdz09mBVH2KyMtEC9z0vpmEW/BXKn
         xfg1CfDkp8cPh2faQDYQ47ijpF3lBTQxd2lITC9PttCy4PP6+MQgC7Dz1WYXw6n9AAWO
         C7MKJBooJY2MbqqxFSLaPYxkQ1jn3hRAzyrPjx6pmPfDe0qPmtH26F4u+7GWu55qRBvK
         CC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723010665; x=1723615465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMv2xpIxwtsAQlfhoQOnGF0CdWu52UF0V/oClSiw2DE=;
        b=Pz24Z+Gw9SVIuWisVKxmCdYXSH7/rTyRrybN+70PED2qWXosVMSq0oI6EtXQME0SB9
         ZhjZggGdYPJ0I9QKPpzG/k1dR61BzjKy2H3VV4yjUTuHd+0w786bbmiT2a5lxJXDnDuJ
         u8cWqCi/LvgPmGPQM1xkVTQfHfUe03ZRmrfq4EsUJfHUvNUpwpNHJNCckx8SqVC46pAa
         dV5WNx/PtkDAO6oi0iQgxbSPq80AZhVS2Bc0yw50srmEwpodg75tjjBZco98UstY/D9n
         DqHvu4/EdfPsFTz1kU3ZmcPIGCFHx25mKAWhV25Iq1C3BF4G8SJv+mojvaUpou24JSRu
         5Qww==
X-Gm-Message-State: AOJu0YwlaKKanjtFbDjuD4f19u5VbnX84S/DvTEMJT0kfBvHYTlLF2Nf
	Ac2svgM0sVVrEOZFfvB3MEie/dzU0oSdzwY/2OhiboMl1FgEUS1EhTXiJwtwlGDzLDLi286O+Rh
	D
X-Google-Smtp-Source: AGHT+IGFvVpozgRMzFOnxaYnjvJe65N8y/zahVwFmzQA8gTUIM/Rd98yXjIwKBkU9Bt7HPYpempuEw==
X-Received: by 2002:aa7:d755:0:b0:5a1:7570:8914 with SMTP id 4fb4d7f45d1cf-5b7f3cc6926mr11856144a12.11.1723010664447;
        Tue, 06 Aug 2024 23:04:24 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c23ff6sm6607375a12.31.2024.08.06.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:04:24 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:04:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <thicnbomf7hux32cx2e5fzd2lpo43hiuaxmxw5tdsppet4hx5j@r2y5cobt4hph>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <e61728fdc9e3c80c4cf6961883754095b604a399.1722261050.git.u.kleine-koenig@baylibre.com>
 <20240807023433.GA29189@rigel>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qxlt6fjbeqvdaqr3"
Content-Disposition: inline
In-Reply-To: <20240807023433.GA29189@rigel>


--qxlt6fjbeqvdaqr3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kent,

On Wed, Aug 07, 2024 at 10:34:33AM +0800, Kent Gibson wrote:
> On Mon, Jul 29, 2024 at 04:34:21PM +0200, Uwe Kleine-K=F6nig wrote:
> > diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> > new file mode 100644
> > index 000000000000..c89ba3e3def8
> > --- /dev/null
> > +++ b/include/uapi/linux/pwm.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +
> > +#ifndef _UAPI_PWM_H_
> > +#define _UAPI_PWM_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +struct pwmchip_waveform {
> > +	unsigned int hwpwm;
> > +	unsigned int __pad; /* padding, must be zero */
> > +	__u64 period_length_ns;
> > +	__u64 duty_length_ns;
> > +	__u64 duty_offset_ns;
> > +};
> > +
>=20
> I would go with __u32, rather than unsigned int, to be absolutely clear
> on sizing.

Hmm, the upside of using unsigned int is that it matches struct
pwm_device::hwpwm. To the best of my knowledge all Linux platforms have
sizeof(int) =3D=3D 4, so a change would have no effect on binary
representation, but only help the human reader (which is good).

I don't know yet, but I will consider the suggestion.

Thanks
Uwe

--qxlt6fjbeqvdaqr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmazDmMACgkQj4D7WH0S
/k4f8QgAs3AipkbNgMlvsYKmKrimlZt74trwcW8rEOzhHW0G51Z0VVWiClsKcowT
kWDuopauLk02MyxUA0jqm0q5GZySXv8ERZmsj+NU3Y9WbCFFdcgxGv9/YGiTlhEh
uarkkoc3gj6G01aZA0mrQAABEt5cQFkOl4BXEfcceCDfs9swC38yWI0yzZq8WHjG
0sOHJnzK0kfZAbnui67XXPUD2pQd4MFQv0pckfIjoF6frSsEb6+3b17ekZfNDoaT
4Vd+x5R10O3BX6GuXBdCDe7xOqVXvWmhRqtHZZcFsuaL87QzpFVCmYwplbzDa4Pe
LKVNMaAoHK+hSOaj17txvoDAa3fBgw==
=gRIj
-----END PGP SIGNATURE-----

--qxlt6fjbeqvdaqr3--


Return-Path: <linux-pwm+bounces-3081-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0696A41F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF321C24132
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB3418BC17;
	Tue,  3 Sep 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2xDt6aZG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0818BB9A
	for <linux-pwm@vger.kernel.org>; Tue,  3 Sep 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380417; cv=none; b=Qsiui1HRIEkse385TxCclpZ0bMFwP8Gzw+rBeWHcxBUjORYWevoTWysrSMmVe6tPhem6cPaxVPW09cvVlDTQQmzIE6/rjRQavaT7GEnM+2uQysPh0rlwk5J8k5/U7iz3QkdtvY5i8CvBT+q3k7b90S5Ijn3oZ0yC8YwZDnNKqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380417; c=relaxed/simple;
	bh=H74pYIhXSdOFwMm2aJy9P2vz5eCGVW8B8NAt3TGxtpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwR4oqD4DrkS5P9eoIxzclyq3VBszxVb/TSOS1CHgO6CIyk2cZefBhraihll/vNMN3hqBqi5HBvg4DuDMgFoolOTlADAzrZfl4wJ/hnSP5n/9JYG3prfPgX0inkMDTU1dxCbml8rIQdRgKdE6JxdpYgzO7nVDhI9fUaotkmcw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2xDt6aZG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso884881566b.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2024 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725380412; x=1725985212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H74pYIhXSdOFwMm2aJy9P2vz5eCGVW8B8NAt3TGxtpU=;
        b=2xDt6aZG6POoEJim/Es6+VfEgvXYihL1Gq00yhUe5jbP9B2k9oKNcLx0fUvobXHXm0
         qqivlVmZUO0ykDaxLGUHJ7ugtJYkBc4V9+HwXMA+8h2RP4/dm+Fq6eGk1fuKzWGxFlv7
         PKdnE6B+gE1negs2ZpyQ02qrfMAnkTr64bWFcDPY96D4IMz9blXNmuSQEuIr2lAcf+qr
         IQQGS2fpisIbonvLwlWZA5VQiPKSOuq731iAfxscJ6AaBuFAzLwIzn0ctNV9uNhqZ7uI
         VFTTIMcMN/uEvuih0Zz5aMoLH64vyVgTS7LzR3YX+gIHlcpTZ81uuAKiWuVmZG3qACND
         h7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380412; x=1725985212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74pYIhXSdOFwMm2aJy9P2vz5eCGVW8B8NAt3TGxtpU=;
        b=K/BFmLaP0nVLjtTtiNVLtNoS+MPoQVQlhgFxHbEOGEgT5K1V0gl0u2Gshq7+rkaZ3W
         M9ER1AfurvT069ssLRgWSiEJu8sJoHADp5a8d3GMM9ezwV9htBqsMD3/vx/xt0Q77rQD
         6FkgmHCORUNeWYkjaAR6FFuQQxsUiAEK5E5XDhllNIZ12pvfYCpn2Ms44Gyx0bzRfna5
         3Qy/Lic9RJ1IjsdRgp7V7U1aHmmq+SwTxfDiGwIhLo+9uhy6IHqg/YtuYszpA5A2rcy/
         EI5BNvVq3XFTZB/iBFf0iKZzTneiocykrmHYvQcvtjXAAjHpYgF7ba66JLq2gBeUdhfA
         /sUg==
X-Forwarded-Encrypted: i=1; AJvYcCXLU+xhJcdGw+NLROHWZlqKx0Mmg6FcO456sBa8RhlDSPuEeIYHlNSztW6m3IHseLsHdTPgt3b/owQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxouxgqN7Eb8SP86FvjTJ/Kz9fYqY5xUDg/9Kj5FVjVtmjEDnJ
	S9iDYuNRg/wRgsKZtxcRRt8NSSRIdWovnZocAcsHspyRJoYeyRxHjCuDfsmr6kQ=
X-Google-Smtp-Source: AGHT+IEr5QVGgWbiVYfCs11rGjeX6QjZhxJmrTzkAqzKLetbWL3snVsaK/w2xgyZunk5r3yWMEi8Iw==
X-Received: by 2002:a17:907:7286:b0:a86:beb2:1d6d with SMTP id a640c23a62f3a-a89827a4283mr1958213666b.26.1725380412471;
        Tue, 03 Sep 2024 09:20:12 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898919670asm708945766b.140.2024.09.03.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:20:12 -0700 (PDT)
Date: Tue, 3 Sep 2024 18:20:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liu Ying <victor.liu@nxp.com>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, xiaoning.wang@nxp.com, 
	Frank.Li@nxp.com, lee@kernel.org
Subject: Re: [PATCH] pwm: adp5585: Set OSC_EN bit to 1 when PWM state is
 enabled
Message-ID: <tpjuy3wiaxoowyry5r23ubm5veznenrvdzrqcpqp3rid5hjoxh@yiqctlab32le>
References: <20240826083337.1835405-1-victor.liu@nxp.com>
 <20240826085049.GA23129@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orgfecggc6qxpui4"
Content-Disposition: inline
In-Reply-To: <20240826085049.GA23129@pendragon.ideasonboard.com>


--orgfecggc6qxpui4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

On Mon, Aug 26, 2024 at 11:50:49AM +0300, Laurent Pinchart wrote:
> Thank you for the patch.
>=20
> On Mon, Aug 26, 2024 at 04:33:37PM +0800, Liu Ying wrote:
> > It turns out that OSC_EN bit in GERNERAL_CFG register has to be set to 1
> > when PWM state is enabled, otherwise PWM signal won't be generated.
>=20
> Indeed, this likely got lost during one of the reworks. The apply
> function correctly clears the bit when disabling PWM, but doesn't set it
> otherwise.
>=20
> > Fixes: e9b503879fd2 ("pwm: adp5585: Add Analog Devices ADP5585 support")
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Uwe, would you be able to queue this for v6.12 ?

Yes, I just merged Lee's immutable branch into my for-next branch to get
e9b503879fd2 and applied this patch on top.

Best regards
Uwe

--orgfecggc6qxpui4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXNzQACgkQj4D7WH0S
/k7d/wgAkOCSryP0aa2OHiPimr3aQ59Aq7DHTjNLIsOXmVjJwgRlwH1+QWVuAWpL
1rGSNLnhgeaAARgbXAWnIwcklDUu8Q10slOXg9BSEoY0Ikrz8l0IMuB6TyXPxjEM
6OcXyZz/kdWRQd4lDVKosPmyimSUjaRFHpCZ/kz5Ms8eWWgsvXEtgPDFKccy34KL
mbDVVi+5QuZRraizVpUT6E0c17l/+21wnumsrFcl5HCy6bRFUkVqgOqPQoeR3445
irfbJEmkyOG2dqYjdrJ+hMBbz6/TkKza3ImH1ClXe1q7PYCxOBBUk28D2CBNdJ3z
AzhHsAzA9XMQvcOPjQSAqD7tG0On3A==
=RtDb
-----END PGP SIGNATURE-----

--orgfecggc6qxpui4--


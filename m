Return-Path: <linux-pwm+bounces-5364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0711A7E4A5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A35426462
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC41F790C;
	Mon,  7 Apr 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vaoqre4r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848911FBCA7
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039023; cv=none; b=In9SzbnsJ+fK6VBJR1yS6iGVjbxtIb9Ecgz27V+10027kKaoTp/rfXH+pI0I/3bSsAjGJLRnvEvrPcdQqyYgB3TW89iZ+3VyzFpv8KG34AwjcfS04+WaNj8LdVKCMKg2rI5DEmE4mcgHK8+W9oj5C2rukUXXAs+tfRZDsxUoGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039023; c=relaxed/simple;
	bh=KuijAyV9elDpjy8R345yMaaZw2M3RehdE6ABXqYOG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgRpg048UGEk1vuJ9R7rsMSVDY3hZ2Bu4yELXVe+ZcjROWHdzQP6qj1jFHZ+akC9Y7o836Pyoxl4H7GiOWQejZQ++RZEoQGtt1ecXXXN6VpOZRLeZ1/0k3LSRRES7UaTypamFMx0aWPqAkjcmg1IeAqsggf9AdDafspivQHR7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vaoqre4r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso723668266b.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744039019; x=1744643819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxnBAvpwCrecjAvuTm91rB4larlUyZM1HHjTp7DbEqQ=;
        b=Vaoqre4rY8zXtOO34JfKJ+skp4t6nPIY2DIZrHGGnb+Rq0OcD7GeGDulCCYyVdu7sK
         n3so1zBTjGBd4IjFAi8UZ3ovTFfy9nOXdmJCuvfjgWirZtkSXIxPg3NUbvRbKvXejxd8
         HUSikvxVQNqEGRccU/hCgRM6CeO+XOI6auYOeCX15nRBlMbBQnwC3THtCTLHPF47R/i3
         PQe59tMaeQZE0jjFOE5t9qEBybO+4ktAR6uK++/c/xyEYiQexkcNdfUSa96UWd1zyiAY
         8hhsgCYJ0RWYk7Os5AVDnEHTeZ4RyPjIKvNuagqSASjmaQFNogXdq74SZnoY/pzcrCW2
         kOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039019; x=1744643819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxnBAvpwCrecjAvuTm91rB4larlUyZM1HHjTp7DbEqQ=;
        b=q0bCcsEMr4M+iIH1dy4OYvii057+ynk5Ify4rOro4ktfy69lJTicCU0uT8s6KGU5kP
         9oolalKPYnVRqDgCcmKCu7zcYXlaB19lstHBw8MmONrgP8fsQyuTxuPoly0eYN9uU7Y4
         7KLfrcniJ3VsDANCPJTGxJvwwB3+2koMqvUtI9SYukdd51+44i0jlzZi1RQ1wZEF2V22
         4zh2CsTxz87OGqvrL5aNtooWceZNS2AMoG34AVA0To+9hQRdzJjCoIpCVFZT7+vRjsBk
         T0n2RUypoHkH/z2aOP6c5asQlOejbFOf2wV/pcObvQLvEG86yxFhlFTj2et4A7yUDpqK
         GADQ==
X-Gm-Message-State: AOJu0YzQTDl0aLxoLe2phie+x+Tii2PIKwpGbfXuGtu9HejbdfjxDZiX
	XA9SKQZcurxlPUG4l2/BFJtkrQ5eDiuP9+s7euFB7KzZJoWJ/RmWCGOdXzNU0AI+6fB2+0hlzdZ
	F
X-Gm-Gg: ASbGncsx57a7lhunkIIXn9XhplM95PO/pjkonWVPymwRg5qcT3BzxFUnMX1aVx8X7BR
	Rh5fpk6Ge6YRmjgR1ZPwMHr2j2tFYO9wvwiaZbMhQy6YodhIwz04ADkeUsNOtUaPmoOq7TdmLYg
	xpB1RmKmsr/MSN+F+i7g3VRmEGmI5n0oEMa3shMXpjXsmamS5b8UNkGrV7HiN8yMf8IkEOfuiEt
	R8oPtFzKCr6MKW5FqEIwKzowQw7wRFWnh9YtlaGMzwMRIQnxBb5OugFYY7tlcsNl2cYA+W87DSP
	oJeh3RCS3HxlApVYfroiv5SzoV0Vx7HwG0XnSBiYICTD6czUYg==
X-Google-Smtp-Source: AGHT+IFzTIXbrDVkyQ6AbBiDuE5pSliyWRspT9PlDuGXWQ5GmY7qspmZDr7hbN6PADzz8nJe3cDOSw==
X-Received: by 2002:a17:907:9716:b0:ac8:179a:42f5 with SMTP id a640c23a62f3a-ac8179a43b5mr48095166b.14.1744039018700;
        Mon, 07 Apr 2025 08:16:58 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7c01c2c3asm768777166b.176.2025.04.07.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:16:57 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:16:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH 0/6] pwm: Some fixes preparing chardev support
Message-ID: <wn3ef55yaangw4p5cihu2rafqlm7ckmylner6q5irtpu6yq3cw@tyjieqhlq6vc>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
 <lzwvrhmx3yqv2v2qkpiq5e542eflnnwvhm63fjmq6szh4bh47b@zk4hifurejja>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvxqsbn576kt2xa5"
Content-Disposition: inline
In-Reply-To: <lzwvrhmx3yqv2v2qkpiq5e542eflnnwvhm63fjmq6szh4bh47b@zk4hifurejja>


--pvxqsbn576kt2xa5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] pwm: Some fixes preparing chardev support
MIME-Version: 1.0

On Mon, Apr 07, 2025 at 12:24:31PM +0200, Uwe Kleine-K=F6nig wrote:
> On Sat, Apr 05, 2025 at 11:27:11AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > while working on character device support for PWMs I found a few
> > inconsistencies that are fixed in this series. After that I plan to work
> > on getting the character device support into shape to get it into
> > mainline, too.
> >=20
> > While some of these patches qualify as fixes I think there is no urge to
> > get them into 6.15, but given there is a bunch of such changes I might
> > send them to all together to Linus for inclusion to 6.15.
> >=20
> > Best regards
> > Uwe
> >=20
> > Uwe Kleine-K=F6nig (6):
> >   pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
> >   pwm: stm32: Search an appropriate duty_cycle if period cannot be
> >     modified
> >   pwm: stm32: Don't open-code TIM_CCER_CCxE()
> >   pwm: stm32: Emit debug output also for corner cases of the rounding
> >     callbacks
> >   pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was
> >     rounded up
> >   pwm: Do stricter return value checking for .round_waveform_tohw()
>=20
> I applied patches #1, #2 and #5 to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fi=
xes

And patches #3, #4 and #6 applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with=20

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index dca5d09d80b9..4b148f0afeb9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -213,10 +213,10 @@ static int stm32_pwm_round_waveform_fromhw(struct pwm=
_chip *chip,
 {
 	const struct stm32_pwm_waveform *wfhw =3D _wfhw;
 	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
+	unsigned long rate =3D clk_get_rate(priv->clk);
 	unsigned int ch =3D pwm->hwpwm;
=20
 	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
-		unsigned long rate =3D clk_get_rate(priv->clk);
 		u64 ccr_ns;
=20
 		/* The result doesn't overflow for rate >=3D 15259 */

squashed into #4 to fix the build failure that the 0day robot reported
in this thread.

Best regards
Uwe

--pvxqsbn576kt2xa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfz7GUACgkQj4D7WH0S
/k6YPgf/SN1j5yOtJmC7QVuGTcUlTuOBLQ2qNU8p1Lg66BPQ6jADoLAXq6aILNiA
Yd2vrJGFq4Aiw1p6B2xWwmzt7C2QdcqKRD8qdbDsfR1STaNLoseLs6nNG4PvbrKw
5HI6vqngB8oD4YE1TRq98S9/J0oGXmP9sHJk7LsHRbsVlaZggTLGXHqqc4wxJFNx
cOBJ4o8zEfjytVTIA4E5wYf86/ag/ZjROBWuZTuhzZG57hkeM3rzGnMtT58/8A98
VaEFgkpFp15TF3utVme6ORwWOm1JNGUJYyV67iDMY4h7IawmHHcstQYR5iOHfqoU
jzQYSZKQ/foRNzTwC+xzpVl5326WiA==
=EicF
-----END PGP SIGNATURE-----

--pvxqsbn576kt2xa5--


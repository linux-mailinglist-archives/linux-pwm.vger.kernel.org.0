Return-Path: <linux-pwm+bounces-2708-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7992852C
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE6B1F24BFC
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085DA145B39;
	Fri,  5 Jul 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oLXQFpOg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40C1482F8
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172084; cv=none; b=P27K2JYxizekTXq0Yl4O0TOCxvqArQ9/aGG7SPLlEJlvlZJPMpnrGECAC+ik1Ux4unSC+dquKXR8yzoISaDwz4trDroHbY09ITXAPXR583wJPCc1EOMfPvUxdfjJDlS2vpzWkgGOBHJ8K6p1d7c/Cob7uqu/McWUgwsCDybPsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172084; c=relaxed/simple;
	bh=0gCYCJd+PH5sRYo9OAbZPjQdA2rIUInR4ifX4vO9+B4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXpTyuV1faUvkhgbqgyEjtZoa7SAdJH/uLlACit/ccHVgCb0oKy8Kp2bngU7q8Q2g7rifX/25HoPeFT1QJVW0em0xht3ZuiQqQ0XwfwxZhzCzTquq91nzXMjH/hB+WHOKijcLNSDXdW2gewmUs07e9SjZPtbGnvW4qN+Yj2VOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oLXQFpOg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36799fb93baso976335f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720172081; x=1720776881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gCYCJd+PH5sRYo9OAbZPjQdA2rIUInR4ifX4vO9+B4=;
        b=oLXQFpOgSOxaAwsobmsj3fkwznFDj7BY0K6TVmiJ3xJ1LCj2Oe3ogWLDduzry1V8Lg
         AmBj6MdQck/0FsqWSaSbluS9Q0fRdY25VHT145tm35MU0YcoFkD1vSWejkDBfc/cmhH8
         y2vMmlMt6nXOsl12v6zrGIDOswZdBR5/mWW5NzNBqET9wAoG9XS/vouOrMSjU8qAd8B5
         nwdluGZlfkNLdnBbXlTfQG20+StK86JqwZbgJfFl+2W8D2puPFfPQf3dipkgCye/UTMN
         589/lpajQIUYXylHEjR769+Q9H9dSJ6Qi8B/wUfLTimCilLNy872oXS01qeRyNgU+5SQ
         xPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172081; x=1720776881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gCYCJd+PH5sRYo9OAbZPjQdA2rIUInR4ifX4vO9+B4=;
        b=Pwa2NCy242NlvTdcWMj8247SNvcdN7BeLGkKCVPnxQPfzSU6QB2I00XX2Ng7CRQ6n3
         ZAveOFk1z1jp7mW1IQrLfiWnP7SoH02u8NGU6IMWuI2TNM6M0x1C/iSgMOMFAY0C5TGp
         i+vpOw27NCGGn/GkuLwzdDzXRZXpOzyR+W6YZ/Zd8e7EiU9KD7+OTinzRlLF5BEIseT5
         UQgCee5kw0PnAjHUIF90uyUllV6xzgyduf26b4BVW2KJBCsutxXx1EAL3JiaYbSSuMpN
         q1XLp27aA6t+G5XBCh2gSlfR1Yhj6tg7H7tqyPBquMpEkHhEDwip9QS5hlBRn2EzSAaQ
         CVuw==
X-Gm-Message-State: AOJu0YwgfFLDyJVIgC2ZkKBhxjBfxKQz1oYSpifBGG2YpK5V2pRFGuLw
	00CHAxbGm7T8n/WdEWv4a6EYSxsFljrN/rGxypzbMHRfaiqQjgHVxx0NpRm794NIb0IHnppLnvM
	S
X-Google-Smtp-Source: AGHT+IHkTArS6BQTg1AUyWkEG6jmE2rIOP0bYapy57OeAph3IJDBh5Y+MLdKj4ZUN3/GzMYXu47nMg==
X-Received: by 2002:adf:ff92:0:b0:367:9522:5e6d with SMTP id ffacd0b85a97d-3679de7ca93mr3143864f8f.52.1720172081047;
        Fri, 05 Jul 2024 02:34:41 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36791d7a93bsm6489587f8f.81.2024.07.05.02.34.40
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:34:40 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:34:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Register debugfs operations after the pwm class
Message-ID: <vjv2c7bbfyw2kp7mcbc56z6svscwcfec7tv5qxgpqpl7y5dquh@cdzvf6ubhvhd>
References: <20240626222529.2901200-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wjhhfwndb7cxtr5g"
Content-Disposition: inline
In-Reply-To: <20240626222529.2901200-2-u.kleine-koenig@baylibre.com>


--wjhhfwndb7cxtr5g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 27, 2024 at 12:25:27AM +0200, Uwe Kleine-K=F6nig wrote:
> While the debugfs operations don't technically depend on an initialized
> class, they loop over the idr that only can get entries when the class
> is properly initialized.
>=20
> This also fixes the ugly (but harmless) corner case that the debugfs
> file stays around after the pwm class failed to initialize.
>=20
> While at it, add an appropriate error message when class initialization
> fails.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--wjhhfwndb7cxtr5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHviwACgkQj4D7WH0S
/k53XAf7BNsg5S6ZtjmhyJQd3IAjH4Eu+3A8dhx7FFO2kTOVAagq6KPgzP9Gj03T
QwWWRGCEuXU2tcgRGJGp7pEIIwguxCwT4fA9ZLsKYAWDlqUWFAqETklELIYaLn1z
nYOJp3BMqZVTpwhQesYWxAyVqf7oDUZp5VIniJqQvQJvfSE5Cq51OBeIG4idgABU
SKHY1CbVVAgW6R+dH5INB3bXCcQ0OIOmcNuv4ePxbqu7ej22BB8Ii/H9VvdnxvEr
95PeAjckCFkCeWd+Ww21PUNdIeG9Y0sWUGw0wjYSKF+2QIFojPu/irmNJY/iZNvd
QRVDBWCWhHUVgxCPhNWWehNRBTFkBg==
=SoTA
-----END PGP SIGNATURE-----

--wjhhfwndb7cxtr5g--


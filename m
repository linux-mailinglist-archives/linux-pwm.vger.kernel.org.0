Return-Path: <linux-pwm+bounces-3228-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C56977A4B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD04281E8C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7D1B9847;
	Fri, 13 Sep 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajSp0G3I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E47581B
	for <linux-pwm@vger.kernel.org>; Fri, 13 Sep 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213795; cv=none; b=Rxq5vCXWOzvObmq2kCJpzJjj4OjFzrDM/mbEWjFU+2NR4UjuCr1vkFk9+nD2quM7LkohnqpjnD9wqxsG1SMMo29JLaiQbQ0xheotsLRQfmQRRJSAmC1Gt7kal6m96OqmdJUIWXeI3Iw69i0kqdRAT8cGFVXm6bLU8elbrnTVwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213795; c=relaxed/simple;
	bh=d6zsnM/knWuhWRTJbnRit/W8yhma5FuughHftgaJJpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUzBt9yIFeGABXqVwkALHit0+1mjZyDu+IJ/omzjsBPgVXpdfLS1m6xiJQSc0e+Km6PcXGMZcT8AXH5HRYyUzSj+7bGuSpyINUw3P5KH2mOG8yyTOyn3Gmiziz7U7cQ5/NXbkeW+3x6smPSSWjgQCFjB+JQ5+yicRBQ6ffuFMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ajSp0G3I; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c412cab25cso734606a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 13 Sep 2024 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726213791; x=1726818591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wa1ITqdE5/BK8kA3fdLjh8dVT7wr8VufQbhlGlfKuFA=;
        b=ajSp0G3IrAnphgfmGOGn7W3zg+N+b87LwNOeVRzN3MjRzaiZD72YbNzOVtEE3CXld2
         Q2laF/IzzKW36f/RCXz/pUcIUptbg4p7W8rTA3A2kWacbFUpCdQxTYnSFEvU1CtyR9fy
         JvQv3EvoBwe6oGfDQc9oGp8vI38eOfvyz0n/8sdTYoFPx1djGy+m8aKb/UkEs8csiHYO
         CE3vTdDqkRUGslkWlKBeyjdIBJcD1fMhu57IzIS3i/K+4xGl+ZDkydiC5QLuVIducHsB
         aHm5aQPeN3nh9SjOgGnOwm/GgtrUq+pOjzV2ufiplFy26f7UpoLb9m+8VsV+CQHMRdVn
         Ghgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726213791; x=1726818591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa1ITqdE5/BK8kA3fdLjh8dVT7wr8VufQbhlGlfKuFA=;
        b=E41AvHQeLyotN3F6H76bzxucuVad3Ypz0hhn6fk3mdOpFpkZ4wN/06j2XS2NNCjp4q
         A/oQN1k0LRHi5Gj3zY/bzma6cVVGrbJwp/YVWwcf1Zgge8BglMECftD8LUHvV1Q4wOM5
         4S2vj9KcY+EQNf+4QFQmca6dfsW2xjs0Cb9DOFzR402uh1ALJHcVKoZZzQ/Naj8zpENs
         jCkw8ots91Dr7Bz6GeHj5zm7ZECRwOl7C/Z6nyEuZDB2kdhptDkv5K+TsQqUBtf0K/k4
         iW9cYHRSxgo0OHjOxJf9laIj9edjPVS7gt53htSlRWTd4KuPU6dlQgbaPpjPpyPT/7cE
         WHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWDuLxaLvS/5FoJG1ggH0zvnVa2BfgzC4LcD24qaxHnvor1P5Je+KJ2NQEe5Oex/ycAIEeEG0ctZIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBszOsOvJdBQyrmNAMEYzXglTlR70h+qMZH03TQT21HxUwTQP
	h/glp/snvx88YJVr4+rUIBWhOunDxcACujEdH+kJ505/Guc2iUgyx/yiQr8XGNk=
X-Google-Smtp-Source: AGHT+IGNol1Ptrv5HMztO+XGTt6sF30N0ildaSdHGkDcLQdc26QC+9nMuku9fBuokfORM931FkSPTw==
X-Received: by 2002:a05:6402:1e90:b0:5c2:4dcc:b911 with SMTP id 4fb4d7f45d1cf-5c41e1b2531mr1444970a12.26.1726213791184;
        Fri, 13 Sep 2024 00:49:51 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd42620sm7231754a12.20.2024.09.13.00.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 00:49:50 -0700 (PDT)
Date: Fri, 13 Sep 2024 09:49:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] pwm: stm32: Fix a typo
Message-ID: <hecpzmymii2aoqc5lgkycmxojin7gmrtyd3wnmhxcgeklnioky@vjkxayxmswzc>
References: <20240912124944.43284-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="332t5ftlx4yomxqi"
Content-Disposition: inline
In-Reply-To: <20240912124944.43284-1-algonell@gmail.com>


--332t5ftlx4yomxqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 03:49:34PM +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
>=20
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index f85eb41cb084..eb24054f9729 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -222,7 +222,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  		scale =3D max_arr / min(max_arr, raw_prd);
>  	} else {
> -		scale =3D priv->max_arr; /* bellow resolution, use max scale */
> +		scale =3D priv->max_arr; /* below resolution, use max scale */
>  	}
> =20
>  	if (psc && scale > 1) {

Oh, that's an old one introduced in commit d66ffb91c374 ("pwm: stm32:
Improve capture by tuning counter prescaler") in 2018.

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards and thanks
Uwe

--332t5ftlx4yomxqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbj7pkACgkQj4D7WH0S
/k6oEwf+LVChmqpZHYi9IgqxWAzp4xco9NwQ1aT4QyzvcrFPgE7d19tn9zTdxMzg
o3OTYwnhSwgIXfYNGkvu4OOjjhuivZqLJTgvv8W6foS+s1unjMbD65u+nxfy7ih6
YBFF1s5RYjPvVYh3cOhdwQ7HDR0V70ROQzOMtMvOlSqvS4b4zqYKY6GvxOW5cxsz
5285CZZJAZK0dH9W4W0DDk9vkcfflnGeqeBFzL50iFf7cssTGobrJ+Unyrx2LmSx
RiULRREupUOiCtD7FC3b1deLpNTzkLuoq8VSldVbFDfCvtR8zMUoJUm9BbiyoJFC
IyL+b/z5ypu86BarN8XpL25to2cg2w==
=8Lhz
-----END PGP SIGNATURE-----

--332t5ftlx4yomxqi--


Return-Path: <linux-pwm+bounces-2707-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FB92851B
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A125B1C22493
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771D137C2A;
	Fri,  5 Jul 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QI0/mnsp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EE13665A
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171839; cv=none; b=P6YnLZzvyQl57QKTM/3EdfLRl6x1PceceC99mle66uDW1uJEl4hvRBpub0uOAQtHjcGM1ckPQRdjIgmXQbcO0wG9/HWmNvpOYqRW43hYDr2Mgxh388mmn6b48jc6rm9JOoq1et/ANAawKrVIfFpC6FfJmPRTkYgmn6o8rE0f0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171839; c=relaxed/simple;
	bh=Y9A85uGiNuKmSQluXFakcDbz90Ffy/6QtGj2zmAQeNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGoY2E0o1fUjpaCeP5n+oQfGkS3T++S0aJmF+Jm9ZZo4aisDJECHjNetMKL0oTWlm0uAcIHpXP63uJV/imBRHLjuEoCsPsBhsHIlw+K2HL5DoLIA0eiasWoHG4pVijFEEnvA8VCdw8hVGg5bYNG4jV/FifmVRhlWBpxhQgumVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QI0/mnsp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso2049893e87.2
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720171835; x=1720776635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdO/uS9TwdQzATDumMNwCYuL6Gl0o0WmFiKQpsz4If0=;
        b=QI0/mnsp92x9obPjfHVodPHSHYu6OGvucZ/EBn0dItPIQO8hYRqp/D7h0S+7Lcf8/Y
         pQVJVlKv1VE6KLosHrm1+7DXxlhtO3ptJwXFpaDETVxEGvE5t1izuQ1RfVolAH6vQ5SL
         ct8rEgio6qvAyR5E4mePpAr66HmEc45NI7zPESaXc/yJVbgbTlOP9TAB6nJXpXOsdwxH
         Hob9X73FGbvrpIfKoZd4JJW/b3sfDi9t1o2wLSXAkrx8TNHmqqKn3esHqXO5ClC6Rbzj
         aoyFImxF1uhgO2ekzg5Ac3j+tf1l3Tx2zAWvrxiberC2lbz5YXTAf8pACM5KlzSIuJ/A
         2BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720171835; x=1720776635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdO/uS9TwdQzATDumMNwCYuL6Gl0o0WmFiKQpsz4If0=;
        b=HtvN0cGxkoU86wYHVeIt1D3F3cTpVNqYBK8E9ij4EzUmsnjHmP0ihMUXHUsN7YcZ96
         fliJKMN36DaZt8SKFVxgbHvz9USuMx+BVy+ewlVFgW5LBCdcaWi4BZEl8Ge7E4hzcDHx
         8jBJZ112oXYKyMkqRPTqfsbJ37AO0BIRcY301/mH8KBRWKzZGL23FT0X/ZXiP1zzfdXh
         Qtx5MG33WVP9LeMImNFL4rwQnUIAPJsRE4oOQ+TZmAN1NQSlIy/sIX25hXG8AbQE3cKn
         VFqCRkqYygqKXgmSZBU+xC+d6Fb3VV/fSxKviThbjsSDffMT0G3/rCv8BuFMKx3zrdEJ
         5V7g==
X-Gm-Message-State: AOJu0Yy7gHz9mWPxIderonveOHbXJIzdVxCRlQCcpFzrAcoHY7sWyR7/
	oFT31HxlA18wbDEDkcpTVLGDjNKGYiy0dqBS3UoX8Z55BZG4akW/uOZa9PADxnah+fr8EFuFNGJ
	G
X-Google-Smtp-Source: AGHT+IFFE9kRpbAbmriANJ/2OwvV5GqhlF4QJ9eP1RAen8KTIhyXDDz8eGqxCZVhyLRHHxO8rGKEEw==
X-Received: by 2002:ac2:5315:0:b0:52c:db76:2a7a with SMTP id 2adb3069b0e04-52ea0632597mr3371985e87.34.1720171834780;
        Fri, 05 Jul 2024 02:30:34 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aafba2cesm670009866b.93.2024.07.05.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:30:34 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:30:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] pwm: core: Use str_plural() in pwm_seq_show()
Message-ID: <dvc257dkgpbxa7n43tqd6uin6hyyrwqreukozu63ldgufkr5td@unh7nmttomds>
References: <20240618075248.1325-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkxogwgvtjrgxprz"
Content-Disposition: inline
In-Reply-To: <20240618075248.1325-1-jiapeng.chong@linux.alibaba.com>


--fkxogwgvtjrgxprz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 03:52:48PM +0800, Jiapeng Chong wrote:
> Use existing str_plural() function rather than duplicating its
> implementation.
>=20
> ./drivers/pwm/core.c:1690:6-16: opportunity for str_plural(chip->npwm).
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9352
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 5c1d20985148..141c5003b216 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1687,7 +1687,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
>  		   (char *)s->private, chip->id,
>  		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-b=
us",
>  		   dev_name(pwmchip_parent(chip)), chip->npwm,
> -		   (chip->npwm !=3D 1) ? "s" : "");
> +		   str_plural(chip->npwm));
> =20
>  	pwm_dbg_show(chip, s);

I'm not convinced this change to be beneficial. Given that emitting npwm
doesn't add a valuable information[1], I tend to suggest instead:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..fc7aa17dc6b5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1683,11 +1683,10 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip =3D v;
=20
-	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+	seq_printf(s, "%s%d: %s/%s\n",
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus=
",
-		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm !=3D 1) ? "s" : "");
+		   dev_name(pwmchip_parent(chip)))
=20
 	pwm_dbg_show(chip, s);
=20

If you want to pick up on this, feel free to use this patch without
attribution.

Best regards
Uwe

[1] pwm_dbg_show() emits npwm lines, so the value can be determined
easily.

--fkxogwgvtjrgxprz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHvTYACgkQj4D7WH0S
/k7kdQf/WQwpNKImPI4crrRDXBJQGDCVcXKIzq5hX5frg+HN45tB7g927yYJ6Oef
jINsn4cH8RsNL2D//jz3tJzlmK0g/noZ8/pHOI/hXNbWjZQBXjPzKwCVb+etswow
2NUN7udIkRUR6dOkb04zPD3B+9FnpSTw8zZN++swjWvYDjnYkzav7IC4QQx/PISz
zM4Qq9gg20193QJG3Gs9Fmdhcofj58SnQGtKHvUNw7xTrXg11kBbkCQxdTe68F4W
sIjvfFeYATEHYgUne3O3iH20HRSDgF96/6S8J40CvsjVYRfmRtvCO7hPNQmemNxr
dJOxStpL+CfxL0NUaJaozxizybtK1w==
=596V
-----END PGP SIGNATURE-----

--fkxogwgvtjrgxprz--


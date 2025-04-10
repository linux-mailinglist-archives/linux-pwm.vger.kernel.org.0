Return-Path: <linux-pwm+bounces-5434-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137B7A83BAD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 09:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B23BCAA7
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF11EFF8D;
	Thu, 10 Apr 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FkUvhHY4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65C1C5F10
	for <linux-pwm@vger.kernel.org>; Thu, 10 Apr 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271259; cv=none; b=Clqcn3UNk8KcFylqAgUpJ89yARwifjo02tQW4vbTL35VSZzbgHIuf0jTZr/AFNBxr9Pzv74148LVF87pTKOBxjtXZeJrm/MSsfR0jrETDM58THtvo/YCltJ2UBWmyTHplBHJpyjmcfUBtIx4CXFXj9Hl9W79YYkEvHr9N+s9yXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271259; c=relaxed/simple;
	bh=/X5sejRkDjU798GSYBk8O75ln0uJBCKO7ZpUKofQRsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXFV0VqwgbZIpyovXYO1b68eNNtEopk/VCkT5Z5jGwBM4IGAPiHHT/V8/P3JoJY39uAK7bXIZ/IJJbVGyE+OkVOHpgTuM1ONuRpzgWtmtDY171cNbHNjud8/XBo2qZd/ShmISg08y5eXkn1C2pMuBSCydWJWeAOm8H3gjMrAeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FkUvhHY4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so10924165e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 10 Apr 2025 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744271253; x=1744876053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GN4ftbVcUrpHv9pyw2kRDHI+xH+v2r8X52a4yZNFBI0=;
        b=FkUvhHY4h6dZ/8DXtssVGY+flOXrhX8P5WvU0CjSWk0//TkRWanjl4unfHfXPzW33w
         l7WstHo6iwKpBOop3mAID5hMk69XN9EYkBP61ZpcDk6XhEhVyjAxIL5PFR7ycp/cx+qm
         cUiUEL83lmn6rT68tEIB5zrVi4U0Mte3v2+VaklU3bsgUpRODr5Sy9rShQ9yUweM6u8X
         J2x+3clz1Gjh9cA8nvS8R0dKiOJ+5T/gFCQ92kgFF6DEOynY2WccBR86A1V9aZ1peSWi
         Dz9L9gt1omUJVlbr3viiHPYOehfkQbXGS4XMk1zrEN53aWr2WOOfoNLX4ZqGVvR16omL
         bFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271253; x=1744876053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN4ftbVcUrpHv9pyw2kRDHI+xH+v2r8X52a4yZNFBI0=;
        b=FI5nceuCZWiM4sj6Zvdv97OkAtdx5cVIAbaOp09mO/5A1RsJj8r7Uk1rSJMKEjCZCZ
         dw6TcqyzDl6b9fLNBbdis8tm9t2ROc5YFqHFMWI8P95ZBQoG24c8Eru/2cwaEf5w0ByR
         1yYdEnbmzqKcBEAEFs1z0e0GZn6EpwU19dHDeUp2kacnsF8Ftwmd/Vt7O1aD+4uRzx8f
         4TwIWzNcKoRA5VrUUWEZPrjVmgid5yUb+sRNLqNRDIb9W5fBmRM/gAyQgzCC680VQhAu
         V3ZxLb+hbkyE2m+zNEjDJe3qIlAnDaB/wvvH8svmVgY1usfmzWfK+HMjdjmiBFH8DBuS
         LUDw==
X-Forwarded-Encrypted: i=1; AJvYcCVUcE9KGGcaV8Z5rvE03+ucb7CKb1xOdwW/o5Lz5xRkvXFbmGZoqGYeHCYnIK/brghAToX+BZFt8Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJrG8xjCu1kc6H8pxnhYOD/Yr8gqWkPtilo26VBRf5Dp370/q
	uOcN3m4KpmvwS0RFYiQeHds2rv4d6N0MN2Qn4fJIzyNpZw0KzFUo4IDB+oCSzqc=
X-Gm-Gg: ASbGnctxmZg4sbBKvo3nGTCiW9rp9dA7LPYwbEyObD8Qa5R6o2Ytk4/COzEv7knVrBO
	xnFgHwONS593A3MLQUH9My4bEbVKhO/jG6jV7Q7+SZ7b7C4ZNSN5XynWQcTgxOwLDyL6XITOy4K
	NHJFugAo/owgNm3vVnfrO45vum7mft63mdh932OYuANyHJgQMu1wXud7dhc0euMQRukefyPc+Vp
	5ES4/4fcYThMYKEusKf+tNZphiq/N9WJ/kqodiGRhEG3YLZuL91GBGAy9iHNrjqlLz4zOSV8cBO
	jF/bK8dI0C4tTftF2pfmp9zGrNxkgb7OOJl9twAlFXXXmqtbj7ykmLrNlc46qrQxURDifbOCWJs
	D1SP61vc=
X-Google-Smtp-Source: AGHT+IEX9hmoF0X9ZqiGVv61djZa30qp2FUBmoKbmDJPiGNvb8KXFFjv8qI0Wlyys1P8zymueqsWRQ==
X-Received: by 2002:a05:6000:1448:b0:391:bc8:564a with SMTP id ffacd0b85a97d-39d8f4c937fmr1341269f8f.22.1744271253178;
        Thu, 10 Apr 2025 00:47:33 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f233a2c46sm41822965e9.13.2025.04.10.00.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:47:32 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:47:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org
Subject: Re: [bug report] pwm: Add Loongson PWM controller support
Message-ID: <bg4zper5r7aj7tae4qo34f6hzrjwrrmyjfqmv6gwy6mrj6hvgx@6vubp6v3yitr>
References: <44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivv6txtuegarob6v"
Content-Disposition: inline
In-Reply-To: <44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain>


--ivv6txtuegarob6v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [bug report] pwm: Add Loongson PWM controller support
MIME-Version: 1.0

Hello,

On Wed, Apr 09, 2025 at 01:59:59PM +0300, Dan Carpenter wrote:
> Commit 322fc380cea1 ("pwm: Add Loongson PWM controller support") from
> Mar 31, 2025 (linux-next), leads to the following Smatch static
> checker warning:
>=20
> drivers/pwm/pwm-loongson.c:126 pwm_loongson_config() warn: impossible con=
dition '(duty > (~0)) =3D> (0-u32max > u32max)'
> drivers/pwm/pwm-loongson.c:131 pwm_loongson_config() warn: impossible con=
dition '(period > (~0)) =3D> (0-u32max > u32max)'
>=20
> drivers/pwm/pwm-loongson.c
>     118 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_=
device *pwm,
>     119                                u64 duty_ns, u64 period_ns)
>     120 {
>     121         u32 duty, period;
>                 ^^^^^^^^^^^^^^^^^
>=20
>     122         struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddat=
a(chip);
>     123=20
>     124         /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
>     125         duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NS=
EC_PER_SEC);
> --> 126         if (duty > U32_MAX)
>     127                 duty =3D U32_MAX;
>                 ^^^^^^^^^^^^^^^^^^^^^^
>=20
>     128=20
>     129         /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC =
*/
>     130         period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate=
, NSEC_PER_SEC);
>     131         if (period > U32_MAX)
>     132                 period =3D U32_MAX;
>=20
> These limits are unnecessary and potentially confusing.

The intention to check for an overflow however is correct. Something
like

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 412c67739ef9..ba8a072defc8 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -122,14 +122,10 @@ static int pwm_loongson_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
 	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
=20
 	/* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
-	duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (duty > U32_MAX)
-		duty =3D U32_MAX;
+	duty =3D min_t(u64, mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PE=
R_SEC), U32_MAX);
=20
 	/* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
-	period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (period > U32_MAX)
-		period =3D U32_MAX;
+	period =3D min_t(u64, mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSE=
C_PER_SEC), U32_MAX);
=20
 	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
 	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);

should make Smatch happy.

Best regards
Uwe

--ivv6txtuegarob6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf3d5AACgkQj4D7WH0S
/k7jGAf/dgV0Hoj9PxUyTccraXuL+RAzwLsPMpu7ZWeEqDBZ6AaOJeyp4X0F2VHH
Wx4gkKEWPc4Bjf/GKOMm0zA/U67ol64OGvCp4Ew1SXX58J9SLYiCB2gmuFT7mVEC
n/YlyKhuzkuY01IQlGjYz+Do5+Z9onyNK8lPaaC4uOYFeqgd+bH52xDopmAsUlFU
li3zP4OVB/xTZPoXBvZ1Nldz9v5HsXJCkB2WhYyDdtYA1zivDWomqrdDQCQxZRJ/
CrTPjcxLs30rzXN1oumuRddmdqxmIiqnNU3MQrsLuilj5j9Gz65EtbpNMBvkaEF3
fqoBzvFgNWojI9r+HfD04ukW8okIPg==
=+NEN
-----END PGP SIGNATURE-----

--ivv6txtuegarob6v--


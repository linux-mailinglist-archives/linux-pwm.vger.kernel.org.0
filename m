Return-Path: <linux-pwm+bounces-4025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525229BAE9B
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 09:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F5F1F213C6
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E01AB52D;
	Mon,  4 Nov 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w64F1RmQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C61494B1
	for <linux-pwm@vger.kernel.org>; Mon,  4 Nov 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710376; cv=none; b=hDWQhTp5Vjt2tn56tvT2PcTd0LlRNdTM7OjycFmzhv3eDQAVL8ePt+tEfaCLVi6YEVNDAjxT+WPNety6wlzDjCSdWnjKG5mdi4Cz6P32D/1ifxXMu7jCaPAyV2GLUoUim35HCWJUu8a24i8qZwYBIRTJZYaVtCOWukCwoQ39X9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710376; c=relaxed/simple;
	bh=+dg7+/oeLYejz4vf4EdmY/yPLTxLAvK5rCpl1BLgxkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKKetOdY1bpBomVljfuL7MARXqykRoosv8VYdZcQvJLUhNMr+itQiYZQ574H+FEQNEaCT2ijIl0YPa7eVAketlVdbgW05rivnEw5dKwG/utzU3pLCoFXVr71xduZKtt7AmHTjebE/wB6oMnV/5CpJ0lcyMX/uDnrkM9Mo0n7xuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w64F1RmQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so2489363f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Nov 2024 00:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730710373; x=1731315173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT4c1xxWFNvifykBes4pG2L4vTvH31piGgiV/8RPSmM=;
        b=w64F1RmQtIfoN34isRu5saJ8zOa6E3eAiE5lCu3XwCK2MDp4sjwXaLcBdTr/E7FY6s
         /nZ+sW0svioXgsEchplLMGYbxiXKurYaTJ8dCIzPcWGrQebc/A+2mGHieCwa+LhIZlHN
         gktKfRz58cOB06E+/OW/oUC+eNEZf6hzfPRHt3qM4wBa7P8Frn4b8FGjMCt59dHBoRz9
         jx6xip8iwrE1QLruV8+BFzZazPKrSATdA2UAByZfylleld6VHLrWO8kffE1BW4Hykt5C
         BSiMoBsO0c0dEArO7PUIIF6zxQ1Tg8Fg2StN9thI5oTlMHskywLrOh4iVh4pbGbb5DFQ
         4ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710373; x=1731315173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT4c1xxWFNvifykBes4pG2L4vTvH31piGgiV/8RPSmM=;
        b=J7zO/EBEl5EHejfHSAZnUUUSCukI/i9jTOixYazcV32S8tmvFViKo5FTioRISV2CaT
         LqXOMfe19uocnel4U/CTQTYZx/JYBbn4xPsfSDcCCUqC3EuP+8TlGtFuZTzBCgFHOZBe
         1+L6PSRQWBl/bNT1RqiGIGS1EPx5LQbprXPSpuxB7iCYi96t92g8Dtyszs4HeJ7nkbCc
         lPwAuS/sQcQp/oeeU1+nGJGGo7k0MKFIcb1njYWPFM7STAyROXFWWc6K+96edOxHXElO
         noHIcMx+3dKqSExElnp1piT5E0gLFhms2F5gnMNOrZQgLCLyb5HSNIGH5qFTHs+yaTda
         Hd6A==
X-Forwarded-Encrypted: i=1; AJvYcCVt2MSzInx7gWotuf31oNc0UIH97cN8ikgMzLjEneaqyLNC+8TSIJTnPCSBD5qx9bdei/m9QTcwAzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBG1CmpiuRpuQViZt9nLVLI+EfOr2rQnZpmCND24V4/PJDTyU
	jwTFGVUGvoTuXTe4GxXwT87QdDppwRNVjgVa3YllciWhlb9LYxykIMTmKkCLWeo=
X-Google-Smtp-Source: AGHT+IH46ZjGucmxl6PTqFcmfDahpKMeLn2vnjDdJTD5YAvlDVhF2bkLjwJIb/MKH9YMOw8OMO2PEA==
X-Received: by 2002:a5d:4fc4:0:b0:37d:393a:97c5 with SMTP id ffacd0b85a97d-3806115a0d7mr20711375f8f.28.1730710373108;
        Mon, 04 Nov 2024 00:52:53 -0800 (PST)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm12734573f8f.7.2024.11.04.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:52:52 -0800 (PST)
Date: Mon, 4 Nov 2024 09:52:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <dy5abepkqhkmbgirwjkblbmw6vwb56vaqgazluyt675qflzioz@glp4djy6fhuo>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
 <20241103190709.GA466098@debian>
 <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>
 <20241103205215.GA509903@debian>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ydvmgz6gd4xioeih"
Content-Disposition: inline
In-Reply-To: <20241103205215.GA509903@debian>


--ydvmgz6gd4xioeih
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

On Sun, Nov 03, 2024 at 09:52:15PM +0100, Dimitri Fedrau wrote:
> Hello Uwe,
>=20
> Am Sun, Nov 03, 2024 at 09:19:36PM +0100 schrieb Uwe Kleine-K=F6nig:
> > Hello Dimitri,
> >=20
> > On Sun, Nov 03, 2024 at 08:07:09PM +0100, Dimitri Fedrau wrote:
> > > Am Thu, Oct 24, 2024 at 11:19:16PM +0200 schrieb Uwe Kleine-K=F6nig:
> > > > What breaks if you drop the check for state->enabled?
> > > > =20
> > > The device is unable to generate a 0% duty cycle, to support this you
> > > proposed in an earlier review to disable the output. Without checking=
 if
> > > the output is disabled, the mc33xs2410_pwm_get_state function returns=
 the
> > > wrong duty cycle for a previously setted 0% duty cycle. A "0" value i=
n the
> > > MC33XS2410_PWM_DC register means that the relative duty cylce is 1/25=
6. As
> > > a result there are complaints if PWM_DEBUG is enabled.
> >=20
> > I fail to follow. If .enabled=3Dtrue + .duty_cycle=3D0 is requested you
> > disable. That's fine. However it shouldn't be necessary to use
> > state->enabled in .get_state(). I didn't look at the actual code, but if
> > you provide a sequence of writes to /sys that trigger a PWM_DEBUG
> > output, I'll take another look.
> >=20
> Apply 0% duty cycle: .enabled=3Dfalse + .duty_cycle=3D0
> Below some writes triggering PWM_DEBUG output:
>=20
> # echo 488282 > /sys/class/pwm/pwmchip3/pwm0/period
> # echo 244140 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
> # echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
> [   91.813513] mc33xs2410-pwm spi0.0: .apply is supposed to round down du=
ty_cycle (requested: 0/488282, applied: 1908/488282)

I don't understand that. We're talking about=20

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index f9a334a5e69b..14f5f7312d0a 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -244,15 +244,6 @@ static int mc33xs2410_pwm_get_relative_duty_cycle(u64 =
period, u64 duty_cycle)
 	return duty_cycle - 1;
 }
=20
-static void mc33xs2410_pwm_set_relative_duty_cycle(struct pwm_state *state,
-						   u16 duty_cycle)
-{
-	if (!state->enabled)
-		state->duty_cycle =3D 0;
-	else
-		state->duty_cycle =3D DIV_ROUND_UP_ULL((duty_cycle + 1) * state->period,=
 256);
-}
-
 static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
 				const struct pwm_state *state)
 {
@@ -325,7 +316,7 @@ static int mc33xs2410_pwm_get_state(struct pwm_chip *ch=
ip,
 	state->polarity =3D (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
 			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
 	state->enabled =3D !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
-	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
+	state->duty_cycle =3D DIV_ROUND_UP_ULL((duty_cycle + 1) * state->period, =
256);
 	return 0;
 }
=20
on top of your patch, right?

`echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle` should result in
MC33XS2410_PWM_CTRL3 having MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm) cleared.
When mc33xs2410_pwm_get_state() is called then it returns state->enabled
=3D false and in that case the above mentioned warning doesn't trigger.

Where is the misunderstanding?

Best regards
Uwe

--ydvmgz6gd4xioeih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcoi2AACgkQj4D7WH0S
/k66+gf9EIyiCWwLCtdADfq3OdF4WI+Bfhcss7xk3MUTxyx4vcgWqEg2309SYLZw
0117CRb6WsbnRyNo5Vj5GGkBn7eITd+k7b1TuEN+Aw0DNH24EwWNabO6DMKzUkQu
AxFy9WXsyVr6IVHvSFK8xtiz0qexTwFSkmTI6o8cm0rAy/wyMY4dLu20WbLkZTZp
zID7f047BkLo8T3o8k0fWmfD2s8OLT87+EDipK+D/VfosMf2BZ0Sb7/pr3tPZSMy
loMLKgaMEGiWb5EZJ2nBeuUnGM4dimWdWI+B1JC6YeaN5/OW795ljIwyyGDELldu
uCGcWdCXc/xONQsetMa5Mn9+tyoxrQ==
=Ek8Z
-----END PGP SIGNATURE-----

--ydvmgz6gd4xioeih--


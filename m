Return-Path: <linux-pwm+bounces-3384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1990988F68
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67AB1F21962
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5151E520;
	Sat, 28 Sep 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iuYdUkLS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE7C8DF
	for <linux-pwm@vger.kernel.org>; Sat, 28 Sep 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530515; cv=none; b=WaP4Wbi425te6zp5/oBXvROy1Uf5ykGu1kXzbhgOC0qBJ+2rHRBALAESTSTjk+E/JDBT/tIBGvuMnMiUfQtC3Paii/qPMIvTWwi97zHTBT96AL/X7CPEhOsyuioT2TaR/QKaAWHja+IYDestlYs8a4Jz97O6eeOitsCjsVZAyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530515; c=relaxed/simple;
	bh=uTTnTyPWS05h96aDuzNzDacF8GaMR2ESxEAh2zsBgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPftFUGGb3T1UnQ9t0mGyHYKdBGHVA2A4pAuVMjrwnKQxmK+eVaabag7uNinyyo7KTxWBegpaT/WFH9YgedGSAEnGul7qP+h82BMEee0r0/RFkT0j+tYf7iagsWbwsoCy0MbOwCG2jXB4z4KiEQLFRjYVQFjSRE2lUDq/kOM6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iuYdUkLS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so4079958a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 28 Sep 2024 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727530509; x=1728135309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LxkNxJ3XTxZHVberIu13V6EH2yduRhCpu9ORXM4WVY=;
        b=iuYdUkLSQNBKD1Cq4DTOz5TTQFyzQI7emO4/WMRb2+X7ccdnm3FKDVLZFYiwOm+MHv
         9XM2+TcQH5URpsJWCss89fM5Xme0jRPCRi3HR8pvuLzGkJcaeDmKXbfKb7fctZsxOIAN
         VcILnb5SG94sNgDjIy//45Igj8TkixMo2BLWMqxlZtC3yuUiTTSRuKeyHhCVHNLyro8t
         J4HvZWg1qjzlqtA38sE4pqARl2f2Y8/08EzhZLY/lEPhX+wRMO0OSzJbj7S4TYtEtdEj
         z50f24/ReMI9afAiMFoT7dYnML4TeKUwsf2cl5uvhT1OGMoXmSPPGB0E8BtYs1vjaJGn
         nb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727530509; x=1728135309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LxkNxJ3XTxZHVberIu13V6EH2yduRhCpu9ORXM4WVY=;
        b=QDv5R2ZrT2jm/pLtv15k4W8S6ucOb94COkS1CeqAIBeMyLb03yTXcAQYBM2HrMPB9S
         zeF4dj4vRzOw3D9YTpDyjs7EybTt+s9Kw7UwjGod2F5kiCsMCPGaQWJDvtlSCt0zzFMN
         QzYshd8dpWy6DpW8Dpswnl8e+pZPgonH2OVBl1/9mXD1WbN8WcUsi0wlrPAZi6SvF/TT
         ZmvD2a6Mjn6rv3lGHL15G6GLb5iEQriLHfphRVnTTRBDYUSDcuPUS2c2kvLkM+fkZCdy
         8IEhVomt4BTM+BrUG5OH/UadII5jBfAJWNbaw7Pk6XQ91oTMl7zqEugKo2cDHh43KFhq
         pUpA==
X-Gm-Message-State: AOJu0Yy3v2O96X7Lo3dTFju3kNnn27oVvDushPLis61Xarsxe18R/uDT
	8ONX2U453gbr/4zL8GeCPnd4oSfDnyauT2w/rixXqXCHEYLWSZbsjJ3AgrImY+o=
X-Google-Smtp-Source: AGHT+IGacTsUcRcuqRZxkF3VfD6Tdz4ymdaPwyjcM0RfzcN8XwkU75fxGNKqr824laVFx6FZouOaxA==
X-Received: by 2002:a17:907:3f17:b0:a86:8f9b:ef6e with SMTP id a640c23a62f3a-a93c30c3d8amr809128366b.13.1727530508532;
        Sat, 28 Sep 2024 06:35:08 -0700 (PDT)
Received: from localhost ([89.207.171.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777214sm247292766b.36.2024.09.28.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:35:07 -0700 (PDT)
Date: Sat, 28 Sep 2024 15:35:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v5 2/8] pwm: New abstraction for PWM waveforms
Message-ID: <dxa5e3wxjyx4cehctv3mm6h5hfvyib66t6c54t67iujdkzvv75@6m7bzs77ooq7>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <df0faa33bf9e7c9e2e5eab8d31bbf61e861bd401.1726819463.git.u.kleine-koenig@baylibre.com>
 <CAMknhBGPyOEA0ZT_4zi4on1mwi+ozM27uo1rTOkiWQtkU7+JGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjoxuar6bnbg57si"
Content-Disposition: inline
In-Reply-To: <CAMknhBGPyOEA0ZT_4zi4on1mwi+ozM27uo1rTOkiWQtkU7+JGQ@mail.gmail.com>


--rjoxuar6bnbg57si
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Thu, Sep 26, 2024 at 09:54:56AM +0200, David Lechner wrote:
> On Fri, Sep 20, 2024 at 10:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
>=20
> ...
>=20
> >
> > The rounding rules that are expected to be implemented in the
> > round_waveform_tohw() are: First pick the biggest possible period not
> > bigger than wf->period_length_ns. For that period pick the biggest
> > possible duty setting not bigger than wf->duty_length_ns. Third pick the
> > biggest possible offset not bigger than wf->duty_offset_ns. If the
> > requested period is too small for the hardware, it's expected that a
> > setting with the minimal period and duty_length_ns =3D duty_offset_ns =
=3D 0
> > is returned and this fact is signaled by a return value of 1.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > ---
>=20
> ...
>=20
> > +static int pwm_check_rounding(const struct pwm_waveform *wf,
> > +                             const struct pwm_waveform *wf_rounded)
> > +{
> > +       if (!wf->period_length_ns)
> > +               return 0;
> > +
> > +       if (wf->period_length_ns < wf_rounded->period_length_ns)
> > +               return 1;
> > +
> > +       if (wf->duty_length_ns < wf_rounded->duty_length_ns)
> > +               return 1;
> > +
> > +       if (wf->duty_offset_ns < wf_rounded->duty_offset_ns)
> > +               return 1;
> > +
> > +       return 0;
> > +}
>=20
> It looks like this return value is being used as a bool, so maybe the
> return type should be bool?

Good idea. I squashed the following diff in the commit:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e3e26aafa461..bbe7bfdb1549 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -95,22 +95,22 @@ static void pwm_state2wf(const struct pwm_state *state,=
 struct pwm_waveform *wf)
 	}
 }
=20
-static int pwm_check_rounding(const struct pwm_waveform *wf,
-			      const struct pwm_waveform *wf_rounded)
+static bool pwm_check_rounding(const struct pwm_waveform *wf,
+			       const struct pwm_waveform *wf_rounded)
 {
 	if (!wf->period_length_ns)
-		return 0;
+		return true;
=20
 	if (wf->period_length_ns < wf_rounded->period_length_ns)
-		return 1;
+		return false;
=20
 	if (wf->duty_length_ns < wf_rounded->duty_length_ns)
-		return 1;
+		return false;
=20
 	if (wf->duty_offset_ns < wf_rounded->duty_offset_ns)
-		return 1;
+		return false;
=20
-	return 0;
+	return true;
 }
=20
 static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
@@ -348,7 +348,7 @@ static int __pwm_apply(struct pwm_device *pwm, const st=
ruct pwm_state *state)
 			if (err)
 				return err;
=20
-			if (pwm_check_rounding(&wf, &wf_rounded))
+			if (!pwm_check_rounding(&wf, &wf_rounded))
 				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], resu=
lt %llu/%llu [+%llu]\n",
 					wf.duty_length_ns, wf.period_length_ns, wf.duty_offset_ns,
 					wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.du=
ty_offset_ns);

and fixed the two new occurences of pwm_check_rounding() in the patch
"Provide new consumer API functions for waveforms" to invert the result,
too.

I created a branch

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/dut=
y_offset

that contains the updated result based on the pwm changes for 6.12-rc1
that are already in Linus' tree. When this survived being in next for a
week or so, I intend to tag it that Jonathan Cameron can pull it into
his iio tree and apply Trevor Gamblin's series for the ad7625 on top.

Best regards
Uwe

--rjoxuar6bnbg57si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb4BgIACgkQj4D7WH0S
/k5dggf/W6qLuisL2tj+fuSxYJJu3yeI0rBDpKwWPJO4bZN9SgR9e6OiRrEXb7A3
piWAQves8fkGpVSpdniyc0paeCzq6B9VbIME4FJAWZD7gvRyThVDGQ+e27fSam6x
VFfiE0CTooE14Y76Xkz2mTXED8BMw3yGVEb3YpqW4/vPbW5UIvD9wJ99x9biM909
VX4GoogPQXeA4WyuDDFpgT2gDyBm68fnqcvciTccreTLbYPElhFVdC9OqA7xcvMp
9jBbBdoPEJYMRQGSxlRbNMfeN00M+W/PFenrsjeXv7aQOyCkS/pJuZHirJDhJzyS
mhsVb6Yknm59a/NsAZc6y2Xp3FzB1Q==
=YJBg
-----END PGP SIGNATURE-----

--rjoxuar6bnbg57si--


Return-Path: <linux-pwm+bounces-3383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46B9887FC
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5EE1C2089C
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1739AD6;
	Fri, 27 Sep 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mK36l8dW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED8A2D
	for <linux-pwm@vger.kernel.org>; Fri, 27 Sep 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449884; cv=none; b=Wg3dT8j/jCfUbwI9ktkD3jOnHFsP6DtLlpKMHV81Zn074vSuSpA59kchx2fRH3uRxSVhLShW2ho84lzgtsBku0XVeOLiZeJo/+bN6YY1msfxsAk1NoXpv1qyXKkdGyUrV3+Yu58Lf56WpsEr3OW6DmQxRMFfhUUZmZlXqHMZNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449884; c=relaxed/simple;
	bh=AzIIdeRLLvyvyUHswyMDzoVSXuaWJ+iIOJqFHnsOqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSqw8VS48qPEwWrA8RERLeBnvQqjMyE4C4K2fnd7+Vvwv4+yF299GJQ+hkPe2q6CEDGV2fEkG6Z8inImmXZglcGQO2ARTcrPDGR5OtLbZgXMsUhjSQFFbFVtRMaKwlJdlBLq8+OmoZJUoeCCGmuBX9Ksr7m2nB63yfSDZaxzKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mK36l8dW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso1514332f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Sep 2024 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727449879; x=1728054679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzIIdeRLLvyvyUHswyMDzoVSXuaWJ+iIOJqFHnsOqIY=;
        b=mK36l8dWDq8mJQZ16xBrrKMjhT013pGgKOWwmTTzCN/CGTkSmbWfMIysgL1fEI3PkU
         UFyvLXN72qb3jD0kpx+ZVF1LZTN2mCaqZGJ3mQ6j1TYmwyUqB+A2zJaDEsQua+RawEBI
         jq7+a+GezduBOPHJ9jY4mwuD3iBTTiVZ4VoH/DtMcLG69ZnRVJIRRGsuz13NCBCZzhg6
         HC6bEOMWbC62qN53pHkyamkhEbF4OOC3ChEascNuMXS/fyHrKN3Y+gnhUoTNEXYBlloM
         vJRKi1ZNBDfIwuhtolhMoII8Hye2LZiX8RdRO/tAhMXxQft82Rmfq+Tii8lxTUE4TmoA
         EBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449879; x=1728054679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzIIdeRLLvyvyUHswyMDzoVSXuaWJ+iIOJqFHnsOqIY=;
        b=oZozh2AGzfvnWtSdGQUmYFDbBn7GoZXkDt1I7UzL3Q9xaPFxkEhxvaEIq8ewPSgaaO
         WTUzWucP3jRZbS1rp0Lh4GWjtU56u4xsMPg/2r1P/v+AMShP9GlPv2Aq6m1eTkXbuUAv
         oay3Z2I2pE/5EY5i/Lw4TOUu4w2bVcuo8XCxpEFoilm2moUUvMtfq+/43lH2saZn/r5V
         Nt1OGM8FEt+dhmFQr9p6Ap+XJ2oKTZbYiAPrmqK3s/T8Tt6hByRfky8ZmiWF7XGp472A
         oAHuZyGcVvcUMzhxfhIf9bGLnQHjbTCNQhaCGSyuY9NFN+vgHW+8RapnA/LS+/G/HHbg
         HZ8w==
X-Gm-Message-State: AOJu0Yyzx2l31nuZsZBZLEETthDVFR9sQT0wNS80QUq3uRU865JXbdeA
	n4cUBgyt5pDsqTV4MvWjvOGMbH0R+1Jb3DZP6TLUksEv5XkxoX9YKe1T5CETMXY=
X-Google-Smtp-Source: AGHT+IH1m8SLErAo0Tr5wrc7LTJ2+h3WnJaq+XRtctvke/JEEPnqi2anC4LMyuoGiDKn8pZUeQ+yFg==
X-Received: by 2002:a05:6000:10f:b0:37c:c892:a98c with SMTP id ffacd0b85a97d-37cd5af2060mr2666268f8f.56.1727449879342;
        Fri, 27 Sep 2024 08:11:19 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm2780791f8f.96.2024.09.27.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:11:18 -0700 (PDT)
Date: Fri, 27 Sep 2024 17:11:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v5 3/8] pwm: Provide new consumer API functions for
 waveforms
Message-ID: <cdyhioabw4euz2bv437owyr4klnlarovj7znrcxqklbqb5vnw2@n4knf7wnwhfv>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
 <CAMknhBFXwv+5ALzDQyMPjZ_Y9_DxDtSX9YWzy2QNjdHz8hkwmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ci6fyyl6t463h44x"
Content-Disposition: inline
In-Reply-To: <CAMknhBFXwv+5ALzDQyMPjZ_Y9_DxDtSX9YWzy2QNjdHz8hkwmQ@mail.gmail.com>


--ci6fyyl6t463h44x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Thu, Sep 26, 2024 at 09:55:05AM +0200, David Lechner wrote:
> On Fri, Sep 20, 2024 at 10:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
>=20
> ...
>=20
> > +/**
> > + * pwm_set_waveform_might_sleep - Apply a new waveform
> > + * Cannot be used in atomic context.
> > + * @pwm: PWM device
> > + * @wf: The waveform to apply
> > + * @exact: If true no rounding is allowed
> > + *
> > + * Typically a requested waveform cannot be implemented exactly, e.g. =
because
> > + * you requested .period_length_ns =3D 100 ns, but the hardware can on=
ly set
> > + * periods that are a multiple of 8.5 ns. With that hardware passing e=
xact =3D
> > + * true results in pwm_set_waveform_might_sleep() failing and returnin=
g 1. If
>=20
> I liked the previous suggestion to return -ERANGE instead of 1 here on fa=
ilure.

I hear you. Still I haven't made up my mind and would like to keep it as
is for now to get forward with that series that is the base for Trevor's
adc driver. The return value convention isn't exposed to userspace (as I
won't apply the 8th patch for now), so it's not set in stone and can
easily be adapted accordingly. I hope to get a feeling what is right in
the course of working with this admittedly unusual return value
convention.

Best regards
Uwe

--ci6fyyl6t463h44x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb2yw8ACgkQj4D7WH0S
/k6CLQgAg1Xv9UxZiERG73DKoxixVKDUgCBDh6G1r2gkeIG+tKceaGdrJrPd5yeV
VY+bL5uFJll2M6PvspQNi5YdcYBAuIKpHIRX7+JCnyXDGqhfzuBzNrLECyPEdHd3
ljnU2XPppkporJPpsDLPYXcuYlB4ziB8adX+gX1Hxegc/tduYkXqzUB1Eggu39Kl
dHquEVIDN+y+jC2VmCC96ry9TYswNvu7s+Vo9wct894iK0L5R14hKd+8WLajtFen
ekRlgxtWTcwB5VZ2J+1BHjFpWY3/WYWdT3g3CES3XuAy1+ZdSEmZHinkupd4XCWH
FOSgVEiqpyc1c+zAiuwpijShvhBybg==
=4HC9
-----END PGP SIGNATURE-----

--ci6fyyl6t463h44x--


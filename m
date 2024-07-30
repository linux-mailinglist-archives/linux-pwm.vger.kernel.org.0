Return-Path: <linux-pwm+bounces-2939-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001F94153F
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 17:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52521F2358A
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BD192B6A;
	Tue, 30 Jul 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1YmfBIpg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4B29A2
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352573; cv=none; b=HsbHv1zm/o4oD7//ZgBcstmjRCkrtUQTCJjSNmnSTkUXiLxJPOCUSyHWWF7tofOW1OvivWNnKhVNt9i1sxkqcr/o3OapCA6O4MfmtCJkh1MBiSxW/bcXyetALb95bjW3A7m+ltXnJrON2B87772MrqebxKEnzhSyR1YTNFlBKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352573; c=relaxed/simple;
	bh=4sMlfvqYaOaWSaCl42tXYUuOht1IVnYppXcTntHi38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1tpId4iwH/hPzkS+c07RdbUkbYXJVC8jwshzHFVFXs7XqgeRXdBeGJ5ApXLLpNsvwIiZ6Jqvax3hCATtYiKiBzB7cI5PdSNrBU3qzq06rBIDo5gXhBIhyJLBiqtl2nDabE6TWgpJgPbTggkCbN3POZ3XCcpNG0FWoUg9taqIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1YmfBIpg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so6592786a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722352569; x=1722957369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgz/8m7bce05UJobMO0viqPTgRs2abA/PmGo0bOBC8I=;
        b=1YmfBIpgopzehNp2o6Ztx+eY65HjTge2LDj51qk+1jDf41olizGy1++02nPFC9h0Nf
         4AUkHhKV7E0fBlTZjNVeR/M1erls+WqCYZ2fVQUqGyE9fKi/6a0uqSg0l5oZlcJ7VXKW
         DNhk+w9AnK7H5QIpRftY64doLb35TEVWTbwWfgoyvgMtEKG1USiivokuBQQCMKT5iMcs
         vGtJp/n+YHhzstmYNoFBMFOuxeU+/47guCNGio4n7q9ZiQmiQ/j9nbhEp9QuD8TUcW47
         DFw6WHdjqf2WAgAJb+WjwrXewQl1PklbpLPl1EK8shVKGx7t8NnpIiQZlVH6jGPIEFQQ
         Rf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352569; x=1722957369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgz/8m7bce05UJobMO0viqPTgRs2abA/PmGo0bOBC8I=;
        b=oQtL5gVOZZvt3qstbKSeguADa4SgvQPuffSxzp01uL+OB0Aj3UHRcSRxngl7+ueoSl
         BSiIWHZYiZ8b0WjvYDFgzhJr6qRaoiEzmN6lAVaHBnJxBrlg1oh9Tuw0ORHTpZJWZ6/c
         lVGDdldR63BxTc48AqT/EoeM8BgmDRCRCer+esrkt1i83SD22viLxVLk47JHa8kf+VQA
         aeVdIevIgUjFoKy1dYwkXu8sCA6DTM3XxrQ6z28eh87t0G8yHUoY4262W0qim1n988Yp
         UL7X1gKzQm6XRj7mB6XDIjGGvanX4GXR3GKKl+AXEf7SifElZS7iO7YuYcRb16Sbxzie
         wHLg==
X-Forwarded-Encrypted: i=1; AJvYcCXDHQcy6xZWfFEjaNlX5V91ZpCU32KoLDUieC5IkF/rfD48hlEuzJ5kz0TSXCGfnmblTPf9suFnqPkPBc2iXwQO4XZxi8fQbCiF
X-Gm-Message-State: AOJu0Yyaxa6bE9QLvrdRr9bwGqS8vkiTYNRsNgWYr2fUdQLdEnZBI5GS
	4jsgLOOKZHewVfrhh2J90wA+oJJWyLpyEZCwdaeXPVz8ciu4Z3pnIfq9qTll5ck=
X-Google-Smtp-Source: AGHT+IFQFQlatRFS9LCSxScWaP61O0PL5SGhOWbQF+jLOEobwrprRyV2Jok7P59PikFm09r+Ry3K1g==
X-Received: by 2002:a50:d696:0:b0:5a2:2ecc:2f0 with SMTP id 4fb4d7f45d1cf-5b02000bde0mr7734778a12.1.1722352569260;
        Tue, 30 Jul 2024 08:16:09 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59bfesm7407916a12.44.2024.07.30.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:16:08 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:16:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-pwm@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 6/8] pwm: Add tracing for waveform callbacks
Message-ID: <cpbmf6ghkrnsu6gylk2xojivdjnzay3teotlxk6yfewgk3itvv@gamyj2lwopsy>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.1722261050.git.u.kleine-koenig@baylibre.com>
 <20240730101246.5fef41fb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcismen6xhltzea3"
Content-Disposition: inline
In-Reply-To: <20240730101246.5fef41fb@gandalf.local.home>


--zcismen6xhltzea3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:12:46AM -0400, Steven Rostedt wrote:
> On Mon, 29 Jul 2024 16:34:22 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> > index 8022701c446d..8ba898fd335c 100644
> > --- a/include/trace/events/pwm.h
> > +++ b/include/trace/events/pwm.h
> > @@ -8,15 +8,135 @@
> >  #include <linux/pwm.h>
> >  #include <linux/tracepoint.h>
> > =20
> > +#define TP_PROTO_pwm(args...)							\
> > +	TP_PROTO(struct pwm_device *pwm, args)
> > +
> > +#define TP_ARGS_pwm(args...)							\
> > +	TP_ARGS(pwm, args)
> > +
> > +#define TP_STRUCT__entry_pwm(args...)						\
> > +	TP_STRUCT__entry(							\
> > +		__field(unsigned int, chipid)					\
> > +		__field(unsigned int, hwpwm)					\
> > +		args)
> > +
> > +#define TP_fast_assign_pwm(args...)						\
> > +	TP_fast_assign(								\
> > +		__entry->chipid =3D pwm->chip->id;				\
> > +		__entry->hwpwm =3D pwm->hwpwm;					\
> > +		args)
> > +
> > +#define TP_printk_pwm(fmt, args...)						\
> > +	TP_printk("pwmchip%u.%u: " fmt, __entry->chipid, __entry->hwpwm, args)
> > +
> > +#define __field_pwmwf(wf)							\
> > +	__field(u64, wf ## _period_length_ns)					\
> > +	__field(u64, wf ## _duty_length_ns)					\
> > +	__field(u64, wf ## _duty_offset_ns)					\
> > +
> > +#define fast_assign_pwmwf(wf)							\
> > +	__entry->wf ## _period_length_ns =3D wf->period_length_ns;		\
> > +	__entry->wf ## _duty_length_ns =3D wf->duty_length_ns;			\
> > +	__entry->wf ## _duty_offset_ns =3D wf->duty_offset_ns
> > +
> > +#define printk_pwmwf_format(wf)							\
> > +	"%lld/%lld [+%lld]"
> > +
> > +#define printk_pwmwf_formatargs(wf)						\
> > +	__entry->wf ## _duty_length_ns, __entry->wf ## _period_length_ns, __e=
ntry->wf ## _duty_offset_ns
> > +
>=20
> The above is interesting. But if it works for you, then you do you ;-)

Thanks for the feedback. (I just pointed you to this thread in reply to
your other mail. Didn't notice you already replied here. Consider this
done.)

Best regards
Uwe

--zcismen6xhltzea3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmapA7QACgkQj4D7WH0S
/k5emgf+LdmojQApbRle/MN3c6x4QqTZ7W9sIvOmExQzGyKxosI6CNUPpihB8p1z
6cxtp5a9R+64VaU7pYCfmV+H+sfeNon6B90Whb3elrov0MNCVjt/7dlbIdhjrbcf
/tw1ZHMAfGZNw6wixJE7o43OX42MGMNiInSISKsbhKjyVMPnyKwcFvSUqcCSmtnw
FcbIhD2KgPEHWPFpVbG3GCG4hZCdsAc08DpaUrhbwfnUYWSZ9SiWMzzyySSoYoBK
YtgeDrCyoIZh0uiDm+x3wlgg3muFh4GGv3fkzKaotLKUW4zDKiNkR6v1r4dOKEYS
y38y+t+2KP8FK1UbYvM2pCylZPTYYg==
=9Y3Z
-----END PGP SIGNATURE-----

--zcismen6xhltzea3--


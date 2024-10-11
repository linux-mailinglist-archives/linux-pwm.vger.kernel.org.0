Return-Path: <linux-pwm+bounces-3593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326299A073
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7EA1C23837
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548FA20FAA1;
	Fri, 11 Oct 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UlRTD7/g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FB21643E
	for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640325; cv=none; b=Kd2KcOHO55PcG4WI3oujCY4Y8csoreGpYGKePhJS4njSI68APPrg5Xdh8AttivIADE1mwWVVB0P112pcDT52mxdJ/uZNM3AEMQAAizBgi7zGHUZEOONc1ceOIakU8tN45aOdGQcGPFN4USW9/h5I9C5JTQJZzIDQ9EpY7ZdRh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640325; c=relaxed/simple;
	bh=Mb5N6pgJzOkIEr7l/yHZXvuZ6alGs7B8vMdJeiW7vT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoXOO4omKrWnhG/t16lAR+b5QHfXAHm4W7yvz7vAWjvnxnFxpfGRzHIeoI8Mq6ovxW4u7lsJNyxleCStirn7o4SZ5VJ4KhBJ1eR3kFAket4vT8SAvaLzW/ncSk9azS3YjDAm+qzyxkkgE+zzylZs2tN5nHpVqAZ8/m9VJTYVnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UlRTD7/g; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so2557984a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728640320; x=1729245120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dg5JkQWPmMTeEn0q8L8CpWb3aGw0P3X7EfNU+52GdRk=;
        b=UlRTD7/gFO8i1UjF9eB6J/hD7H5qIgv5v9UNwFdkTCNmmZM47svO4okw04fuJG05w0
         5MaKpZSnx8auaVBAhifb584S//8V/1CRd7ns+tXEtNoe6PP6oDyygS9CmRYJoDhJlbD0
         PX9R82ZllK7pvLT8/ZJVnGgkU2Vsj9kEgoOqvMSvocmD/01amdu+lVtHLNjMXiq79Cfo
         h1B0MikpprXRqPzCvC/seh60vLzHTS1etgXsVzFZF08NS5y0OCdPkrc9yeIdmci5Od/T
         XPPaSrWolK32D0Iup7fZ7E8INLv4+9Yn43dLrT7xOJpfa5iiqngXri1CuxowtR+UT2An
         l4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640320; x=1729245120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg5JkQWPmMTeEn0q8L8CpWb3aGw0P3X7EfNU+52GdRk=;
        b=lt8rUtBW14dm25SiPseDLpm0yV2S3F6zWM2yRVhXL+M6ACnno4VpcxmIE1Ud4db2/o
         PTUhELNUtd2z6fDK8dSgF1QGqLsCK83nz8IyLaqrwyOzYeDNvKPhWcuGQWFYCqeQaKY7
         zUQ4F+d4yls2DftYILm285OHKfagGH+o6AM8RlF+hT0N+k3iEcFc0fd6CSh+Jzx3WeRs
         S4rVJNl+9sOsTDo29PZHXvk9vNhSxVWQYT3AOI/BlN6UnYAvdMitgzmZC5k2/6JzxrkB
         1Rupy1myTLUi3tkSPmeU2gIyQboXfts4vKpSXZnQc0xoctYXeTQ5lsNMM5tb/a05+1AB
         OXug==
X-Forwarded-Encrypted: i=1; AJvYcCWIq6O0usY6cvwCQg3uoRsyStBpnblWQMuc+ycbzMDsOYfPvDZWz7a+RErFil1TxRaU0SYyFGwiEFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKcVECN/BEVO6tUXrZmDsFJQNAqD4Sv3f8FV6KVCBVMlbK8uo
	yBAw2Ly9K3tasDjSGSDr1ULfD4mR3Niew90gSNlUd6qlyKDVz5A8jM7epimjIkM=
X-Google-Smtp-Source: AGHT+IEYI+hnTD8/LN0b4vnJj7mNneMtZiBdz98KJBavPDXAX0+SupOuNK2lcS6vIWAIh1CXT8EsOA==
X-Received: by 2002:a05:6402:5250:b0:5c9:89f:9a with SMTP id 4fb4d7f45d1cf-5c948dac9b8mr1221925a12.32.1728640320569;
        Fri, 11 Oct 2024 02:52:00 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93711ba3asm1761875a12.32.2024.10.11.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:52:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:51:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
Message-ID: <zm6uc43aidfouc5wj4outd2cqribbzqnbp76my7ntcflbn6drb@sc7nwgho6x2c>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
 <57169283416bf7902523891ba03d1f878772ffe5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yuwjcgjvfj2h5dn"
Content-Disposition: inline
In-Reply-To: <57169283416bf7902523891ba03d1f878772ffe5.camel@gmail.com>


--5yuwjcgjvfj2h5dn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
MIME-Version: 1.0

On Thu, Oct 10, 2024 at 10:33:20AM +0200, Nuno S=E1 wrote:
> On Wed, 2024-10-09 at 16:11 -0500, David Lechner wrote:
> > When using the axi-pwmgen as a trigger for ADCs, we've found that the
> > default behavior of the PWMGEN IP block is not ideal. The default
> > behavior is to wait for the period of all PWM outputs to run out before
> > applying any new settings. But there isn't a way to block until this
> > happens (and even if there was, it could take a long time). So the
> > pwm apply function returns before the new settings are actually applied.
> >=20
> > This makes certain use cases impossible. For example, to use the PWM
> > like a GPIO to create a single pulse on and off to trigger a single ADC
> > conversion.
> >=20
> > The AXI PWMGEN has a FORCE_ALIGN configuration option that changes the
> > behavior so that any new output settings (period, duty cycle, etc.) are
> > applied immediately. This can cause glitches in the output, but makes
> > the PWM actually useable for most applications.
> >=20
> > Also, there was a naming conflict with register names, so there is a
> > preliminary cleanup patch to sort that out.
> >=20
> > ---
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

b4 diagnoses for that:
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
     Msg From: Nuno S=E1 <noname.nuno@gmail.com>

I fixed that manually now, but would be nice if you'd care for matching
addresses in the future.

Best regards
Uwe

--5yuwjcgjvfj2h5dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcI9ToACgkQj4D7WH0S
/k4f3wf+KsgrrCvn7a+lLYM3vfU+YRXF1pzJJzD7wKtq9CIRwk8PgqO1wpowixCd
GGtXe6IZqrlOsvkKYPbpIYdduIzQjFIFXfaKgxAusxBSPDIJLeJHdF0EjXtmR+h1
46LMhizFqy+WAbXqSjzo9n7upxhMWoN8v8eASZg+AK/n42le7atwIZ+o2pQmLRXP
8KlBSaIvog2BrkmINETKYzwJ/4pT2kWtqsI1VGZTF80sST3+JRJGeF3qDYtI8NRx
kenPB+clI9WjnQCRoYn2Up7j4brTFHui0bwBp/4JZR18o+2GaXa/cpRwY6i+rPCI
DkoLykrFis60Dte7TFb4B9bBtfkFDA==
=/SiV
-----END PGP SIGNATURE-----

--5yuwjcgjvfj2h5dn--


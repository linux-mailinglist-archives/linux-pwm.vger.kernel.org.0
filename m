Return-Path: <linux-pwm+bounces-6801-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FAAAFE1BB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D753A6661
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE155212B28;
	Wed,  9 Jul 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HHvaBN2+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379B18A6DF
	for <linux-pwm@vger.kernel.org>; Wed,  9 Jul 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048094; cv=none; b=BeRn7Z6++tmvwum1xWVTvCyw7S48BZ6kG9QF0EXMGRhh8TJE4lJDp5+uUDJdqvVTLFO41k8wIFJDQHyHN85Epgae0Aw2rtFETFSuTzlJfA/KPmS0P6bDIZwqOxKHKi2CBS1fxIdWF+7IYTGgLfcu3Pyb85tpL5EO3HgWicBEd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048094; c=relaxed/simple;
	bh=+LMs9nwAbFqUimrlcZAU115LhNSVWWcRlkMoxh2fsVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFNYXo/XWbHV3/mNT7S22sW1AVv01maX54QfuUAAhFa4bGEiEN8BV7/InECWgqmrMkkdYuJMMoZMUmXQwMc2Dv0x3vRZdZeoDQ6g4J6zZP/lSAwl52mZKFk7V8icXbyetOqZgpdu1yNJq7gYhOtK6GbWFpBWb6CJfFjHcca5Tu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HHvaBN2+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so9718136a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 09 Jul 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752048089; x=1752652889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LMs9nwAbFqUimrlcZAU115LhNSVWWcRlkMoxh2fsVs=;
        b=HHvaBN2+B2at0E35/Fw0REsIfHVgz2n1YsJ0URiOw/HKyY8r6EQoXy8oZ9io9jl2y5
         QARjqZCDQgc+mLLM2zuoxLaPjyMlytXXagZZEqfCma7P9UET1fWlxwMs8Rjn+s0AWp5M
         GNRn1Rgc+6MkKiNpuxaqNdP6+Flhq+fz7l7359hVQH70UdpEMNQDvX+w/0LjHohIwDNv
         ZglQ1OEGCdFVyPzu0/wCXPyLVAhYn7DgoxZbrml5paa7tu7q30XKYjqcaQBV7hIm4Lan
         0n6nc2BKoF0Ir1ikdPyjCV/r0Kl5qn2TBPfLmRxZuE4F3OGGL9NbRolhyrr+cQ2pix/W
         fpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048089; x=1752652889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LMs9nwAbFqUimrlcZAU115LhNSVWWcRlkMoxh2fsVs=;
        b=LTivJCdO43xnukIaMwoeL5cvkyJgxaZcsSPIzlsI/eE/7ONpJV6It7mptvYuDRDhc5
         UmMWotKg5miXPoLLEvoQrwfMJmcZ6RecOSnm4MgWXSZfrovQcTQEC1AY+idqKKIZTk/h
         vTOishZqZbwvxDsdpRKbNitI7JY/TSirW0lh1djgrTm0HQc6bsxAkq5Ne24CFv6iggC1
         FBdT8Hmt/ThT/xRAhVBcjqndGZ6neLfvRcPbQXmMMyszqOCIo181Jqlsf3t0gDOS9OX7
         XJd1gGrqN0CCWC92zU+FgF3mcgkWhtzUyAPrxgXdNk2iSvJ44yX6G6ej58yTv+8CMY29
         jTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtAcCFYCAT9xcBxDi58VIA03b/P2jyXrcmCWuzYOVfDyecLHK8e1KrxEYWEiRcCt/ZwqaAd5eFUss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8j7/+6mKF6nI9bdJ4Ja7K/tSuH3k4pNZasKPLM8W7Z4j6POM
	xOZT9y8m9awOJjlIYrG1tHOjBJpO4QvitJ5hmNZrvOojn2YafSy9zi4tSvn7nEiuioiT1Ycq9jQ
	QajHU
X-Gm-Gg: ASbGnctYGyrFIlWDt3kSh3VBke/Xih20ocDXWkIB63hOb+QzOV43SByytpG7/XC3L7c
	q1tnIigNa1xWCH6ohQOhw2U+SthKuVIMgEG+GOXf0S4vW54u5MaRxDBrDhJqHMePdWVjv2mU1Eo
	VUzacnKkl53grGBaX1MJfF/tDCk/gHOpNfjaSwUEUPq8KUWTRbtW8+rdMrzMpkljN1zke9AHP/Y
	Erkr11IDCHQytc9BsLaJxSymW6VNvcvNetWqrelLhj3LJDw6J0GGllQKe2LtPpQJ6E4vLkkzlbq
	nYbc01f2U1cx7oM5kvRxeQR04ZiaDTPp1ghJW1syERlM0GFh7D2PMdWOvp+3h8CJafg=
X-Google-Smtp-Source: AGHT+IFBXOzd9iwnJcU6ys0n0tOScCaS96LTlgmk4/agHFWXi9OXbwsBntMcLQxbhIAYszAndNvzfg==
X-Received: by 2002:a17:907:874b:b0:ae6:c9b3:57cb with SMTP id a640c23a62f3a-ae6cf549b81mr155596066b.5.1752048089411;
        Wed, 09 Jul 2025 01:01:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b0336asm1061070766b.115.2025.07.09.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:01:28 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:01:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
Message-ID: <xkluxdj7ns3mxul7iadgd675t2yrztr5ywj73z3zimrpqpz5o3@foo6qpnmt7c5>
References: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>
 <ad575b88-80c7-4301-96eb-b34d97c5d5fa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nlx4gym6ltgwnmyd"
Content-Disposition: inline
In-Reply-To: <ad575b88-80c7-4301-96eb-b34d97c5d5fa@collabora.com>


--nlx4gym6ltgwnmyd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
MIME-Version: 1.0

Hello,

On Mon, Jul 07, 2025 at 11:33:00AM +0200, AngeloGioacchino Del Regno wrote:
> Il 04/07/25 19:27, Uwe Kleine-K=F6nig ha scritto:
> > After enabling the clocks each error path must disable the clocks again.
> > One of them failed to do so. Unify the error paths to use goto to make =
it
> > harder for future changes to add a similar bug.
> >=20
>=20
> I don't like gotos, but admittedly that's the cleanest option, so:
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

I somehow missed your mail before I sent the patch to Linus for
inclusion into 6.16-rc6. Anyhow it's very appreciated even when spotting
it only today! Thank you and sorry for not honoring that by adding your
tag to the commit.

Best regards
Uwe

--nlx4gym6ltgwnmyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhuIdQACgkQj4D7WH0S
/k4U5Qf/YSzRht495dMD2nqnQVOBbye9Zhk8OhgjT3q/FobP0sdpSL8jtIMYA997
ZBs2YOUYobAvfqlYRLI5GCpBr/3A0Vp8M1oeFb2IL5h7j9QjXHaQL8ZBHNUDZCcJ
Z4o7e6LnVrEnyokwK8NIrfi3VTtJCz3XuXp+f07bNuDLNtPT20dDD+VsHf1+qV9h
2FtzpRlVBXWqu5e9SyVPyjF/Rj2F0HkghPkEGrV+M0nRhMhFzZ92SKzpqzOAnEFg
EcG+foh9umzKYgSOgKEolj11hdHYp1k3Efl2CFRX+CpvP2T6FBr6zRZLiyL3LuNq
Arl5RRU8HtWOl8vMMNFO+D1Crq6r2Q==
=L+fW
-----END PGP SIGNATURE-----

--nlx4gym6ltgwnmyd--


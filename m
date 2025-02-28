Return-Path: <linux-pwm+bounces-5025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B2A4A643
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 23:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEEF189AE81
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 22:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0541DE8AB;
	Fri, 28 Feb 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uhr7Ylgv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DF1A3140
	for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783458; cv=none; b=GNugDz2cG0BVKKM8VnXHhO3yImdBrpoI7LfC4C51bjpK7FozY/B+xPrKNDb3cQGk53YHbU+6IdAf+p0GJ+Eelsykwb03KfLxmaLY/kvGTSUXF8UpjsjcSk3XuG+6oROThN0S+iiCeflW3cKljX0MIsh1fN/i4LCh3dpLXXsgmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783458; c=relaxed/simple;
	bh=8Dz5g1CECl6qQI022Ku13m6K/4FsqMwEoxJzi6L9fIE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd/p+ht2V6zWVHpncbnFJ+dwRT+bU3S4cbHYw3Iz194sLv5gdvvJEX+BBnaMr8UMVSAIUi7W1Z7Gq19ElmI3ua4U3V6T+tiv8WTyW/7WJ8DBgmTF2tr+tqPoHdeclikG+uNbkfk/imaC8QArLqx8O4dcnJPCbkqVhVBO49JvTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uhr7Ylgv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so4565750a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2025 14:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740783452; x=1741388252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dz5g1CECl6qQI022Ku13m6K/4FsqMwEoxJzi6L9fIE=;
        b=Uhr7Ylgve7bnL+IAmx9UZNa3/y0B1x2tYEODuMjy1x+XM7ZUjss+wOn/UA8XY+AEKF
         I7Lr3NBFCiIANLTG2OOC8KHNSic9to2K4Nc14rtzqwxR7+9va9G/kGG1YyD33SX417bt
         E78/zHFCAdLNuv5JpcUajB/aZ3SoDw6qLaqXVPjPTVZFWJH31QP578UgNcD0wwmqJKji
         J7yEFbZFFBp8UfPm5tHu0j37wQd8cUt7dnFXNd+kp3l2xNX6A+LVmePtL8FF/nbR66yU
         WXjOWxk/XXFqGj+9oTcWx24CV+tbyr7MerQNZeCILA/h9cYnPkuGf8PHPTBwTOuTTayg
         vSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783452; x=1741388252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dz5g1CECl6qQI022Ku13m6K/4FsqMwEoxJzi6L9fIE=;
        b=oo7J8SWIWihdBiRgt7hmxev/8h6Wyf9TR8fWQqt2jrRdEX0GvpYu0dvc772GvZYnpF
         CncNnhyMOaT/csmCZaFtB+cmWg6iqMyfF5zKM28gRdwy90xcAoHMHR0wAHXvE+CWLBLb
         bEB3WOI0WSsAx+Zg8ZqDDQIDECeAdEFxUSMSvAo0IZJOvhO+o3qDr/EFsHA1lz0M7CV0
         LH0pusRw5CypRRnL52UH6gc5XBRp526SfjnN43BFNg4NiDEJeEc0/d2lj17b/8re67yU
         b8UxPHmhYDNtveNNa7Q58Mqi6gLJEr+mLJDC5TOGPSYdjq4iNS4Tvfd99QL+gDyCJS+h
         wevA==
X-Gm-Message-State: AOJu0YxOgv5m+K3Uhh3iDtfHWzt1SDDkFLbTT4xJl6YSXBlFhgw5v1KY
	xNwFUose/Ull65WTZSPzDvaxrqlaujlA4Z7HJpONtN5g+BnSiEmNXm6WuqjOpVuRpTL8WBfRvT/
	B
X-Gm-Gg: ASbGnct8UlrQoJxtPMxRmnZvCq59xG6ukbpj1HCUz8vuUGXf0CN0p8XdVeC53Lf7evP
	eLIMV7koRcwlOCi8UEjQBT8hhYt37wbcg7PQYd1epULnE3+5DoTutQtHM9S6qOI3TXcUOKvGh/4
	NTbnYS3+5DsDzssGUUALn9nzGE/v3BlzjtEd3/GV2agUygsQ6nssuzWGEyOkDsftFDeEMdi+tFy
	ll+TXnXizZP3aFRnWFQYtJv9nkfbt+4KwXbBvnPXjFamMqXzml26Lbm4x/ADANqU4v9TCLAGetZ
	yhqGzoGTQ+EzNoEhNTcVfHam6rSCGgA=
X-Google-Smtp-Source: AGHT+IE5ed1Eg55FqjmiMWYwTHBdHSDUPgGGBEr1hpb08aRMpvZMujJJNm+vZSsSn/zjaNcDOQFc5A==
X-Received: by 2002:a17:907:3da4:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abf261fb192mr609136566b.29.1740783452435;
        Fri, 28 Feb 2025 14:57:32 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7bb872sm358572366b.165.2025.02.28.14.57.31
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:57:31 -0800 (PST)
Date: Fri, 28 Feb 2025 23:57:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Check for CONFIG_PWM using IS_REACHABLE() in main
 header
Message-ID: <ku5jtfwihybnvbnjgf4quw556phnluxajvlzcdriulpko74wkw@nnwipmoshzac>
References: <20250217102504.687916-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrpyxergvm5prjjh"
Content-Disposition: inline
In-Reply-To: <20250217102504.687916-2-u.kleine-koenig@baylibre.com>


--lrpyxergvm5prjjh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Check for CONFIG_PWM using IS_REACHABLE() in main
 header
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 11:25:02AM +0100, Uwe Kleine-K=F6nig wrote:
> Preparing CONFIG_PWM becoming tristate the right magic to check for the
> availability of the pwm functions is using IS_REACHABLE() and not
> IS_ENABLED(). The latter gives the wrong result for built-in code with
> CONFIG_PWM=3Dm.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--lrpyxergvm5prjjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfCP1YACgkQj4D7WH0S
/k5KzAf9GTSHcx6q2goR/br+G9vL1PqEh4xkqti9zfFzahzMX8mEewoVJl/0n4j4
xOMi18C53c6ZeQ5bcIhjneHQwkzMmROMXIVjLDwCL24F7qq8b55BaIqBPfZkd2Fl
EmxDD6zCGk2xKDt6C1EZu3eG1K8eHr/I7SChevot3N8BYY39VJAyIdUiBwiueV10
AU3NvTMjhW6Yj1ctaY5RlzFFpbuyDhWrg3ypcjYGyj7wOYm3N3jhZkxH6FV4nGN0
ng2CMWUleWbMN8FUiGK8nQ3dSFu0ugnv2BOVIB1tTqkORYKbIdPw7bV1S0gavTiB
TvfCiYk/YkPSqnLDE9uYA95wyHJIAw==
=zu4H
-----END PGP SIGNATURE-----

--lrpyxergvm5prjjh--


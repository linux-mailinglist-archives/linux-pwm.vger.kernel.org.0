Return-Path: <linux-pwm+bounces-5361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84CA7E00E
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E953A9D65
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE622F19;
	Mon,  7 Apr 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ixi6ihUd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C66FB0
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033678; cv=none; b=pNTeFESXJmBrUFqG+q59LOB+bRvgLUp6FoGSvTrTxjZRG+rUllz3jF5T+fj9rClFo4hs/1VRptyuFHo2nNDbegY6+hslBCWu5sdf37CuQrT/nNJh8aS22TMWWA/Hxzu6Kl5Sg37aP1kWsZJ2AbBplh9haLW1q/ngoKB3IaDnv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033678; c=relaxed/simple;
	bh=mSL0RZ4uoliOH+tSArIbEpowCvf/5d112H4ZL9YKGWU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFMBRDFG9JCaqa3/8YQovdIV/cluJpE8lj4mK7BQLNzwkqpcW9YOeyt1OlZ0RgYAaqlDfCVPLgs7AbnHcW9OC4c158NeHLwuTjfzLsPXCEOPuXKrWwqfzFxOpWlNbrKf34thRVc+Wqw2ib6oKRmBWeXZ1I6UjYIxcBbE5X2qGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ixi6ihUd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so582533866b.0
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744033672; x=1744638472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSL0RZ4uoliOH+tSArIbEpowCvf/5d112H4ZL9YKGWU=;
        b=ixi6ihUd8LaEGkvVFlTECS8YhhRx7VdJkljoNlJSRcdNDPl9VnjGgc8vpCgWMUgUAk
         +BMtybuYPLL9tdWmsBmqubKKA34Fh6xKomCKxteiPFlG/NFuRviIVGEPveXfD04KfgJw
         p9AAVlOgupKijTK9TWz7vNz4naxg2gtBrO7sHjLyWOMk65BM3+ywbEMAfQD+t0glRrgs
         eBt1IngzhMggG9/ITBmh7N7tynFxDPPwxBav1CQMQuWE6gukRWhaBPFL1PJZ3HxA36JI
         nFeT69DML4vI3iSDedHAlx0nLKPBt0cADiDze5bHlbcslE1Bs8RlDcnPLSniW3pJyGo4
         ooFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033672; x=1744638472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSL0RZ4uoliOH+tSArIbEpowCvf/5d112H4ZL9YKGWU=;
        b=YaAz7fyYR6NN3Y8K9rjFLln5qr8EX8m02jADr98Kzp0+WxzZTi7XdGJwGipJ6s5cNJ
         XC13wPN9Ycr55bX+d9gsKIScWueoXQzAXjlSihKQo1SBwef+/xGuujXz0fCpbgl95oG+
         YjXFTBP+HNoOUIDAMWRRPNya5bJA1HQ/6ehM3MHwV/RKJBAdSzQH08i4MFx/xcE2DpP1
         H7dkU72H5NtkRQWbfSmnx+wZAE+m9rmvld0w5jgclD8urXV2MIzcCqtpyVy+MfIkqfgZ
         Me618axbsrWorUHS1AiXIgotm+CRjqgok39PPM4etXYKANEKSve4jxAcFWLHP+ylw3cR
         TCFQ==
X-Gm-Message-State: AOJu0Yycq9iqNWaKilMWu0xZREDKKEjg28+blIh6iQ5Lstv04Tn7Db16
	ZAuBm5Ff8vrOG/+GaQNoydiEGm5Yq9rkfhHqiKa4TKcUXZIiHaNnx8vumi5WZDy6CJ+4EekuZSR
	f
X-Gm-Gg: ASbGncvcV86y/hFDgMn8A2P8L8zKS6wS2irVeM+k0z+qnsTOLdm/MvcQQsZ2XxxHf/4
	P/A8gfFzDujIgOM44pFHdXz3h1sumG0Wu2Q1b6lPxZx8CfPOhVhFK4aBvvmTMVzsbai+t0V+zdD
	Z3LetCy2QeM/SjTVjhGd1eQk/ds3oaWysjqH09ou8QJdEMqhkufsM2YH7zCl2vaveoRxHxUpYAO
	hZQuYdFT4sPmR8KmGUrj1FnFtSKGgEDn84wxo/8FTT7sqAygj7ZhoXBup/AW1+UrekG98dfbIKr
	SwCLtWXDYjpZDvuxhYk25EyVq/TPd2S9/oI+wjb8whtOCqZnfg==
X-Google-Smtp-Source: AGHT+IHqUzDk9nF3pE4yvVLU+Qa+gwCJp9Iv2UtrcO6SIcs9nSts2A4TbQWub65bZFflHcS0VQoZFA==
X-Received: by 2002:a17:907:988:b0:ac7:31a4:d4e9 with SMTP id a640c23a62f3a-ac7d16bc089mr1312506766b.4.1744033672440;
        Mon, 07 Apr 2025 06:47:52 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfea0eadsm754325766b.67.2025.04.07.06.47.51
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:47:51 -0700 (PDT)
Date: Mon, 7 Apr 2025 15:47:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Make chip parameter to pwmchip_get_drvdata a const
 pointer
Message-ID: <fcxafrxigtvlv736e6snuj3liur3rfwnavc2otuymtxbeuxxtn@i5c2xtrjf6vl>
References: <20250403151134.266388-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niq7knwaym6oigxy"
Content-Disposition: inline
In-Reply-To: <20250403151134.266388-2-u.kleine-koenig@baylibre.com>


--niq7knwaym6oigxy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Make chip parameter to pwmchip_get_drvdata a const
 pointer
MIME-Version: 1.0

Hello,

On Thu, Apr 03, 2025 at 05:11:32PM +0200, Uwe Kleine-K=F6nig wrote:
> dev_get_drvdata()'s parameter is a const pointer, so the chip passed to
> pwmchip_get_drvdata can be const, too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--niq7knwaym6oigxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfz14MACgkQj4D7WH0S
/k4Higf+O/cXoqPojGIN4CL1MbXPaAtRtLjXlN5ONkQp4Q0HVmAuau4WJL30GKzE
zD5bC8H2Q/h7euB+VGgG2qqcOc6doejhodT2CxTJJZYDGbae56vfvLwaS5xw3G0K
Z3yFVFpFkw7A1IbNaALSSgv4xdGUArTjkMkbZfh23wj+STdIsfvgqYjzlpQ84tjY
P0kyCt/Cg+FnYvb5L4ZEoIYkZ9HkMDRn7Ob2drnhj4huZCojgrz/XTumYQOnnyXJ
ddyMwvJ8iOP4xaSggmtRTbNFfZAr3d2lEVnB0Y+AqpVss62WVKGJuxx/FquaBUxH
FRC0jZ4XxG4BbBTFVOEintDMdvr9XQ==
=gUqu
-----END PGP SIGNATURE-----

--niq7knwaym6oigxy--


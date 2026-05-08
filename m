Return-Path: <linux-pwm+bounces-8848-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBAlAJXe/WmqkAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8848-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 15:01:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F84F6B73
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 15:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAFB03021AE0
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EB288AD;
	Fri,  8 May 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="OsNAYx50"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A43DDDDB
	for <linux-pwm@vger.kernel.org>; Fri,  8 May 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245219; cv=none; b=LZdwxHcM4n4IEfuXkD5Uq+TPVZYF9JcCVvBZij83Ryq/6abgaN+iUMT7u9wWYF4T6hveBquP8WQHEzkBCiWi+hqAIB+1jJfuRK4hzzqIHuJdwcjQwaN+Efj38rbg7p9Q4J/umtBaFKCwLQuOSZgvqyBKrlPljtqC46EfCiquV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245219; c=relaxed/simple;
	bh=H+pzZMqcVNHrQGygvPeDFTp2qtgnGuqqJsXL+kRhHX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3HlwEP1mmwpPylsobk0gs/wxz6ndrCwNJNcKl2GAuKPjevMdRIJe0+tAF3gXMe+d/PEHydXGzVM/P9kvEOwFOyau9iXF7w1/6LBPOUDQGcBTvRLv0XhmrgYLW1aK34SQA7HGws5CFNSX5UINnHOciV74qea/CmcENKP/2EH94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=OsNAYx50; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso23842455e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 08 May 2026 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778245215; x=1778850015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+pzZMqcVNHrQGygvPeDFTp2qtgnGuqqJsXL+kRhHX8=;
        b=OsNAYx50S5lagisGLIrzSVbXE8SmRlPDZj7xab5B+gxQr1OhpwYiTzvGDuofGh1O0C
         yZCUxehgE/M/5VKoRRirYQ0thDVBobt4yZdcWy73+N7Dhl3w5x7rESa/rAtMONv8GcjL
         YWSiQB3+P9TSPex6PJtCd4IyHBnrUJAE5nnrUYqPV+ASE3wWio//GyOjkzhI/eG/qkCu
         XmKIDMdsgja3cLFmEbKcIBYORMfSnWkPFsa9CG0xM2wjHVqMGav8Ow/wfFoS9fj4uP5E
         MRGTGZXer58wEGNO9ZUAsrJI2s+ukTTQQDRqbykHzLkjvjTs/8oeKGZIVh9c2adkSllq
         EB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245215; x=1778850015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+pzZMqcVNHrQGygvPeDFTp2qtgnGuqqJsXL+kRhHX8=;
        b=fn0bq2/HqAaPzs0tHhVbDFXpZtYIai9VZq/I8K3T9G/LtWzqtT3GnRVSUeKeg4cz55
         XCSNSwhx0UYI86GEhMIftvef/7pJtOyNbl7h8xU3uzCiso0nwwPouOQkzp7WCG/EbrAj
         V6ccG6TsV7z8o/BPVL0tCbwHIF6m0KgnEhIxqykKIuVtxVd0ME5gkiDd4yobf6oSlEP4
         ZRXypUayHXS9qpE7lhp4+H01va6jPbxcusL+2l0oqUMwiWeA1nnVi3tnWLxLR+wMf+PO
         ZZDDO/QYZSfnqT45NMV32WJfk4F7MzwwQEZhZhjOi2sYi1aIZpxgVhaSNZqLACDdo9Bm
         nCUQ==
X-Gm-Message-State: AOJu0YzQ0z4sd4zXKk2psWBzwAXhBEtE9bffDe1QQYcb5Nogp1Z4x/2Y
	nT263HCG49D4xb7NoA622Jn+oaMLx20yOPKQP9g/sxgDfYBkJP0nMwuhiedT9vd8lvI=
X-Gm-Gg: AeBDievYPrv2b62R2nOaWCs0VrdSv+D713pjb/Pqq4jjnkNzXODqqWyuEN5RW3bMPvM
	srOkLiw843kgBm1VeCOD7uR1iFSe3dyvXuTuybtao79Osw6lPSqtTpVi2dSwGqGJoshGSDSUepU
	iyw7LCpStemxH7kkx7UYzYNl4ZfgIhVfWcGHhkaeiTo+5Kg/vIH8zOfLmFI5F91JZCUY8g/4Qqw
	QU1PM1wYxbiFq2IDRGvX8Yealms+UMK8BVyK28GL+CTkTZLuxZPiPggV6vH39tDdrV7AMfaRpDN
	Pcn05yOddd/zxl9TVzkxtAEy6BEUqzBSb6PTffc12raBzbxdBNh9YOoGf4U1r/mLq28KhEwhYNb
	RFCXqqfFmhhCq6nYChCGeUyUUfU5vrDKx9/n7N8ThwEjniqWpZye0BK2jO+/sfZCnacma+dibZj
	3ro8nt5dZdX9grUuy+fwLGxBgP4hEnDTRGoRy9Fg1cympFrqFM9oTcyN1TdkkohXhkaZMUAHpd1
	xVmKYynOGdfPY0=
X-Received: by 2002:a05:600c:3151:b0:48a:7605:751e with SMTP id 5b1f17b1804b1-48e51e0837amr191333725e9.4.1778245211651;
        Fri, 08 May 2026 06:00:11 -0700 (PDT)
Received: from localhost (p200300f65f114e081c5a29ffa776f241.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1c5a:29ff:a776:f241])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e65e10397sm18026095e9.35.2026.05.08.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:00:10 -0700 (PDT)
Date: Fri, 8 May 2026 15:00:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 2/2] pwm: stm32: Make use of
 mul_u64_u64_div_u64_roundup()
Message-ID: <af3eKKiCpf-pQDGQ@monoceros>
References: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
 <788319f0fff963feca4df3c5fcdd471dcf70ccdf.1776264104.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7hou7ppk2yrmpvu2"
Content-Disposition: inline
In-Reply-To: <788319f0fff963feca4df3c5fcdd471dcf70ccdf.1776264104.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: D37F84F6B73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[baylibre.com:query timed out,baylibre-com.20251104.gappssmtp.com:query timed out];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8848-lists,linux-pwm=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--7hou7ppk2yrmpvu2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] pwm: stm32: Make use of
 mul_u64_u64_div_u64_roundup()
MIME-Version: 1.0

Hello,

On Wed, Apr 15, 2026 at 04:50:13PM +0200, Uwe Kleine-K=F6nig wrote:
> When the driver was converted to the waveform API the need for this
> function arised but at that time this function didn't exist yet. In the
> meantime it's available, so switch to the global function and drop the
> driver specific implementation.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied this to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as merge window material.

Best regards
Uwe

--7hou7ppk2yrmpvu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn93lUACgkQj4D7WH0S
/k7wDAf9G+aiX3BQ2bfaYJjdgIEJkJ1uqMaChVZsHE8UfZN3lwXYCTUAYwwNHISb
fD7c8AMwVs8ykrkQ7Z7UiwSqDK5e8E6aE/aDbdT6W49ZyhqZG7DnkdF3HqjKDTgN
ceo7nqzO/ciAVBB+KAF80xsUQZoFoLKdDS5sYCyaib0FovUnKuEGhuUfzirtbJ/u
KW9RdGF8C+UyRsiVmugaX6YLGUJEzgaXADiXX2ndsUsbkTZkMfzMhjBAS9oRL8uy
wGLj57N9Aj2uF86KpC823E1pjbDt30kZk5Syk4AvoeA3Sz5atXsxkgJm6Qeihfwc
7seC079+uAqQdmiOAWnX7PDcVV0ChA==
=CTCc
-----END PGP SIGNATURE-----

--7hou7ppk2yrmpvu2--


Return-Path: <linux-pwm+bounces-8767-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDthBIZq+GmauQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8767-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 11:44:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AD4BB29E
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B23F305044F
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54030378D77;
	Mon,  4 May 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cG2gdifd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493737E30C
	for <linux-pwm@vger.kernel.org>; Mon,  4 May 2026 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887579; cv=none; b=Rgm4FpE+XHkjbNR0L92nGAToXALosM+udqzoBW9dSWSe1RCukOoMcCGmCMG6NAoaBFi9g4xUZIus+BrwHiCP7yvKj9nKkFaVVZhnUXngLbVBw14vkQVhSV8+uiksbMcwXDLKS6oQEFs3HDhoV6Yo7AOMyJEOFdwJpZZaFIltgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887579; c=relaxed/simple;
	bh=PGTjrb2aAouyJ1vDQ+OxmfxqV9FcgNVpQoVY9ZJpj8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVvxTRKXtL2DNgMnDvdI/WRNu1Kpr0ZgwfTVT/kdji9FI1mAodXpE/+0IM9+Yh56edlK24gsiZ+55VwB/9GyFDJ+qanulUpyVdzZ5z5dPZx+kvdUHi0HKQN0kH7EoDpYXrrkbaLgcHOBDNMIf4atGo2W4MO5+S/51oCxI/0RTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=cG2gdifd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso26835005e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 May 2026 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777887573; x=1778492373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGTjrb2aAouyJ1vDQ+OxmfxqV9FcgNVpQoVY9ZJpj8w=;
        b=cG2gdifd4W6Vf/VnZT+VcZk34JaHB+ClJAY/Riy5cAQqXpcMwqtYVsRspw517wkQRc
         7NY8S3etoDKLsrh4LvAyQtJslHs9+q7xKgPFgEFganoskzD4knXqiad2gdTu1QQS7JUZ
         240/ED+VoBTb2fsdj6hVj47a/CW6YA6tHIrYpPwjY860aywK0t55lcc8p+M5raH9SKiM
         Tr0hvhYHmEfheuTQGreqbAQ8MvPVeb58vr/b9tPdf1psLQ75Y3pIY3uSaVpXznmJAT4D
         zotierco7p/lOefSLagMtFSHbpEDD4OhGd2jWkSCs1KzBVEkdvq30vQGpAnqRcI34DS5
         HGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777887573; x=1778492373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGTjrb2aAouyJ1vDQ+OxmfxqV9FcgNVpQoVY9ZJpj8w=;
        b=rheWpmj89F/9r2qdaUqUk2v0yNudCFjz3aBAH6gwN5LGoUfbM28rupFA1Uy5wzG3B6
         IqUJEud3GeBZeC9HQUYDdR8DvMyKWZ1KdThsisgn3lJfPwcYMLvLKp1hI3yZRA43NHdV
         OBBGM+3gVcY3tE9pAEHz73Y0ZHldTNaMgCRmegQYSeBnB3xteTn3gzQvey+xXcTeXiOx
         ADhofFLVShxs1B0esu9bNzw9Y8e+t3DiNZcs9oJolPuCe3G4ALZy13jKjZVkJgKFNd75
         hKXnpTP4TN3s4OgM+IXAg04ejgx3YK88XIOqcISsvgZNzfBZHLWV4tL/6R9mNcLtDYnm
         sY0A==
X-Gm-Message-State: AOJu0YwnC7VfvhRHllqXCoxvElerbuDsv+/upBq4DfmvPxeewk6amL2m
	0EXFrMeBI+GGzs+7JWxylHDvk7Ok2L8ApH++isj8zNvDycqhzzFa1DkN/lXv0wKuBzTP/NaZ9N7
	SbbpP
X-Gm-Gg: AeBDieuolgJgj8fezS3+xVDVe0XOYBAT1s98ijSG2EPvVAht5fCdUu858krQpawQa+j
	GUZmjfG7tUS/h1zecLWle4PEDHyvCE+TS6aYX/5L58HJl0TQ01Fn4udijhrh2kq/ONKJmHhMYJT
	PoioXnK1sgVSlcMaVuLm0x1lBgyrdaN8hEPc5V70lXftJPA5YVGTGYcg16cJFpQ3UaNS96opgSY
	B4xuPpHyXmc2MHzNhb+btMF7h80fqpvyHZ2bYZs8HpI93n+8SuD0EJRr0cJRsJT88N3JLna5Y2b
	ffJLu8yrme/Nycsiks55rAi2wHnxUoVsBzbxUuyyJP3xCXoA9Bzzgi99JJVJ7KIP0+Z00gX3sph
	uqQedq+HcN2gL6PI1owgwrfFQCJYamXYLBlhwhPddw3TdWmnffJ8cnDw/XpF9C4+9OzYB59B232
	qDlHXr8iQYs+uirr3eohrzP0vB+DsoZ4YDml1DM7OH5GbwTDIv0ZynmJUgyjD8Jf3peeguYc5vQ
	6aRhePiF08voxo4MfsxQvX4eoZo8RY2SZDo
X-Received: by 2002:a05:600c:8710:b0:489:1cd2:610a with SMTP id 5b1f17b1804b1-48a9887194dmr140216835e9.9.1777887573081;
        Mon, 04 May 2026 02:39:33 -0700 (PDT)
Received: from localhost (p200300f65f114e08f5a4175dadf07882.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:f5a4:175d:adf0:7882])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a822be902sm340602905e9.6.2026.05.04.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:39:32 -0700 (PDT)
Date: Mon, 4 May 2026 11:39:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Consistently define pci_device_ids using named
 initializers
Message-ID: <afho6JEZ0WH2d7RQ@monoceros>
References: <20260504085535.1914668-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vs3hhftnngotlizo"
Content-Disposition: inline
In-Reply-To: <20260504085535.1914668-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 659AD4BB29E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8767-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]


--vs3hhftnngotlizo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

Hello,

On Mon, May 04, 2026 at 10:55:35AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> prerequisite-patch-id: a31e1d7b9e6310e9c453afcd2037468686cb552c
> prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
> prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
> prerequisite-patch-id: 1fd68e883664147052540eea19769ea9e92d0138
> prerequisite-patch-id: fff07090df18a39a361bbb091a3f17223b4606b4
> prerequisite-patch-id: d0d54f7acecd560cdeb6ea0c0e5ae77a50695d68
> prerequisite-patch-id: 5011234352b266242ce01fd8babbf0459bfb005b
> prerequisite-patch-id: a935aab66aa9896437ab9d757ef9fdc859d22495
> prerequisite-patch-id: 344256383ec67df7fbbb6e35e4301d3d14b2571f
> prerequisite-patch-id: 14c277a51a268cdcb630d888c1bad3334018d11c
> prerequisite-patch-id: 93f14fa1ae7c71a1389488e87bf5d4ba8dbddf84
> prerequisite-patch-id: efe5e069be2c0c039e895fb10bbbf6510fd773e6
> prerequisite-patch-id: 21ac68c87f24f9e1d35f3268c04e5b40f93849c7
> prerequisite-patch-id: 84fb61dca584c253aa2e461e97df8aad59159c28
> prerequisite-patch-id: 8e7cee5cc55dd50271326313cb258934dd8c3579
> prerequisite-patch-id: 38526e2d87a08a78ccdefaf3261751220d645f15
> prerequisite-patch-id: e608a54ff3511d5345f0b396fd5d8e9b003b31ec
> prerequisite-patch-id: 4a715d89f621a2ffb364abeb15db3fa2b9b83317
> prerequisite-patch-id: 6d049443e6399e1266e06ba412601308b0e44cdc
> prerequisite-patch-id: a42f44b27a7bf3795c177fd5df47258463114c9d
> prerequisite-patch-id: d8b8fe8728706b0abdae18fa7a77fbb50db89aab
> prerequisite-patch-id: 2c85231c5c460bdbe3293d275e6e7b9c135a5e7d
> prerequisite-patch-id: 60892ec2e01f3559dfb6791d3f13035d46b01ebb
> prerequisite-patch-id: ed9523b310540069539cab89374600fd0b23a043
> prerequisite-patch-id: 3619058b0eb67d71f94ae209ea44f7e6645594de
> prerequisite-patch-id: a867be2bb1f4f5afeaf4effbcbf1a3b3d32655bb
> prerequisite-patch-id: 1a8c38d82ef577bedd1a665b130dde53ca32fb65

This is wrong. These patches are just conversions of other subsystems
that due to how I create the changes happen to be below the patch under
discussion. The patch applies cleanly to the base (i.e. 7.1-rc1).

:-( for having made it (maybe) harder for build bots to check this
patch.

Best regards
Uwe

--vs3hhftnngotlizo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn4aVAACgkQj4D7WH0S
/k4jQwf+OZjRwlVoD50zXZsunqMr1T2S7BlC7eBM1Zmdui9D8UAi1Y7C0vx1ptaP
/dq5GN033DOudJ/BY5A04wkRR5/EhAP2FILy7pCJoTTrfaf5wNLCQ6VgvEIHst/P
mZSCyXSV62D62wgyfG8CDhcVkogkgtgQXLY2gRlNARo9B6LJ/4fqe8paqCgj1IbV
QOblTCjTXH1a6qdy9uoizWlhyrGKx9GbNF52dYLkU7hxZsQH7JB9ezaEI7HVl3rY
DFZykZVzYrYrtv+AFeGULpzcO0AGdZmDxJbJSeAqw+ynyBFVrVJ4kCRRWZU2Z+5t
+WY/f8s/aqSNBzBLeV5j6jd8LAhahQ==
=L+HC
-----END PGP SIGNATURE-----

--vs3hhftnngotlizo--


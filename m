Return-Path: <linux-pwm+bounces-4071-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328AC9C4904
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875BDB2EB34
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D0C1BC9F9;
	Mon, 11 Nov 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eddNke6Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85A1BA272
	for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362187; cv=none; b=PF/9Qhg4hXPLyiWCGg82c2mjdH2M2M2BU0/AY98uwmjKM4MToqcCtY3F5osnmitQvctKH6pwNGde0B53x7aH4HZQvWzGtnT2zRtqxJaHlSgrXqkU+yCeBRM/ycqhAzkqBGVFAN4HUeqEooh9Ut7jApIfCinFLg+rgHjeLrtQfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362187; c=relaxed/simple;
	bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjSUk83XqZhDcLl197+9pWjq6p5/rXIAax1NVgB7opmcmieZhtd7/6jLbl9sfbLW6jKArxsYhR8uHXVSS9vkmobFky4TpV1HriUidDg01HGE7rxeT7+LVgFIgrEjLLhqe3TEyVaQ0jmNQMhntHwCwimJDWQsHicFSaj+vOBPOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eddNke6Y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1097208a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731362183; x=1731966983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
        b=eddNke6YaiV5+RYnZnZbtkM9cFrKj32uXHpxEwZfVcptFUKobYv+K7931+pWlh+Jjg
         ZjvHulavdBaAmdRL8rz22JYtLfUTxLfbbq9AWv2k9SBp5hqjssoK32qVV3lOdGQR7nZF
         TMNGX7OpcC+rkX9EveElbzq6kTP6tajBqE19u/7+5Mh8k79Z+9NnUSbs+G7Flye7i1EG
         tRkYjfmzzBbG8lvASN7hRzejshKvDxY9qTIefiKYNTKzr2zx2uo79UQdNUaN0kYII2XA
         DKqCXLMe+q6W+ELpLlLp73B3wguj7cXdJoDOvL1K3wKBThQ0IKWKkO53rtmhFXE0cenY
         UM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362183; x=1731966983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
        b=vzBueAQapIL8g7xRhmiA52Yyi1N1AMXD2agXJFUyVf4FsUC5F+2jquor6FlbZMc/t8
         7S5JHJ/0SZirTGQgBhCee2QtXSRMtdcDdikA9243+IudHpKYbcpnQHIFqnZMgNdCnb8F
         PpkQp2Xx+LYkDRHWoQyxHcblZ+7UQnaBWU3Mos9G7VCgphKh23bI5DTD3fm3GF6lVOEj
         k+GJuenqRDbT3im6tiF5GkXvAN2ww2/ipZnw742kW4a/xnr9ItzniS/SpiQ7TAIN4sao
         0Ql04rELOqKL08ysbWvUSxvfjd3cPIg9zhDnfAHx+AhcBkSzxDk97wapzUzIqbPoVLng
         gxdw==
X-Gm-Message-State: AOJu0Ywt7kLgAmrMKJ70Y3ccYujsdaWAo2XHd8Nt3ONLrZzWsFGqBlFh
	I9rjPmgljgOmH375GrKp84XED3LaepFeu7YoeaO3SY3ORySsfEHsWr2x8+cLe7U=
X-Google-Smtp-Source: AGHT+IESSpILR/iPGZm0pAhRtjg22DxKyqisSYGKu95NrISH3frP1PvPbrRXMGKpBiJ0cLMHB83xqw==
X-Received: by 2002:a05:6402:518e:b0:5cf:202:57f0 with SMTP id 4fb4d7f45d1cf-5cf0a4fc0admr14132879a12.12.1731362182661;
        Mon, 11 Nov 2024 13:56:22 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:5160:f0ec:2465:28a0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7cd57sm5263715a12.81.2024.11.11.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:56:21 -0800 (PST)
Date: Mon, 11 Nov 2024 22:56:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Replace deprecated PCI functions
Message-ID: <dewm5vj3owzv4z4c7r7coev6dxsiu3gtecavve6h73pui3vmcw@w4zh4i7vdobd>
References: <20241111090944.11293-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faadkvccw56m7kg5"
Content-Disposition: inline
In-Reply-To: <20241111090944.11293-2-pstanner@redhat.com>


--faadkvccw56m7kg5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Replace deprecated PCI functions
MIME-Version: 1.0

Hello Philipp,

On Mon, Nov 11, 2024 at 10:09:45AM +0100, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()").
>=20
> Replace these functions with pcim_iomap_region().
>=20
> Additionally, pass the actual driver names to pcim_iomap_region()
> instead of the previous pci_name(), since the 'name' parameter should
> always reflect which driver owns a region.
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
and scheduled to go into the mainline for v6.14-rc1.

Thanks
Uwe

--faadkvccw56m7kg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcyfYAACgkQj4D7WH0S
/k5pUggAjScI9j/x/+n0cffC7BTBFHTwo9/8/l2A6Qq7JehofXA1wO3Ct4oPvny+
d27Go6GDo8EGqt8dPSz8ZFZnJO4z/8oOAeW3HyGNKCYg/6jmDCvLZMWUSOQGPjFv
UnHIY5BJULDJM3Iw2LIBnMQb6UrZ7w3RoBsaqJk6cr5i1kf2vm9hblBlSqtKjsE8
GTV+mysLp8rJFPvVkY6NfHjNlAAMTIiTIbFr4zfMlOsvuP3D2cXuX2It93qYclix
sOoZrTjZatzwbep8p6puMZT4erhBbizw3mhFBwLXZkI1loUGi+9/Hm5N/NYFcTJR
EByH+W/ihAXSyOoX/I8+FpU9ZpRo/Q==
=TPlp
-----END PGP SIGNATURE-----

--faadkvccw56m7kg5--


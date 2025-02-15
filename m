Return-Path: <linux-pwm+bounces-4921-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588AA36EE0
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6921D165B14
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9941A2643;
	Sat, 15 Feb 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="29XZxOgg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871271624F4
	for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630595; cv=none; b=Sz4OsfJEm/S+0OORD0BI6oS4tJaD7n8a4R63uI6Js1tagJVFiW4cEoUOKp74PfwgYbaZSMX92rVNE8UCOkQrwvDqwUNw029JwMkRsi0pofMpgldrD6gZ2pQlaaiKZ4IxW2RIM3lvf0UbWcfSA9FEdBYuAcfgnd0S2SV2sA6biSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630595; c=relaxed/simple;
	bh=Whfttpy3sYQ6iKxEh1K2lzapOgmvl8L18ErwsGHvbkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEd3rnCCf56NQcq7PPBDspimM9H2MziZYksO34cZYr0e/WrcyCGrFCofqfkBN62r+xP6DLtHK9vlbYiSbpTS5JI73AR2YxFjFo+5BCME9nES9YmrC5R/EDvcFv0csZM8D17mHKtzjAc5g/PpCtnPC/rM5tcKR624bZIcPumgiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=29XZxOgg; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so4647106a12.3
        for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739630590; x=1740235390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Whfttpy3sYQ6iKxEh1K2lzapOgmvl8L18ErwsGHvbkM=;
        b=29XZxOgguC1CNX4Fuuv62sqgqN3akB+CCUBit50x2cPWNHYgPDyUUuVTg/s2EqECw4
         i3DBem8LsU2no8CYE3Q5fmB5+8qd+SRXpjKPqJgP4eE5IbiKJwbVTr5jMiCuIzsKySd4
         taf7qWZDqq3R+S8zu+YyEapo6SA3vCNtb8U9hPkipZ9r+J6CGncIuRQoXDkYIO0y2kg/
         NlkST0mDzPV6Fh8on0l3CaKLHEqRY9/QuNXdThSG4gSniQjRq+VA1bJvC5Hk6sS1im9D
         0CAqf6Vmf4VsawGQ1Lk+YnjTT2Aa+L+JHIDWhRXF6pYqkS3nbsNnQ36b+7Dz3MNgo8Ko
         mVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739630590; x=1740235390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whfttpy3sYQ6iKxEh1K2lzapOgmvl8L18ErwsGHvbkM=;
        b=CyTihuvsQYxGJwGFrUB/3prbrnHDFCaJDrpCpKdSSMs+Ynk4aX9DjbAd7DfURvTZDY
         ep7TtMEvk9NOAFa3gtGsOYS44IYvdBahsNdoPIArAyqmiPjCM5nN1JzMbRAN3QuaFfup
         93dKaqsSutY/rxOiuQVWcW8FVUHYsE3UeR/OuxewYJE8W6qKMV0mkad+qnMHVFL3QlTV
         m4O6jelx4I0akFz23o9TWDZ1OFo+Cmn/8u0zDm55y0M/hnvXTNoPVLFrv8QhI/5ilDhD
         CbS72Uc+qUBjdfsofmglIIitNp3z+fdRl39VC+0pFvN+SilAMz5s6OlOf006wEYZNojj
         OK8w==
X-Gm-Message-State: AOJu0YxDh20I5yCRbpDtvNkSP++XWc+zPgmeI5mnWd4C+xwstt/GR6tM
	gQH08Cd1BH94Cb7Kz+i/bQ6TNPOgdZzMnnqnGM4aozL/yV9MsUMGgl/Ktcy7wmBKfH232FUXYrM
	qqFLScg==
X-Gm-Gg: ASbGnctpFupSV0vT0p3dXBY3KBy0Hpbq5LgbBWKftcXDKJ/MzxtiIS/ivFZCB8+rlWB
	kPSfv9LVdcPUGtTgC4CV1QaVews48a3OjbaNn3fQaXNThwRoAK8QmFfBKJ4umI9lYKmfDuxXv+Q
	NNlNMnoWZTUwGvQ7bCzRteM+9JsYQ45ZNzfjQojv/W56JmSelMmb9UvbGrATtA1jAPiR4ztL/bt
	my6YdU+0dqVoD/DaeSji6JOHE6+qine0hhn1YJOBy00+dymu45kBZMcgZrNcS/aG5RmgGTzVbkN
	pWZZI4q81W4p4nUXyn0W
X-Google-Smtp-Source: AGHT+IF9V3ZdK3uwfUNuA7uzybMTFs3FPandYOZajnIJZut2oXQyf0jdir87Qtobw/I84l6+TOD4xQ==
X-Received: by 2002:a05:6402:4414:b0:5dc:91c6:8096 with SMTP id 4fb4d7f45d1cf-5e0361effd3mr3920532a12.30.1739630590587;
        Sat, 15 Feb 2025 06:43:10 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e03aa0b1f7sm1128324a12.2.2025.02.15.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:43:09 -0800 (PST)
Date: Sat, 15 Feb 2025 15:43:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: clps711x: Drop of_match_ptr() usage for
 .of_match_table
Message-ID: <v6zwgjpo5wrikbrmyxhuhsrux22sfblmog2x2pupy2shobf4s2@mrlc4d564d3n>
References: <20250214163442.192006-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7coxxkyjdk6z5vhk"
Content-Disposition: inline
In-Reply-To: <20250214163442.192006-2-u.kleine-koenig@baylibre.com>


--7coxxkyjdk6z5vhk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: clps711x: Drop of_match_ptr() usage for
 .of_match_table
MIME-Version: 1.0

Hello,

On Fri, Feb 14, 2025 at 05:34:42PM +0100, Uwe Kleine-K=F6nig wrote:
> The pwm-clps711x driver depends on ARCH_CLPS711X || COMPILE_TEST. With
> the former being an ARCH_MULTI_V4T platform, there is always OF=3Dy when
> ARCH_CLPS711X=3Dy, so in practise clps711x_pwm_dt_ids[] is always used.
> (And in the case COMPILE_TEST=3Dy + OF=3Dn this only increases the driver
> size a bit but still compiles.)
>=20
> So drop the usage of of_match_ptr().
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---

Applied with Andy's Reviewed-by tag to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--7coxxkyjdk6z5vhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmewp/gACgkQj4D7WH0S
/k7GAQf/WgwmIsu4X0Zr8vKY06z6s90Tzj9k6Rhn9CutP0YvJrWlW1XWN/wGGRzX
nqlKAOBI9J4yMAA87y8r7jRZzujvIIHjkve+ATIurEM0SXXhJYmpeABIfE+yXjub
QjLbQ/hhVrYvNmrlK9HM9YwAcXjq9vrB2d+ATNbTH1txT3o3b/cDrzFff0mwPdVx
2h9HEezHEMmZr7QltXiFt6Lec3qJkwO4KnKT/LTSCW/mAzPRkKza3FKi2moSgptu
C0YlUulOi+Nyb8lJS06spA+1MR+lwNIP0fQMF1mrWcxMXAp8lNCMnPivUC20Si/a
0l26OtJk5N50ODUFXXPU0lb7poPbSQ==
=EQ4N
-----END PGP SIGNATURE-----

--7coxxkyjdk6z5vhk--


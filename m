Return-Path: <linux-pwm+bounces-4922-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1286A36EE2
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A233B136A
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCF78F35;
	Sat, 15 Feb 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KTLvfd8m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0AFF4ED
	for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630931; cv=none; b=ninUWLTc2rjHEY/Jm16SrvbseGchWjvnHOz1910Lt8H8xyZUbhAsHgFoBbnOLS7ZLfzijiAll63WJZrlDUSL6HfmIxQS24LI/7fT4ps6ulld72ocXAPJtQeiLrR1QqmNHrWhQJgf5ET4hs4KwYwblh8PoALGPjpbuBkkrCn0f3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630931; c=relaxed/simple;
	bh=f/fEPwwDMe77+WuuQ/lA4U3XsORecDk3y3PKKVuf06A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1eZNFtNMgBEGMmQBy9RBNzC+0NNCzoXDt/Tu6v1EECNrvl9+QzGwt2CpCbak/NHQC4UU7MK+8iZLPX7gnbySa7TGpGAAcgej1tup/PIqFBLv3nM4WO0iNBUQQ5VoXmnihBYPK1lqd5/jKSSqSZMssYkHLoX927PxXRFpZHkPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KTLvfd8m; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so290974a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 06:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739630927; x=1740235727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lbg1N+wLayi/whWMrltZrWn7zwfnnHHeJrDcaKiX4Ps=;
        b=KTLvfd8m9/qMSRnQsretEBOOBNixuhRvBWHZ1p+mentp+JnYFCOk1PtBicczUb2Dmt
         SuCTJ0pl7neAXdeW0a0bYIz5gM5b4fIIbbFGzVRi/Cfns8cBEqk8n+2DD1148uNCZMMb
         MBVuQ2Uvm3cwXzhexMza1AQedY9oyHJfbWi5bVgYbRBSmz/tEM0DXeDCLAodoGl8Yx3v
         LMVEwtwolkoHCc7ZDScXx0KfsNUz0SlXUjw+Y28/+SstxNWVbWbluhv4HLFXjotZcKhT
         RZHwqOTCzxAJKFju9Ksl+dndgBlmUhpbKFAvXnRMU5gSgZ8p6r1OE4+QaIro8FTTAoW5
         Tpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739630927; x=1740235727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbg1N+wLayi/whWMrltZrWn7zwfnnHHeJrDcaKiX4Ps=;
        b=pKcvkGYqTY+Pj+mjd+99CiA8uh/MytFxHiQSFQJtZ7niUx8TvuHWY5EjplPykg0gjN
         yma5x23fmgotpXjgNFHWLuy8P7NHYBwL+AGe+O8IZrOwWkyzhpfZ4NvUXq6livPexZeW
         JNMGmR8KIAMZTlJNpmR/UnRClAAvVISyxLcp1gCl2kbZsAw7oi5MtOv62/hdoLJDme0a
         54OwriSANKR4mYzqpZnArVrEAFJ65UopCkNMwN3gxvnHHXzCIbDKYPMhWUWm5I9tTyYR
         kuS106nra30iJ18cGHpiuLqZtiBsQCc93ycRtE33vMvbD+/TaYOUOUxAM304BAA4ZJal
         NTLg==
X-Gm-Message-State: AOJu0YxLl5pRm3XBE3J1iuQD1Dk0wVYGV+JmejSJ+Nz72jFGWJk8tGuW
	ioWbwbwHJTWtnV/5aitKim5BxKwdOjOG6sf7x7wdEnWfAsXgXwag9CWplzTEgSI=
X-Gm-Gg: ASbGncswxYdhDsFBdnh3lLcLkOavm+6yRSC3aIr0iThYJKw0mdov4vX1kjX1dAS8Pqq
	E7hO06dVwjJ+RrfA3fBmRvdAWrZr7F1uTHOCzh0rghK3+BS0PFYk8ASAKH3iqb3CJTOFkHFD3Y3
	Ei07kBIHoqaCmNTD023PLTjOOrmve2ZYwZmSNThABq0V42OIXe59SNFyx8hEQDbyjZLc9G3ZB+i
	9Xxk1CIwDvQp3u0p6UOksYzmGWehD7VJ//2sjE3Gzup5RyYa8eo4uLIyk5lJQLM5u2tbiaFj3rH
	bY+oMAa3WEgWqphy0vLK
X-Google-Smtp-Source: AGHT+IHGUJDSLwV8NiWicLHO4Iozp7Nhzo5SqFKK3mYQs2c37P7TAAIEBh9jKvZYNUC3E+8LNP+rJQ==
X-Received: by 2002:a05:6402:2394:b0:5e0:445f:9577 with SMTP id 4fb4d7f45d1cf-5e0445f96d1mr591569a12.22.1739630926630;
        Sat, 15 Feb 2025 06:48:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f65sm4535781a12.1.2025.02.15.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:48:46 -0800 (PST)
Date: Sat, 15 Feb 2025 15:48:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] pwm: Strengthen dependency for PWM_SIFIVE
Message-ID: <ts5ze4fosj2vg6pokjfqx3tjernjug646kihiqikxfrhk7tzbl@whgq4nuhni4r>
References: <20250127105001.587610-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="abah4d5y6c23gnb5"
Content-Disposition: inline
In-Reply-To: <20250127105001.587610-2-u.kleine-koenig@baylibre.com>


--abah4d5y6c23gnb5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Strengthen dependency for PWM_SIFIVE
MIME-Version: 1.0

Hello,

On Mon, Jan 27, 2025 at 11:50:01AM +0100, Uwe Kleine-K=F6nig wrote:
> Back when the sifive pwm driver was added there was no symbol for sifive
> SoCs yet. Today there is ARCH_SIFIVE however. Let PWM_SIFIVE depend on
> that to ensure the driver is only build for platforms where there is a
> chance that the hardware is available.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> a quick grep suggests that the driver is only used on machines that inclu=
de
> arch/riscv/boot/dts/sifive/fu540-c000.dtsi or
> arch/riscv/boot/dts/sifive/fu740-c000.dtsi and for these ARCH_SIFIVE is
> enabled. So I'd guess this patch is fine. Still an ack from someone who
> knows this arch better would be very welcome.

Applied now without further feedback to
	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

=2E

Best regards
Uwe

--abah4d5y6c23gnb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmewqUkACgkQj4D7WH0S
/k6PBgf+NdlhPNnLRvoXn8ieJ1IOw9v5VVkzZm5tJWQNbYaQF2b/VJQOPa2i1nmB
Lbw/LoU4pgrGjhwyZ/f1xs2TLqiESJRBjQXT2jre/SoU0BvcgmDUEpFdAlXxeuc6
gI3PhXJgik2DKrNZbvOa6mT4J1VF31up07n3mZGrmU0sPtwKywrNrEdQLOLTpB2k
r/tikPD+OdiqCdRNxMZLsDaePEK6/X6RlplAr8yjcZMl+jNCfUmDlP/I7/LLEkGK
52A0jazwJ28ocX0GKi+gy7/5v7IJ5jZpBtms1dXaJITbtff5ELv6KSYEqNFGSxBj
sKpcnKoT8/eXeZqKvpsp4OhjQuM2Wg==
=Y4rI
-----END PGP SIGNATURE-----

--abah4d5y6c23gnb5--


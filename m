Return-Path: <linux-pwm+bounces-3827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59B9AE87B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D65B2557C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749801E6DC9;
	Thu, 24 Oct 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO8ojSh9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB81E1C33;
	Thu, 24 Oct 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779136; cv=none; b=SV31HwW/x3YVdzaZQQaM/Mlbam+k/TyTR68/FqLMbH9ntaNJMkUAbDtG+nnXI3hUC3Vf4Sash7zrBIaBzW2+6CF6KCiEoQ5rlAEygl5pYkvkaB27MRC8HVsjpSkdRh8t6h+4pH0d1XrlmS6BUTU76NaNcDmC9Qgh/pZbVfTgztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779136; c=relaxed/simple;
	bh=Nj1ebmcv/mm+UDNIZ/dfe2bFowbODDJCifUQEhsRIc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWUMIsTZ0T0CZn267tXThIYOK5hVEQ0XYpak3aF7w4Lfx/xu6Sp2CFSQV3WRW8tDeSOfumJiRg7w50bEG7Ae//gLtVRQWppSORd31nX8+983bZ9JDhSvmbFObDYy5OCRoBOjcAzU6tTfZ80HcK/dqekl1UvOWE+vzzrP3fWM3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO8ojSh9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso124221566b.3;
        Thu, 24 Oct 2024 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729779132; x=1730383932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nj1ebmcv/mm+UDNIZ/dfe2bFowbODDJCifUQEhsRIc0=;
        b=OO8ojSh9WDsj0rSgpByfnZd8pchVCJixVmCqBD7Nuq/IafPo//zv4YvTA/jlmifCb6
         F+sVpCVvOAz5iHnEPZw4xhzQO0+Ck8MlVUTwhNKnDr3ADCw/8KDNtac1+qngjzLVZWMf
         M/QOHhBiWqgmRyaKwpM8rvTQcEP3f6urnJlFIHVDx2yRXoouMxZAr1C5PbpQD9SxHQih
         4ryQY/MAY/y9HTia1nzCqLKRG7p+7MgQZ08sl/zG7mbPMaBGd7UH7XLAX0BCPV/yiCIs
         8t8VwXenp1F3vVOqXjFZMOmLvs4wuvgcLZfG6aZhCIX357yj8vSFdoFofVxQz2y5Rh23
         cYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779132; x=1730383932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nj1ebmcv/mm+UDNIZ/dfe2bFowbODDJCifUQEhsRIc0=;
        b=M1hfSyAFg+CcONEC7HzZUIxreW4aC2yiL67qybvvtItkeOHr76k4S2JEtIyvkI7m91
         E5p0ZMq4LvTg1sStrCI3+/918mnE/BrMebXilZV6/eQKfk5bJpmpYl61PPfXPJRFTarE
         xEYfGr9RjpDodZ2SWzx/V2Y7eudQPVsNHy2Wy4AiA67VaWrYDAGzpG3FF+jWLicc1ZTp
         nUDRi1u6DPHxun+Pn2p9t1Jx7V7xB8S7cJSHH6FZJpKZkWyIZRz1TrDM5bnXiW8MHsim
         hhwjJp812s3KKsz0JSsBBbwB7ZOQ7M9cDrb8zOD6N02o3tVcZl3lqDdExohs9Oewbekj
         Zy8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdtsi0NSvF5w9GLMocYLbK9+SBiCHsUPBQa2Y8TbnSUb90ApqjIi5sEhK6cjzctLlkeG/sNWK4QOds@vger.kernel.org, AJvYcCVjEPYBHTLeivO1s0jYtIDnkNmT3fG0gxXaDDuGGHE5q4WPtX6N0aIocPmCIjbeX1bgFza0oyD6vA+8@vger.kernel.org, AJvYcCWPqg0b22MDkQkSNYwcKwn80m0crJYIhGNtIzfye7mZbCGEUI9baRnme6t0GJCr5kvjdExp1knRpn3A@vger.kernel.org, AJvYcCXNyyHoN8M7BUuCFcpkpUZo5tSBRPjM+4NxswhUMDlWdCmu9oFp6g0EA70Dm1UHXvFX67Njt8Nesh5O@vger.kernel.org, AJvYcCXjF2z3wqXa5U6vPgAZ1suTuXjX0hU5E9UURxKB8krZWFiuFLQRqJeaaloI2saz+OYddMyoLiKcX1ndL53W@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVBYtTEkX8wmGP/rcQ0JTqI+mDefSnoOtZcsb7UAkn8y0GvNV
	ElvPGegIS9TwzFipYJ6+5+UMk0z3Jf478IXE29S/P2FyGoQKl5Sy
X-Google-Smtp-Source: AGHT+IHpDlN3uiwFaGU+NjrmHJnbgiUpiTHuzfNHuRoy7uR9tWOnbsFsdxmjuDvqcRRC+hYZGgSCDw==
X-Received: by 2002:a17:906:7309:b0:a9a:55de:11f4 with SMTP id a640c23a62f3a-a9abf96d176mr580734466b.54.1729779132047;
        Thu, 24 Oct 2024 07:12:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a214sm627093766b.213.2024.10.24.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:12:11 -0700 (PDT)
Message-ID: <72afe00622075f77b410e9537cca0a7ac5a4cba3.camel@gmail.com>
Subject: Re: [PATCH RFC v4 00/15] spi: axi-spi-engine: add offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Thu, 24 Oct 2024 16:12:11 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> In this revision, I ended up changing quite a bit more that I was
> expecting.
>=20
> In the DT bindings, I ended up dropping the #spi-offload-cells and
> spi-offload properties. A couple of reasons for this:
>=20
> 1. Several people commented that it is odd to have a separate provider/
> =C2=A0=C2=A0 consumer binding for something that already has a parent/chi=
ld
> =C2=A0=C2=A0 relationship (both on this series and in another unrelated s=
eries
> =C2=A0=C2=A0 with io-backends). For now, the only SPI offload provider is=
 the AXI
> =C2=A0=C2=A0 SPI Engine, which is a SPI controller.
> 2. In a discussion unrelated to this series, but related to the idea
> =C2=A0=C2=A0 of SPI offloads [1], it became apparent that the proposed us=
e for
> =C2=A0=C2=A0 the cells to select triggers and tx/rx streams doesn't actua=
lly
> =C2=A0=C2=A0 work for that case.
> 3. In offline review, it was suggested that assigning specific offloads
> =C2=A0=C2=A0 to specific peripherals may be too restrictive, e.g. if ther=
e are
> =C2=A0=C2=A0 controllers that have pools of identical offloads. This idea=
 of
> =C2=A0=C2=A0 pools of generic offloads has also come up in previous discu=
ssions
> =C2=A0=C2=A0 on the mailing list.
>=20
> [1]:
> https://lore.kernel.org/linux-iio/e5310b63-9dc4-43af-9fbe-0cc3b604ab8b@ba=
ylibre.com/
>=20
> So the idea is that if we do end up needing to use DT to assign certain
> resources (triggers, DMA channels, etc.) to specific peripherals, we
> would make a mapping attribute in the controller node rather than using
> phandle cells. But we don't need this yet, so it isn't present in The
> current patches.
>=20
> And if we ever end up with a SPI offload provider that is not a SPI
> controller, we can bring back the #spi-offload-cells and
> spi-offload properties.

Well I do like we kind of gave a step back and are more focused in supporti=
ng what we
have and know at the moment. And I think (for what I saw so far) things are=
 being
implemented in fairly flexible manner. So yeah, as far as I'm concerned, I =
liked what
I saw so far. Hopefully everyone can agree on this so we drop the RFC :)

I'll try to look at the remaining patches tomorrow...

- Nuno S=C3=A1




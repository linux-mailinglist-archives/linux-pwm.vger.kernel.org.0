Return-Path: <linux-pwm+bounces-5950-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2202AB5797
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1382B3BF92A
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E11A9B40;
	Tue, 13 May 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL3rZcb6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D074C14;
	Tue, 13 May 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147850; cv=none; b=qCTQgBOe/IZywTpkRyqU26dVmuEljXl4MdKIMp6eZVpg0Pe+fLl7uu27+SgwligUURutWG6LRM63aP6AfPHcRcwgNmGzUF/s51PCMsV1mGYh/WuW8SoKE1Fnc+n9cfEFGoCB3OzIe4K1HjqpGD70qzYUjUQ/NsciEka8X0v8ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147850; c=relaxed/simple;
	bh=EJgLkdmNfb2EC2JqowyZq44VPRZLvDgdTYRcTpr1w5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsjRiGLctNM8ylC2xjaKWomtpQoHULd24ezStybjgqDZdj7P2wdrRsq/1hoEVe0snGVO7XHEJuenbg+su9qCnn9XDnkld/B5XRrwW/Nx2ffpbkADFdRdSYXtfP+01BUR1RV/2CK6t6zr0zoCc8VJklD8y1GF/J14XdyXfQnsPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL3rZcb6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so58199855e9.1;
        Tue, 13 May 2025 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147847; x=1747752647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPfB6j/v47j+7/OUbK8UoG5JuGrhxLLtIVyyV2s70Vo=;
        b=KL3rZcb68M54ad8tJd6496SB8haJIriHvKc0IC0sF3bf+6rxBONGsPZD2kfS0p5vbt
         T+PfQdoYXqSZcgMUUjEBAseodXAxNJdkIIaA03R5JJNfqyIMAuQEpDkVhAka9PCrdMIm
         ox3l6u4f5QlznDH7TTXHnJP4TQTzavHdjRGFibk7A1dVlorqnw9WczVbN3xEZxF8gr4N
         37R2aFAYwdyP62hL6oOeOWYIZZNaYQhEuvi0DjII+PRNoL9tyJAdYngPQ2K+YM2oOwfL
         Qt+TyQQLdZsPvfE8ZEidsoqibd7NCjGwUPFRNRQFz80hCAxRLbKp9xTIx0WOQheZLMG+
         L75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147847; x=1747752647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPfB6j/v47j+7/OUbK8UoG5JuGrhxLLtIVyyV2s70Vo=;
        b=a8+mQkKY8sDV5vGyCn2zUIEyyWjGXmJkpQeDTcuzyYMTBsFr0Xz4zhtrIjstFnxtG1
         TVN+BCLZLpRtNBav9SgfBbHjeBMkXfi0fDq2tGMc9zLmYv2pqsACgLNgAa/fJpadtyow
         C5QFO2vZ+Zs38omVUJ3zQI3i14liXAEcY5mcscM4Vk4mG4uErgzgB2apxKbqBMuu79yQ
         0t0SZx7AskvZfFpYZpgdW85Fk9vZ0MXcYFxCdQVC++YGLKxfhyRE4IA/kT9HfmBMuVrk
         w8y+IkpZaKJ0E35oXWFW55bmZDiE1bCI+9oCEd+0BJpIvQodFgEEgMwX3hWT865bN41r
         xASg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/QXhHTkYxmH0yRYsJUXnEhhqzv1XLGQVLDT3dweSZIneHqXUDEk9CPxDk5euBj0z2kvZw6gOFljl@vger.kernel.org, AJvYcCUU/PJFviTyVCJiw8tbaxyIeNWufa/AIILdmXAM8NWdDNFTJHpvc/iQyH/JL9zD01AxxAoNPx/kSWMI@vger.kernel.org, AJvYcCXl3PkLZk5dAiT8ZL79Bzdy3gB8JHDwtareeJMUToqwRr5aiMrvrEGr3pLmLxK453kIwstNJO7J/WeR5Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9phzcjtxtNAh2b5LBlqTsaquILAzeJquI1Elk9AMyFAY9o3w
	BXTyzgQeLnpE9jxS2uFmWiIQq2DQeL+cDU9QIyYXfEKvFBaTLB32
X-Gm-Gg: ASbGncv9MaBGzcCklKAmxdyU1VCRbrk4B3XiYZDeiNe+6NIhGYftHO8YUMutzoB+Cd9
	MMs48MyEJMHCzHMv0XOxoqBKeYFMxCeGvqE0bXTwWFCYc0p/oBlnywyxX2TTvNbfR8HsGoNndvC
	dJZ343dJXUcobBw6JaNRMQ0lgyrRzloTc3UWuOK8TlMsw2+031WYszHbAZ9vkOpxL3SETwIX7pO
	b2JrnJQN/Eb6CP+wx/5AaMFTfv766mFN9zJYKHG4VqW5jFHfVzII/ly89V3ciuDoFVMzrLURvYp
	V0e+f8BHYuYctSZFFhIsauRoZp1Me66w96nF7M0leDtTbdpEucCnahEW0twOsfg=
X-Google-Smtp-Source: AGHT+IGFemJjMcWp+Er+bfzAIVa7zMX/Y93kIKn7ld8VXr9Aosl7W6bRXwxWBs5QutFPpayuRRY/kg==
X-Received: by 2002:a05:600c:5297:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-442d6d0a9dfmr163766255e9.3.1747147846900;
        Tue, 13 May 2025 07:50:46 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687ad31sm169482165e9.34.2025.05.13.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:50:46 -0700 (PDT)
Message-ID: <549b84e16ce3fa07e287662910ed042268642acd.camel@gmail.com>
Subject: Re: [PATCH v3 05/22] mfd: adp5585: make use of MFD_CELL_NAME()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Tue, 13 May 2025 15:50:45 +0100
In-Reply-To: <20250513143942.GN2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-5-092b14b79a88@analog.com>
	 <20250513143942.GN2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 15:39 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Use the helper macro. No functional change intended...
> >=20
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > d693b1ead05128e02f671ca465f9c72cab3b3395..19d4a0ab1bb4c261e825596306240=
59529
> > 765fbd 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -4,6 +4,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2022 NXP
> > =C2=A0 * Copyright 2024 Ideas on Board Oy
> > + * Copyright 2025 Analog Devices Inc.
>=20
> If you're going to sneak in irrelevant changes, at least mention it in
> passing in the change log.

I actually thought this was needy and is present since v1... Can mention it=
 in
the commit message in the next version.

>=20
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/array_size.h>
> > @@ -24,8 +25,8 @@ enum {
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] =3D {
> > -	{ .name =3D "adp5585-gpio", },
> > -	{ .name =3D "adp5585-pwm", },
> > +	MFD_CELL_NAME("adp5585-gpio"),
> > +	MFD_CELL_NAME("adp5585-pwm"),
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct regmap_range adp5585_volatile_ranges[] =3D {
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20


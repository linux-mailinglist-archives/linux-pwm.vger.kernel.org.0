Return-Path: <linux-pwm+bounces-7625-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D2C5C5B3
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4473AD8E0
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80630102B;
	Fri, 14 Nov 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBMmQAXq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A23304984
	for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113569; cv=none; b=Jnf7TlzezMWd4IuLEWGsWWgr/myRyrvuqdSLNwonZa9nK/iDQqSS3T+gpoa/KHqCa7gy5QeY206bd6iCrvYG6YZzzmyYHi8GjGkGurpr92rnbORPgpbropgauhV1HhmpriC2twHWJgcL1qa8rT8U0cVLo/aLsqpSR8tsBsyiEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113569; c=relaxed/simple;
	bh=ajCREfT/hcJRDBbyJOi3jQMEdUT2txP4PezLHt7RVuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKIHtbtws1kJaIheX/DiAvgve0hVylrzs7wE/VLeMsuVDy+AsGzEIFXjLuS00zPPgoPJaiNBfBe20MS0cPqmheDC5YbUgw+1mdmeEoHuvJnndUO9piYDHshN5gNTsj4p21oa3xAV13VdqezsGCkSTqweyBwpMmhSu+JeXR+xyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBMmQAXq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477442b1de0so12037605e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763113566; x=1763718366; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5bwqEJshLQG2pK67j+3WEK74xje3ZFwPQhZbDPgILsA=;
        b=SBMmQAXqf0ETquKTKF04tRQ9J6y+ojJjIWPMaVmSbGOZCcwYcsecP5l9OFpCC5XfvN
         1CthhUrl3cBGTWRO8O9f4XVQV8JJ6066kwll+g9KbxZVo2rEkY3i8sQkRp40FTBOnDmK
         0dotcj0zMntYWLGZQIwqAMrP54GVBFGEfqlKKNCnH6ldPsOFVuhKfQaDS/t+MJ5+XwbG
         WxHbDOb0ieWnZyQXzaw9B0LKQHlOAcIXjhe4PFwyoaHcxxay40p/QhCod+kg58tjiSDl
         Jp3IHufofQArrKPYnVEtAraT5Ajeeud9VhJw54HBJ4d2u18d1zkkASOHM5aoCCadPxm/
         B9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763113566; x=1763718366;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bwqEJshLQG2pK67j+3WEK74xje3ZFwPQhZbDPgILsA=;
        b=Bv6JHxf0LW+M0bGUjxE+W5xvb4gGHcN3Pgx0E2njmEvPwXvOGFPTikD5RJXKDwPXW7
         XTRUJwy8qn3oSz5ao0PYc+Hyn0VEQygCONJFkRPODOqrF15dKr9im/YKr4ZsyPs+vgWw
         6oM/WxwOxB/BhjD+OhJ04DDibFEhSJtyK6X9MpsaVB6Ct5bEebhn26KYfO/SlaTHlnz1
         BQKAwIewNaCFUEnke4M652snaqHhfxnu+LD4ew+2jgwpPHXRXq47jKiu3oOJzXTlDsL3
         UeUU+qyyOVAwz5YuvljguEEtjAhy94idD5PS7C6HaILopWA1Qa61tNHA5KO61BO3NYIK
         26OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZAhoCOAVBBoqJFMMoRpAdOpUwFRo66PSSAlAYdIS1hvw5VTAFtuDqXuQJgkli/7gxGfonqV55QUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIzMhrc5e89tWRu2Zp3r4tD1vYBHOCyf2JoYBrYz4XhjOVkT0
	xNCkPTKxAOiO9i7WaZ6Ti0SW36o0++jOWvoxrKOqrjvBgaKOUdtrRiRW
X-Gm-Gg: ASbGncsgLEXiAwaegKnmunv1bVQkfr5cN968yniy+kVVExEfLIWQ78cAh9xrBjPo+w/
	m74aQSvzyDgIyKNXI8dlg8KJ4+J8KuS/YrYLz8tf8uCG8w9GEZkKiIuijKy4yJ/c4M2MnvMT/hx
	dV4T6EJt9hjS+e7szLdGrvcToC3Cqy3F1JSKWrLq30X1yN27SW9tJ/nSMxJAWODlAghUQVXxchR
	Lqrq8R77Bh4Vt3u/v2xvaTSu24Lj41t5WEMieBAy4jzLxLEsybBGTAyB5hiU/Bnw8OmL0iDO2Iq
	1E6zvvuvCPqGnXioL3x/LSzms4I5pFhqwEGmGQdzPNGWfP4SJKZiSWKV55+LNS8ZMnFWdnAzhyC
	k0HxrMwA1a30RT235nkAe1o7kFR0JhfHajvUnJYNZKBEU2RDmDwbNFxZHol2nS6sqtaqL5UuMlJ
	ILNuUji9OBrXADt0PuzHk=
X-Google-Smtp-Source: AGHT+IH/jWTFHh9aKpcCWJvmgpXyHpzOKiaHuKZDq/cY0kpC+Nuc21cAjdAdX+5mcEWPkyyHNGr6Gw==
X-Received: by 2002:a05:600c:474a:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-4778fe003ecmr21077485e9.0.1763113565466;
        Fri, 14 Nov 2025 01:46:05 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e45677sm143331965e9.8.2025.11.14.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:46:05 -0800 (PST)
Message-ID: <34af5576a5e779a279975dd9fb8be7c2b233f661.camel@gmail.com>
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, 
	ziniu.wang_1@nxp.com
Cc: laurent.pinchart@ideasonboard.com, nuno.sa@analog.com, lee@kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Date: Fri, 14 Nov 2025 09:46:43 +0000
In-Reply-To: <jqsmjigr65kqhlk3buybrcurllqxlad6zkkuwo3tea5uqopqzl@ldwbjsndltpk>
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
	 <jqsmjigr65kqhlk3buybrcurllqxlad6zkkuwo3tea5uqopqzl@ldwbjsndltpk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 10:30 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Nov 14, 2025 at 02:53:08PM +0800, ziniu.wang_1@nxp.com=C2=A0wrote=
:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >=20
> > The register addresses of ADP5585 and ADP5589 are reversed.
>=20
> My German feeling for the English language suggests:
> s/reversed/swapped/.
>=20
> > Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
> >=20
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> > =C2=A0drivers/pwm/pwm-adp5585.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > index dc2860979e24..806f8d79b0d7 100644
> > --- a/drivers/pwm/pwm-adp5585.c
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_devi=
ce *pdev)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
> > +static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
> > =C2=A0	.pwm_cfg =3D ADP5585_PWM_CFG,
> > =C2=A0	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
> > =C2=A0	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
> > =C2=A0};
> > =C2=A0
> > -static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
> > +static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
> > =C2=A0	.pwm_cfg =3D ADP5589_PWM_CFG,
> > =C2=A0	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
> > =C2=A0	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,
>=20
> I wonder how that didn't pop up during development of 75024f97e82e. I
> would expect that the driver doesn't work correctly in a very obvious
> way without this change?! I tend to want to send this to Linus before
> 6.18, but the question makes me wonder if I'm correct with that
> urgency. Any insights?

Yeah, this one I kind of asked for Liu to test it (as I was not testing the=
 PWM bits)
and he did tested it [2]. But it was v2 and that series had some more itera=
tions. So
I suspect that I messed up along the way and the last version of the series=
 was not
tested (for the PWM bits).

[2]: https://lore.kernel.org/linux-gpio/3efb68e2-7091-47e1-81a2-39930da5a42=
7@nxp.com/
- Nuno S=C3=A1
=20
>=20
> Best regards
> Uwe


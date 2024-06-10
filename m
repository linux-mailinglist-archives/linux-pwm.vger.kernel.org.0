Return-Path: <linux-pwm+bounces-2393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BC9901C5E
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C516CB21791
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1F63C7;
	Mon, 10 Jun 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkrSSlNV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C661FDD
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006820; cv=none; b=DxHUEwgfbMNZQz6np/7AAmRawQiOczCcSy/x+eCg9km1qiSBW2ettQ/lbhi54zjRhJL12XAQjoWtF4Vt+f6p3z6LRihFGkYvHd3MIxICQ+dQ1MM/+HydUCB92ue0dQ78singLj+DCmqu7fFqkBgkDYcdHQsjbdlyockn+/F6+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006820; c=relaxed/simple;
	bh=5oOTWJnPuiMtph2wbh1iNyiuUn09IP5YAQihoiFZ/hQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpX7/W96C6KHW0QBRl8n3zxRO6GBsFtasNMnZVJQmtHwDtkhPgO3VyRuLf6c60n7hGJpT3X6l2n9eJPqm0DF4ycHT35xkW+zHJvOBDz6JIIDJyAZl7FRAJOwgX8/iLCWJByAc6KbhuFGDQOZs3qEuWkphEzNShn6/bcJNJkJMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkrSSlNV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so1069519a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718006817; x=1718611617; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5oOTWJnPuiMtph2wbh1iNyiuUn09IP5YAQihoiFZ/hQ=;
        b=mkrSSlNVpskOA3+9IDnKg2Cz4mV4oToG3bCTKMynsShmlvMaWxVQuclZO3K5Jxl0W0
         R7P8ob8h0luTumDPn7gxbgm4/UCbkrVibblWs8lqzGHRArDqBirZSEJ/A74sWZjkefbL
         X7HeHTCSmnACup6gHuljyKEmWTtkN8JxibEqQX7mmt1qw/rGL2YFG4KkVsFAckv6lLAP
         PI3sdkN1N6eqHMrrjC5W09UZcyt2wz2sMvfzrad0PkFSMCel3bUgFvlJPXU4bpgdeOuW
         xbcqF9YAEl0k/PCi7J8h96JRgiJ1EB1bS6OvL24XPIWPrDvvjDqfJXcORH0UXQA+Zh2Y
         uF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718006817; x=1718611617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oOTWJnPuiMtph2wbh1iNyiuUn09IP5YAQihoiFZ/hQ=;
        b=qI0sB7ClM/WAsdqf4HRUxJuhabcVFbpXw93PwpXad8Ep4QSLLOI7YlpV1TMbhU4f58
         2i98jzXusmXW4xMs9qeKglZKJ23S14/bAMHLoVYzXpwlwVqbY/Vtex/8X2MEF8KuCYfL
         xvJiqzYz6pmTEp9ax7kyUbxLiVBCGHfdFMZ41CmbqOlSIzzBXiQbul9qr1Fychy8UW+T
         M9tnuT4hGnZ+1MzybX+DmCrZgF5U3N3KiCOwaMHwrPEIiw3xGCnFddFkQiVV6lAsl3cp
         cAw5Pe5i5bNBSX3FiDXMTKC5Sz/RsoF/0PAH1p8t+OOUcEg4p3lEqrwX9I50LDtR5tlY
         /OTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ8huqacKpN43ZD+UCERIpZu4HApShIrooOwXudx/14j6+zq4jVYkO2RQhyF0blwvLvqw5sBjc8yMPZxhnzZDyosYewk/1o6F
X-Gm-Message-State: AOJu0Yx4LDe0pTozVAvHhTzQCuH3YAX22nLsNbQbaGwrmr3M51B+Ml30
	T/Sn7AqXjW+RdMljsHcJKWt0CRb8Fx3t2EKioe1ONxClA6eSx2CgLLLmXcCV9VQ=
X-Google-Smtp-Source: AGHT+IEMVVuqcqxCz/DwMglEYKUy1ZRfKNNIkCrTff8/ysgwQNBsPUvgF2Tc9U8kbF7VMPsPJXlI4w==
X-Received: by 2002:a17:906:12ca:b0:a6f:1df:377 with SMTP id a640c23a62f3a-a6f01df0516mr296866166b.55.1718006816510;
        Mon, 10 Jun 2024 01:06:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2323f7sm7026712a12.85.2024.06.10.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:06:56 -0700 (PDT)
Message-ID: <28680a1c88a680fc03de9256c14f2553386c8190.camel@gmail.com>
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-pwm@vger.kernel.org
Date: Mon, 10 Jun 2024 10:10:44 +0200
In-Reply-To: <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
	 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
	 <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
	 <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 07:53 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nuno,
>=20
> On Fri, Jun 07, 2024 at 08:40:32AM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Instead of using regmap_update_bits() and passing val=3D0, better use
> > > regmap_clear_bits().
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Thanks for looking at the patch. When I apply it (using b4) I get
> however:
>=20
> NOTE: some trailers ignored due to from/email mismatches:
> =C2=A0=C2=A0=C2=A0 ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> =C2=A0=C2=A0=C2=A0=C2=A0 Msg From: Nuno S=C3=A1 <noname.nuno@gmail.com>
>=20
> I'll add it anyhow, but it would be great if you fixed your workflow to
> have the sender match the address in the tag.
>=20

Yeah, I'm aware of it. Sending emails from my corporate email is just too
painful that I use my personal one and an email client that actually fits k=
ernel
development. Til now, it was never an issue and this is the first "complain=
" I'm
getting :). I'll try to remember this for pwm in the future...

Sorry for the trouble!
- Nuno S=C3=A1=20


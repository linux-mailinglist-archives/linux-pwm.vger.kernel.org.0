Return-Path: <linux-pwm+bounces-2780-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CB92F92F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC23B1F24823
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AC14EC73;
	Fri, 12 Jul 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIaiZ/V7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC9146D7A
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781833; cv=none; b=nQ6P5KgE2kDjA3ctP0oIuaNG82jMmhsEEoqBLoLYeBQBjB9lSx3j8o7iDUqZG6CCjQCflBvm6vSHbWGcXf2FKsm37gtLGA8ohJlqycAOQYgl9BOD+y7T5px2m58C8Bgm6J9vp7AJsSBY68JEcVhKq98pXZHUs7dc3yIT3H/0m6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781833; c=relaxed/simple;
	bh=FvGQ6E1zkTFF2hYyXkrFwgHNUoRnYb/yNF0+tUtDMvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgCX2w297d1l5gDMiCHorTAyWHdP6AhUey6xiqf+gDyR753efPezC9ChdgM+gd8inxzHMzI9FJn+ZvyHLuJJ39OiqyvtLgMFRTti9elbrd8an0XDrq+1AGy3kpXlHP7fjczp95uQskhokycJf/Ut5qlpdn1EIp2aScsqUjjh7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIaiZ/V7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42679f33fefso12440935e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720781830; x=1721386630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgtOL082WZTsJAeug3L4TOOF66Ki9aV73G2f//iNPMk=;
        b=HIaiZ/V7tR/tkwbECvvZOBFN3XAZxysI/kuGIoBEQpLkr1mMdGu4+8pZ2rypqz4x5W
         z3JgJnnyjXYgi8F0ukXFe94ZGkSz4sA+FUwguS1zk3LcHR9DKq8LKGN7X2w7qwY6Xzzb
         1A8gtaGgqc5V5/mQIoZYRX00t8NWSGzDNAspdaix/vMenykADnTihCb3eUhqhJGR6m0W
         6EpfH+AYB+BPtsYGDlzkD8Buux9vA2yla+0Il27u0WmM4JcQF8f2gR5zNkS9lmqAC4X1
         loSEMWTIx4MD1Jus2UA5216HFPa1i+0vpxgT+oVaEtGdrdsPD4+Om7ADr77EhsgjB4U6
         gDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720781830; x=1721386630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgtOL082WZTsJAeug3L4TOOF66Ki9aV73G2f//iNPMk=;
        b=o3h3eQlG3sfXh5X7X0kD0DKUzxnaEr/TiQeOmAJEp2DgoTk0Rj9lSYNuWm5sQhZn7k
         SLwFOyJpzS46RUPqq8+zv20UZUhM/+mktYSnqjxiw42omiGkiifR2Hu8KSP72m4ufQ37
         pn7N+dRyI6pImZcPD26+iPxUshTdTz9nD3I4pomp5vtMHHFYomKQ8DFwDVz+rH1lJ6CC
         KolvGLvSRh3hCkmpbVBSbYLFQyUECkqi/xMB4e3n+9Whd7JiRRhrbl8YHsagJvWnPdtz
         sht8hkIU2dCW4ZFNFBu7AzuZipquapnYpxt0MiqOQupPe81dL/MpKVltCBgQ7O7y6z6Y
         3Qhg==
X-Gm-Message-State: AOJu0YzqHrsV3ZtysS61t6FKyEpI37JZYeJhlFsAYjeE3XZY/JwNaBrd
	7o97AsaVzrMmUt3xAr8hMM9OYupft5W8eb96IogjqXRsqG2Q02AXCE/cFaNAgmM=
X-Google-Smtp-Source: AGHT+IHTH5ilkdKhDl3Q/of+l69ZVZUrrfom8jpjgf1X6qX8G+tk52E46mC4hV55kEcLOeNyrX9lLg==
X-Received: by 2002:a7b:c458:0:b0:426:64f5:b10d with SMTP id 5b1f17b1804b1-426707db59bmr65977935e9.14.1720781829976;
        Fri, 12 Jul 2024 03:57:09 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f28c31dsm19306225e9.28.2024.07.12.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:57:09 -0700 (PDT)
Message-ID: <d625777dfeb5a53a232835e9abb1f39de55e6a17.camel@gmail.com>
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org
Date: Fri, 12 Jul 2024 13:01:04 +0200
In-Reply-To: <hogxczszsbqtxu7b2dgllyclnr2pztellxzq3figkhdlajhowi@6vmjvyoifkjk>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
	 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
	 <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>
	 <hogxczszsbqtxu7b2dgllyclnr2pztellxzq3figkhdlajhowi@6vmjvyoifkjk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 11:48 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jul 09, 2024 at 11:37:13AM +0200, Nuno S=C3=A1 wrote:
> > On Mon, 2024-07-08 at 12:52 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > With this change each pwmchip can be accessed from userspace via a
> > > character device. Compared to the sysfs-API this is faster (on a
> > > stm32mp157 applying a new configuration takes approx 25% only) and
> > > allows to pass the whole configuration in a single ioctl allowing ato=
mic
> > > application.
> > >=20
> > > Thanks to Randy Dunlap for pointing out a missing kernel-doc
> > > description.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> >=20
> > I didn't looked very carefully at the patch but one thing did caught my
> > attention
> >=20
> > ...
> >=20
> > > +
> > > +struct pwmchip_waveform {
> > > +	unsigned int hwpwm;
> > > +	__u64 period_length;
> > > +	__u64 duty_length;
> > > +	__u64 duty_offset;
> > > +};
> > > +
> >=20
> > I do not think we should have holes in the struct given this is an user=
space
> > interface.
>=20
> Ack, will add explicit padding (and a check that it is zeroed).
>=20

Why not having the __u64 coming first :)? It also save you 4 bytes (yeah, s=
hould
not make a difference)

> > One other thing is how likely is this struct to grow?
>=20
> I don't expect it to grow. Extensions I could imagine only concern
> things like:
>=20
> =C2=A0- request the currently running period to be completed
> =C2=A0- block until the hardware is programmed
>=20
> and these don't fit into pwmchip_waveform and would require a different
> ioctl command and parameter struct anyhow.
>=20
> > If that is expected we should probably think in adding some
> > __reserved__ parameters or maybe to modify the interface so we could
> > make use of:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/include/linux/uaccess.h#=
L348
> >=20
> > Like wrapping struct pwmchip_waveform in another struct with an extra m=
ember
> > forcing userspace to specify pwmchip_waveform size. But I agree it's a =
bit
> > awkward and ugly (but it could be hidden in libpwm).
>=20
> The size is already encoded in the ioctl request constants. So I think
> we're set to use copy_struct_from_user() if my expectation about
> pwmchip_waveform not growing turns out to be wrong.
>=20

Oh, indeed. I had to go and remember the IO* macros...

- Nuno S=C3=A1



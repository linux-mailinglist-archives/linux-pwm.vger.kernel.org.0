Return-Path: <linux-pwm+bounces-2790-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFE92FFA9
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FB71F243CD
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06D17BCD;
	Fri, 12 Jul 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0RoSmgX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84835168C4
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804849; cv=none; b=VEKnhe+C2laKh6PAAc1an+OfXPD/wSVy+x+vOWkdiRD1Dxevq9S79QvVr/+1Z7foeQhTndQRQAVVTHiGjfp2+/Q7kWHlMfxbIW/2B6XlLUPW1X5xQ/nccOFl7g32r78CGUg6cHDPmOUnnSzZmmYsy2Az5ISJqKcAV4NHbT4gFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804849; c=relaxed/simple;
	bh=QKr0cjKnuFVDbYdw/N+mVbbiyCnoZZ6Btt8nVMzUjmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6bhPZkbaUvmDgnSoXBQKS1V6ukGT3Hqus0swoiWtU4pDzXzsG70gCy+nD0rvSg9aFKq7FLSzueBHIG5y7MsRe6EHrrc/xai7frt4M8lDWvtZHDpdpRXHMnZTFjVdDx/3ZS4Kqz12d8ixxcnf+Ol9IGT72jF8V8yrjvp2HYvSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0RoSmgX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so34841771fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720804846; x=1721409646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6F7f/8Mp2jYHfVGrtNaBWj1+MIVz6QinD7fS37vRcwE=;
        b=i0RoSmgXzzCb5hsKnbplOY37bsW5W7kl2GaNniUXy34lNK6W6FPZ8ScXdsQTGw4FX0
         NOgc21ewoDMD2BQWAMum2PsWqN59TZyCC+Pb9l6vh2gNigwm3NrMSSgPyF3vhXCm1i88
         Fy421DJY+9N312W9tECHY4gvR8yNJUBFcMYI78K0dNhtg/c6JKMJuNKgodyRyx8EvKxM
         XyMCSdBpkK1kgOaRXz6Y9gUSE5vlI1CmxZeWv4fCKacjAEcltSZnh30p4AIwMg07rqlf
         9a5H6wI/vYw5wS7nq9Zj2AaPnaVqjJZ+PIy1fzY8GQaGUSrH3GzRnsUTTI/ZjAW+suqe
         mWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804846; x=1721409646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6F7f/8Mp2jYHfVGrtNaBWj1+MIVz6QinD7fS37vRcwE=;
        b=kvUa5Nx4ONGaQ0zY7zVqy5v7pgGUQWJgVOrr8mW0I8XHerJDCFYgUXid4gd/eylbXL
         n3LbKkdBHBrIhbYx7wauLwFgzmWFbSL44IGM70R97YW2sMSbCk5NOcGGKfjqQe+9T0qy
         rshN9i1Zh9Jb77LUZ5BK+zcWr7t8d8RIb6AcJ2WnPnHy8Rq5PuLxasmMoYmdxIY6DXvm
         2G+Op95KlIM12/7Us2aemlJKG4IWhrzHXAtV9cxkCBCdhdeppP9LExr9wMeYkL+tQDA+
         SKvsSb0JjpJF2NCHYndT5PS50seifFlmKgi0h5alP3zCDbTuWyxYybMdTYHSvADtsl0t
         Y/kA==
X-Gm-Message-State: AOJu0YyOTwJWXUExcM4e2vq7bDF9eBbEEPXL9ODSKGho8pBp88P10Omc
	Dqh4yxKRw8fSwWnUfb2PCPV80IHG25S0lreucm8VxgpHXd6R1y3s
X-Google-Smtp-Source: AGHT+IEe6Ph2QRlQEVwtVW0DFyTXzB/oqVG6lVXiohGNGi+6WwPSA4I1tfwYcMG1EJeb5tvbH2OWOA==
X-Received: by 2002:a2e:9b0f:0:b0:2ee:8dce:2f92 with SMTP id 38308e7fff4ca-2eeb30ba7acmr98327271fa.1.1720804845211;
        Fri, 12 Jul 2024 10:20:45 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f264911sm28626095e9.12.2024.07.12.10.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:20:44 -0700 (PDT)
Message-ID: <d3c3f69e1e2561d88285738e28ba733f77297288.camel@gmail.com>
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org
Date: Fri, 12 Jul 2024 19:20:44 +0200
In-Reply-To: <lsl34pvo3vbnqwnzrv36fguasxxb3brrgq44e2w3flgrdjzlx6@5vx53mvpi5fi>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
	 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
	 <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>
	 <hogxczszsbqtxu7b2dgllyclnr2pztellxzq3figkhdlajhowi@6vmjvyoifkjk>
	 <d625777dfeb5a53a232835e9abb1f39de55e6a17.camel@gmail.com>
	 <lsl34pvo3vbnqwnzrv36fguasxxb3brrgq44e2w3flgrdjzlx6@5vx53mvpi5fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 18:28 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Jul 12, 2024 at 01:01:04PM +0200, Nuno S=C3=A1 wrote:
> > On Fri, 2024-07-12 at 11:48 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Jul 09, 2024 at 11:37:13AM +0200, Nuno S=C3=A1 wrote:
> > > > On Mon, 2024-07-08 at 12:52 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > > With this change each pwmchip can be accessed from userspace via =
a
> > > > > character device. Compared to the sysfs-API this is faster (on a
> > > > > stm32mp157 applying a new configuration takes approx 25% only) an=
d
> > > > > allows to pass the whole configuration in a single ioctl allowing=
 atomic
> > > > > application.
> > > > >=20
> > > > > Thanks to Randy Dunlap for pointing out a missing kernel-doc
> > > > > description.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.co=
m>
> > > > > ---
> > > >=20
> > > > I didn't looked very carefully at the patch but one thing did caugh=
t my
> > > > attention
> > > >=20
> > > > ...
> > > >=20
> > > > > +
> > > > > +struct pwmchip_waveform {
> > > > > +	unsigned int hwpwm;
> > > > > +	__u64 period_length;
> > > > > +	__u64 duty_length;
> > > > > +	__u64 duty_offset;
> > > > > +};
> > > > > +
> > > >=20
> > > > I do not think we should have holes in the struct given this is an =
userspace
> > > > interface.
> > >=20
> > > Ack, will add explicit padding (and a check that it is zeroed).
> > >=20
> >=20
> > Why not having the __u64 coming first :)? It also save you 4 bytes (yea=
h, should
> > not make a difference)
>=20
> Well no. First conceptually hwpwm should come first and second there is
> https://www.kernel.org/doc/html/latest/process/botching-up-ioctls.html
> which recommends:
>=20
> 	Align everything to the natural size and use explicit padding.
> 	32-bit platforms don=E2=80=99t necessarily align 64-bit values to 64-bit
> 	boundaries, but 64-bit platforms do. So we always need padding
> 	to the natural size to get this right.
>=20

Right, my bad! The third point about struct sizes is also valid and would f=
ail with
my suggestion.

Thanks!
- Nuno S=C3=A1

> > >=20


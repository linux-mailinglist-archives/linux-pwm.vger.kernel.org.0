Return-Path: <linux-pwm+bounces-6631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41ECAEF622
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E9D167409
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B804271471;
	Tue,  1 Jul 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY7VmB0r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46E221281;
	Tue,  1 Jul 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368144; cv=none; b=Nt1e5XRe8vz290LGqRD38kJ7xvI4aXWrj15WEjU+uUJRerVr52Eg/BarLJXZTfjQTtR6owIj6NxihtyaGMFSjM9yw00C3V6EBO25jdNUrnQv4j5tDsJ+cipnwS2mEoteYkUGPRq+fLoS0przxhWBx1l/Q0o8LiGyjZu4hiIJpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368144; c=relaxed/simple;
	bh=Ss69KFwZrBaTJvqhneY9Ggo++o5mBMnUGiw6Fyh50Lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtNV5sg3+q7/jsN9ZW9r8ykDKA/FqSvcoffDNMc6znDg8WqSdmhQW9B/Na29KkLnDvuXUg0SJMnN439N2Sr6PeENz60akgbXDpnXHpZ7y8vamg7wcCn7HR7RxZgP4VjbL8T3nIXCuYpyjW6QXF1J91ZzwhiRtBMzPs11e/iRU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY7VmB0r; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so15617705e9.2;
        Tue, 01 Jul 2025 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751368141; x=1751972941; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ss69KFwZrBaTJvqhneY9Ggo++o5mBMnUGiw6Fyh50Lo=;
        b=iY7VmB0r5KzErkySjm03zm4PaEH8yPOADiXx05xJf6AEvetxV2ZGpQhIzGje69S7lW
         dArI2qHRB8VWajveOhqGvNYKgRFgOOEcnJJ6mxbPppVJCSldZe4yzNG7ovl8hdoQO5pu
         KkUmbdnZqx8FzDeDqIp+F8FxIWyjIOZKGMTwnAjE+fYhUh+FMYvDiWpR/9xa/0LehWgQ
         zOKcNTvsXJmtgJUb1ete+ugPoFdYwl6g5bVAIXKP+qali4JOltL1YWxk/lCZXR05pWO5
         Y4Yue+z9YmJROrKFDitDatV7fH/rFlS2078T1Elh0h4JL2vhNb2B+NYnsWXB/+Sqnb27
         jd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368141; x=1751972941;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ss69KFwZrBaTJvqhneY9Ggo++o5mBMnUGiw6Fyh50Lo=;
        b=aKWyBXG2Zy0On4WPpdshwAUlKG0m/6udyDHw98fM6TlKykfX572Dk2p8LF0L5RXTrY
         eY+bjwrcGSLl2xmNVQQPoHAlGwQ3YPBv0LKeDEbH2RDYu4R4AUrsWOVsyiT0qpmEglnz
         TN2QgOhrhz6obeXwvaqexc4KBVEOoRCPENZHrvrx5Lp+4HAIioVKmeztB1hTfkNwMsmm
         WGDRbBatbHMoUliTAB4h7Ghgj1g1xtvohZw4MJbUvIdoBM3YWX+mJAE7I4HOojks4led
         Av1UvKY9VMe+Sjk+8wUI67xh4k5U0VsU+zbE33OEPStV+LHtjE+xW7zWfZc321/TRRVe
         FSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO61qe8ci/QKKYxkCHk7BLndVHIE8wEzNdaAzBB/yKKU2E5Ck+IO5JXBb/9TrWK1IadLLEO/hxOJSN@vger.kernel.org, AJvYcCV5vnbbgWPzw5Y37ZJn1boYGfzT2p/YKJD1LvxlgH/Cwu2GWzqbUCFWSrWRWegJCpmMBekzPrI5wRVr+/s=@vger.kernel.org, AJvYcCX5gkA18g8trIZxfx3u0EJa2VMKsr6JyHsPeO7kimZkaQp3d7S6ThrtPKWtUreeDmHOGcRgqfPH5Ah96g==@vger.kernel.org, AJvYcCXb0Ni1R8qs0NTLPxUu+YHz5EryfcQ47mKUBpmQFt5Tm21+pv6xamWIGANzPzo6lvj7Y1WWf33GmS6t@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGwxKr1rW7A/9N0JV3t0MHpmgCW/2/D3mS3ESbtV527REvfK+
	03oCBSkvh3sE1yzni7xY8h0sy613z4mdNybopVkXy407TFvzCQp3h2id
X-Gm-Gg: ASbGncs3DUKv8AN2mZYaH7RqUisVKwWuZAvF7KULsmLcmA4p96cT8fxG8TH6troH31/
	L1hh6Bs9/+sG/HFJMEAvw6K/HpYUGlP+1bBTPzx19Q0Qf4hah2h5zuOLb2QMTUyyMd7K8H1pBA9
	4WOuwTu6VEEoQtmS+xYl4GSzn87YPCOz5wmM7Nvbhnsll63wxPyWb3uACzIlMXxUqFYvpU31kMT
	NCTYLW5389s2MhSE5bQM6c16p50rJqQYL4Gxno07nikRg3fP8f5OmlGpWZb8GcuSOQf6L+QaS0u
	lo2WP00qRjOYb09Ert2L5YMC0weI/YE2H25B/ixkuqKr0xqjtsaKtPO3TDPB2IhOiOZeFw==
X-Google-Smtp-Source: AGHT+IHkKYKNDk/1G74A3RMLM4kxhUgKA8tX96VPZrktX/Ic1LW08K41bZKrscjlU5i/qNFzp+92aA==
X-Received: by 2002:a05:600c:82c3:b0:43d:97ea:2f4 with SMTP id 5b1f17b1804b1-4538ee3b865mr168607925e9.12.1751368141255;
        Tue, 01 Jul 2025 04:09:01 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm165291675e9.29.2025.07.01.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:09:00 -0700 (PDT)
Message-ID: <15ba1febb0f0acf4057af64c5c84db0633cab864.camel@gmail.com>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Date: Tue, 01 Jul 2025 12:09:11 +0100
In-Reply-To: <20250701110522.GK10134@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
	 <20250619133834.GC795775@google.com>
	 <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
	 <20250701110522.GK10134@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 12:05 +0100, Lee Jones wrote:
> On Fri, 27 Jun 2025, Nuno S=C3=A1 wrote:
>=20
> > On Thu, 2025-06-19 at 14:38 +0100, Lee Jones wrote:
> > > On Sat, 14 Jun 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > >=20
> > > > Hi all,
> > > >=20
> > > > Here it goes v4. Main changes is to drop chip info based struct and
> > > > directly use an enum in the FW .data pointer, use the notifier API =
for
> > > > dispatching events and multiple calls to mfd_add_devices().
> > > >=20
> > > > Regarding the last point, I think I could have used multiple calls =
to
> > > > devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices=
()
> > > > but I do not feel that would have been "correct".
> > > >=20
> > > > Thanks!
> > > > - Nuno S=C3=A1
> > > >=20
> > > > ---
> > > > Changes in v5:
> > >=20
> > > In future, these should be inside the patches themselves please.
> >=20
> > Hi Lee,
> >=20
> > I'm about to send v6. I just have a question regarding the above. Do yo=
u
> > mean to
> > have the log in the commit message itself like DRM or do it with git no=
tes?
>=20
> I have no idea what git notes is.

It pretty much adds a note before the diff stat but with an annoying "Notes=
:"
line. b4 seems to ignore it anyways.

>=20
> Simply place the Changelog inside the patch, just above the diff stat.

There's already some emails about this on v6. I ended up doing it DRM style
because tweaking the patch before sensing is surprisingly non trivial with =
b4.
Unless I missed something.

- Nuno S=C3=A1


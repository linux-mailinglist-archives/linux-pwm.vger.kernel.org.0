Return-Path: <linux-pwm+bounces-6314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF0AD6D34
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E43AA1DF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C224231825;
	Thu, 12 Jun 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9PW3aKO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9196230BD0;
	Thu, 12 Jun 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723040; cv=none; b=JyE1HDAttSB0iDslIBNQBrpcNwX7MGYTE4QBZzfxF2D2W7RjagMbuYC+fMdltFs4eHYHjbaM3+IN4VYdw6ApV6PiwlWh8GdR4UDSxclnbdNUexuKhY8ZkiXta4yLY7Ciwy54oWAk79SxI+AYqucfMFh0HQSuoSW6Isne4LUyPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723040; c=relaxed/simple;
	bh=DF3s7CDEfVSdY/c3E2qn4/BepOIfr1L9K/VwKfaLyCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4zEHe2/sYhOWqQ7ojtUV8X21Q4rjgK/mt2XAHKbf8bvUq2OVyL64VLeCuqiYHQPaXsHiTnZ5pE/AK8rdqM1ViRU7kmXMCfHlUf4Rnnpo6IE3ie3IG4JrhhxoKXMERC2C2y1F/YCI2ybVfryvE8OhwLa2g7/kSmgMCWoMIrW5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9PW3aKO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so748760a12.0;
        Thu, 12 Jun 2025 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749723038; x=1750327838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od+pGMVaUocwgiaa7SUEUwfatBuJRDmXSED8IyxGGqQ=;
        b=a9PW3aKOofPs5mcApsFKc3ofGrx+jM/XpIidoHhxAaq+WC8T6g7Rew3zp4iRI0l7ZH
         cYc2iKUDbo4F0vaD19mDXYgnGfPU19KmxuEENUHxD0H5inGIB3UxlTllP3/8lg+L3UM4
         7IEMvojkm+881OVrr2NSwN1RZfNCGXLSt8/Ft/bw8r0zexVATUZAotq5vf0yor+Ja9s2
         +x6LKmtjMckqZGNvWIcrjOr8ReYmN5i602fxksnanY7kp/E4yF8386pGeB+AsPI7Ig52
         ePZaxX8YTRYOOCFrn4IXVweiXz0LnTbSvxWYAmhoQSJ8O3A+jlTXsOd+L1nQM1N97xDV
         dhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723038; x=1750327838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od+pGMVaUocwgiaa7SUEUwfatBuJRDmXSED8IyxGGqQ=;
        b=I1stqGKJs9hZgi5t7I6Ocz0SKWy55UPj4OwVo3ZlghG57/IclXAr4142Y636LlxxrT
         B8GCcCA7pzIB0oF8IM6/qLHzwBt0uINXRhFDHavVq8/rr6EOL84tJCFqsL2BOhAn3ANI
         JlKrSJKS3iI1biugt0nt+VWqnqqxhIGHn+hMigCojydWUpOfAOjPRx4lNXIs4PaA3QX0
         prs2+eZNOtPX3G8SCGKGmmU840T0OgrqEY6HSTDNDuTkYIggeeGsu620IUcF+gA48FkK
         WLZcAD8cEkZlhShVGzy16q2X1hitIOsa9gyL9BrrIzuYTEOmrH+u2dz8ynXOw6HV+NDH
         958w==
X-Forwarded-Encrypted: i=1; AJvYcCUxv22IJB5vkzvqqPnd1O/whvewzoC/nJr/aplQenBJbIa9mYF4SdiLhBOsJOZuKtR9QRT2WKDLH6B/@vger.kernel.org, AJvYcCV+HAd47Zb1MY7nGqA5sGIm6+B1/8oqhEP/2MsC3EqvFp03mVcwnfM5GHcg9qg+qmFWGa/04mygUdCqIL5B@vger.kernel.org, AJvYcCVC3FvpUxIauJIdilnpxn6FrVHZnxGQnSgjhbhiMoKOt32VNPsHgGdMkNSdPhF8Mkf8AHoqXvKgsijI@vger.kernel.org, AJvYcCWp9a8M5lezVdm17sYCsaWEK50xBAHZpRaCGhkWBU4CnC/7+JNAHPCLwQvINTVzGCRj5L+8VuRxrI8s@vger.kernel.org, AJvYcCXcDLGoEUW53Wgrd1DBThxsIcEjYgCdXiRtcaEfPk7LoZAvoNvmJn/13CBOkHsiusTIfE3wHYEI6f6p@vger.kernel.org
X-Gm-Message-State: AOJu0YwBL2VgXZoMIU7nhOitMF4OfPEdAgTZu7o8Khwj4VwiQN3wOi8r
	HeEuCdazMovyHnKR6M/N13jy2nlZkJlKO9f1KjXDd1cSc4KgDzEDILiE
X-Gm-Gg: ASbGnct2oW47nit60wlY0qAl0xAfXw1NtzdVbNdZAlNHJ03HUQRIi4Je0yjXphS1sKP
	jQHvJlgJkLNba+xgeVtlmIZaGUQYGGZEQyHkLgZIRKzniERdrqTWlfRL0FRG7rP2plq6zpKdpis
	aPgjofxEOCrni3Ge6vDEMxGWoGhieuhI4CAyPfKFGljKs7ELzbAKQihStCNIoSgYzF1VvAT+gQ6
	GqYZ5VpkVdjP+YeQYUSpiRLC9SuHWcaRqYhll+Qg3uuzAq4Zdxx3W5bTPeb7R8f106t7oW2SsPp
	cE+qDoR5ri+loygT26p/2jqL9Hz5F9UKzkKm99ad1UMkJZaf1GKAnIZaEAJbJ+ZCTjAqaF9GVcb
	HUia4Tw==
X-Google-Smtp-Source: AGHT+IHE/u8jw54XOOI+Ok2LBdze/j4Nou5XfGAkiYCq4HwLigmdJXOqdaEnDwzuzqBGwSO5pN8fnQ==
X-Received: by 2002:a17:902:fc4b:b0:234:ed31:fcae with SMTP id d9443c01a7336-23641abeaefmr111981645ad.22.1749723037928;
        Thu, 12 Jun 2025 03:10:37 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e63d49asm10303055ad.85.2025.06.12.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:10:37 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:10:25 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/8] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <6gn3kr3vlddousquogcxcdnojcawjt24onnvkf3wvl77bhqoxe@qwehcxjdeab5>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-1-cf1e44c516d4@analog.com>
 <20250611180252.76f1fe7f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611180252.76f1fe7f@jic23-huawei>

On Wed, Jun 11, 2025 at 06:02:52PM +0100, Jonathan Cameron wrote:
> On Tue, 10 Jun 2025 09:34:34 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> Trivial: 
> In the patch title use the actual file name of the new ABI.
> 
> add oversampling_frequency in sysfs-bus-iio
> 

Ack.
> 
> > Some devices have an internal clock used to space out the conversion
> > trigger for the oversampling filter, Consider an ADC with conversion and
> > data ready pins topology:
> > 
> >   Sampling trigger |       |       |       |       |
> >   ADC conversion   ++++    ++++    ++++    ++++    ++++
> >   ADC data ready      *       *       *       *       *
> > 
> > With the oversampling frequency, conversions are spaced:
> > 
> >   Sampling trigger |       |       |       |       |
> >   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> >   ADC data ready         *       *       *       *       *
> > 
> > In some devices and ranges, this internal clock can be used to evenly
> > space the conversions between the sampling edge. In other devices the
> > oversampling frequency is fixed or is computed based on the sampling
> > frequency parameter, and the parameter is read only.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index ef52c427a015cf47bb9847782e13afbee01e9f31..e60367255be89a9acc827ec1a749b729735f60e6 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Hardware dependent values supported by the oversampling filter.
> >  
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> > +KernelVersion:	6.17
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Some devices have internal clocks for oversampling.
> 
> Wrapping on each sentence is unusual. David pointed this out in v2.
> Wrap at 80 chars as a single paragraph.
> 

Yep, sorry.
Hopefully I develop muscle memory for vim's Vgq soon.

Best regards,
Jorge

> > +		Sets the resulting frequency in Hz to trigger a conversion used by
> > +		the oversampling filter.
> > +		If the device has a fixed internal clock or is computed based on
> > +		the sampling frequency parameter, the parameter is read only.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> > +KernelVersion:	6.17
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Hardware dependent values supported by the oversampling
> > +		frequency.
> > +
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> > 
> 


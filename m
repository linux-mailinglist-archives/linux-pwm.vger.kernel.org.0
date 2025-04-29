Return-Path: <linux-pwm+bounces-5767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7CAA0DC3
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13121A880F2
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3622D323C;
	Tue, 29 Apr 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPjjcb5n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1F2D29AD;
	Tue, 29 Apr 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934458; cv=none; b=O+OBKLy0C8SPK1rK5Rbwjrorb4Xb4wbFF4BgIwdNmvlNxFraA2bqLAbXP8/Q7djlLe4Ce4MRc1Fnj7K9FM8OXnVQvPwejObSbMT8QG3vhuqY/b2/nTn49oFa2N6aIgXkCfhDSUTgCLbA01UYw6mxb/JnTZHLkyPW7n3lWexwJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934458; c=relaxed/simple;
	bh=DjzHEUhss7O4w8xX58jtGF/4zzUbQ8mr8m5sP2MwNWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4heCHbr9bTYtDNITw1i3QH42Whn2IYd/loBHy0BdI6dgbXqAEUUQIqJ+rIsEjuLqXcID0CB3qNMyYTQFJOQPi8d5IX5hkyTTmlD2SFFtQR6dkFfpaNi9I+4Xv46I6t28rgImK7h5/oIQmyybZ1TYPWJrZwOY0cUrOi04Q2WzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPjjcb5n; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acbb85ce788so1174968566b.3;
        Tue, 29 Apr 2025 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745934454; x=1746539254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaTZWkSikhbMzTJTGFDBFHGc5K2hyAh3EtvsyFFLBQY=;
        b=MPjjcb5nz/phaZpZxbBaYDBfvBnNJ63keoI+FimAf47y9livMwmlHDz2YP68piLTSh
         onlvH7lhv4ivqxs/aXz4HtkFqxRwGjtVb9MAICzvzyYM/XjR3Ufact/8devWmeAqnlxE
         xwnjp4zsnBr19aZ2jwS0iJrqqQhss2j0TQU91Yu86h/4cSmp3WSc3AWa/5/yJMHyVBTB
         FPhfYj0eRzX44mkVBiLQEyBVvqfHsQ/pa/Xb3Kx6qd7dT4F0jmOyaQ4hK6zlYZ9o5KWU
         FnIzx6/AnLNCU+doW3cG1kpto0HAyIBYF0PqeVNpkCiePlpAFMrWp4/igpm86nPTAALl
         uN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934454; x=1746539254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaTZWkSikhbMzTJTGFDBFHGc5K2hyAh3EtvsyFFLBQY=;
        b=PHKhrLXxIMS+HfPhkK4ugFKK3RaoRw7J+L29SuKCxpHwqFwEywmc5fwSLV+3RCbqah
         zcKSf3HI5qdDuLECSD6ZBprLXGRx6LLUrGLXlz3U1PEwuAn1eYoTU9jLHjMmkSaZrDgC
         2JoI/c4E5FpQectoUeDxV5VoYZOVXCuI6ZraH1YNW6+lzC9OhPp1kBAROlO7A3KAdm7N
         oRRmcDzaGqb4DFJUr7/Jd/jLE31HFSRh/UXHvIzYcQpixEMj2Hys6JRr5yije/TQT9Br
         lRochJ5R6BApISrPlPge8uU9RwAm/ITej/4sIKELfZwysn1UQvY/rzzC8EtHrRSSMhxe
         LEGA==
X-Forwarded-Encrypted: i=1; AJvYcCVfG8aU32bE0PJP0O8ldxvDcgwidFddJqLjww1vxaJs10NVcOu7il9TK3kewI3V0ZF+r2/xLEjdCVld@vger.kernel.org, AJvYcCWWzujkhMk4rINXfcSlik4vdH4yU9fkBxTTF/jM7oLU78y4RRvlU1gBnUekxFzp9UrYprkSQ8l/fdh/Awnl@vger.kernel.org, AJvYcCX/+ATSgcX+4GnmWSVTruK9qS5xWcHVTot+aTk0u2jewm6emB+swZAcPbf5reYq9cjzlvkT5p1FMbbk@vger.kernel.org, AJvYcCX1aDwKHKsNdPOoKgALN3ilRezUwPzMKE28D4ZEKALWQN+ugknbBmGoBiuxDLnSoCnUe7E9JTDtqV9A@vger.kernel.org, AJvYcCXbBt0NAzV/e7COOeu8nqxcZsaFS2DwCNZhkGg0F9g6SdJrijgoe1Rv+KvwepHGb3FRCXPuMLIB8BFa@vger.kernel.org
X-Gm-Message-State: AOJu0YzrB9TH+LojeMRe8LrYHyyxHO17p4R2h41eQSQ81KmgkN4DCj5e
	JPGGOeerkHu/QT2bN3qYFNegocW9Q9Hotzl+36pLzzH3VwH7HZ5D
X-Gm-Gg: ASbGncsBbYLYNR/iAXxyMGLWDy+zYDC758st3UFfFdZe/ETA0uBEMCOsqLegugVMlxp
	mDfHK934iB3axU6lxlw4ovXhaXL/S1LEfhA7X0tQlnjuxQTxD+kttAE08Oxj6lhDH9YajGcGEOW
	dibJllRwqpT66BtXsgujlG4BFIxlZaDbR7V+pb0cRPWSHA0qy0bs7H5b1H+DlDukBLC8FiiVwN0
	UwJq0ANG4B1m+gATEwJSCk77pZAS3N+6SxUGTwFRdThmXC6L+XAjy+waQ6iEdcwbmsay4AdZNv/
	Kl/JnDEOsBaRc3tnGodsnrG3CoXtzMqo6CxbDNylH2N89pTxCJenA5yN8zpMRPPYUnY=
X-Google-Smtp-Source: AGHT+IHewjMQ0MZiNJB4DgK8tvKn2XGZDPn4MYHgyVOxmK6G/0S4ZlgFqHAA9mb76xCeTR/leX0CMw==
X-Received: by 2002:a17:907:6089:b0:ac3:8516:9cf2 with SMTP id a640c23a62f3a-acec87bb143mr338540466b.55.1745934454357;
        Tue, 29 Apr 2025 06:47:34 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:26c:ba50:9d5c:4d3e:be76:7564])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acecfa384b5sm77159066b.0.2025.04.29.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:34 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:47:31 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <3w7y2e4yfkf6ujr2mpsxcammdrb77rdybxi3ikpfoguvwsnipn@j2v45uldkw5t>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
 <143ffe9b-b32e-41ea-b5c7-855c680b48d4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143ffe9b-b32e-41ea-b5c7-855c680b48d4@baylibre.com>

Hi David,

On Fri, Apr 25, 2025 at 04:16:20PM -0500, David Lechner wrote:
> On 4/22/25 6:34 AM, Jorge Marques wrote:
> 
> ...
> 
> > Devices with this feature are max1363, ad7606, ad799x, and ad4052.
> > The max1363 driver included the events/sampling_frequency in
> > commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> > and ad799x in
> > commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> > hysteresis")
> > but went undocumented so far.
> 
> It looks like this part was copied from a different commit and isn't related
> to this one.
> 

You are right, this is from the other already applied patch, I will remove.

> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 33c09c4ac60a4feec82308461643134f5ba84b66..129061befb21b82a51142a01a94d96fcf1b60072 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Hardware dependent values supported by the oversampling filter.
> >  
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> > +KernelVersion:	6.15
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Some devices have internal clocks for oversampling.
> > +		Sets the resulting frequency in Hz to trigger a conversion used by
> > +		the oversampling filter.
> > +		If the device has a fixed internal clock or is computed based on
> > +		the sampling frequency parameter, the parameter is read only.
> 
> Don't need a newline after every period.

Ack.

> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> > +KernelVersion:	6.15
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Hardware dependent values supported by the oversampling
> > +		frequency.
> 
> 		oversampling_frequency attribute.
> 

Ack.

> > +
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> > 
> 

Regards,
Jorge


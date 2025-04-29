Return-Path: <linux-pwm+bounces-5769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3DAA0DCF
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A781B602A5
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A22C3773;
	Tue, 29 Apr 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XezweXAS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113551F4199;
	Tue, 29 Apr 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934550; cv=none; b=mw0SD7cn+6O1iRQFf4ZsdWshOiZGWHo/LLs6rq5n8HXig7FirmKqG6M0kW5Y8b/ZHC3Nk8ZrUJFFIM9XqkpX7BWcVoSmAFwVa6DAI+faUHk+poEe6OhGu5vfZOJ+/j89XwBO81Kn/yG221IET/zgGx5tDuH8q1o9qTZtpfdF0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934550; c=relaxed/simple;
	bh=u25kBiNYfM/wtumTZNqSg7VVfwAsVm/PW00la88zAf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8QLnibVpC9NhJ9+rsJgjPZHvy9qz+kz+LMSNdskFrL4fvl37JN5ywDt5W2oyKJp/Th2mva1TQuEKAt0sC97oq0ASs0Z5G2BqAYW9eqFF0ACTX06N9+FWoNBsT/yfgaWBqwjdcUEelmSbL7wynFBOsYD/GJdCcv6V2czSaJXBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XezweXAS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aca99fc253bso916130866b.0;
        Tue, 29 Apr 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745934546; x=1746539346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppyxyyxpPGYWacq1nxIpfBKTgMizOBIyRRvjHp/psAE=;
        b=XezweXASNZcxC1kKqb9fa1RjjavNwvjQZetAssjZ+/2LX27GwAIp4bR/Zi/BggxrYZ
         Fc3WfZEt7r7pYE4PnM9MwHFBP1nTfsD3UmL/fhOdX1ZYfySOX87vF/F8QR32WSeYwPEG
         8zdhTnWHebRPZz08MNADbfaZgEIEFM4cDmvvYuOI4+rjSarT6DboZo2CT63nbLf7Xitb
         +U0g7Ly6WlkmU8KyGnpdIgIzW+qTYXQBv9k6xu2bNt2h3ljprwMEBAhuUNHtisRxrmP1
         hvV55lW0tJiLohUvpn5ii6//103BS/2YVP0WZ12pl3WJ9zE0SdAsB6FB02HJNpztcGIB
         RfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934546; x=1746539346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppyxyyxpPGYWacq1nxIpfBKTgMizOBIyRRvjHp/psAE=;
        b=dYbsAooUIeSUxMH70UHNJhghwFw3gJ9ca5UWzjhmFgiOwyfcovbkDQDyEDjartPc7S
         8WFiL+0z/pGI1r5bvjVFPHMpKnm9kChgPQKRN7BPM2Z/FdS+6ze/jPVSbWSK4xDIjoiA
         h5emBs9utn9ECNdKsaym2Ga6jDZMZcc2WndzPVbUDBnufe1R/F0DQSZgsYzTaWrRkyH+
         gf1zxaKkbigY17zUPgQZmoFEl4LhndUwJxoNWT6baOmWNM3Gub0L7EFRKQ6P2NBxpdXI
         pwzKKR6RfSxIrHHmdeuuoMx8s+dbTqh+nyJcLM4z7H9gYF9OJqODiKDnoKflGHbeqXJN
         w7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVV0peHl9+vbmThwBMJG1u84VFevuX4SgVSthwBFd/SFhsp5pGuWcIvFBfZ1Sp4VyiKGlr/n34c87Gi@vger.kernel.org, AJvYcCW0h2CXeZMXGeIa1tCcrhf1DkSalER3YY8QMM48yrdanbNUrOs1vMhpO7DOaTDE/kA4/ge4n8DRsOWR@vger.kernel.org, AJvYcCWwnrjq5BOUXJ4/F+6ryCrXueyzwFaPwXr6qU2Xpk5GRl+Tu51hwjpQnUkF/3CJwMuqdyLc2rZRtcUN@vger.kernel.org, AJvYcCXB32AElS0+2eXrSXVjIFzIN/83v4H+kSMEI5JcUGp9brRhFTxJJULWqtInbVzCl8FO54fUgwL3ccbY@vger.kernel.org, AJvYcCXby0rgob+CpLDvMo2nnqWiSYHmT2JvsFcuvvCYxlHQGJXtnQ75xusAVugsPmlFbxncgmhtzd3CYKbiDMFR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0nBZNKI1n1fMtEhH41Ot+bseG5/pIc1YEsYV+74zCU0GufjD
	AgFSysK4Rlz5f9R2PF86ORzOrp6G9BuidkRjjWxKG4IwOjLyfvMq
X-Gm-Gg: ASbGncsTLR9H24bpeLr+DgovEqdtfwcKvGGKm2Emt76JLLCcc//Z7ukuut57FmO8who
	WT3TRZhvtA3SiOBUrW1udG6NtkPqvoxV+8kfQAgKrSJzlfMh9W5mh3q8iI/KSa8ve4TYrbQcW8U
	kUk1RwtXgL5+TViz/mzLlS3i2RIvPXCqY51pAaSEnNOnMI7Uo20rG5GX/xlZWSMasTvr7PBFgM5
	lh8NaoPA1pY6viMlBarslP0c2E4FVpA828xb4RILvmU4vEp7mngz6AO2lHa+j1gFSpMhEKA+BZU
	vnS1y0jb/qkJ3nHC7FXPi6PeayFAnr/kxXg79LtNLT5UI9xLre1RaedNPnKdfZTjszkvgzmRg6w
	9Yw==
X-Google-Smtp-Source: AGHT+IHl26bfFNJ867rxOTpcu4IVxtgQZhbR09rkAFmuMyJXqLB8U2p7yRUpVXUFUuu25vmCYX1jMw==
X-Received: by 2002:a17:907:7e95:b0:ac7:16eb:8499 with SMTP id a640c23a62f3a-ace848c0148mr1227220166b.5.1745934546030;
        Tue, 29 Apr 2025 06:49:06 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:26c:ba50:9d5c:4d3e:be76:7564])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6eda63aesm777779066b.164.2025.04.29.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:49:05 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:49:02 +0200
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
Subject: Re: [PATCH v2 4/5] docs: iio: new docs for ad4052 driver
Message-ID: <nrffdb34ldh24kjphvebdnc2p466xbmay4pm6pe3nen2wftycv@uyxqjovmm726>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-4-638af47e9eb3@analog.com>
 <9f5b0709-f795-44c5-aa64-aaed81a459bf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5b0709-f795-44c5-aa64-aaed81a459bf@baylibre.com>

On Fri, Apr 25, 2025 at 04:44:20PM -0500, David Lechner wrote:
> On 4/22/25 6:34 AM, Jorge Marques wrote:
> > This adds a new page to document how to use the ad4052 ADC driver.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  Documentation/iio/ad4052.rst | 95 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Also need to update the table of contents in Documentation/iio/index.rst,
> otherwise this page won't be build (and will cause a build error).
> 
> You can run `make htmldocs SPHINXDIRS=iio` to speed things up and only build
> the iio directory to make sure you have it right.
> 
> More info: https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html
> 

Yes, sorry.

> >  MAINTAINERS                  |  1 +
> >  2 files changed, 96 insertions(+)
> > 
> > diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..410aaa437ed5fea6a2924d374fa5f816f5754e22
> > --- /dev/null
> > +++ b/Documentation/iio/ad4052.rst
> > @@ -0,0 +1,95 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +=============
> > +AD4052 driver
> > +=============
> > +
> > +ADC driver for Analog Devices Inc. AD4052 and similar devices.
> 
> Please don't put newline after every period. Here and throughout the document.
> It makes it harder to read.
> 

Ack, that was a personal touch that at the time was easier for me to
read ahah. Luckly, vim's `gqq` can flawlessly convert.

> > +The module name is ``ad4052``.
> > +
> > +Supported devices
> > +=================
> > +
> > +The following chips are supported by this driver:
> > +
> > +* `AD4050 <https://www.analog.com/AD4050>`_
> > +* `AD4052 <https://www.analog.com/AD4052>`_
> > +* `AD4056 <https://www.analog.com/AD4056>`_
> > +* `AD4058 <https://www.analog.com/AD4058>`_
> > +
> > +Wiring modes
> > +============
> > +
> > +The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and
> > +a CNV pin.
> > +
> > +The CNV pin is exposed as the ``cnv-gpios`` and triggers a ADC conversion.
> > +GP1 is ADC conversion ready signal and GP0 Threshold event interrupt, both
> > +exposed as interrupts.
> > +
> > +Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge
> > +of the CS as the CNV signal.
> > +
> > +Device attributes
> > +=================
> > +
> > +The ADC contain only one channels, and the following attributes:
> > +
> > +.. list-table:: Driver attributes
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Description
> > +   * - ``in_voltage0_raw``
> > +     - Raw ADC voltage value
> 
> No scale attribute? How do we convert raw to millivolts?
> 

I will add here and to the driver.

> > +   * - ``in_voltage0_oversampling_ratio``
> > +     - Enable the device's burst averaging mode to over sample using
> > +       the internal sample rate.
> > +   * - ``in_voltage0_oversampling_ratio_available``
> > +     - List of available oversampling values. Value 0 disable the burst
> > +       averaging mode.
> 
> Typically 1 means no oversampling, not zero. (It is a ratio, divide by 1 is the
> same as doing nothing, but divide by 0 is undefined.)
> 

Outdated doc, fixed.

> > +   * - ``conversion_frequency``
> 
> Needs to be updated to ``oversampling_frequency``.
> 

Ack.

> > +     - Device internal sample rate used in the burst averaging mode.
> > +   * - ``conversion_frequency_available``
> > +     - List of available sample rates.
> > +
> > +Threshold events
> > +================
> > +
> > +The ADC supports a monitoring mode to raise threshold events.
> > +The driver supports a single interrupt for both rising and falling
> > +readings.
> > +
> > +The feature is enabled/disabled by setting ``thresh_either_en``.
> > +During monitor mode, the device continuously operates in autonomous mode until
> > +put back in configuration mode, due to this, the device returns busy until the
> > +feature is disabled.
> 
> Probably worth mentioning the ``events/sampling_frequency`` and
> ``sampling_frequency_available`` attributes since we've mentioned all of the
> other attributes.
> 

Ack.

> > +
> > +Low-power mode
> > +==============
> > +
> > +The device enters low-power mode on idle to save power.
> > +Enabling an event puts the device out of the low-power since the ADC
> > +autonomously samples to assert the event condition.
> > +
> > +SPI offload support
> > +===================
> > +
> > +To be able to achieve the maximum sample rate, the driver can be used with the
> > +`AXI SPI Engine`_ to provide SPI offload support.
> > +
> > +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
> > +
> > +When SPI offload is being used, additional attributes are present:
> > +
> > +.. list-table:: Additional attributes
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Description
> > +   * - ``in_voltage0_sampling_frequency``
> > +     - Set the sampling frequency.
> > +   * - ``in_voltage0_sampling_frequency_available``
> > +     - Get the sampling frequency range.
> 
> In the driver, this is currently info_mask_shared_by_type, so would be
> ``in_voltage_sampling_frequency``. And there currently isn't 
> ``in_voltage_sampling_frequency_available`` in the driver, so it needs to be
> added in the driver (or removed here).

Removed here, it is constrained by the PWM trigger.

> 
> > +
> > +The scan type is different when the buffer with offload support is enabled.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 81fbe7176475c48eae03ab04115d4ef5b6299fac..04aa8db44bee418382a2e74cb6b1d03a810bd781 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1334,6 +1334,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
> >  S:	Supported
> >  W:	https://ez.analog.com/linux-software-drivers
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> > +F:	Documentation/iio/ad4052.rst
> >  
> >  ANALOG DEVICES INC AD4130 DRIVER
> >  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > 
> 

Sorry about this submission, this file was indeed not updated between
version.

Regards,
Jorge


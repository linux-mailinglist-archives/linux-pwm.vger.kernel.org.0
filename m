Return-Path: <linux-pwm+bounces-6227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80DACB9AC
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC84024B1
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B829224893;
	Mon,  2 Jun 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTjmzWDz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B2221DBD;
	Mon,  2 Jun 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881987; cv=none; b=sEYTqeesBWFQM15glYVCBXDUTYYgjS/7rcbKZyrs841Sor7ENdAM3E1OO53Qaf5mnyG8KUfRO9ClUbgtynozdK9VziGeWhJvsMhWi3XXR9Sm+Z2f7BEjWhPBPqlGxbwYn6zHUdroxS411L+PNucPK1ciyOUo9EGDyZS/dLhwvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881987; c=relaxed/simple;
	bh=Xz+aD4WKbatFaE/ZleOL4RDN8L49A9nba2WKv1yXxo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8xqyf3rEJ6nJ8Pz5RXQ4oVFG1m8p1h37YH+EMIuhMk6Wuk/Fi/2EiCfnQ5+fvMVB6PeheJDgnUoEQjut9yGoOwgJ91esRgz+KKqaHxVyYfNgwSIf/U8Fqtjca3TNPHHnwZwFlZEczdNCQHXKvsrgL/givlARwvRPzYXJlHNeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTjmzWDz; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e591544d42so1527813137.3;
        Mon, 02 Jun 2025 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748881984; x=1749486784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dE+UsxBMqGkP0BbEtqtbaQdE82KuzoJQUPmSA85nzc=;
        b=MTjmzWDzhNK8OLfLgUrToQm+eVx/QIMBgDcpkfLCCHEd+66eWzkJl0ALR0FPnkoq1R
         Vr86J43862OBZkvyFrp3rQkNmcEcZc7NtGgvo6Y+rrt0Yg9MknR9tkP4/mm2rQfTcP9u
         L09iaRbfK46hOgXf+AACpWILofwuiT/W4qmXvvjxZpLoEb3XfIgRwCp5xzdd93Dszuz6
         DLxdOrMhElJxJSJ+2V394APflTs45RElnU/TqpZUvS1Xt6R9lEwAiPNlReW2qLFJdkGU
         HrtsE3vZ5DCDX5eEbRHysUA6sdeIImjXmrnT0YLKy2va5aSfYypI7x/UDmtBuYJcfFEo
         rnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748881984; x=1749486784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dE+UsxBMqGkP0BbEtqtbaQdE82KuzoJQUPmSA85nzc=;
        b=N1i3VA6u/jmV2W4Q5R+/hgm49cNLi1KJyIZ8A9gICw5iJUMs06pmuY93iORXKhefws
         TFMn1My2VJ7Oh5/1fygfdb68FY19+Z4SWY1+DjQxhT8fUJ4e8/T0c6YXEi7OyTmvR7oK
         7no/6NaSBKtRDqhAblki0hJFlJ1gZjhJp1mecW26yttQahMw8NOkN69bwNj0jM4+EkDr
         n+oaFrJ5WXjm/ZKrxQ7sJBSjmWVuZ92r46Er2Mf+qjUKToS93mEgzj0mXVBzpa2NoI55
         2x9s+o/D6FO2m0w1oo3wPI6RrW3IyptTP3Lxr5n/B9qO7EOwGY5EUA4PO7fu/Y2Dz9wZ
         RHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoeppsOy4YsU3OmDKSW5QNgAL/nwzYn4geIX4wwSsN+/PIpkKZFIb59ITd9oeovX4GhwsnqPCoG0AP@vger.kernel.org, AJvYcCV3knfzbs88kGs42q23EE0o3HRdbMGos/Pw8FY3c2QhwGImncPrfUKwIWk0DzEHOxM/Z9JDLOn/kIyV@vger.kernel.org, AJvYcCVGZfrFMhp16U3PAYYdymfdgu58XBHM5SYamYyFjC+38vCvI2EBn4zvsQ8ftM85r/+CaieCE7gCN9Tg@vger.kernel.org, AJvYcCVdJQLJ31JFvcNJh23c44rm/tQjc2KPRIwUFl4THAjeZLe+t1h1pJNVGN9edvNqAyOJv1D6QsjPFjoP@vger.kernel.org, AJvYcCX684NwhN2Bhohfg9oPLxHGxKT0SUK+k4nGKF8M4D8TTQWG0F1cHAD2hxaIzznnyIiWZpqrzwwk3j8RxxfD@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOADZZxShqZodVtRsf5fU6QrvZf8eEqP5JS9x9q2FpOV1uMSi
	TRowqON22IVdAMus06Yj9539sbJ2hTijjA+b5uxjrVwwUNcmOFOan4K3
X-Gm-Gg: ASbGncsYXxsQ1wfaEPDBytAcw/jAqeXkbAqPBWaw/bdlOEH0pYo04EnnXQStLEtm3BR
	3lA6QUsSHenepjpYVdLBRc0itfXE+HrzcCTmvnORJA28T1bQ3qt2hC3A1zyxnFn+lqsQdzkiQTH
	/TCH9ed+duMeTVceiS0j11bqtMKcRqaEO39+yQ5Z817EDB2lIZ4+gAY8DZE3Laqh5+5zmEmhOuM
	DrnEnDpNKbGdIYcxiNRPzOyZBuIDYlp05CJ5eucEI0MNywGoD7EgX0ToQjlWKDfDzYISJqyMYI+
	NGIRGyVU0V+zjhdYMvC0xpYB/2R2zvQApCFz7A7A0vOhtgmPCpi8zawqrOpcMwxOztyiKFx7vZK
	8
X-Google-Smtp-Source: AGHT+IES5AO+Rxsfz4apvd5o1ztpHWeCsDwi5GiSxhjId0o3aGmiE04FWzNCWRSYdyXaBFN0S23Amw==
X-Received: by 2002:a05:6102:ccb:b0:4e6:d995:94f9 with SMTP id ada2fe7eead31-4e701c887c2mr5933484137.12.1748881984383;
        Mon, 02 Jun 2025 09:33:04 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e644429616sm7449963137.1.2025.06.02.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:33:03 -0700 (PDT)
Date: Mon, 2 Jun 2025 18:32:52 +0200
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
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <a6cguahvrbqjv2wtisvgg2wvm2tj3awmn7omo6ebfpts6v546o@4xzpj353vlsx>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
 <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
 <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
 <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
 <a6f62963-5776-47e4-bdac-78e921a6e476@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f62963-5776-47e4-bdac-78e921a6e476@baylibre.com>

Hi David,

On Mon, Jun 02, 2025 at 10:17:18AM -0500, David Lechner wrote:
> On 6/2/25 4:17 AM, Jorge Marques wrote:
> > On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
> >> On 4/29/25 8:48 AM, Jorge Marques wrote:
> >>> Hi David, 
> >>>
> >>> I didn't went through your's and Jonathan's ad4052.c review yet,
> >>> but for the trigger-source-cells I need to dig deeper and make
> >>> considerable changes to the driver, as well as hardware tests.
> >>> My idea was to have a less customizable driver, but I get that it is
> >>> more interesting to make it user-definable.
> >>
> >> We don't need to make the driver support all possibilities, but the devicetree
> >> needs to be as complete as possible since it can't be as easily changed in the
> >> future.
> >>
> > 
> > Ack.
> > 
> > I see that the node goes in the spi controller (the parent). To use the
> > same information in the driver I need to look-up the parent node, then
> > the node. I don't plan to do that in the version of the driver, just an
> > observation.
> > 
> > There is something else I want to discuss on the dt-bindings actually.
> > According to the schema, the spi-max-frequency is:
> > 
> >   > Maximum SPI clocking speed of the device in Hz.
> > 
> > The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
> > (higher, depends on VIO). The solution I came up, to not require a
> > custom regmap spi bus, is to have spi-max-frequency bound the
> > Configuration mode speed,
> 
> The purpose of spi-max-frequency in the devicetree is that sometimes
> the wiring of a complete system makes the effective max frequency
> lower than what is allowed by the datasheet. So this really needs
> to be the absolute highest frequency allowed.
> 
> > and have ADC Mode set by VIO regulator
> > voltage, through spi_transfer.speed_hz. At the end of the day, both are
> > bounded by the spi controller maximum speed.
> 
> If spi_transfer.speed_hz > spi-max-frequency, then the core SPI code
> uses spi-max-frequency. So I don't think this would actually work.
> 
Ok, so that's something that may be worth some attention.

At spi/spi.c#2472
	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
		spi->max_speed_hz = value;

At spi/spi.c#4090
	if (!xfer->speed_hz)
		xfer->speed_hz = spi->max_speed_hz;

So, speed_hz is max-spi-frequency only if xfer->speed_hz is 0 and
not bounded by it.

Then at spi-axi-spi-engine.c:

	static int spi_engine_precompile_message(struct spi_message *msg)
	{
  		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
	}

Where max_hz is set only by the IP spi_clk. If at the driver I set
xfer.speed_hz, it won't be bounded by max-spi-frequency.

The only that seems to bound as described is the layer for flash memory
at spi-mem.c@spi_mem_adjust_op_freq.

For the adc driver, I will then consider your behavioral description and
create a custom regmap bus to limit set the reg access speed (fixed),
and keep adc mode speed set by VIO. And consider spi-max-frequency can
further reduce both speeds.
(or should instead be handled at the driver like spi-mem.c ?)

Thanks for the quick reply!
Jorge


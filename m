Return-Path: <linux-pwm+bounces-3391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46985989555
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00884284286
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B561779B8;
	Sun, 29 Sep 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4kCkr8x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD918E29;
	Sun, 29 Sep 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612868; cv=none; b=t0i1I45wJjBBNq2tcz/IFTTdJDGbJVSgc7G/wurbKgO+8Uka3fO0Z0+Ol4ioEtIEfoGNW/zHZlrwpNa0hvQi2J1H9N3FA+SGIGRww+OLhGvtfk0CjwKhJiu+djamwaDe0qIGtczJbYr1XYNAuC2fDPH/kHe0vhwAdRAOi960rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612868; c=relaxed/simple;
	bh=pW+C8/T45qdBO+LTXxiY8Y7QnwF/WqtASu3RM0+ae90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsogQoSpMEfWmeyPaO+LBqoBhuYvTmrpKl8lssFgfCSWA+svCQ6HvLKgSDsHydE2CpBkLqDAC0g9orLmYk2XFQTnz9ydlWzhaR6/dOVngJ9GilN0DhFXt/VkFvKWJdM1NWM+2OZbGO5VKtQUo9IqLH8N8Zqp4Cds1Trel3Gp8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4kCkr8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE013C4CEC5;
	Sun, 29 Sep 2024 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727612867;
	bh=pW+C8/T45qdBO+LTXxiY8Y7QnwF/WqtASu3RM0+ae90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4kCkr8xFkLKzAwq9mQIR61upPGCSbi+JDmkTDxBWD4erWd1Qq8J/t6F3EIIbd5pv
	 E54tPmF/pAt+01jJ5S3T9W4eWf/YU2KvZtj3omn254KW5bCK7Dx2m4JXaPXqMvaCR+
	 8T7NdGqMYtYmeYu2zod71htzsrUg33Lzj6Ma2dQcOE2866eT2ktC/PuIqUDtJ6Q/qm
	 6Y/2NOYgUmKpIZay4zAuJZpjddjIhbpjqk0Pl2ZTuQpGta9p+CKezb7hPj+6xRTgQm
	 sO+TvNrb5UtO7Lj9Yidig4AIQq1lHmS5skrVHHPstRmC/0Fd5mnkKhbPHchw0+hjrQ
	 /sHTWwad9F30g==
Date: Sun, 29 Sep 2024 13:27:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: ad7606: Make
 corrections on spi conditions
Message-ID: <20240929132737.020564f4@jic23-huawei>
In-Reply-To: <da15af17-e5cc-4714-9fe1-4683d990abbb@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>
	<20240921-playgroup-regally-f26c17be26dc@spud>
	<56090167-15a0-4386-89a6-c379d70faae6@baylibre.com>
	<20240924-unvocal-playback-2753bbbb0e45@spud>
	<da15af17-e5cc-4714-9fe1-4683d990abbb@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 17:28:30 +0200
Guillaume Stols <gstols@baylibre.com> wrote:

> On 9/24/24 16:59, Conor Dooley wrote:
> > On Tue, Sep 24, 2024 at 04:41:50PM +0200, Guillaume Stols wrote:  
> >> On 9/21/24 23:55, Conor Dooley wrote:  
> >>> On Fri, Sep 20, 2024 at 05:33:22PM +0000, Guillaume Stols wrote:  
> >>>> The SPI conditions are not always required, because there is also a
> >>>> parallel interface. The way used to detect that the SPI interface is
> >>>> used is to check if the reg value is between 0 and 256.  
> >>> And, yaknow, not that the bus you're on is a spi bus? I don't think this
> >>> comment is relevant to the binding, especially given you have a property
> >>> for it.  
> >> Apologies, I missed to change the commit message, it will be fixed in the
> >> next series.
> >>
> >> Since Jonathan did not like very much inferring the interface with the reg's
> >> value that I used i the previous verison, I introduced this flag.
> >>
> >> However this is only intended to be use in bindings, to determine whether or
> >> not spi properties should be added.  
> > To be honest, if it is not needed by software to understand what bus the
> > device is on, it shouldn't be in the bindings at all. What was Jonathan
> > opposed to? Doing an if reg < 1000: do y, otherwise do x?
> > I'd not bother with any of that, and just make cpha (or w/e it was)
> > optional with a description explaining the circumstances in which is it
> > needed.  
> OK, it will be removed from the series and sent as a side patch because 
> it anyways does not really belong to this series.
I can't remember the original thread (or immediately find it).
So I may have this totally wrong. 
- I don't want checks on reg value to change how the binding works as that
  is a wieird corner and in theory this device could be at a small address anyway.

- Fine to do as Conor suggests and just add a comment for this
  corner case rather than making it required.

Jonathan
> >> In the driver side of things, the bus interface is inferred by the parent's
> >> node (SPI driver is an module_spi_driver while parallel driver is
> >> module_platform_driver).  



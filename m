Return-Path: <linux-pwm+bounces-4000-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81819B942F
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1588F1C20E09
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665B21C5798;
	Fri,  1 Nov 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZZMFUWU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAF4778E;
	Fri,  1 Nov 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474248; cv=none; b=CaqMfyIjVDwFMFi/MuieKoU0MYtTOVUBcYYXqQpN7siDbT4ShKgnVj2sdHtovePxZjmsEhIWOhQrlmyP4g8KZ2xq0yX+l3nm0w2/Kx1W8Fteui9FHbbzd5W7exGoeEeLPRLKd7gSwBQUI8YkUPs6yiVzBIFiJeX32hw96TKXVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474248; c=relaxed/simple;
	bh=Tigeh6OfHNbtXhcgO2I9tZCnaQp8q6lEANEuNMg2xyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjFnACpRrHeptaQgWfJK2/R/zNY51vi0DxEk76HJwC+L4N+JaBX0Zrd7ICxienwl2T3uIWswyshKubV1k5FeGPopSuM3dIc18gZDtnoQHwIbfxF+0h+V/AdOvAt/MgopGul0NN2YCxkbVkULOP3Vj4ilNX1D9It6r7Ij+bmGb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZZMFUWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B174C4CECD;
	Fri,  1 Nov 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474247;
	bh=Tigeh6OfHNbtXhcgO2I9tZCnaQp8q6lEANEuNMg2xyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZZMFUWUVCHSBTJyvR1ixugO1ppY2hyEBgk2sbqadAUJF25tCZUg3CSmd+smYk7bl
	 q6C3dh1HQs9ABdePR2dv7u71tYKjylJ/BBlwzmBfNuzqSwClJw4LnhEwY0iBk2TYO2
	 HmNrU+CxXCr2S9E8Mi2FApv5Y0QATDOntGLJ26BXAqAPFoSfEQUk6zCS6At4GON3A/
	 677IpiLYsy4jxJ2HkAvJZSOYBfNHcfsdJ0X09wDzsSDzVb4Dt0CLh1B+uOjcSPcu/4
	 qYT3g0hjWtyo4QXoMcWZlY/44wl5cW7uNxopk9072Pm5P30O8V12an7EBCvzMVqlE6
	 8mY9vGTVE54Ew==
Date: Fri, 1 Nov 2024 15:17:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 0/7] *** Add support for AD485x DAS Family ***
Message-ID: <20241101151721.234ba899@jic23-huawei>
In-Reply-To: <20241101112358.22996-1-antoniu.miclaus@analog.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 13:23:52 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD485X fully buffered, 8-channel simultaneous sampling,
> 16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
> common-mode range inputs.
> 
> Some particularities:
> 1. softspan - the devices support multiple softspans which are represented in iio
>               through offset/scale. The current handling implies changing both
>               the scale and the offset separately via IIO, therefore in order to
>               properly set the softspan, each time the offset changes the softspan
>               is set to the default value. And only after changing also the scale
>               the desired softspan is set. This is the approach we are suggesting
>               since we need the softspan configurable from userspace and not from
>               devicetree.
> 
> 2. packet format - Data provided on the CMOS and LVDS conversion data output buses
>                    are packaged into eight channel packets. This is currently handled
>                    as extended info.

For future cases. The cover letter should have the version numbers as well as the
patches.

Also, the cover letter title should be similar to the patches.
[PATCH V5 0/7] iio: adc: Add ad485x driver.

How did we get this far with wild cards in file names?

In IIO we always name after a particular part (there are a few historical drivers
that don't).  Using wild cards goes wrong far too often. So rename the file as
ad4841.c + same for the dt binding file and documentation file.


Jonathan

> 
> Antoniu Miclaus (7):
>   iio: backend: add API for interface get
>   iio: backend: add support for data size set
>   iio: adc: adi-axi-adc: add interface type
>   iio: adc: adi-axi-adc: set data format
>   dt-bindings: iio: adc: add ad458x
>   iio: adc: ad485x: add ad485x driver
>   Documentation: ABI: testing: ad485x: add ABI docs
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad485x      |   14 +
>  .../bindings/iio/adc/adi,ad485x.yaml          |   82 ++
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad485x.c                      | 1061 +++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c                 |   44 +
>  drivers/iio/industrialio-backend.c            |   45 +
>  include/linux/iio/backend.h                   |   13 +
>  8 files changed, 1272 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
>  create mode 100644 drivers/iio/adc/ad485x.c
> 



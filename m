Return-Path: <linux-pwm+bounces-3639-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F899D715
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 21:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F21C20615
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA331C7603;
	Mon, 14 Oct 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9oVzOP5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB212B73;
	Mon, 14 Oct 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933330; cv=none; b=o86iDypKlU/eCIJ5rXXoZjwP+bJcLohvVtQk2/RjODAWJowjFBTUsHS03ou8lT3fX+/l000ed+Z7kDXjHArVFIwmeUV7TMPoH50/5CniRMZoNCK3LjnEO3GjnuGe55ghMYKLB0IbT0/Ax2gKICiGnBBnL5n0Wjus7GiJYjuJssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933330; c=relaxed/simple;
	bh=2Zo/obCSn5sslgsyI7NcI4a9viaES0kEmjXw1Txs1R8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwC/ClgDbRiSusyXpwy4MjG9IIhAefsXx2x4oBQXL6vFXGTFUKRb9rAF3RVc/kblYKYysSXsFzNijgVnPE4QDf+0jj0UGQX7s5bjJvCk6vrSLlqao/KNfW4UaNCl6VFEzPxMehK92vt9hrLXiO23KFBGKIGk92RvxK+thHjlV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9oVzOP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16985C4CEC3;
	Mon, 14 Oct 2024 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933329;
	bh=2Zo/obCSn5sslgsyI7NcI4a9viaES0kEmjXw1Txs1R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9oVzOP5A+O3Y10xCy8sTnXEiZTjgSttozIQKYSb9hWODlNOskBcYxxesmM7nJ8w6
	 IAtL4Kd83dsPQUBqFRqGH1K/G4r8OURptnimqufsHMCv0WDFzJWarc1kM/gUfUbbsf
	 6iW/iGWdizJY5kKq8SoOej6kehFEVoqwAJQLjJAD8P5CcyAT6fidhDhjNPv+20/bLu
	 34Q99LGSMbo73je22Ekl20bBhCnpqC0YwaYLhMDnmDq0sRTLQoaP4mGtcLVO+0TDl/
	 RYOL+s8g/el5jVuwZ2NF6o1PuObwg7LMqF+uN6ojVgYv14wiFPptZn+PNo8qRczMgv
	 46+s6JWpQw42Q==
Date: Mon, 14 Oct 2024 20:15:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dh?=
 =?UTF-8?B?bHZlcw==?= <joao.goncalves@toradex.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241014201515.463c7c07@jic23-huawei>
In-Reply-To: <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
	<20241014094154.9439-6-antoniu.miclaus@analog.com>
	<Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 16:14:27 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:
> > Add support for the AD485X a fully buffered, 8-channel simultaneous
> > sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> > differential, wide common-mode range inputs.  
> 
> ...
> 
> > +config AD4851
> > +	tristate "Analog Device AD4851 DAS Driver"
> > +	depends on SPI
> > +	select REGMAP_SPI
> > +	select IIO_BACKEND
> > +	help
> > +	  Say yes here to build support for Analog Devices AD4851, AD4852,
> > +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
> > +	  data acquisition system (DAS).  
> 
> I think I already commented on this... Anyway, it's much better to support when
> this list is broke down on per device per line. In such a case it's less churn
> if we need to remove or add an entry in the future.
> 
> > +	  To compile this driver as a module, choose M here: the module will be
> > +	  called ad4851.  
> 
> Also, with all these devices to be supported why not ad485x as the name of
> the driver? Is it a preference by the IIO subsystem?

Don't.  We've been bitten by too many cases of manufacturers noticing
a hole in their part numbers and 'slotting' something unrelated in.
So it just causes confusion.  Hence strong preference for any new code
is pick a name from the list.  The wild card also implies restrictions
that tend to break overtime when other part numbers outside the range
are used.  Not using a wildcard keeps it consistently wrong so people
get used to it :)

> 
> ...
> 
> > +#include <asm/unaligned.h>  
> 
> linux/unaligned nowadays (I learnt it quite recently).
> (It requires v6.12-rc2).

Yup.  That bit me in the IIO tree 3 times so far. I've
merged rc2 in for that reason.



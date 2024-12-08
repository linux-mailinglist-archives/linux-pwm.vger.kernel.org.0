Return-Path: <linux-pwm+bounces-4289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C29E874A
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB65164515
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC1189B85;
	Sun,  8 Dec 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzmflGFx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EE145324;
	Sun,  8 Dec 2024 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682730; cv=none; b=mWUoZfOZk98754ID3EYFFWyHhkol0OQn1XZ+VD+sDSe8f6xF0+NL0u3NaWwSQc17NrpA9AVCc6Zfy1RPLnD09N6hKC8ntNFPPPimIQaUXm/Zc9owuDAdtpyoR1xMPi0hWczu+IL/DK+VjVGm8j+BMjbnLnXjHioyL3Rdlvpa4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682730; c=relaxed/simple;
	bh=vkpIgwYBpysi2q22hKet+gev725W0T2HlhlIHocDAeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/AiJLyRHVg3KWcwmnMqWSZgdwgvgiMRflqF6DFakvZU8XcKd1sz3THJI/vz2mqPzA9OIpQIPv/PCP7ZIO+bwt7B/Oc8zIEehLgpMEV5ZSkz9xB0roCDJHzfzrYcFmyEoFalZkXBbNvkuBN5D76OP7YEvfIe9+PAX8ap9CR89js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzmflGFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FDBC4CED2;
	Sun,  8 Dec 2024 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733682729;
	bh=vkpIgwYBpysi2q22hKet+gev725W0T2HlhlIHocDAeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LzmflGFxnrGBxZhk+lPv32AyRW+kaZov7v/N8zIql4RE+p0VJldBYKHdPhd6vcbMB
	 CikdS5Y4mSVyr+lw+LwaDAs26PturPuJ//iBJpU8/I0GVifmuc50SE/CHHMsIejCVu
	 WunOR2EI7N3hgVkXo/r7E3sYvXbsnEx8mpyl6rkr9sxaZ8Rva1OgA3z23Q77uXHzOH
	 Zc73qAOGjZ+4KoWo7xXRk/+IIaqczM+DxNv6YMl05u741XseEmIQ2RAUgOcrVVNNZN
	 9J39MlcieT+zAdi5NoU1sTKs+tdU2MfsvQpb8zGleQMmvyFu3ugQuyUv/SWcLdRXnh
	 +hNUF24prbaqw==
Date: Sun, 8 Dec 2024 18:32:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 10/16] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Message-ID: <20241208183201.1b83cd0c@jic23-huawei>
In-Reply-To: <21d2e190-4cb9-4090-9dfd-2bb250ba186e@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-10-bea815bd5ea5@baylibre.com>
	<20241124171609.50c6c3a8@jic23-huawei>
	<08ccc3fd-a53c-4d0e-8659-92204d2c27a8@baylibre.com>
	<21d2e190-4cb9-4090-9dfd-2bb250ba186e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 16:04:40 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/6/24 3:36 PM, David Lechner wrote:
> > On 11/24/24 11:16 AM, Jonathan Cameron wrote:  
> >> On Fri, 15 Nov 2024 14:18:49 -0600
> >> David Lechner <dlechner@baylibre.com> wrote:
> >>  
> >>> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
> >>> cases where the DMA channel is managed by the caller rather than being
> >>> requested and released by the iio_dmaengine module.
> >>>
> >>> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> >> Fresh read and I'm wondering if the lifetimes in here can be managed
> >> more simply either by pushing the DMA channel get down, or dragging
> >> the release up.   Basically I'd like to see them at the same level
> >> of nesting in the code.  If it ends up being necessary to duplicate
> >> more code that is fine if it makes this easier to reason about.
> >>  
> > 
> > One option could be instead of introducing a 2nd function, change  
> 
> Oops. The new function is devm_ so would still need a 2nd function
> but changing iio_dmaengine_buffer_setup_ext() to have basically
> the same signature would still avoid the asymmetry.
That sounds sensible. (though I've mostly forgotten the background ;)

> 
> > the existing iio_dmaengine_buffer_setup_ext() to use the signature
> > of the proposed devm_iio_dmaengine_buffer_setup_ext2(). There are
> > only two users of these functions. So we could move the dma chan
> > request/release out to the drivers for those.
> > 
> > Otherwise, we can't completely get rid of the owns_chan bit.
> >   



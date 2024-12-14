Return-Path: <linux-pwm+bounces-4351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4109F1F62
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43FF1605F1
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F8192B63;
	Sat, 14 Dec 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpnRqEcd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC40EC0;
	Sat, 14 Dec 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734187077; cv=none; b=gVsZ9u+xwzsF2NQvSZyVniqFSlVTkfQfiUpfsY3sPAIjx98F8zgRubgWRTcfHVHEo5R7pCFYhwaLkb/yk85f4DJPyjHIwmLtcuFGkHCaTRXzZ3BoxRK/FilIsdvMX/eX0MMZOqDbvI8JHu0cWuQqPKiaX2hyxHE8SjK2MH6hEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734187077; c=relaxed/simple;
	bh=QK/mGCIL3/gzA3FO2l3WrCzw+jBGDFXp7ZuXMYNQxdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMpU96yl95vNdki+PLztWw4cPjMepzuuUPCG8/YSSzH1nYQcLS6++7ewkPv/5YYQTtCYm1mN4WJzR10EgRvWVcrbs7h3bHfx4OfPhB7Q8dbr+9fKjdQjvlRVKkCycp6eKsQqD9lkrFhU1Vog9v/QrxblirzFi6+nJF8wmU17uQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpnRqEcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71744C4CED1;
	Sat, 14 Dec 2024 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734187076;
	bh=QK/mGCIL3/gzA3FO2l3WrCzw+jBGDFXp7ZuXMYNQxdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpnRqEcdCRX3Tcr1UTRUxgCk3Mb13RNIgdHo+TY0DbW60TREs189Ar+FL2o/q0P+S
	 p6RZCOOWWSWd75PQlVK0BHvsWB2fUnrRauo5ZEOwqfxcINoPjzYOu5izIo0TAjnAuY
	 2ZL8EJuFtt1z71s6xQ8qcABAks/ItPxXIE4oXTm/fIN4PTakFgBIE607Xqj1r2qfIC
	 e2WW4A0d6Ves1b+uS8JNhcMMQVNZOGuDURPAU3Xd0JyKN/smhMRv9GM7qTi9JrEfZC
	 KZ0tMV++O4qTOVQ6nMHFu1cbE5T7HbvwAZfpz80G+9NcA2QxPg383v/jwJCDZKZicb
	 qn5Iq63zSOprA==
Date: Sat, 14 Dec 2024 14:37:45 +0000
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
Subject: Re: [PATCH v6 08/17] iio: buffer-dmaengine: split requesting DMA
 channel from allocating buffer
Message-ID: <20241214143745.681e8408@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-8-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-8-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Refactor the IIO dmaengine buffer code to split requesting the DMA
> channel from allocating the buffer. We want to be able to add a new
> function where the IIO device driver manages the DMA channel, so these
> two actions need to be separate.
> 
> To do this, calling dma_request_chan() is moved from
> iio_dmaengine_buffer_alloc() to iio_dmaengine_buffer_setup_ext(). A new
> __iio_dmaengine_buffer_setup_ext() helper function is added to simplify
> error unwinding and will also be used by a new function in a later
> patch.
> 
> iio_dmaengine_buffer_free() now only frees the buffer and does not
> release the DMA channel. A new iio_dmaengine_buffer_teardown() function
> is added to unwind everything done in iio_dmaengine_buffer_setup_ext().
> This keeps things more symmetrical with obvious pairs alloc/free and
> setup/teardown.
> 
> Calling dma_get_slave_caps() in iio_dmaengine_buffer_alloc() is moved so
> that we can avoid any gotos for error unwinding.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v6 changes:
> * Split out from patch that adds the new function
> * Dropped owns_chan flag
> * Introduced iio_dmaengine_buffer_teardown() so that
>   iio_dmaengine_buffer_free() doesn't have to manage the DMA channel

Ouch this is a fiddly refactor to unwind from the diff.
I 'think' it's correct, but am keen to get a few more eyes on this
if possible.  Not 100% sure what route this series will take, so on off
chance this patch doesn't go through IIO or a immutable branch I
create.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



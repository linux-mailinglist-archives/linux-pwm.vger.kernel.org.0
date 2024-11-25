Return-Path: <linux-pwm+bounces-4148-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106469D8E06
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CA728B025
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4641191478;
	Mon, 25 Nov 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt9e3SLK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E2185B77;
	Mon, 25 Nov 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570268; cv=none; b=TKzxvNJQHl6Hlc67YiNn0ujZf6HXuMdHU7SyauxqknfbCkobwcR49Qm3/+xsafXxO44Ey57hcMDTzByIZPWv096Pck4kNEdg3MC6OyAOaEcltnA1B7ZBb6+02o2wLy0pIE0CrsqDycn+vIS9s4H+nInYswkUNLNs/rUkc6cFYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570268; c=relaxed/simple;
	bh=iGVTMarzxn5JVfucjRE+H4jhcqvPyiJG2UTEgJoa4VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+T1rwZbVABem8+ntimY2yBz2pzgfbMpzlAa2xRReLBU6sL+m79sJbLt1e88iol6mAfLGkrkOM0g9fUHzxcFx4PWq5SYXQvsohncpvGWmf1as3wqzLWXO0vnLlV2XWkl6CJ+rVAo9ak2EotX+29tfqNma3ZLMRaDt83aLLvuzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt9e3SLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACEAC4CECE;
	Mon, 25 Nov 2024 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732570268;
	bh=iGVTMarzxn5JVfucjRE+H4jhcqvPyiJG2UTEgJoa4VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dt9e3SLKzk6MEaz6xazhNJo4xqvtm2ot3hfAhi4ZH5qKady5Ylas34+cv4W5GvOPM
	 Vghav+UA2GRXPSwqJYV7BHNWpBI8s1/AyHfl4+GOXo8BYzJMerlrWcmknidkpq8Ldm
	 6Krp5PZ1dtGxUAkjNErE+6mOZXtYJCT+jXP9kYa4+PbM2h3zn7w6nvmmvKWDcbNpb6
	 eUdBMEnsyDTBtAtcR8ZdkHjf4X2ixOip65JcE3F2bOmZEjtJUNDc5jXS8+GJlhY5JP
	 rkqoD/Txa3pmfFIqTy+MWWBFDAfwwE2il66SbuE5kdL5RMhiLQqxB/h2UeOp3iK+cC
	 upbroTs5+aetQ==
Date: Mon, 25 Nov 2024 21:30:58 +0000
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
Subject: Re: [PATCH v5 06/16] spi: add offload TX/RX streaming APIs
Message-ID: <20241125213058.137349ed@jic23-huawei>
In-Reply-To: <259515cc-ca36-4dcd-b884-a9f9e3c2ab2e@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-6-bea815bd5ea5@baylibre.com>
	<20241124165039.206dc994@jic23-huawei>
	<259515cc-ca36-4dcd-b884-a9f9e3c2ab2e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 11:54:44 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/24/24 10:50 AM, Jonathan Cameron wrote:
> > On Fri, 15 Nov 2024 14:18:45 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Most configuration of SPI offloads is handled opaquely using the offload
> >> pointer that is passed to the various offload functions. However, there
> >> are some offload features that need to be controlled on a per transfer
> >> basis.
> >>
> >> This patch adds a flag field to struct spi_transfer to allow specifying
> >> such features. The first feature to be added is the ability to stream
> >> data to/from a hardware sink/source rather than using a tx or rx buffer.
> >> Additional flags can be added in the future as needed.
> >>
> >> A flags field is also added to the offload struct for providers to
> >> indicate which flags are supported. This allows for generic checking of
> >> offload capabilities during __spi_validate() so that each offload
> >> provider doesn't have to implement their own validation.
> >>
> >> As a first users of this streaming capability, getter functions are
> >> added to get a DMA channel that is directly connected to the offload.
> >> Peripheral drivers will use this to get a DMA channel and configure it
> >> to suit their needs.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > Some docs that need updating.  Otherwise I wonder if we should delay
> > the _tx variants until there is a driver using them.
> > 
> > I'm sure you have one on the way and there is an argument that it makes
> > sense to review rx and tx together, but still good to only add code
> > when it's used.
> > 
> > Jonathan
> >   
> 
> In v1 Mark commented that he expected TX along with RX. And we do
> have a DAC driver we can probably add to the series in the next
> revision that uses it.
Perfect, or maybe just reference that in the description as
'coming soon'.  I'm fine with infrastructure coming a bit before the
user and I can always trust you to send me more drivers :)

Jonathan




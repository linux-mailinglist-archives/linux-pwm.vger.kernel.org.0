Return-Path: <linux-pwm+bounces-4350-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F549F1F50
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE1166553
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1629194C78;
	Sat, 14 Dec 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+oyUZXs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCE194C67;
	Sat, 14 Dec 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186611; cv=none; b=khSbvCiP2gVFD19sabtoRLbKasM0U/rNnLLESwGOscxcuGzrV/6eERHBvngrLNtZVeRj8dj2OMa+VIXBkoMK+QHGl/0Qa76qMQOEhzc/wFI/d1qrCTjT34cgVW/66s7jeNBVcbMUUnC/9+sZ/ZvMkVsMW//1VgoMkKUxhPVhOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186611; c=relaxed/simple;
	bh=QRQM0WeltiB5LUa+CXRAAaSfLyq9oNFuIdDrLTxLWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWnlX/cHektABOhYA/mbIqPYzFutK3ch5EjW/iMJXX8EQURCPGXmB0cCy/rQlpNoiCYbITrFHwBUipkdosQfcBmI0y9Suqg0O6NNl62u5/14AH1nC1QQ71wdHMAinT/dSnQHKAcFAUtLWuBlbGkeqrgNpgbHXWObEUwQVyY3ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+oyUZXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE1EC4CED1;
	Sat, 14 Dec 2024 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186611;
	bh=QRQM0WeltiB5LUa+CXRAAaSfLyq9oNFuIdDrLTxLWnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p+oyUZXsO2Y6g/BnRMkV0u44AkIFH05QBDOJwJw8N9OkjJ9KnfXFkZ+L40VCxxpLh
	 HAfr7MzHtkcx9LC0kLGlZEeywEbJGVI8lcNZLPNcPWzIbvfvZTuDWSBlZbkG29rQa3
	 2w2h4iyqNk85C+q4cgNgbkfD3zeotuMykYpea8ndjJqQJj946XEi2J0Iu1o3bt5ecB
	 ih4Iw3RlgcEF6BkEBinO9+g+D4dvL363kLoACaLSQtFLrMxoe6bHwtJdh+C8RIhVoH
	 Z0GLDqRuJFiqK2jPGN2WzNgoV3+brcVphemMTgviPHieXKGh8r34lmf8ZU1Kbd2ZW9
	 DPIH6Vescgfhw==
Date: Sat, 14 Dec 2024 14:30:03 +0000
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
Subject: Re: [PATCH v6 06/17] spi: dt-bindings: axi-spi-engine: add SPI
 offload properties
Message-ID: <20241214143003.050be762@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-6-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-6-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:43 -0600
David Lechner <dlechner@baylibre.com> wrote:

> The AXI SPI Engine has support for hardware offloading capabilities.
> This includes a connection to a DMA controller for streaming RX or TX
> data and a trigger input for starting execution of the SPI message
> programmed in the offload. It is designed to support up to 32 offload
> instances.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I briefly thought about suggesting some docs for the dma channel naming
but meh, that's just the pattern stuff confusing me. The actual strings
are pretty self documenting.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>




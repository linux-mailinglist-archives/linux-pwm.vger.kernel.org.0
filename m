Return-Path: <linux-pwm+bounces-4174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B15519DF20B
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B01B216A4
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D481A9B31;
	Sat, 30 Nov 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq4dOyIO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820991A262D;
	Sat, 30 Nov 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984798; cv=none; b=eAPbmijypIKiPFBYIWTY3PFdo2og3NDSg6gJkop2EglGhx8sywpTt5zH0S6qhuwe9BHvKVdeg31pNyjZUFHlURhO1142RrmHI6tUS5fuqZ1MM1ecX2Yw01+V21gKAyV9bxSVi1Z/13eSHlFFN8hXV9ZrJubnu5iMCipxv12X3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984798; c=relaxed/simple;
	bh=+u8LgIOvUlPBz2HK5bh0o3+XbmSU74QqH3PJbLYocJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOr9mYm6tVr3t/7RW6wNGHhlx4VqP3NzVOc/DLryW0wYYuktdYtPmXYeDVcRWWl6qARWypEbRH2levXvTUEh31FPXuuStXxS8Gws/t6hdN3YoKp6hpqIsOcyWmsrIFjb39Cpc6RyVZZ5GnN2NTTh/l0eV3mGtBHEGkAURDHIjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq4dOyIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23193C4CED4;
	Sat, 30 Nov 2024 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732984798;
	bh=+u8LgIOvUlPBz2HK5bh0o3+XbmSU74QqH3PJbLYocJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sq4dOyIO46GyiPRltR/GLigKM2kEfYbgEmzaB+Ub2t+CF4L8cBBAM9237MtPlOfWJ
	 wtdeWIL5XXl5PvH5cg9xtrhfBI7iYyH5cC0BvbFIMuFahBGPuxtcxscQedySeuyKWR
	 dm/n/95Z/ojvT2Aa1mLwqaBfr0d4FeqiS+3qUaWHy4Yd9yH3IV7aMfYH9tLAkyCc14
	 3DP30fISyInWZTZ9bO+cNEQWSZJAfpb9hSyoU9gsdy/hdmuJJ6uWY1UX3k/CkyhcqK
	 +OuZeRsaGEMRJ4rTbi7XXKkMYcOIyoYKjgETUAeSnMUK/fQr6VHVTpWmyAWLZErfNG
	 vy99UXUY00Bgw==
Date: Sat, 30 Nov 2024 16:39:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Message-ID: <20241130163948.269289dc@jic23-huawei>
In-Reply-To: <20241129153356.63547-2-antoniu.miclaus@analog.com>
References: <20241129153356.63547-1-antoniu.miclaus@analog.com>
	<20241129153356.63547-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 17:33:52 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for reference doubler enable and reference divide by 2
> clock.
> 
> Both of these blocks are optional on the frequency path within the
> chip and can be adjusted depending on the custom needs of the
> applications.
Thanks for the additional info!
> 
> The doubler is useful for increasing the PFD comparison frequency
> which will result in a noise performance of the system.

So I'll play devil's advocate. Improved noise performance sounds
good. If it doesn't take me out of range of allowed frequencies, why
would I not turn it on?  What is it about the surrounding circuitry
etc that would make this a bad idea for some uses of this chip
but not others?

> 
> The reference divide by 2 divides the reference signal by 2,
> resulting in a 50% duty cycle PFD frequency.

why would I want one of those? My 'guess' is this makes sense
if the reference frequency is too high after the application of
the scaling done by the 5 bit counter.  In effect it means the
division circuitry does divide by 1-31, 2-64 in steps of 2.

That could all be wrapped up in the existing control of the
frequency, and so far I'm still not seeing a strong reason why
it belongs in DT.

The 50% cycle thing is a bit of a red herring as assuming it
is triggered on say the rising edge of the high frequency signal
to toggle the divided signal, that will always be a 50% duty cycle.

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - add explanation in commit body
>  .../devicetree/bindings/iio/frequency/adf4371.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..ef241c38520c 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,17 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves lock as
>        measured by the digital lock detect circuitry.
>  
> +  adi,reference-doubler-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference doubler block is enabled.
> +
> +  adi,adi,reference-div2-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference divide by 2 clock is enabled.
> +      This feature can be used to provide a 50% duty cycle signal to the PFD.
> +
>  required:
>    - compatible
>    - reg



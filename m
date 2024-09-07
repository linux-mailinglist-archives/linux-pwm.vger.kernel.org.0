Return-Path: <linux-pwm+bounces-3147-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B797026F
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 15:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE491C21319
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3A15CD6E;
	Sat,  7 Sep 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsIJfc3O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A515C14B;
	Sat,  7 Sep 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716285; cv=none; b=t7vvx2Kspc+5TltkY7+Fo3MWdCOBwyAULDH4CIKl3IYoOPW8e3YpZzIa2W6b3tcstWwftIdmg8h2snPXhRdmeAJ6OL1RsPq64FyzqMm7OgCFlMnBcI/KHd5Ifq8/uZKtbc90yARUJ6SFhTHFuSyx+vNY/U3hmId3QD37dIyClt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716285; c=relaxed/simple;
	bh=PmRMBiGpEYZ5ZlHp1rYoWZQiWna2cIWEzbmQr+h8KsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrSSNj3UDuSMASjWAuZrlYmuC8GpBgk9BYaCHL1ZCqeHLIhIN0cbYwqVYWValNLzeIgejHIvszsauDlUiBMJCwspBjyhV5puI8GtGUq17pjChDTLPZwCoNzqeI57n2IraO3zMm3+6u07XvJFszqCLQWmfU54+fns+sv5HCViFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsIJfc3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C35C4CEC2;
	Sat,  7 Sep 2024 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725716284;
	bh=PmRMBiGpEYZ5ZlHp1rYoWZQiWna2cIWEzbmQr+h8KsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsIJfc3Ol3cBA4KSar5Ki99v3QRJyCi13+UVxzmQRdjLYdlLDfCZIaRNfOI6GOHC8
	 sLPltt3f4v38wkWUpncdoUprfIHBnLMOCSJ31D3L0esvtq3IabG+biVBXclzjb0DU5
	 jopxttKvwcDPNelCCyczIp7hv0CFpyI7YtiC505S0SqwxeVoeUUUu7hWW8oqvFOiYq
	 OzwmGcx+IP8pwgpcHfctrPX/1M2Gdifk5wOqQro1JLDQKoImWoyNyM6a9lJXquPu8p
	 otTA4Fyopw9ZAucdrwUqWIUfVmrDjC+x7K2cN4DGoyB9Hr9EEyi4v1840Br39nBVh2
	 gI8J5aeuxnnZQ==
Date: Sat, 7 Sep 2024 14:37:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Guillaume Stols <gstols@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, aardelean@baylibre.com
Subject: Re: [PATCH 2/8] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Message-ID: <20240907143753.4ef594c0@jic23-huawei>
In-Reply-To: <b7cae260-19ca-485d-b9c5-4b9209ee4886@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>
	<20240817160900.01224c80@jic23-huawei>
	<b7cae260-19ca-485d-b9c5-4b9209ee4886@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 11:54:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/17/24 10:09 AM, Jonathan Cameron wrote:
> > On Thu, 15 Aug 2024 12:11:56 +0000
> > Guillaume Stols <gstols@baylibre.com> wrote:
> >   
> >> Add the required properties for iio-backend support, as well as an
> >> example and the conditions to mutually exclude interruption and
> >> conversion trigger with iio-backend.
> >> The iio-backend's function is to controls the communication, and thus the
> >> interruption pin won't be available anymore.
> >> As a consequence, the conversion pin must be controlled externally since
> >> we will miss information about when every single conversion cycle (i.e
> >> conversion + data transfert) ends, hence a PWM is introduced to trigger  
> > 
> > transfer
> >   
> >> the conversions.
> >>
> >> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 75 +++++++++++++++++++++-
> >>  1 file changed, 72 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> >> index c0008d36320f..4b324f7e3207 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> >> @@ -114,13 +114,28 @@ properties:
> >>        assumed that the pins are hardwired to VDD.
> >>      type: boolean
> >>  
> >> +  pwms:
> >> +    description:
> >> +      In case the conversion is triggered by a PWM instead of a GPIO plugged to
> >> +      the CONVST pin, the PWM must be referenced.
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +
> >> +  pwm-names:
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +
> >> +  io-backends:
> >> +    description:
> >> +      A reference to the iio-backend, which is responsible handling the BUSY
> >> +      pin's falling edge and communication.
> >> +      An example of backend can be found at
> >> +      http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
> >> +
> >>  required:
> >>    - compatible
> >> -  - reg  
> > 
> > I think we still want a reg, but only to differentiate multiple instances
> > perhaps.  
> 
> In light of the recent discussions on the similar AXI DAC
> support for AD3552R [1], should we consider some of the same
> things here?
> 
> Essentially, the AXI ADC IP block in this series is acting as
> a parallel bus provider for the AD7606 chip. This is used both
> for configuring registers on the chip and "offloading" for high
> speed data capture.
> 
> So this would mean...
> 
> 1. We should add a new compatible string to iio/adc/adi,axi-adc.yaml
>    for the specialized version of the AXI ADC IP that is used with
>    AD7606 and similar ADCs.
> 2. In the .dts, the AXI ADC node should be the parent of the ADC node
>    since the AXI ADC IP is providing the parallel bus to the ADC.

Ah. I'd completely failed to notice this didn't have a separate control
bus.  The existing ad7606 only does reading so I assumed that the
data path couldn't carry configuration data.  Looking at this patch
is that still the case?

If so I think it is less critical to represent the bus given the history
of not doing so in this driver.   It would be a nice to have though.

Jonathan


> 
> 
> [1]: https://lore.kernel.org/linux-iio/20240903203935.358a1423@jic23-huawei/
> 
> >   
> >>    - avcc-supply
> >>    - vdrive-supply  
> > 
> > 
> >   
> 



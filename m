Return-Path: <linux-pwm+bounces-3028-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E895587D
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34237B21467
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093F1EEE6;
	Sat, 17 Aug 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4QJRRbT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E598C13;
	Sat, 17 Aug 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907161; cv=none; b=IjTA4DpwPb5mXF/YNTyCB0cIdqNZjm4uJ0BwMR1QkpsM2omFoZONftIFC5G7zANsgOVG0uBkw0F13It9JsMdlqGV266KiwygMlGGxbFJdulup2Nav4dCBK1vBiMGFXgG7Y0opWBGV6NxmCy+SqK8FXS8zRjq8lSNjwlSd6wPXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907161; c=relaxed/simple;
	bh=DPfWRBNmOad3lOAZeZayk9fxKFvYsffkJGnblvIMbb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2+R9X5yL0Nb//ap9djba4mNpQByFEwB7x1IWyM3jEo2ihF5SzlS2uWF6aq1NY0Ww/a7VhSdDC9nr6r7gBFgAhIzuZwtTsR2GrKNH5UlLA40/oa5F6uCQio1VxOXXarvn1ACO8V2ezDq5zekSKuMDpU8PFoZOAe9jmJMtEKwjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4QJRRbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E4C116B1;
	Sat, 17 Aug 2024 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723907160;
	bh=DPfWRBNmOad3lOAZeZayk9fxKFvYsffkJGnblvIMbb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4QJRRbT2PlAnxzbLrcwjS5ln88z6VW+NnmMk65s1HMYf8hD4450xMpPNgFTta4El
	 mmTDOPgyCzBPzmkZjRwbleIKQyJOJRFCvymgPMXZB45r/UKq/WyFk2Rx9Et6GYdWRD
	 KUZaNvAIpFBlxATxb62dmSqTaxjKYiNvNehqTlq+W8ATiCPiap+D7CBzJ2DQfOOENr
	 cxQ8WJv2cZcKDeRWmw/ykSqptZYGyJ6q+Agd6ebE3wkNPYaIj5zFVhlUdXE8WGDAdU
	 H6mLgafz+vmH/8yiHcySOIBYRhRGtb9lwI9d1aDQ//i4Lpbsi/fDr11u3q1UQmUXHU
	 3WmSAadHAfW/Q==
Date: Sat, 17 Aug 2024 16:05:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: ad7606: Make corrections on
 spi conditions
Message-ID: <20240817160551.35353140@jic23-huawei>
In-Reply-To: <20240815-reword-wildland-1319629f0718@spud>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-1-cea3e11b1aa4@baylibre.com>
	<20240815-reword-wildland-1319629f0718@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 15:35:34 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Aug 15, 2024 at 12:11:55PM +0000, Guillaume Stols wrote:
> > The SPI conditions are not always required, because there is also a
> > parallel interface. The way used to detect that the SPI interface is
> > used is to check if the reg value is between 0 and 256.
> > There is also a correction on the spi-cpha that is not required when SPI
> > interface is selected, while spi-cpol is.  
> 
> This feels like it should be two patches, with the first having a Fixes:
> tag etc, if the original binding was incorrect.
> 
> > 
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7606.yaml         | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > index 69408cae3db9..c0008d36320f 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > @@ -117,15 +117,26 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - spi-cpha
> >    - avcc-supply
> >    - vdrive-supply
> >    - interrupts
> >    - adi,conversion-start-gpios
> >  
> > -allOf:
> > -  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +# This checks if reg is a chipselect so the device is on an SPI
> > +# bus, the if-clause will fail if reg is a tuple such as for a
> > +# platform device.
> > +if:
> > +  properties:
> > +    reg:
> > +      minimum: 0
> > +      maximum: 256

That's not particularly nice - in theory the parallel bus memory map could
be at 0 - it's just very unlikely on a real platform.

I'd just do what we do with i2c/spi drivers and just not make it required at all.
Rely on comments to say why.

In ideal case we'd figure out from the parent node if it was an spi bus
but I have no idea how that might be enforced.

> > +then:
> > +  allOf:
> > +    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +    - required:
> > +        - spi-cpol
> >  
> > +allOf:
> >    - if:
> >        properties:
> >          compatible:
> > 
> > -- 
> > 2.34.1
> >   



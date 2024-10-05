Return-Path: <linux-pwm+bounces-3501-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63E9919B9
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DA61C20C15
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CE15F330;
	Sat,  5 Oct 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5dskjzy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146815AAD7;
	Sat,  5 Oct 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154225; cv=none; b=hJmvmVU4HN86S/tHkNreIAxflplpezrtnJg/XSxvZyG4Hn+eUXv54e0Cj5+oQvjhBLZFuZTsUzhhz9ZANK5xia+E89G1PrulLXkBcaHXaSnPmXFV+xukzHzKoi97C5wNuzmm6aSt1PTg5vsCUihEok/sm7bx39Hy8FBD8F4crWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154225; c=relaxed/simple;
	bh=/h852+JNDuH5bczkVGdaU70hx0zCVGRm4Umc47VfpuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzHjC+S+8QvhX03OrNqHtXB2w+fpVt8GJK6YBSCFBl5tCVTAcqVCWg8K1+OfHxKnZc5FRRkN9BfAic9u1JkqsC2UqCercaigmchaIWlC/4GPVjLWS/hGtN0jfR3kmIfTiVIWl40fVA1ARtELp4exoLnsdRAAR1DI5UdUHA0Q4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5dskjzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF4C4CEC2;
	Sat,  5 Oct 2024 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728154224;
	bh=/h852+JNDuH5bczkVGdaU70hx0zCVGRm4Umc47VfpuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5dskjzyroZ5LbrtLmy7wgQQ+PA8neH6RtXNyAMU2uuwHgsbbLYtHvlUbavJuCONQ
	 SgrPmuFk++Vtc3mTfc0cUl8v1fY81hoQDv3A6OpMdw8wiaD79n3Dw9xcwZnNusJ++j
	 Q0dJSLT5A6Zr3GIHaX1tI/NzZo9KUVmrGboEvfoBxGG6dIkZ7TQydSxXXu3wdRLFND
	 9Z3fBVYXJyIe3PIPOA5AK4g3Nm6AEOPkLbCkCNtKTT1LQWw2TRIIEJTodvLJdLQeCA
	 mEEyVq3BIvtcwWlSIbmxCjv8yvkFPgg+T6l6Q+YmT5Zz2H+ThWNrvT46Ebb3D6NOTe
	 U/1YQM54tzFuw==
Date: Sat, 5 Oct 2024 13:50:23 -0500
From: Rob Herring <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, aardelean@baylibre.com,
	dlechner@baylibre.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Message-ID: <20241005185023.GA521649-robh@kernel.org>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
 <20241004-ad7606_add_iio_backend_support-v3-3-38757012ce82@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-3-38757012ce82@baylibre.com>

On Fri, Oct 04, 2024 at 09:48:37PM +0000, Guillaume Stols wrote:
> Add the required properties for iio-backend support, as well as an
> example and the conditions to mutually exclude interruption and
> conversion trigger with iio-backend.
> The iio-backend's function is to controls the communication, and thus the
> interruption pin won't be available anymore.
> As a consequence, the conversion pin must be controlled externally since
> we will miss information about when every single conversion cycle (i.e
> conversion + data transfer) ends, hence a PWM is introduced to trigger
> the conversions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 64 +++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 47081c79a1cf..a389cfda824d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -129,6 +129,29 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
>  
> +  pwms:
> +    description:
> +      In case the conversion is triggered by a PWM instead of a GPIO plugged to
> +      the CONVST pin, the PWM must be referenced.
> +      The first is the PWM connected to CONVST or CONVST1 for the chips with 2

s/2/2nd/

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


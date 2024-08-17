Return-Path: <linux-pwm+bounces-3029-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4A955883
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC6A1F21BF8
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436101442F2;
	Sat, 17 Aug 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCEtOVZf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AF282F4;
	Sat, 17 Aug 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907361; cv=none; b=eusT2npWqe7Dwra5c+UxVB9nJBFZlYROAndYd4lg94WC9tIaTjJKXPPHIEVrERmnVG91bxqTbPqUyJtyID8OIh9bNB+9TxKMmYLBumGMGhHAfa6UUVA/ksCPuJo8OP8a4w09CxgR6pzQTR6OsVIbVCM9QWojIya4D1eAHWG65XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907361; c=relaxed/simple;
	bh=vT90vZx0bkS5VbqUkazyS+8auUsDLMrWvv+LTZ+swMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMLXa7qCDxOO0dP66IiVxDKYenlFGQKKeri4RHvRJMgCF7dORT4FYjtt56nbmHL5ZNi0/nW/c09N2rjvVp7hefnJ4QopGIzOLxoYgx/RQaTF1V7WEKhoaVXYyAa+ZVcuVdh3y1AGRNk98d2de28KSkS4dualrkfWUP9LRuTQilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCEtOVZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD543C116B1;
	Sat, 17 Aug 2024 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723907360;
	bh=vT90vZx0bkS5VbqUkazyS+8auUsDLMrWvv+LTZ+swMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCEtOVZf2KXGsSlV9M4pTypH+iH6GEjpJYeYRUe8RkXTllV2EYldbabBXg5HyJaSi
	 ROopU2mRJBPj1UeEV7PRyzucQm8TgHK690r/8pabBaO+5gMi/QS3MhLnDwNXTrIG/N
	 oIL+s7PWdTMKWd5vD2CBaUU7qZW+QvBlK2KShnHQ3xAhPS9RSr7Jiy3x5BMl+Uir4i
	 HqayNfGkwVIuZcspDFJQD+JYGxN/+Y1rJgUCO81sVmioYNAk5uzxLUxvw5bc7fmqTA
	 KguC5pQ8FMQq6MetyLU01zTHyYDHjojyTb2Ytr+HmkYOpC0LpX70M4kob1GsBQMb9p
	 vC6QZsq9AxqJA==
Date: Sat, 17 Aug 2024 16:09:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 2/8] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Message-ID: <20240817160900.01224c80@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:11:56 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Add the required properties for iio-backend support, as well as an
> example and the conditions to mutually exclude interruption and
> conversion trigger with iio-backend.
> The iio-backend's function is to controls the communication, and thus the
> interruption pin won't be available anymore.
> As a consequence, the conversion pin must be controlled externally since
> we will miss information about when every single conversion cycle (i.e
> conversion + data transfert) ends, hence a PWM is introduced to trigger

transfer

> the conversions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 75 +++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index c0008d36320f..4b324f7e3207 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -114,13 +114,28 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
>  
> +  pwms:
> +    description:
> +      In case the conversion is triggered by a PWM instead of a GPIO plugged to
> +      the CONVST pin, the PWM must be referenced.
> +    minItems: 1
> +    maxItems: 2
> +
> +  pwm-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  io-backends:
> +    description:
> +      A reference to the iio-backend, which is responsible handling the BUSY
> +      pin's falling edge and communication.
> +      An example of backend can be found at
> +      http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
> +
>  required:
>    - compatible
> -  - reg

I think we still want a reg, but only to differentiate multiple instances
perhaps.

>    - avcc-supply
>    - vdrive-supply




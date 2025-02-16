Return-Path: <linux-pwm+bounces-4926-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737AFA374F5
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9736E3A1337
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137D198831;
	Sun, 16 Feb 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPCxWs5p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7811712;
	Sun, 16 Feb 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718956; cv=none; b=dui+2l/npkx9X+8+GFdvqjKLtPOCNwLhAy4kHexoE6QpQtcMkqo0+RQRXm69QCBdG6b0D8C2SFiGxvheXwfCJWmPnhIdXOahyW2AFzxO77EEfU77wG1Svhz+6apUQ6GGr1KvXbil1JNQr67xDHN39CmZRJsDFVdUbWp0cSF8pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718956; c=relaxed/simple;
	bh=k4xegN9pPojCrS2cyA8cvq1EaKPhQT0kZTepVfLZKQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHubXnCd52qtNgQkbt5lWPKnvBOLzy4HJmr+6WhUrV8zumWsoCfqwrULzp9BbjMx2TH5V7AAjXqhCq4OE8Wdzjxre/1QKZzdk0diaZ3aX8UbyiydDN7d2nc8QZf1A3jV/LuNWIXz+5vKgsYURz8LcR+Sj+WwclvpXGjLrkRbDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPCxWs5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA99C4CEDD;
	Sun, 16 Feb 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739718954;
	bh=k4xegN9pPojCrS2cyA8cvq1EaKPhQT0kZTepVfLZKQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vPCxWs5p2xCWOKNyLXFfY35OxxbRGLwNzHBjzi6AcrpDAaZzNYHqteVsTOOpH9i1K
	 3lxXXmWoVZmuyLW1iaNpJjTg/irCFSjwp6D5TFVtpgXNE6OCGWbStj9caBY3nZrDZD
	 z4VRJtbxGpHMhIljG1iKRN6QicSmGSX6bbsb0Jb3o3zuX1LLjeH2SsVM5MzSl+KfZC
	 h9eaxRP4QzZPqZvmB8D/DG4aizWwJ1ZuCVJo3fwL7iKD/TzNag/2il57fUySS/PMZ8
	 Xb4KEj+TBqejI9zfLlmoThd9MFAzd1AhF8i4lB5tpuJ61Qymm5bjbQhTAG5zBazzAQ
	 cbnCVfzJrcflQ==
Date: Sun, 16 Feb 2025 15:15:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v13 5/9] dt-bindings: iio: adc: add ad485x axi variant
Message-ID: <20250216151547.0c3edd58@jic23-huawei>
In-Reply-To: <20250214131955.31973-6-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
	<20250214131955.31973-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 15:19:51 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add a new compatible and related bindigns for the fpga-based
> AD485x AXI IP core, a variant of the generic AXI ADC IP.
> 
> The AXI AD485x IP is a very similar HDL (fpga) variant of the
> generic AXI ADC IP, intended to control ad485x familiy.
> 
> Although this is not preffered, the wildcard naming is used to
> match the published firmware under the same name.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This needed hand applying as the ad7606 case is already in my tree.
Also, quite a few typos in this patch description. Please make sure
to spell check in future.

I've applied this speculatively as we don't have a dt maintainer tag
yet. 

Jonathan

> ---
> changes in v13:
>  - adjust commit body and add comment on wildcard matching the published
>    firmware.
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index e1f450b80db2..f1b470f74069 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -19,11 +19,13 @@ description: |
>    memory via DMA.
>  
>    https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
>  
>  properties:
>    compatible:
>      enum:
>        - adi,axi-adc-10.0.a
> +      - adi,axi-ad485x
>  
>    reg:
>      maxItems: 1



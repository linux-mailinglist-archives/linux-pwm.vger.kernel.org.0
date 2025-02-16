Return-Path: <linux-pwm+bounces-4925-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D24A374E0
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 15:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A573616D82A
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98B198A06;
	Sun, 16 Feb 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jikGf2L6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160534C70;
	Sun, 16 Feb 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717808; cv=none; b=b6McRet0hFfZ2s69tX+Q/cKiN1dsLKBzk2PjivFZFXTWrsi9qXemA5nugP+VyHYlt/O/oMElqbQTH6QA/TesNq04kUSJyvFehGc+/DjjhcMDI/XSQd283FFw3eyVR87zluQfwYuAiwFcuuYpXUhJL2CN6Dx5AAGIjyUApc4ifD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717808; c=relaxed/simple;
	bh=udOKYh63bVmyVt1N98zIrhAr/2ta25BD0RnVWl+EyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUU4rO+8BK6tbXo35C2xrrx1rqm3M5AhdzNymCjvLXqVrJf/bsCkVNXx7af2qes7V+UM19M4VyhcJ6Us7+SriExWnWuIu6+XHgZcw1Y2SGY3YFwH2I6T2+UBoUfXpqM4zL2Qnw1T4kzdMc8O4X2NnjMrgqHI1sX84y1Q6izGNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jikGf2L6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878BC4CEDD;
	Sun, 16 Feb 2025 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739717807;
	bh=udOKYh63bVmyVt1N98zIrhAr/2ta25BD0RnVWl+EyNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jikGf2L6LNE+8i3d/7niK5UDh0bGHNREER5WxEn68JESW2Rgqhc2f2Uo+55END7v1
	 xcxqyhe6oe8Sr3nsoEzVBSncI17C5RgRtGzP9NSvBtQe6NOAE/WBryxtKTxkTjhvTs
	 vqtd5nM94cw0dzzEz9Q0pFvSemtpFR3RQ35Pmno2RIOOe6SEnW0OFFG0zqd7fP7BLD
	 20Mb7seH0N0O2ZAJ7gaQrhbykAgAhb9Om3+5eZY3PeqftFJC41khJ2MBiYmNgbRAX5
	 6quFlEeb3j8znswWI8xqXpnqPuPRWxQrSwGdM9wt3jzEcQV5Tbq6+qv1bApNVXjEGR
	 M6VxTxl2aoWnA==
Date: Sun, 16 Feb 2025 14:56:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v13 5/9] dt-bindings: iio: adc: add ad485x axi variant
Message-ID: <20250216145639.38ed6420@jic23-huawei>
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

preferred

If nothing else comes up I'll fix that up whilst applying.

> match the published firmware under the same name.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
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



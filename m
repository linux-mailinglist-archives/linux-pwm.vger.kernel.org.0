Return-Path: <linux-pwm+bounces-4581-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86749A0AA4E
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Jan 2025 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25804161018
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Jan 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF791B87E8;
	Sun, 12 Jan 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M45FWJ+I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA22F56;
	Sun, 12 Jan 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736694116; cv=none; b=KLswwHLphbt8bA/JlourkjOaabpX/0n+ndxkHG/ybDiQoBeQ8s2+Tb4cCj78stqC8FMOv0/8+8JYjitW4PDHbf1/Uh+gko+weoMFri4PSCWXGnjk9JPkAEYMWZYAWqlRcCsZaLcj3NHA7dB6gU+F4lxgZr1t81U7eigGpR/ahSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736694116; c=relaxed/simple;
	bh=infrPgIecbZ00H4RefJyMZhsSGwXd5kIqeOiF9OjsPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3tpoGl90JzCu6SM/v6jyh9DcHhBDq5x9pkFV42e+Ku3wOdD65YSTl+DkjhYgEtHR460Q2H/1x+eDGul7/AnUwKNqCGOzw3jksJco87Q18vzd6GC2wnIYhEw+nFAIEh8aHHevwJuQm84wHXa5FCQG5WNttJlazn7f+a6L5dJUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M45FWJ+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9EBC4CEDF;
	Sun, 12 Jan 2025 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736694116;
	bh=infrPgIecbZ00H4RefJyMZhsSGwXd5kIqeOiF9OjsPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M45FWJ+If5KX3BcF3zTrLGfYOhip22Lx/RnSg961SRnrVqv9sonfDb97zx2EeBfha
	 UPEyv3GcEF/ZqgId2GYgMjyV9SmDr5wVev0NjiFCzqZ89APOGPpyNA6cj5QiJpZqbk
	 LiAf0ljDAso8JrLuY3vaLU3XDXDKCH5EnIFTO6WgXsUac/m6ViUE7065ntnl8bQKxa
	 AlS4evCEwuHKDnjvVBzto9MFDozlv1+wfyJxKV032fl8biIXvGVsP+/1NKAJ6yaIQ8
	 h6Lzaa2aiADCGlOBUaR5AvydgbG3SvkqhXvwZE0YqwCCTVkKUwu+sGolHFtZKaeQjz
	 cC9RlGPTHaksQ==
Date: Sun, 12 Jan 2025 15:01:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20250112150148.43349803@jic23-huawei>
In-Reply-To: <20250109133707.3845-2-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	<20250109133707.3845-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 15:37:05 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting between single-ended and differential
> reference input.
> 
> By default the single-ended input is enabled.
> 
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - add enum in clock-names to support both se and diff input.
>  .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..9ad5b22c59d7 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -30,8 +30,11 @@ properties:
>  
>    clock-names:
>      description:
> -      Must be "clkin"
> -    maxItems: 1
> +      Must be "clkin" if the input reference is single ended or "clkin-diff"
> +      if the input reference is differential. By default single ended input is
> +      applied.
> +    enum: [clkin, clkin-diff]
> +    default: clkin
Given the property is required, what does a default mean?

I don't think you want to apply a default, or mention it in the description.
Otherwise LGTM.

>  
>    adi,mute-till-lock-en:
>      type: boolean



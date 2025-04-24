Return-Path: <linux-pwm+bounces-5684-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D0A9A28E
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483BB3B11BC
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836911D799D;
	Thu, 24 Apr 2025 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+lMwYXF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7C84FAD;
	Thu, 24 Apr 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477263; cv=none; b=WmrV8z0gY9c5Zi2t4lKfkw/Ukf6sUqVhX3fpRtYUMpHX0SqL0a8nMkqLWpA3mrekJJKS6fFO5idNoARPHJ8PpvtcDvSkWx6p8b462l5m9nZtASAiNyD7H5kR0ewmLnrdEAO/RGumuY2ZEkJF+rF5PhI5ubvaXNumhFgxMu6dgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477263; c=relaxed/simple;
	bh=ET5XGuXWot7j4ph0bPMc5LmHK6iblfnXB0dSje/G3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+IK4GwdaejxMiwXHQESCrRu6Z9BzSO498TRXMiT7C/pxZe9fAS7hUwO/uJBl+8R1DLgPHl/f4WF1Dbiuy0y878Ug2bFYsOa3gZkjNDnIcRWfNANgchAPzJq4iHJJHMoIAONGH6HKyPO78CpRE71dLp7oGl0JqWdXtT/qHgj4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+lMwYXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274A2C4CEEA;
	Thu, 24 Apr 2025 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745477260;
	bh=ET5XGuXWot7j4ph0bPMc5LmHK6iblfnXB0dSje/G3v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+lMwYXF0U4Drvo1iKXxccYk9NdGznYEi7EBKiXmaFQvzKBCfC/be+F+gCG4Sayi1
	 C8LpFh6Mu8z51/KJ3ZUxs8x1zjz9SIayZqk7bkAjwc+PKHwiTTWrLpOU3FoOaeoGVL
	 b3iB3uuXYgbGQBeOsxNfmtabIxtP3SpRKX6aHDMA9i3dHQ3+lVzL96Q1d2QaBWVT4Q
	 dj4BQzvyXwcPHTU+x0OHDlZ7EPxwf02FoRaaosk+1yH9pznPPXcsumPAb7YfwEze2h
	 R9ZqJB1+jFnbdBfYvOjjHWvyaKd3x1epLJWpufgfM2en3FjSUjpv1qDyqPcWm6j8Oj
	 NfEVq/ZES2c0g==
Date: Thu, 24 Apr 2025 08:47:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <20250424-bright-vague-finch-57fc38@kuoka>
References: <20250424012335.6246-1-looong.bin@gmail.com>
 <20250424012335.6246-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424012335.6246-2-looong.bin@gmail.com>

On Thu, Apr 24, 2025 at 09:23:26AM GMT, Longbin Li wrote:
> Add compatible string for PWM controller on SG2044.
> 
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



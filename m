Return-Path: <linux-pwm+bounces-5716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B416A9D3A8
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F141C00F28
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C58D224885;
	Fri, 25 Apr 2025 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQFIj9fb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4D223DFF;
	Fri, 25 Apr 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614712; cv=none; b=o5/zNMpY8KfcdfycinO3EtJOj/6sTrAHgVSmoHHb3UP1eok6G4w/PRT9fKTc1YSrerxqfMq4/kG0Tg5CmISNkFKIgrnsuSRlAfi4U5oZ2chgJT+ui3StnxTO7ISsigMLY8Q6w3h/KTqFbx+0UJLaVjC+H0yglSkIOBwo/10UD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614712; c=relaxed/simple;
	bh=u8rem+r7gx79gYxvys3BADmn5fPu7FO5pWb44JXABFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhErf3hvIYnWCy9mco+Oig324eH6bPBACeMGBGs/BniI1QAymoBMl9J/0DiRiTzLOkUiGmMSI8PM3n3w3cyvrdy+iuvt1NDoFUpcsZ8NLLveZSNKeFoqKBcA93p2ebBz0JWOQ9tdPBcK/Ajp3FtWG5WMlVMDzXu8ATXdRM3pR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQFIj9fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9EBC4CEE4;
	Fri, 25 Apr 2025 20:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745614711;
	bh=u8rem+r7gx79gYxvys3BADmn5fPu7FO5pWb44JXABFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQFIj9fbYb92Ll/HVB5bNshQlBb9ByulxlZ4gqxUYOLkFIsr82uNKFIbwD59EOo5G
	 yFZCWHvpsVEHOhlcRJE2nOvZsGa7BK/6yuhIlPNlZduIOxuaq7Orvue1KhP1F3Ypt4
	 YqTty19M4HeXAPIKoh3SfhVnGI/8+miTsUMkzAvpnLydN+S0D9ZImroKcVBghpvRYS
	 7PI7B0JaY+/7qD8zBuHzdvKi4QCOjP68WK/0YLejGcqqzwMSzzdRDqzN8rNPTHUvCs
	 +z6r5Ra64Ez1D/ZxCotS66g1WNO/zIoVAW0KA1EZBNwzZO+DKQQ1gvlrW0bXQH5rUQ
	 VEWYNFhUb8X6Q==
Date: Fri, 25 Apr 2025 15:58:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <174561468464.3094452.2482613375239857117.robh@kernel.org>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>


On Tue, 22 Apr 2025 13:34:48 +0200, Jorge Marques wrote:
> Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> low-power with monitor capabilities SAR ADCs.
> Each variant of the family differs in speed and resolution, resulting
> in different scan types and spi word sizes, that are matched by the
> compatible with the chip_info.
> The device contains one input (cnv) and two outputs (gp0, gp1).
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 98 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 104 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



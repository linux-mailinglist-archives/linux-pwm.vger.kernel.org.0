Return-Path: <linux-pwm+bounces-3500-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A879919B0
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018051C2126F
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B1415ECD5;
	Sat,  5 Oct 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ5c25gv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7C15B99D;
	Sat,  5 Oct 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154064; cv=none; b=ZH+l8MJTDb9t4KnmW/dJenVMFMzhQHwpveF6pvu9Yio4KQzfy2XADgybq/eOpAFxBzy1CkitJtTDMOmOdTvjx4OTZNp+2qydQyW4NjcmCARRjzTK0QJyVe2wuj9+tV5N4Q9iHKIgVEuxQPog9xdcjILbsT8ojiIQtWCZHXi9YX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154064; c=relaxed/simple;
	bh=CCsUb6uPCpoTXjrHubgnd2r2d40QWaxK5u4uvZlJkhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL7k6ulBdFXFqRUw1YZ5IFd4y69xBR+LsNhWEPBzHBz0gXOLpRp1H3Gy2DgWrvtJixAm7FS9RMZG5jPwviggFaWdQUvEcfUv6dkpYokP4sxAAxVpa1vjo+E25NJ0guF52K5NNjqgg8C828ZO8kz/fd9it2hP8UxSyYE0QPBfRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ5c25gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A9EC4CEC2;
	Sat,  5 Oct 2024 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728154063;
	bh=CCsUb6uPCpoTXjrHubgnd2r2d40QWaxK5u4uvZlJkhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZ5c25gvKHoopbsKtJjnI5L/BeEh4cBsbLFy+tVlXCG1rYRH2P/urXdhNX549ynVX
	 iFOWWuCj1O+/XP1dC+I6UT2YkXLKS42vcWv2goocZgL7o+y8CU51Vtz30OF2SmD4RX
	 fh9BlvCPfxjMJblKcEIINbyVlVfTO4nX0a/xgG/YpfFffgUNpZo1lQexlIvAupLgtv
	 oM+3yCvVi+5y/AoFGZP55CanVSg5ALVOpMFm1EFNPjr1oQ/IusgcsZWrJ7ARiHJNUm
	 Y/P1rnmNGZGyogQAwLfrwdZRFmgMs1MrANwTPrr3PqHMDBaXD+Qmg96fbVTN6dOTnB
	 /EIq7Wj0OKXZg==
Date: Sat, 5 Oct 2024 13:47:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
	aardelean@baylibre.com, linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	dlechner@baylibre.com, devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: adc: ad7606: Remove spi-cpha
 from required
Message-ID: <172815406221.521472.1043315949208476695.robh@kernel.org>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
 <20241004-ad7606_add_iio_backend_support-v3-2-38757012ce82@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-2-38757012ce82@baylibre.com>


On Fri, 04 Oct 2024 21:48:36 +0000, Guillaume Stols wrote:
> The documentation is erroneously stating that spi-cpha is required, and
> the example is erroneously setting both spi-cpol and spi-cpha. According
> to the datasheet, only cpol should be set.
> 
> On zedboard for instance, setting the devicetree as in the example will
> simply not work.
> 
> Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation to yaml")
> Fixes: 6e33a125df66 ("dt-bindings: iio: adc: Add docs for AD7606 ADC")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pwm+bounces-4380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F69F4DE6
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E251641F4
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523881F543D;
	Tue, 17 Dec 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfrBGFNT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2141F542F;
	Tue, 17 Dec 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446179; cv=none; b=EBcFezhPfToEb9L1Xyb1ymR3cePFFTxjE2qp7J3FqtjIozyYSoIVog3Ug/eH3s6llOwO2koSvsCoF1VZBlBPxDU98ZwxmiMXZ7IRwJY1h7GBsTNMGaEXwWMvqp1L8fTXo8+km0YAttViWwZ2fudIrtMRuwhqnc4Oh66eXHVVE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446179; c=relaxed/simple;
	bh=my1aBRiQT5KWc3R/Bcupw6GBuTFoXt2/EVVHhbq+P/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0xpQW27bM6I9kcvBdZ9oXS72NGadDe7xHj5Aav/X9l74KuE7DOHML+LwctphuoPayCkO+AOUuDqVi7aa6t9FzyG4aLP9zsbXPuaX/8/7IYBT1hLr2fd1VVmYfQA7WxaUafT8EjUsF7pgqQGDlBPZfOREIluukFIL9xB8vlONxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfrBGFNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C0C4CED4;
	Tue, 17 Dec 2024 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446178;
	bh=my1aBRiQT5KWc3R/Bcupw6GBuTFoXt2/EVVHhbq+P/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfrBGFNTPV2iWfhaTeGmkkyk+aa6qsklKNNPcSDENDrdfKsnyMcivlnfyYVqRADrf
	 1NX40g4aAYd+CKiR9fmtCfc4S4+IxpoGnnDrI2g4rNzvGxvDA+JV+3wOAK6u1cF7ie
	 pwkWMSKkdaZGHtdM66iV8FufGULLLKDhhd1hGnpXl78lkKZe+6B5hBWBIME295NXGD
	 75GwBUHyy5z3wTmv/7rBergL7oVx7zAVO2hAG6NwglMx6qadFtk+L7v852IamGmia9
	 2RDlvrtkPbAxCB+JndspipOe19IwMR3pEjqn5CCcngMjxSOQJHCBuhGOTB/GiyYHFf
	 uKKgJ6LTwAD3w==
Date: Tue, 17 Dec 2024 08:36:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v6 13/17] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Message-ID: <173444617666.1633026.7697525623383978911.robh@kernel.org>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-13-88ee574d5d03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-13-88ee574d5d03@baylibre.com>


On Wed, 11 Dec 2024 14:54:50 -0600, David Lechner wrote:
> Add a pwms property to the adi,ad4695 binding to specify an optional PWM
> output connected to the CNV pin on the ADC.
> 
> Also add #trigger-source-cells property to allow the BUSY output to be
> used as a SPI offload trigger source to indicate when a sample is ready
> to be read.
> 
> Macros are added to adi,ad4695.h for the cell values to help with
> readability since they are arbitrary values.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v6 changes:
> * Drop $ref to trigger-source.yaml
> * Add maxItems to pwms property
> 
> v5 changes:
> * Added macros for cell values
> 
> v4 changes: new patch in v4
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 13 +++++++++++++
>  include/dt-bindings/iio/adc/adi,ad4695.h                  |  7 +++++++
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



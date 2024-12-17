Return-Path: <linux-pwm+bounces-4378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25AE9F4DDB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 15:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5345B1893250
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCF1F7594;
	Tue, 17 Dec 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhGyRurg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A51F758D;
	Tue, 17 Dec 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445950; cv=none; b=ONHY9sf0T6fead7mI/8OpVDXf/3s8RN+cfHp3kHrmsSJIXhHqNKrvnqIJeqJsdYuwkTHmX+C2m+npExylgROVGSQadduwFPoKqaUbHNX/VjhGr1GcBKHhtMuH/vBtMtNDk9s5C1kNgx/ddc5KGDMNjVxI2NZCTd+heB6IG9eMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445950; c=relaxed/simple;
	bh=VFIC1QIxQDmgiC47kHhQBRFZAruUXZmOHT0RGt/bQqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDadQ42XqrRYdrlLJJqI47HuW2BHY21TpkgydcTFL4J1QE9HmuYDsI21bo777MJToz5fWrUpVtzL2ir4jdzhsK1RBuodTUS02wm5mtsZma/KhopDdMLP/kidNBbNAg/iOHXoeJVz4teIqvZxWoZr1HNoIC+RMESdpKde5zSjVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhGyRurg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B3AC4CED3;
	Tue, 17 Dec 2024 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445949;
	bh=VFIC1QIxQDmgiC47kHhQBRFZAruUXZmOHT0RGt/bQqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhGyRurgxnpaEGzw4ipvApLgF0FKjbqiVV8zz1ZdeEKEFxIkebIdXcawJlln+/QkT
	 Hfjt8QNX0u7Yk9wmPt/pamZ4RCXm4mlF5LkQtbAAUWVQO+3f17HCQkau98i98wQvpy
	 GNgotBHS8aGetR6JGXZT/3jIAvl+vJRdlcwb2EL24wVgbhxLNHp7r6MZ50xUgNVy9W
	 hGFpozkEx+ot78jQRSt+5KmFNAuNAqjN+xDidPYHwpJRZLE7RUqbg4TcY8rHH5NrV5
	 bjWaUB0zjY5GhhX4QXcjyBK8SI0lfICuSkwINfqTJP4rWmWLp8gDrQ1R/1ldHuqIU5
	 Cs+0LFQaxJPqQ==
Date: Tue, 17 Dec 2024 08:32:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>, linux-iio@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Message-ID: <173444594747.1627418.10497892119447871858.robh@kernel.org>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>


On Wed, 11 Dec 2024 14:54:40 -0600, David Lechner wrote:
> Add a new binding for using a PWM signal as a trigger source.
> 
> The idea here is similar to e.g. "pwm-clock" to allow a trigger source
> consumer to use a PWM provider as a trigger source.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v6 changes:
> * Moved file from bindings/spi/ to bindings/trigger-source/
> * Updated description to not mention SPI
> * Dropped $ref: /schemas/spi/trigger-source.yaml#
> * Swapped order in name to be consistent with "pwm-clock"
> 
> v5 changes:
> * Add MAINTAINERS entry
> 
> v4 changes: new patch in v4
> ---
>  .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



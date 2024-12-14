Return-Path: <linux-pwm+bounces-4354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9779F1FF5
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 17:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7231887E35
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4196199384;
	Sat, 14 Dec 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpMQ+oxo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815B1A8F6D;
	Sat, 14 Dec 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195586; cv=none; b=JozhCPoVpD2iXvz1x7lmmoIEvjKrlpfX4TqVDqWKn85k3/uScoBnK+Yk5Zvynr8ddaSp36+tHMnV9ZU1CCzL8e0CAOXQWsbSIK/M+TYUgmBJs1BRC+/1f+n3f38tTn1Gza75m8ybIKqR6UitKEBsC90Zky+fZnlT0us1CpDFmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195586; c=relaxed/simple;
	bh=Laq6O8kQ7isI+jK4rPChjwsddb7jpheyC+aAyKL2/j4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jci0NVXrdmqJUnU5yxPc2Qhg08LzgdBcfebna4P8evvRCc5oI3m3SkOiTwnuNVAmTiRXgXGiUvdWHEj5rRD7ZCuk0OUmunJWdphFA1HbKqpzRTX1Djg6dHj/w/6ucvSm1VHolanTlCJ0ycneFyE80jgkakPEgGsFZQ1D2VNv/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpMQ+oxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A620C4CED1;
	Sat, 14 Dec 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734195586;
	bh=Laq6O8kQ7isI+jK4rPChjwsddb7jpheyC+aAyKL2/j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZpMQ+oxow+ZeeESeSzro+YTL/HvjmJkzXZiTKViMDrGr5u1r07QHH8RQMB3IpM/5G
	 llOlbaOcPq0Vx24Q1UjjJnZpi3c08eo8QIdRvbVx0W5c87hhm729NtJ6ZdRKzBMOkZ
	 Huq9XP6Rd3ZkOSWsEVrG7UsU61hdYIgkm+pOFsp80uY2JQNsHC8tJLnOE8DSARqNTC
	 M2dM3i8ks9Pbg0dK5BOI9Z2Ib72Qg8F4QA6pQj9Xx7id2Mt0ooYGL5kGB6RaIYxflh
	 CphKVrTKcSoXakFGD0WkoaGyRZyFL/ZvDSzsPXXnlaWeUgKQ8h1iEpYXP0h2XUGOqt
	 crom5g287wYoA==
Date: Sat, 14 Dec 2024 16:59:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 13/17] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Message-ID: <20241214165936.4090525e@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-13-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-13-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:50 -0600
David Lechner <dlechner@baylibre.com> wrote:

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


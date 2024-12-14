Return-Path: <linux-pwm+bounces-4352-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B39F1F69
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7F1884A63
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B2193419;
	Sat, 14 Dec 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzyftlpd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94917EC0;
	Sat, 14 Dec 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734187167; cv=none; b=oGt+Td50lnq0PPpAR7mfgY4xn3I7h8uZ9fnY1PaZdOCWvMm13RGxvak5gD+b/S/f+HuVqP3NS/OlQPw8jGKI9vXjAuBNjkAId5WDPQDv/gZhjSCTpPEnYVY2lZM9zBc6TNbuSVGLqnodIAqdLBZ/LXEtHBvZocDcHEMyoeikaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734187167; c=relaxed/simple;
	bh=9NuCdmw8KQZZ1apwFrQRi6/Fz5J/9fHH42DpX0fP+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBPtPEFvDzbRt+Ew1FmGSqA5GxoaC69hlKndHjBT51NbMxfDg4a3HN0rSERGDhyTQzwZAsGzDQKLGOjiBRcBYmFbXXCpphIZuidDNL+kQYEs+0leOMbZtmuVYh49IX4Zl3cPbaYybRDQWUIR1kERiWb+cEk/YOun4M3p2wTHtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzyftlpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D96C4CED1;
	Sat, 14 Dec 2024 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734187167;
	bh=9NuCdmw8KQZZ1apwFrQRi6/Fz5J/9fHH42DpX0fP+kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xzyftlpdi9k5Y9vAWQhzvpzAN/m7N8uC8xl7YyADcNshzHwkQ/Rz6Fk9eOl/zIW2y
	 lUaU7jQsIxTF6hVtmJtbmmGm1ny9/P3bqdqevfXkoKY5RkCwqKf8BuEFmjUyQ3V2X+
	 Cx7WbKNiI/JOKTIxA9GKbVRDlhkhDYkyMinuT1fKS16laWX5Rnz1R/5K85fNn4JbA4
	 G0hqBQQXvVBYkANrKG66L/epx3F1YOdSZqkNyT6xaRsH7VQSJkYmDYiboBzVulH4qP
	 WiqfPWObkj+TqXFN4wlCZFP8DqwivJWQo+23jU3A2qi+9nbpahuS/XOvTYo4WlDhX0
	 2Gx7iSYxOtAqA==
Date: Sat, 14 Dec 2024 14:39:18 +0000
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
Subject: Re: [PATCH v6 09/17] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_with_handle()
Message-ID: <20241214143918.6bda7e66@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-9-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-9-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:46 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new devm_iio_dmaengine_buffer_setup_with_handle() function to
> handle cases where the DMA channel is managed by the caller rather than
> being requested and released by the iio_dmaengine module.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



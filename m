Return-Path: <linux-pwm+bounces-3732-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEA9A4EDE
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A40F1C241FA
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E414D71E;
	Sat, 19 Oct 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfP0Rb8s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F120E31D;
	Sat, 19 Oct 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349658; cv=none; b=AxQKRzvZRDT1jxG3lixb5NbOjQi/kGsWAtm6uFQ4+0K1P/GsERmVcc91oMjSBPRKeMbp5f72we2CM1UMNQXvkUix0mra3ai73U3sIDzz78r79TpJ4fH3L8N/MigAmrp/s5+xagXXvDmZegLRHP/HuQoUr8GvU+hOwlQne67a2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349658; c=relaxed/simple;
	bh=vpQTVSuZQVqefzPPD+k1ty/SusXy1W7/xOTYwE6N8mE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw/beEfYYy5mL9Zgx5ofIoYXdEG4eJtVHwGhMYGeljfsbK8L4YW6YNHSHOBbwepHMPOvhZLFRAu3O1KmkOfkInmXpjRoRnTSsp4NPQ7VnLPFR9jiqqPc7pEPIjE2qIh/ym+1xWyHlUpiz+RniBcIXN5TXzca1MVtBs4NxSeJAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfP0Rb8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE2EC4CEC5;
	Sat, 19 Oct 2024 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729349657;
	bh=vpQTVSuZQVqefzPPD+k1ty/SusXy1W7/xOTYwE6N8mE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jfP0Rb8sRTCgSBMuKX4X+74790++W12dbD1sPQNT3toqqPzHSs3+fsd49mYWaVHLX
	 ppZjfLBCPvPkjZyMZrIoe8IglbnVT9MEGtkHrj6zS7Ma2QBuc36Dmc5z5zxRI/4W6D
	 OG1IHLAlldQoWC1INJbe+eLf6alQjzkCabWsvR4pfqTSlk2VCdbKCRLE930eYqwqQU
	 5U2HOvUH41Y9xWUWzm3rDEIFoz7+KXI4yqoO7+X/e1VQciKT/Eu7cw6MttGsVXkxNH
	 lTddVtwf8eBBf/PKRNQmkJv+ynnXerToeVXzFDaeYfRENY1Tk3LAExmA1SYeqDGaf3
	 6bmGw3hGwYO7g==
Date: Sat, 19 Oct 2024 15:53:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com,
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 0/8] Add iio backend compatibility for ad7606
Message-ID: <20241019155329.500ae439@jic23-huawei>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 13:56:13 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This series aims to add iio backend support for AD7606X ADCs.
> 
> In a nutshell, iio backend is a paradigm to shift the logic establishing
> the connexion between iio buffers and backend buffers into the backend's
> driver.  This provides a more stable programming interface to the driver
> developers, and give more flexibility in the way the hardware communicates.
> 
> The support will be first added on AD7606B, and on next patches AD7606C16
> and AD7606C18 will be added.  The series have been tested on a Zedboard,
> using the latest HDL available, i.e
> https://github.com/analogdevicesinc/hdl/commit/7d0a4cee1b5fa403f175af513d7eb804c3bd75d0
> and an AD7606B FMCZ EKV.  This HDL handles both the conversion trigger
> (through a PWM), and the end of conversion interruption, and is compatible
> with axi-adc, which is "iio-backendable".
> 
> More information about this HDL design can be found at:
> https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl
> 
Applied and pushed out as testing. Please check I didn't mess up the few
minor tweaks needed.


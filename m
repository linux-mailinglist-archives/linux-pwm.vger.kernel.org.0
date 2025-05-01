Return-Path: <linux-pwm+bounces-5794-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AAAA5FAB
	for <lists+linux-pwm@lfdr.de>; Thu,  1 May 2025 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D946145E
	for <lists+linux-pwm@lfdr.de>; Thu,  1 May 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F951DC99C;
	Thu,  1 May 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RLBb0XN/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250F19F11B;
	Thu,  1 May 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108611; cv=none; b=FrrXVNu2tydtR18vNsy99gTqgqHDg45qykG80b4ZkdIX7TtEnP1UE34qFkpynE7l9/QUDQGOG/tW6Rekg9wDajkMWF47F24X0yl0L1Bm9wIIzJCX3s1viS7VPi1KfA0WC2s9ZxuM5H5x+jGbPBUac5CTNxZhYZyIyOpPzFCPUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108611; c=relaxed/simple;
	bh=qjeLQ3PncRVChJGVRM0PPaIgh0f30aEzHnjTAO0O9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAIXbF9MDINg/3AZpOfkixZ1knxWvNNaLW+Np3tc4d+Yib+RIN/t/04n9XUsecEQLgYOz2RabnoIOnVBdU38cF9LDbDPe78MoO0Nb2OIC/mZX7le2v9AA64uQ+/bK1ph1hLqlIjbsMxH9c+Hph/+WJRYQJuHDIoTGhwSHfw4xbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RLBb0XN/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7CF763D;
	Thu,  1 May 2025 16:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1746108599;
	bh=qjeLQ3PncRVChJGVRM0PPaIgh0f30aEzHnjTAO0O9b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLBb0XN/WZGE6skVJTQC5TFZPez0DX17c+cHnQFMfo6BLIuu534MY0HMq7DvYzQrl
	 KXUcKn8Vhh22SCCLuaIeNsQ6TUVJu5Vr+ke/cY7gtbATEE3Di5IqFYRQpEjc7mtB4o
	 BxSFFhtNTgcx8o9oJrsjyTU639SG0AU52NaMTnXY=
Date: Thu, 1 May 2025 17:09:58 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250501140958.GB6838@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <174610080338.3792828.16902042195346769114.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174610080338.3792828.16902042195346769114.b4-ty@kernel.org>

Hi Lee,

On Thu, May 01, 2025 at 01:00:03PM +0100, Lee Jones wrote:
> On Tue, 15 Apr 2025 15:49:16 +0100, Nuno Sá wrote:
> > The adp5585 MFD driver was introduced in 6.11 adding support for gpio
> > and PWM. However, the gpio part of it was already supported as part of
> > the keyboard driver:
> > 
> > https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboard/adp5589-keys.c#L532
> > 
> > On top of that it also overlapped with my refactoring of the above driver [1]
> > to drop usage of platform data and use FW properties instead.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/17] dt-bindings: mfd: adp5585: ease on the required properties
>         commit: 3a2ea3e9f369bdae939bcccff67a77a6281dca74
> [02/17] mfd: adp5585: enable oscilator during probe
>         commit: 7353f196fd73b79e30ff750d93caf096ed660e1b
> [03/17] pwm: adp5585: don't control OSC_EN in the pwm driver
>         commit: 7c7e9f08a1a9bf16b6c1942c2e0cb919da855970
> [04/17] mfd: adp5585: make use of MFD_CELL_NAME()
>         commit: e72e9148d017535b39500d0aad624d0a0fcd2ce7
> [05/17] dt-bindings: mfd: adp5585: document adp5589 I/O expander
>         commit: 6da01b9d833c5efbce7c2e30dde276e0d29105f8
> [06/17] mfd: adp5585: add support for adp5589
>         commit: 382dc0327b8a9ee03c901df9b85134c68917becc
> [07/17] gpio: adp5585: add support for the ad5589 expander
>         commit: cff3cef09595001140bd29aedf33fc84998bf77c
> [08/17] pwm: adp5585: add support for adp5589
>         commit: 333b66fd3edfe18db4dc16041328a89144b73067
> [09/17] dt-bindings: mfd: adp5585: add properties for input events
>         commit: 7bdb41d7a85e1c6244da57d4dcc491df962ff3fb
> [10/17] mfd: adp5585: add support for key events
>         commit: 8814ac45c75fcce55896bc376a97b56f392925c3
> [11/17] gpio: adp5585: support gpi events
>         commit: 8f3d9b44c5c5ada312d0ef71ec0181011854a95b
> [12/17] Input: adp5585: Add Analog Devices ADP5585/89 support
>         commit: a53fc67a1e21a8507821263946b1d65687b0284f
> [13/17] Input: adp5589: remove the driver
>         commit: 216c99cf1002a42f896b54fab09823e8ba46b218
> [14/17] mfd: adp5585: support getting vdd regulator
>         commit: 63a8717f744d51ea0c8228e09db4233d48f2f9ba
> [15/17] dt-bindings: mfd: adp5585: document reset gpio
>         commit: 49c887f0547bc14eb50ba20e1c8acb7255af3b86
> [16/17] mfd: adp5585: add support for a reset pin
>         commit: 01c328823459456fb99469cc37f270f70d41fd2a
> [17/17] pwm: adp5585: make sure to include mod_devicetable.h
>         (no commit info)

I'm a bit surprised, didn't you ask for changes, calling for a v3 ?

-- 
Regards,

Laurent Pinchart


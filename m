Return-Path: <linux-pwm+bounces-4989-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F74A44C28
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6E37A64C6
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632B213236;
	Tue, 25 Feb 2025 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA/yQo2D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57299212D9D;
	Tue, 25 Feb 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514357; cv=none; b=luRtl1d2A2rVsXM4UNANx2A/NIpCeA3nDmiCVff6By7PmgQRfxEMFHoSPCUBA5tFGI+iojNdCZVcYpe6axolz5VIPI47JvuX6PWkDPra0CNdDW1PA9VxWr2Evx+uQpMWDVZCulmoSQm5kwV8D+REsiDQy2LwnaQfrHw1tkRPLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514357; c=relaxed/simple;
	bh=yTCj5mHCtdBx8pk+52dg55Yg5D96C+PxN6w8CQznwjM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gJBsdT2g3+zVzew3Tf39gsq/8dDy3epRsVz/eU6ZEczwi32Y8Xva2GKdM9QQxX6MrRkQ3x4/t3WdAGlVFlL6Rzh1Q7mWZO6jNB/g0gGSfqWvlVqqWIDeMwqV11N5t4sN0srdaH6qWbm6K/+knuhEQKfqb/QX8WJi9udhrvdmWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA/yQo2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DFC4CEDD;
	Tue, 25 Feb 2025 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514356;
	bh=yTCj5mHCtdBx8pk+52dg55Yg5D96C+PxN6w8CQznwjM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qA/yQo2Dj7sATmTqu+FxRMZ65j9/jCkahdI62i/V40ioGuSi2VPnHu+ozuj0hCykM
	 7SwJsjXxnFwy5gAEVVto5RF/S13qmg4gmUdYBgf6i+zc8r0IROTfT+VESyZEPDRs4H
	 UxNacRkez6vE1G0S562m0LjxY9fD5f/Qub7y8BpjbWIkVKPsdJlRHbcAXQfPCJ4xLH
	 DQyQUfZ+U1hwVn5ZH6fcdjIQJJ7uOc1hu6AAK1njsVkcmXuyu5F1ItA39HdEWxd/qN
	 7p1JfHl5t6QAegMK+0wFDo2wggGt9kTyPga4LZqk3/r281/fkY6jUdkoUe6vqE6OGZ
	 cdwFm+tgF71yQ==
Date: Tue, 25 Feb 2025 14:12:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: will@kernel.org, jic23@kernel.org, lee@kernel.org, ukleinek@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 tglx@linutronix.de, catalin.marinas@arm.com, daniel.lezcano@linaro.org, 
 linux-iio@vger.kernel.org, wbg@kernel.org, devicetree@vger.kernel.org, 
 linux-pwm@vger.kernel.org, conor+dt@kernel.org, 
 alexandre.torgue@foss.st.com, krzk+dt@kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, olivier.moysan@foss.st.com
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
Message-Id: <174051415125.2971414.5163158019956863310.robh@kernel.org>
Subject: Re: [PATCH 0/8] Add STM32MP25 LPTIM support: MFD, PWM, IIO,
 counter, clocksource


On Mon, 24 Feb 2025 19:01:42 +0100, Fabrice Gasnier wrote:
> This series adds support for STM32MP25 to MFD PWM, IIO, counter and
> clocksource low-power timer (LPTIM) drivers.
> This new variant is managed by using a new DT compatible string.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC.
> Same feature list as on STM32MP1x is supported currently.
> The device tree files add all instances in stm32mp251 dtsi file.
> 
> Fabrice Gasnier (6):
>   dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
>   mfd: stm32-lptimer: add support for stm32mp25
>   pwm: stm32-lp: add support for stm32mp25
>   counter: stm32-lptimer-cnt: add support for stm32mp25
>   arm64: defconfig: enable STM32 LP timers drivers
>   arm64: dts: st: add low-power timer nodes on stm32mp251
> 
> Olivier Moysan (1):
>   iio: trigger: stm32-lptimer: add support for stm32mp25
> 
> Patrick Delaunay (1):
>   clocksource: stm32-lptimer: add stm32mp25 support
> 
>  .../bindings/mfd/st,stm32-lptimer.yaml        |  23 +-
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        | 177 ++++++++++++++
>  arch/arm64/configs/defconfig                  |   5 +
>  drivers/clocksource/timer-stm32-lp.c          |   1 +
>  drivers/counter/stm32-lptimer-cnt.c           |   1 +
>  drivers/iio/trigger/stm32-lptimer-trigger.c   | 109 +++++++--
>  drivers/mfd/stm32-lptimer.c                   |  30 ++-
>  drivers/pwm/pwm-stm32-lp.c                    | 220 +++++++++++++++---
>  include/linux/iio/timer/stm32-lptim-trigger.h |   9 +
>  include/linux/mfd/stm32-lptimer.h             |  32 ++-
>  10 files changed, 554 insertions(+), 53 deletions(-)
> 
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/st/' for 20250224180150.3689638-1-fabrice.gasnier@foss.st.com:

arch/arm64/boot/dts/st/stm32mp257f-ev1.dtb: timer@46060000: trigger@3:reg:0:0: 3 is greater than the maximum of 2
	from schema $id: http://devicetree.org/schemas/mfd/st,stm32-lptimer.yaml#
arch/arm64/boot/dts/st/stm32mp257f-ev1.dtb: timer@46070000: trigger@4:reg:0:0: 4 is greater than the maximum of 2
	from schema $id: http://devicetree.org/schemas/mfd/st,stm32-lptimer.yaml#







Return-Path: <linux-pwm+bounces-5110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72EA50597
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC531695FC
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B61A5B9A;
	Wed,  5 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekxy6gYh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CEE196D90;
	Wed,  5 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193280; cv=none; b=r0LhUUQK+8L2xQUijWZdajVcaWsWeFRy377hGAx+Z01xWuoP0P8e/vgt9biWGmo9bG/z3xcQQCQspa4VIZ2eJLrrX5un3ebWzZQUv2QJCW6N44e5lO9967fmk+w683SqA/zD74gGCqNhG7EnP5L41uLGYqqA1N3fdvv8vof02wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193280; c=relaxed/simple;
	bh=q9RwUsahZEDzg4kp8X6VT0iwUQxY7NE3PJQxq7dtK7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcy0/bFDcqnsYfNPd4D/j9V+/Ull+m0heyRXa3kypaIZibDh9OH3jWe5E2uXk57BkZkHu5e0UG8T/A8xoegIUBnhoWFLuS3NnfYRdY7Bb82fJVb74dglThlyKmc8fj85BZ7fcSqllv08ZUHz2KBM4KTreltZ9w/0hYcJ2lrF6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekxy6gYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF23C4CED1;
	Wed,  5 Mar 2025 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741193280;
	bh=q9RwUsahZEDzg4kp8X6VT0iwUQxY7NE3PJQxq7dtK7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ekxy6gYheu0ogt41k4byYBhS5G+HBulFW9+/8nNtHsUEpaPQzVOLHbNwBNQpBsGw1
	 Lzcd5JprYDUUkdqDdjHeKwTAR3egKNc6w1ijwkEqKdF6R3R/GylpaFbwx4WV4qOPDh
	 PLpsU3jz+VwnZxMSJViOKAN+d524dJiTEClfQiOoGiuIMHzl7N6M95zHN3ys17K6Vq
	 L+tBaPLWV6AbJDbOINBy/E2uovpIta2UATL4CFIzYreKNPdnLFLRQXLg2Vk976H0tZ
	 yW7JtQksdVCo7do/dY7B5mwoaiyObB8LqHJiCjp4llrX+RhCOnnnrB2ApdUbjcLssY
	 9wKadFzvDCdYg==
Date: Wed, 5 Mar 2025 10:47:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: jic23@kernel.org, catalin.marinas@arm.com, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org, olivier.moysan@foss.st.com,
	conor+dt@kernel.org, wbg@kernel.org, lee@kernel.org,
	tglx@linutronix.de, krzk+dt@kernel.org, daniel.lezcano@linaro.org,
	will@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, alexandre.torgue@foss.st.com,
	ukleinek@kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mfd: stm32-lptimer: add support for
 stm32mp25
Message-ID: <174119327848.2121305.11563216194052431018.robh@kernel.org>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305094935.595667-2-fabrice.gasnier@foss.st.com>


On Wed, 05 Mar 2025 10:49:28 +0100, Fabrice Gasnier wrote:
> Add a new stm32mp25 compatible to stm32-lptimer dt-bindings, to support
> STM32MP25 SoC. Some features has been updated or added to the low-power
> timer:
> - new capture compare channels
> - up to two PWM channels
> - PWM input capture
> - peripheral interconnect in stm32mp25 has been updated (new triggers).
> - registers/bits has been added or revisited (IER access).
> So introduce a new compatible to handle this diversity.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V3:
> - Fix yaml indentation issue found by Rob's bot
> Changes in V2:
> - Use fallback compatibles, along with stm32mp25 specific compatible
> - trigger identifier can be up to 4 (e.g. from LPTIM1..5)
> ---
>  .../bindings/mfd/st,stm32-lptimer.yaml        | 40 ++++++++++++++++---
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



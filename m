Return-Path: <linux-pwm+bounces-4983-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DFA43EBE
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20073A6C3C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDC267F48;
	Tue, 25 Feb 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ7r2+Kt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E559267B1A;
	Tue, 25 Feb 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484971; cv=none; b=B3jhgGZ/N1N9nyiQIgRImVoXXm7DZi3QS3cHMQhJluNJpq2z8VHMpLrgDf0aZ/fmv5xr0NRwjJLvKqaRid4TUfr64ThvpQwhGpjYGHANGQuNQUE1TIRskT1OK8pJfZnh9j7LMilpsydT+wlnR0HvwEyy8EClXDMJhUM08n+KC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484971; c=relaxed/simple;
	bh=5u7h0X12oKtvzpOzqx7CcREHMSTIyV6i4dduMgVCWvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0/7WEZtZPKnNlFnspZK0Rv7S/8YjWfjwynw46eSEL3obGlhghyYHsrSvr7BBaC15a4J6teNyAGa7/GRPVRFQfYc6NFGK4aC4AeDuW/l1sAJDZivE5ccQhDtGOVBXUCvRRpxeApOyO3JQBC100lcvbptUqgpXJrsuOClC3KODaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ7r2+Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59010C4CEDD;
	Tue, 25 Feb 2025 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484971;
	bh=5u7h0X12oKtvzpOzqx7CcREHMSTIyV6i4dduMgVCWvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ7r2+KtuJ3s25tsKTKD4y4Q8/vruepuHAt4+eVPb1PzmCX+NBcjxDUliictUO29V
	 3Onn/6qF2ZoaT0/fNmUiyGfz1KZFKg6gdLnT65gT5bXKfjgrD9DlMn14UAzM0USD4R
	 DHx2Ji4oYzbv9IHsEjgw8UFdjsLOCc/JQBN9judAOkDnwPE0ajl6jcDtcRHXmd0jjT
	 utTWIU9YZVLF1YLCPRncQ64YAZ6xb6LgG8vIjfFFxiA6UvTTJNHysNFk/GYYmCKpbS
	 /uoMPnrQQoqISJqqGjS/y8BTaI+m1p9rQ8QHyczw1GPk4oML1Va9sJDpISunAtyZR2
	 rWz+mOISKk/pg==
Date: Tue, 25 Feb 2025 13:02:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 4/8] clocksource: stm32-lptimer: add stm32mp25 support
Message-ID: <20250225-purring-herring-of-reputation-1aed2f@krzk-bin>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-5-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224180150.3689638-5-fabrice.gasnier@foss.st.com>

On Mon, Feb 24, 2025 at 07:01:46PM +0100, Fabrice Gasnier wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Add the support of the new compatible for STM32MP25 SoC in driver, as
> described in Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
> and used in arch/arm64/boot/dts/st/stm32mp251.dtsi.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/clocksource/timer-stm32-lp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
> index a4c95161cb22..db055348e2cc 100644
> --- a/drivers/clocksource/timer-stm32-lp.c
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -197,6 +197,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id stm32_clkevent_lp_of_match[] = {
>  	{ .compatible = "st,stm32-lptimer-timer", },
> +	{ .compatible = "st,stm32mp25-lptimer-timer", },
>  	{},

Same question.

Best regards,
Krzysztof



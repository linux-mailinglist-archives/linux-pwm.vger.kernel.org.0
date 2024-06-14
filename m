Return-Path: <linux-pwm+bounces-2453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3D908774
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6ECB20C5D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBAE148828;
	Fri, 14 Jun 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVyVB1Q1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F612481D0;
	Fri, 14 Jun 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357489; cv=none; b=hAHFsTl4fPz6fMqo9QzLurGzp3dbnjbQGUBN/t377qOdnzorBSl1IcX++JVnCPG1eoBU7thXKb5AtyAef74jpzsHDG5+Il6slISxNp40I3BXLJ8SwprQhEH+M9+SLLKatGTnT76XovAbENNDkVFVTBImU0D6R0NhViXkUi0N+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357489; c=relaxed/simple;
	bh=GHeElqe8VrB34C9wBIcEMogZsFo2aeiU/M3nJbLyXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlY2xXgyIB57lT8UPM2WeMWWBeVKM6YPU98caTEM6R8+o5caOX7lC9WmynxMkj9Ch3tzeAUDzgVdnnI6bXjuAgQDPjjBa7uL50KYU5vV7gu7pHM9JsNPgiPmUkUrHB1Oguyx3D1MssLvES7qU5C0J4m3V3UQt0UbN1/HieXYcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVyVB1Q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27173C2BD10;
	Fri, 14 Jun 2024 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718357489;
	bh=GHeElqe8VrB34C9wBIcEMogZsFo2aeiU/M3nJbLyXxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVyVB1Q13OgHfxDgorVlgcTtPWWke8R6tnuozRHFZqo8a9Jwd3zF/iajHtabIgDSN
	 fJUC450HjXueTqfpKmdaFk4pP+C4KBHDWlioCDY9YSYiGfcFB+zVJlUQ32lyPuIv8e
	 76fCrocYx59ivwY2AKivgZ4sRrf5zE1DDrhTAmqu8BcWI9cyHo7+iaQoit+LazNjKb
	 YMF/Poqeivz7CbcPm3E7T3vqy2luQaTwMisOR5oM6ltsy6SOO8arAfb5zwxClBDPii
	 skZhlEj4yjnBBPfaXF/cEw445MAyEu3lmkliENODUC/MChs81QWnQdksjcSBDoYOww
	 w7id1AERN7VGA==
Date: Fri, 14 Jun 2024 10:31:24 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: stm32-timers: Drop TIM_DIER_CC_IE(x) in favour
 of TIM_DIER_CCxIE(x)
Message-ID: <20240614093124.GD3029315@google.com>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
 <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>

On Fri, 14 Jun 2024, Uwe Kleine-König wrote:

> These two defines have the same purpose and this change doesn't
> introduce any differences in drivers/counter/stm32-timer-cnt.o.
> 
> The only difference between the two is that
> 
> 	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE
> 
> while
> 
> 	TIM_DIER_CCxIE(1) == TIM_DIER_CC1IE
> 
> . That makes it necessary to have an explicit "+ 1" in the user code,
> but IMHO this is a good thing as this is the code locatation that
> "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> (because software guys start counting at 0, while the relevant hardware
> designer started at 1).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 4 ++--

The subject should be renamed.

>  include/linux/mfd/stm32-timers.h  | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 0664ef969f79..186e73d6ccb4 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -465,7 +465,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
>  			ret = stm32_count_capture_configure(counter, event_node->channel, true);
>  			if (ret)
>  				return ret;
> -			dier |= TIM_DIER_CC_IE(event_node->channel);
> +			dier |= TIM_DIER_CCxIE(event_node->channel + 1);
>  			break;
>  		default:
>  			/* should never reach this path */
> @@ -478,7 +478,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
>  
>  	/* check for disabled capture events */
>  	for (i = 0 ; i < priv->nchannels; i++) {
> -		if (!(dier & TIM_DIER_CC_IE(i))) {
> +		if (!(dier & TIM_DIER_CCxIE(i + 1))) {
>  			ret = stm32_count_capture_configure(counter, i, false);
>  			if (ret)
>  				return ret;
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 92b45a559656..f09ba598c97a 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -47,7 +47,6 @@
>  #define TIM_DIER_CC2IE		TIM_DIER_CCxIE(2)			/* CC2 Interrupt Enable				*/
>  #define TIM_DIER_CC3IE		TIM_DIER_CCxIE(3)			/* CC3 Interrupt Enable				*/
>  #define TIM_DIER_CC4IE		TIM_DIER_CCxIE(4)			/* CC4 Interrupt Enable				*/
> -#define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt enable		*/
>  #define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
>  #define TIM_DIER_CCxDE(x)	BIT(9 + ((x) - 1))			/* CCx DMA request Enable (x ∈ {1, .. 4})	*/
>  #define TIM_DIER_CC1DE		TIM_DIER_CCxDE(1)			/* CC1 DMA request Enable			*/
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]


Return-Path: <linux-pwm+bounces-4982-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFBA43EBA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 13:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C33AFFCA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D9267F50;
	Tue, 25 Feb 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLchVBJ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDC29CF0;
	Tue, 25 Feb 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484951; cv=none; b=ZIoDhcWlLqsmt11QV1rudlcMTMklC5b/CNHUyv9zsDh92ZF69EMhvn08pB2XtD7ns1o2jBJnR9gmycvQms+S3rCmexWotnBkQGtzUF+yFJZ7rAwYTgRzaspCXqR5yiMrWVMoqHKY1aDGOs9ZdrvAALryLKU290yY/LkOTIywd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484951; c=relaxed/simple;
	bh=R/cOn0v6QuOZo+xg2JB81n4XEbmiI+jQBlxb5k5MOhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOnVZ4FnH3rae97P1vYMCQz34qpdRp2DuOl9uzjMfbkgxaduhB+JVAOklfu0PGg8Vfc2NTbIh1wux8toPaN2frcAWtTpmt2Gd6M7ADe2R3ZpiLucVrrgzMn2q8gkST38bvOSsj8sRrSpqDfjtB9aIWAw/UHTzpLcPAbtdhuxL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLchVBJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F7DC4CEDD;
	Tue, 25 Feb 2025 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484950;
	bh=R/cOn0v6QuOZo+xg2JB81n4XEbmiI+jQBlxb5k5MOhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLchVBJ6qU4UVRV6lO0rj81zD64IBrcFV9hUCD26oKNlj8cVUHLFzrrh650n/hUyW
	 RbCcgSSiKYp6/fkoFFl/k+7cymdhXiVhYHpdwQzRAfdp2WWlRZwipEMnklw2Da2rs0
	 yrNzkuef8f+gsJvQKmNaWlMgEFljgGCfrqSlu+QHTyh/bvk5eHR4RHhf4AKotnGhZV
	 aXvWD4VoSD+xyArJSBO08WLi4Fd9wPs6rGXeTno5OuahP9dDxGAgzdd0NXtMDqOSBN
	 GpffOR5JOQJuQZMOYEMPKofZG9xb3fpfSZSTvYfqLRsEH5pibqqPwvdlSwPeA/anSE
	 9WyRKty0cPwUA==
Date: Tue, 25 Feb 2025 13:02:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 6/8] counter: stm32-lptimer-cnt: add support for stm32mp25
Message-ID: <20250225-pelican-of-pleasurable-might-e9a7e8@krzk-bin>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-7-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224180150.3689638-7-fabrice.gasnier@foss.st.com>

On Mon, Feb 24, 2025 at 07:01:48PM +0100, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> this new HW variant, even if no major change is expected on the counter
> driver.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/counter/stm32-lptimer-cnt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index b249c8647639..a5dce017c37b 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -508,6 +508,7 @@ static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
>  
>  static const struct of_device_id stm32_lptim_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-lptimer-counter", },
> +	{ .compatible = "st,stm32mp25-lptimer-counter", },

So fully compatible? Why this change then?

Best regards,
Krzysztof


